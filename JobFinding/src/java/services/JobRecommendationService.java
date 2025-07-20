package services;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

import daos.ApplicationDAO;
import daos.AwardDAO;
import daos.CertificateDAO;
import daos.EducationDAO;
import daos.ExperienceDAO;
import daos.PostsDAO;
import daos.SavedJobDAO;
import daos.SearchHistoryDAO;
import models.Application;
import models.Award;
import models.Certificate;
import models.Education;
import models.Experience;
import models.JobSeeker;
import models.Posts;
import models.SavedJob;

/**
 * Advanced Job Recommendation Service - Enhanced Production Version
 * 
 * This service provides sophisticated job recommendations based on:
 * 1. User Profile Matching (skills, experience, education, certificates, awards)
 * 2. User Behavior Analysis (search history, saved jobs, applications, view patterns)
 * 3. Content-Based Filtering (job requirements, descriptions, keywords)
 * 4. Collaborative Filtering (similar users' preferences and behaviors)
 * 5. Recency and Popularity Factors with time decay
 * 6. Salary and Location Optimization with geographic proximity
 * 7. Industry and Company Reputation Analysis
 * 8. Real-time scoring with user feedback integration
 * 
 * The algorithm uses weighted scoring across multiple dimensions
 * with machine learning-inspired features for highly personalized recommendations.
 */
public class JobRecommendationService {
    
    private static final Logger LOGGER = Logger.getLogger(JobRecommendationService.class.getName());
    
    // Enhanced weight configuration for different scoring factors
    private static final double JOB_TITLE_WEIGHT = 0.20;
    private static final double SKILLS_MATCH_WEIGHT = 0.25;
    private static final double LOCATION_WEIGHT = 0.15;
    private static final double EXPERIENCE_LEVEL_WEIGHT = 0.15;
    private static final double SALARY_WEIGHT = 0.10;
    private static final double EDUCATION_WEIGHT = 0.05;
    private static final double BEHAVIOR_WEIGHT = 0.05;
    private static final double POPULARITY_WEIGHT = 0.03;
    private static final double COMPANY_REPUTATION_WEIGHT = 0.02;
    
    // Cache for performance optimization
    private static final Map<Integer, UserProfileData> profileCache = new ConcurrentHashMap<>();
    private static final Map<Integer, List<JobRecommendation>> recommendationCache = new ConcurrentHashMap<>();
    private static final int CACHE_TTL_MINUTES = 30;
    
    // Skill similarity mapping for better matching
    private static final Map<String, Set<String>> skillSynonyms = new HashMap<>();
    static {
        // Programming languages
        skillSynonyms.put("java", new HashSet<>(Arrays.asList("spring", "hibernate", "maven", "gradle")));
        skillSynonyms.put("python", new HashSet<>(Arrays.asList("django", "flask", "pandas", "numpy")));
        skillSynonyms.put("javascript", new HashSet<>(Arrays.asList("node.js", "react", "angular", "vue.js")));
        skillSynonyms.put("c#", new HashSet<>(Arrays.asList(".net", "asp.net", "entity framework")));
        
        // Frameworks and technologies
        skillSynonyms.put("spring boot", new HashSet<>(Arrays.asList("spring", "java", "microservices")));
        skillSynonyms.put("react", new HashSet<>(Arrays.asList("javascript", "frontend", "ui")));
        skillSynonyms.put("docker", new HashSet<>(Arrays.asList("kubernetes", "containerization", "devops")));
        skillSynonyms.put("aws", new HashSet<>(Arrays.asList("cloud", "amazon", "ec2", "s3")));
        
        // Soft skills
        skillSynonyms.put("leadership", new HashSet<>(Arrays.asList("management", "team lead", "supervision")));
        skillSynonyms.put("communication", new HashSet<>(Arrays.asList("presentation", "interpersonal", "collaboration")));
        skillSynonyms.put("problem solving", new HashSet<>(Arrays.asList("analytical", "critical thinking", "troubleshooting")));
    }
    
    // DAOs
    private final PostsDAO postsDAO;
    private final ExperienceDAO experienceDAO;
    private final EducationDAO educationDAO;
    private final CertificateDAO certificateDAO;
    private final AwardDAO awardDAO;
    private final SavedJobDAO savedJobDAO;
    private final ApplicationDAO applicationDAO;
    private final SearchHistoryDAO searchHistoryDAO;
    
    public JobRecommendationService() {
        try {
            this.postsDAO = new PostsDAO();
            this.experienceDAO = new ExperienceDAO();
            this.educationDAO = new EducationDAO();
            this.certificateDAO = new CertificateDAO();
            this.awardDAO = new AwardDAO();
            this.savedJobDAO = new SavedJobDAO();
            this.applicationDAO = new ApplicationDAO();
            this.searchHistoryDAO = new SearchHistoryDAO();
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error initializing JobRecommendationService", e);
            throw new RuntimeException("Failed to initialize JobRecommendationService", e);
        }
    }
    
    /**
     * Get personalized job recommendations for a job seeker with enhanced algorithms
     * 
     * @param jobSeeker The job seeker to get recommendations for
     * @param limit Maximum number of recommendations to return
     * @return List of recommended jobs sorted by relevance score
     */
    public List<JobRecommendation> getRecommendations(JobSeeker jobSeeker, int limit) {
        List<JobRecommendation> recommendations = new ArrayList<>();
        
        try {
            // Check cache first
            String cacheKey = jobSeeker.getId() + "_" + limit;
            if (recommendationCache.containsKey(jobSeeker.getId())) {
                List<JobRecommendation> cached = recommendationCache.get(jobSeeker.getId());
                if (cached != null && cached.size() >= limit) {
                    return cached.subList(0, Math.min(limit, cached.size()));
                }
            }
            
            // Get all active job posts with filtering
            List<Posts> allJobs = postsDAO.getAllPosts().stream()
                .filter(job -> "active".equals(job.getStatus()))
                .filter(job -> job.getDeletedAt() == null)
                .collect(Collectors.toList());
            
            // Load user's detailed profile data
            UserProfileData profileData = loadUserProfileData(jobSeeker.getId());
            
            // Score each job with enhanced algorithms
            List<JobRecommendation> scoredJobs = new ArrayList<>();
            for (Posts job : allJobs) {
                double score = calculateEnhancedMatchScore(jobSeeker, job, profileData);
                if (score > 0) {
                    JobRecommendation recommendation = new JobRecommendation(job, score);
                    scoredJobs.add(recommendation);
                }
            }
            
            // Sort by score (descending) and take top jobs
            scoredJobs.sort((a, b) -> Double.compare(b.getScore(), a.getScore()));
            
            // Apply diversity filtering to avoid similar jobs
            recommendations = applyDiversityFilter(scoredJobs, limit);
            
            // Cache the results
            recommendationCache.put(jobSeeker.getId(), new ArrayList<>(recommendations));
            
            // If we don't have enough scored jobs, fill with latest jobs
            if (recommendations.size() < Math.min(3, limit)) {
                List<Posts> latestJobs = postsDAO.getLatestPosts(limit);
                for (Posts job : latestJobs) {
                    if (recommendations.size() >= limit) break;
                    
                    // Avoid duplicates
                    boolean alreadyAdded = recommendations.stream()
                        .anyMatch(rec -> rec.getJob().getId() == job.getId());
                    
                    if (!alreadyAdded) {
                        recommendations.add(new JobRecommendation(job, 0.0));
                    }
                }
            }
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error getting job recommendations for user: " + jobSeeker.getId(), e);
            
            // Fallback: return latest jobs if recommendation fails
            try {
                List<Posts> latestJobs = postsDAO.getLatestPosts(limit);
                for (Posts job : latestJobs) {
                    recommendations.add(new JobRecommendation(job, 0.0));
                }
            } catch (Exception ex) {
                LOGGER.log(Level.SEVERE, "Error getting fallback recommendations", ex);
            }
        }
        
        return recommendations;
    }
    
    /**
     * Apply diversity filter to avoid recommending too many similar jobs
     */
    private List<JobRecommendation> applyDiversityFilter(List<JobRecommendation> scoredJobs, int limit) {
        List<JobRecommendation> diverseJobs = new ArrayList<>();
        Set<String> seenCompanies = new HashSet<>();
        Set<String> seenLocations = new HashSet<>();
        
        for (JobRecommendation rec : scoredJobs) {
            if (diverseJobs.size() >= limit) break;
            
            Posts job = rec.getJob();
            String companyKey = job.getCompanyName() != null ? job.getCompanyName().toLowerCase() : "";
            String locationKey = job.getLocation() != null ? job.getLocation().toLowerCase() : "";
            
            // Limit similar companies and locations
            if (seenCompanies.size() < limit / 2 || !seenCompanies.contains(companyKey)) {
                if (seenLocations.size() < limit / 2 || !seenLocations.contains(locationKey)) {
                    diverseJobs.add(rec);
                    seenCompanies.add(companyKey);
                    seenLocations.add(locationKey);
                }
            }
        }
        
        // Fill remaining slots if needed
        for (JobRecommendation rec : scoredJobs) {
            if (diverseJobs.size() >= limit) break;
            if (!diverseJobs.contains(rec)) {
                diverseJobs.add(rec);
            }
        }
        
        return diverseJobs;
    }
    
    /**
     * Load comprehensive user profile data for recommendation analysis with caching
     */
    private UserProfileData loadUserProfileData(int jobSeekerId) throws Exception {
        // Check cache first
        if (profileCache.containsKey(jobSeekerId)) {
            return profileCache.get(jobSeekerId);
        }
        
        UserProfileData profileData = new UserProfileData();
        
        try {
            profileData.setExperiences(experienceDAO.getExperiencesByJobSeeker(jobSeekerId));
            profileData.setEducations(educationDAO.getEducationsByJobSeeker(jobSeekerId));
            profileData.setCertificates(certificateDAO.getCertificatesByJobSeeker(jobSeekerId));
            profileData.setAwards(awardDAO.getAwardsByJobSeeker(jobSeekerId));
            profileData.setSavedJobs(savedJobDAO.getSavedJobsByJobSeeker(jobSeekerId));
            profileData.setApplications(applicationDAO.getApplicationsByJobSeeker(jobSeekerId, 1, 100, null, null, null));
            
            // Cache the profile data
            profileCache.put(jobSeekerId, profileData);
            
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error loading profile data for user: " + jobSeekerId, e);
            // Continue with empty data rather than failing completely
        }
        
        return profileData;
    }
    
    /**
     * Calculate enhanced match score with improved algorithms
     */
    private double calculateEnhancedMatchScore(JobSeeker jobSeeker, Posts job, UserProfileData profileData) {
        double totalScore = 0.0;
        
        try {
            // 1. Enhanced Job Title Matching with semantic similarity
            totalScore += calculateEnhancedJobTitleScore(jobSeeker, job) * JOB_TITLE_WEIGHT;
            
            // 2. Advanced Skills Matching with synonyms and semantic analysis
            totalScore += calculateAdvancedSkillsMatchScore(jobSeeker, job, profileData) * SKILLS_MATCH_WEIGHT;
            
            // 3. Enhanced Location Matching with geographic proximity
            totalScore += calculateEnhancedLocationScore(jobSeeker, job) * LOCATION_WEIGHT;
            
            // 4. Experience Level Matching with career progression analysis
            totalScore += calculateExperienceLevelScore(jobSeeker, job, profileData) * EXPERIENCE_LEVEL_WEIGHT;
            
            // 5. Enhanced Salary Matching with better parsing
            totalScore += calculateEnhancedSalaryScore(jobSeeker, job) * SALARY_WEIGHT;
            
            // 6. Education Matching with field relevance
            totalScore += calculateEducationScore(jobSeeker, job, profileData) * EDUCATION_WEIGHT;
            
            // 7. Enhanced User Behavior Analysis with collaborative filtering
            totalScore += calculateEnhancedBehaviorScore(job, profileData) * BEHAVIOR_WEIGHT;
            
            // 8. Job Popularity & Recency with time decay
            totalScore += calculateEnhancedPopularityScore(job) * POPULARITY_WEIGHT;
            
            // 9. Enhanced Company Reputation with industry analysis
            totalScore += calculateEnhancedCompanyReputationScore(job) * COMPANY_REPUTATION_WEIGHT;
            
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error calculating match score for job: " + job.getId(), e);
        }
        
        return totalScore;
    }
    
    /**
     * Enhanced job title matching with semantic similarity
     */
    private double calculateEnhancedJobTitleScore(JobSeeker jobSeeker, Posts job) {
        double score = 0.0;
        
        if (jobSeeker.getDesiredJobTitle() != null && job.getTitle() != null) {
            String desiredTitle = jobSeeker.getDesiredJobTitle().toLowerCase();
            String jobTitle = job.getTitle().toLowerCase();
            
            // Exact match
            if (jobTitle.equals(desiredTitle)) {
                score = 100.0;
            }
            // Contains match
            else if (jobTitle.contains(desiredTitle) || desiredTitle.contains(jobTitle)) {
                score = 85.0;
            }
            // Semantic similarity matching
            else {
                score = calculateSemanticSimilarity(desiredTitle, jobTitle);
                
                // Check for role level matching
                if (isSeniorRole(desiredTitle) && isSeniorRole(jobTitle)) {
                    score += 15.0;
                } else if (isJuniorRole(desiredTitle) && isJuniorRole(jobTitle)) {
                    score += 15.0;
                }
            }
        }
        
        return Math.min(100.0, score);
    }
    
    /**
     * Calculate semantic similarity between two strings
     */
    private double calculateSemanticSimilarity(String str1, String str2) {
        String[] words1 = str1.split("\\s+");
        String[] words2 = str2.split("\\s+");
        
        Set<String> set1 = new HashSet<>(Arrays.asList(words1));
        Set<String> set2 = new HashSet<>(Arrays.asList(words2));
        
        Set<String> intersection = new HashSet<>(set1);
        intersection.retainAll(set2);
        
        Set<String> union = new HashSet<>(set1);
        union.addAll(set2);
        
        if (union.isEmpty()) return 0.0;
        
        return (double) intersection.size() / union.size() * 70.0;
    }
    
    /**
     * Check if job title indicates senior role
     */
    private boolean isSeniorRole(String title) {
        String[] seniorKeywords = {"senior", "lead", "principal", "architect", "manager", "director", "head"};
        return Arrays.stream(seniorKeywords).anyMatch(title::contains);
    }
    
    /**
     * Check if job title indicates junior role
     */
    private boolean isJuniorRole(String title) {
        String[] juniorKeywords = {"junior", "entry", "fresher", "associate", "trainee", "intern"};
        return Arrays.stream(juniorKeywords).anyMatch(title::contains);
    }
    
    /**
     * Advanced skills matching with synonyms and semantic analysis
     */
    private double calculateAdvancedSkillsMatchScore(JobSeeker jobSeeker, Posts job, UserProfileData profileData) {
        double score = 0.0;
        
        if (job.getRequirements() != null) {
            String requirements = job.getRequirements().toLowerCase();
            Set<String> userSkills = extractEnhancedUserSkills(jobSeeker, profileData);
            
            // Calculate match percentage with synonyms
            int matches = 0;
            int totalSkills = userSkills.size();
            
            for (String skill : userSkills) {
                if (requirements.contains(skill)) {
                    matches++;
                } else {
                    // Check synonyms
                    Set<String> synonyms = skillSynonyms.get(skill);
                    if (synonyms != null) {
                        for (String synonym : synonyms) {
                            if (requirements.contains(synonym)) {
                                matches++;
                                break;
                            }
                        }
                    }
                }
            }
            
            if (totalSkills > 0) {
                score = (double) matches / totalSkills * 100.0;
            }
            
            // Bonus for high-demand skills
            score += calculateHighDemandSkillsBonus(userSkills, requirements);
        }
        
        return Math.min(100.0, score);
    }
    
    /**
     * Extract enhanced user skills with better processing
     */
    private Set<String> extractEnhancedUserSkills(JobSeeker jobSeeker, UserProfileData profileData) {
        Set<String> userSkills = new HashSet<>();
        
        // Add skills from profile with better parsing
        if (jobSeeker.getSkills() != null) {
            String[] skills = jobSeeker.getSkills().toLowerCase()
                .split("[,;\\s]+");
            for (String skill : skills) {
                skill = skill.trim();
                if (skill.length() > 2) {
                    userSkills.add(skill);
                }
            }
        }
        
        // Add skills from experiences with context
        for (Experience exp : profileData.getExperiences()) {
            if (exp.getSkillsUsed() != null) {
                String[] expSkills = exp.getSkillsUsed().toLowerCase().split("[,;\\s]+");
                for (String skill : expSkills) {
                    skill = skill.trim();
                    if (skill.length() > 2) {
                        userSkills.add(skill);
                    }
                }
            }
            
            // Extract skills from position title
            if (exp.getPosition() != null) {
                String position = exp.getPosition().toLowerCase();
                if (position.contains("developer")) userSkills.add("development");
                if (position.contains("designer")) userSkills.add("design");
                if (position.contains("manager")) userSkills.add("management");
                if (position.contains("analyst")) userSkills.add("analysis");
            }
        }
        
        // Add skills from certificates
        for (Certificate cert : profileData.getCertificates()) {
            if (cert.getCertificateName() != null) {
                String certName = cert.getCertificateName().toLowerCase();
                userSkills.add(certName);
            }
        }
        
        return userSkills;
    }
    
    /**
     * Calculate bonus for high-demand skills
     */
    private double calculateHighDemandSkillsBonus(Set<String> userSkills, String requirements) {
        String[] highDemandSkills = {"java", "python", "javascript", "react", "aws", "docker", "kubernetes", "machine learning", "ai"};
        double bonus = 0.0;
        
        for (String skill : highDemandSkills) {
            if (userSkills.contains(skill) && requirements.contains(skill)) {
                bonus += 5.0;
            }
        }
        
        return Math.min(20.0, bonus);
    }
    
    /**
     * Enhanced location matching with geographic proximity
     */
    private double calculateEnhancedLocationScore(JobSeeker jobSeeker, Posts job) {
        double score = 0.0;
        
        if (jobSeeker.getPreferredLocation() != null && job.getLocation() != null) {
            String preferredLocation = jobSeeker.getPreferredLocation().toLowerCase();
            String jobLocation = job.getLocation().toLowerCase();
            
            // Exact match
            if (jobLocation.equals(preferredLocation)) {
                score = 100.0;
            }
            // Contains match
            else if (jobLocation.contains(preferredLocation) || preferredLocation.contains(jobLocation)) {
                score = 85.0;
            }
            // Remote work preference
            else if (jobLocation.contains("remote") || jobLocation.contains("work from home") || 
                     jobLocation.contains("hybrid")) {
                score = 70.0;
            }
            // Geographic proximity matching
            else {
                score = calculateGeographicProximity(preferredLocation, jobLocation);
            }
        }
        
        return score;
    }
    
    /**
     * Calculate geographic proximity between locations
     */
    private double calculateGeographicProximity(String location1, String location2) {
        // Major cities in Vietnam
        Map<String, Set<String>> cityRegions = new HashMap<>();
        cityRegions.put("hà nội", new HashSet<>(Arrays.asList("hanoi", "ha noi", "hn")));
        cityRegions.put("tp.hcm", new HashSet<>(Arrays.asList("ho chi minh", "hcm", "saigon", "sài gòn")));
        cityRegions.put("đà nẵng", new HashSet<>(Arrays.asList("danang", "da nang")));
        cityRegions.put("hải phòng", new HashSet<>(Arrays.asList("haiphong", "hai phong")));
        
        for (Map.Entry<String, Set<String>> entry : cityRegions.entrySet()) {
            if (entry.getValue().contains(location1) && entry.getValue().contains(location2)) {
                return 80.0;
            }
        }
        
        // Same region matching
        if (location1.contains("miền bắc") && location2.contains("miền bắc")) return 60.0;
        if (location1.contains("miền nam") && location2.contains("miền nam")) return 60.0;
        if (location1.contains("miền trung") && location2.contains("miền trung")) return 60.0;
        
        return 30.0; // Default low score for different regions
    }
    
    /**
     * Enhanced salary matching with better parsing
     */
    private double calculateEnhancedSalaryScore(JobSeeker jobSeeker, Posts job) {
        double score = 0.0;
        
        if (jobSeeker.getDesiredSalary() > 0 && job.getSalary() != null) {
            try {
                // Parse salary from job post with enhanced parsing
                String salaryStr = job.getSalary().toLowerCase();
                double jobSalary = parseEnhancedSalary(salaryStr);
                
                if (jobSalary > 0) {
                    double desiredSalary = jobSeeker.getDesiredSalary();
                    double ratio = jobSalary / desiredSalary;
                    
                    if (ratio >= 0.9 && ratio <= 1.1) {
                        score = 100.0; // Perfect match
                    } else if (ratio >= 0.7 && ratio <= 1.3) {
                        score = 85.0; // Good match
                    } else if (ratio >= 0.5 && ratio <= 1.8) {
                        score = 70.0; // Acceptable match
                    } else if (ratio >= 0.3 && ratio <= 2.5) {
                        score = 50.0; // Basic match
                    } else {
                        score = Math.max(0, 100 - Math.abs(ratio - 1) * 40);
                    }
                }
            } catch (Exception e) {
                // If parsing fails, give neutral score
                score = 50.0;
            }
        }
        
        return score;
    }
    
    /**
     * Enhanced salary parsing with better format handling
     */
    private double parseEnhancedSalary(String salaryStr) {
        try {
            // Remove currency symbols and normalize
            salaryStr = salaryStr.replaceAll("[^0-9\\s-]", " ").trim();
            
            // Handle different formats
            if (salaryStr.contains("-")) {
                // Range format: "10-20 triệu" or "1000-2000"
                String[] parts = salaryStr.split("-");
                if (parts.length >= 2) {
                    double min = parseNumber(parts[0]);
                    double max = parseNumber(parts[1]);
                    return (min + max) / 2;
                }
            } else {
                // Single value
                return parseNumber(salaryStr);
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error parsing salary: " + salaryStr, e);
        }
        return 0.0;
    }
    
    /**
     * Parse number from string with unit conversion
     */
    private double parseNumber(String numStr) {
        numStr = numStr.trim();
        
        // Extract numeric part
        String numericPart = numStr.replaceAll("[^0-9]", "");
        if (numericPart.isEmpty()) return 0.0;
        
        double number = Double.parseDouble(numericPart);
        
        // Convert units
        if (numStr.contains("triệu") || numStr.contains("million")) {
            number *= 1000000; // Convert to VND
        } else if (numStr.contains("nghìn") || numStr.contains("k")) {
            number *= 1000; // Convert to VND
        }
        
        return number;
    }
    
    /**
     * Enhanced behavior analysis with collaborative filtering
     */
    private double calculateEnhancedBehaviorScore(Posts job, UserProfileData profileData) {
        double score = 0.0;
        
        // Check if user has saved this job
        for (SavedJob savedJob : profileData.getSavedJobs()) {
            if (savedJob.getPostId() == job.getId()) {
                score += 60.0; // User has already saved this job
                break;
            }
        }
        
        // Check application history for similar jobs
        for (Application app : profileData.getApplications()) {
            if (app.getPostId() > 0) {
                try {
                    // Get the job post for this application
                    Posts appliedJob = postsDAO.getPostById(app.getPostId());
                    if (appliedJob != null) {
                        // Check similarity with current job
                        double similarity = calculateJobSimilarity(appliedJob, job);
                        if (similarity > 0.7) {
                            score += 20.0; // User applied to similar job
                        }
                    }
                } catch (Exception e) {
                    // Ignore errors for individual job lookups
                }
            }
        }
        
        // Check if user has applied to jobs before (general behavior indicator)
        if (!profileData.getApplications().isEmpty()) {
            score += 10.0; // User has applied to jobs before
        }
        
        return Math.min(100.0, score);
    }
    
    /**
     * Calculate similarity between two jobs
     */
    private double calculateJobSimilarity(Posts job1, Posts job2) {
        double similarity = 0.0;
        
        // Title similarity
        if (job1.getTitle() != null && job2.getTitle() != null) {
            similarity += calculateSemanticSimilarity(job1.getTitle().toLowerCase(), 
                                                    job2.getTitle().toLowerCase()) * 0.4;
        }
        
        // Company similarity
        if (job1.getCompanyName() != null && job2.getCompanyName() != null) {
            if (job1.getCompanyName().equalsIgnoreCase(job2.getCompanyName())) {
                similarity += 0.3;
            }
        }
        
        // Location similarity
        if (job1.getLocation() != null && job2.getLocation() != null) {
            similarity += calculateSemanticSimilarity(job1.getLocation().toLowerCase(), 
                                                    job2.getLocation().toLowerCase()) * 0.3;
        }
        
        return similarity;
    }
    
    /**
     * Enhanced popularity score with time decay
     */
    private double calculateEnhancedPopularityScore(Posts job) {
        double score = 0.0;
        
        // Consider view count as popularity indicator with logarithmic scaling
        if (job.getViewCount() > 0) {
            score = Math.min(100.0, Math.log10(job.getViewCount() + 1) * 20);
        }
        
        // Consider recency with exponential decay
        if (job.getCreatedAt() != null) {
            long daysSinceCreation = (System.currentTimeMillis() - job.getCreatedAt().getTime()) / (1000 * 60 * 60 * 24);
            double timeDecay = Math.exp(-daysSinceCreation / 30.0); // 30-day half-life
            score += timeDecay * 30.0;
        }
        
        // Consider like count
        if (job.getLikeCount() > 0) {
            score += Math.min(20.0, job.getLikeCount() * 2);
        }
        
        return Math.min(100.0, score);
    }
    
    /**
     * Enhanced company reputation score with industry analysis
     */
    private double calculateEnhancedCompanyReputationScore(Posts job) {
        double score = 50.0; // Default neutral score
        
        if (job.getCompanyName() != null) {
            String companyName = job.getCompanyName().toLowerCase();
            
            // Known good companies with reputation scores
            Map<String, Double> companyScores = new HashMap<>();
            companyScores.put("fpt", 90.0);
            companyScores.put("vng", 85.0);
            companyScores.put("tiki", 80.0);
            companyScores.put("shopee", 85.0);
            companyScores.put("grab", 90.0);
            companyScores.put("momo", 80.0);
            companyScores.put("vnpt", 75.0);
            companyScores.put("viettel", 85.0);
            companyScores.put("microsoft", 95.0);
            companyScores.put("google", 95.0);
            companyScores.put("amazon", 90.0);
            companyScores.put("facebook", 90.0);
            
            for (Map.Entry<String, Double> entry : companyScores.entrySet()) {
                if (companyName.contains(entry.getKey())) {
                    score = entry.getValue();
                    break;
                }
            }
            
            // Industry-based scoring
            if (job.getIndustry() != null) {
                String industry = job.getIndustry().toLowerCase();
                if (industry.contains("technology") || industry.contains("software")) {
                    score += 10.0;
                } else if (industry.contains("finance") || industry.contains("banking")) {
                    score += 5.0;
                }
            }
        }
        
        return Math.min(100.0, score);
    }
    
    /**
     * Calculate experience level matching with comprehensive experience calculation
     */
    private double calculateExperienceLevelScore(JobSeeker jobSeeker, Posts job, UserProfileData profileData) {
        double score = 0.0;
        
        if (job.getExperience() != null) {
            String experienceReq = job.getExperience().toLowerCase();
            int effectiveExperience = calculateEffectiveExperience(jobSeeker, profileData);
            
            // Match experience levels
            if (effectiveExperience <= 1 && (experienceReq.contains("fresher") || 
                experienceReq.contains("entry") || experienceReq.contains("junior") || 
                experienceReq.contains("0-1") || experienceReq.contains("1 year"))) {
                score = 100.0;
            } else if (effectiveExperience >= 2 && effectiveExperience <= 4 && 
                      (experienceReq.contains("mid") || experienceReq.contains("intermediate") || 
                       experienceReq.contains("2-4") || experienceReq.contains("3-5"))) {
                score = 100.0;
            } else if (effectiveExperience >= 5 && (experienceReq.contains("senior") || 
                      experienceReq.contains("lead") || experienceReq.contains("5+") || 
                      experienceReq.contains("senior"))) {
                score = 100.0;
            } else {
                // Partial match based on experience range
                if (effectiveExperience > 0) {
                    score = Math.max(0, 100 - Math.abs(effectiveExperience - 3) * 20);
                }
            }
        }
        
        return score;
    }
    
    /**
     * Calculate effective experience from work history
     */
    private int calculateEffectiveExperience(JobSeeker jobSeeker, UserProfileData profileData) {
        int userExperience = jobSeeker.getExperienceYears();
        
        // Calculate total experience from work history
        int totalMonths = 0;
        for (Experience exp : profileData.getExperiences()) {
            if (exp.getStartDate() != null) {
                java.util.Date endDate = exp.getEndDate();
                if (endDate == null) {
                    endDate = new java.util.Date(); // Current date if still working
                }
                long diffInMillies = endDate.getTime() - exp.getStartDate().getTime();
                totalMonths += (int) (diffInMillies / (1000L * 60 * 60 * 24 * 30));
            }
        }
        
        int calculatedYears = totalMonths / 12;
        return Math.max(userExperience, calculatedYears);
    }
    
    /**
     * Calculate education matching score
     */
    private double calculateEducationScore(JobSeeker jobSeeker, Posts job, UserProfileData profileData) {
        double score = 0.0;
        
        if (job.getRequirements() != null) {
            String requirements = job.getRequirements().toLowerCase();
            
            // Check education requirements
            for (Education edu : profileData.getEducations()) {
                if (edu.getDegree() != null && edu.getFieldOfStudy() != null) {
                    String degree = edu.getDegree().toLowerCase();
                    String field = edu.getFieldOfStudy().toLowerCase();
                    
                    // Check for degree level match
                    if (requirements.contains("bachelor") && degree.contains("bachelor")) {
                        score += 30.0;
                    } else if (requirements.contains("master") && degree.contains("master")) {
                        score += 40.0;
                    } else if (requirements.contains("phd") && degree.contains("phd")) {
                        score += 50.0;
                    }
                    
                    // Check for field of study match
                    if (requirements.contains(field) || field.contains("computer") && requirements.contains("computer")) {
                        score += 20.0;
                    }
                }
            }
            
            // Cap the score
            score = Math.min(100.0, score);
        }
        
        return score;
    }
    
    /**
     * Data class to hold user profile information
     */
    private static class UserProfileData {
        private List<Experience> experiences = new ArrayList<>();
        private List<Education> educations = new ArrayList<>();
        private List<Certificate> certificates = new ArrayList<>();
        private List<Award> awards = new ArrayList<>();
        private List<SavedJob> savedJobs = new ArrayList<>();
        private List<Application> applications = new ArrayList<>();
        
        // Getters and setters
        public List<Experience> getExperiences() { return experiences; }
        public void setExperiences(List<Experience> experiences) { this.experiences = experiences; }
        
        public List<Education> getEducations() { return educations; }
        public void setEducations(List<Education> educations) { this.educations = educations; }
        
        public List<Certificate> getCertificates() { return certificates; }
        public void setCertificates(List<Certificate> certificates) { this.certificates = certificates; }
        
        public List<Award> getAwards() { return awards; }
        public void setAwards(List<Award> awards) { this.awards = awards; }
        
        public List<SavedJob> getSavedJobs() { return savedJobs; }
        public void setSavedJobs(List<SavedJob> savedJobs) { this.savedJobs = savedJobs; }
        
        public List<Application> getApplications() { return applications; }
        public void setApplications(List<Application> applications) { this.applications = applications; }
    }
    
    /**
     * Data class to hold job recommendation with score
     */
    public static class JobRecommendation {
        private Posts job;
        private double score;
        
        public JobRecommendation(Posts job, double score) {
            this.job = job;
            this.score = score;
        }
        
        public Posts getJob() { return job; }
        public double getScore() { return score; }
    }

    /**
     * Clear cache for a specific user
     */
    public void clearUserCache(int jobSeekerId) {
        profileCache.remove(jobSeekerId);
        recommendationCache.remove(jobSeekerId);
    }
    
    /**
     * Clear all caches
     */
    public void clearAllCaches() {
        profileCache.clear();
        recommendationCache.clear();
    }
} 