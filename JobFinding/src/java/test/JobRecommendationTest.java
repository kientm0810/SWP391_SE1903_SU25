package test;

import java.util.Date;
import java.util.List;

import models.JobSeeker;
import models.Posts;
import services.JobRecommendationService;

/**
 * Test class for the enhanced Job Recommendation System
 * This class provides comprehensive testing of the recommendation algorithms
 */
public class JobRecommendationTest {
    
    public static void main(String[] args) {
        System.out.println("=== Enhanced Job Recommendation System Test ===\n");
        
        try {
            // Create test job seeker with comprehensive profile
            JobSeeker testJobSeeker = createTestJobSeeker();
            
            // Initialize the recommendation service
            JobRecommendationService recommendationService = new JobRecommendationService();
            
            // Get recommendations
            System.out.println("Getting job recommendations for: " + testJobSeeker.getFullName());
            System.out.println("Desired Job Title: " + testJobSeeker.getDesiredJobTitle());
            System.out.println("Preferred Location: " + testJobSeeker.getPreferredLocation());
            System.out.println("Desired Salary: " + testJobSeeker.getDesiredSalary());
            System.out.println("Skills: " + testJobSeeker.getSkills());
            System.out.println();
            
            List<JobRecommendationService.JobRecommendation> recommendations = 
                recommendationService.getRecommendations(testJobSeeker, 10);
            
            // Display results
            System.out.println("=== Top Job Recommendations ===");
            if (recommendations.isEmpty()) {
                System.out.println("No recommendations found. This might be due to:");
                System.out.println("- No active job posts in the database");
                System.out.println("- Database connection issues");
                System.out.println("- Insufficient job seeker profile data");
            } else {
                for (int i = 0; i < recommendations.size(); i++) {
                    JobRecommendationService.JobRecommendation rec = recommendations.get(i);
                    Posts job = rec.getJob();
                    double score = rec.getScore();
                    
                    System.out.println((i + 1) + ". " + job.getTitle());
                    System.out.println("   Company: " + job.getCompanyName());
                    System.out.println("   Location: " + job.getLocation());
                    System.out.println("   Salary: " + job.getSalary());
                    System.out.println("   Match Score: " + String.format("%.2f", score) + "%");
                    System.out.println("   Job Type: " + job.getJobType());
                    System.out.println("   Experience: " + job.getExperience());
                    System.out.println("   Posted: " + job.getCreatedAt());
                    System.out.println();
                }
            }
            
            // Test cache functionality
            System.out.println("=== Testing Cache Functionality ===");
            long startTime = System.currentTimeMillis();
            List<JobRecommendationService.JobRecommendation> cachedRecommendations = 
                recommendationService.getRecommendations(testJobSeeker, 5);
            long endTime = System.currentTimeMillis();
            
            System.out.println("Cached recommendations retrieved in: " + (endTime - startTime) + "ms");
            System.out.println("Number of cached recommendations: " + cachedRecommendations.size());
            
            // Test cache clearing
            System.out.println("\nClearing user cache...");
            recommendationService.clearUserCache(testJobSeeker.getId());
            System.out.println("Cache cleared successfully");
            
        } catch (Exception e) {
            System.err.println("Error during testing: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Create a comprehensive test job seeker profile
     */
    private static JobSeeker createTestJobSeeker() {
        JobSeeker jobSeeker = new JobSeeker();
        
        // Basic information
        jobSeeker.setId(1);
        jobSeeker.setFullName("Nguyễn Văn A");
        jobSeeker.setEmail("nguyenvana@email.com");
        jobSeeker.setPhone("0123456789");
        jobSeeker.setAddress("Hà Nội, Việt Nam");
        
        // Job preferences
        jobSeeker.setDesiredJobTitle("Java Developer");
        jobSeeker.setPreferredLocation("Hà Nội");
        jobSeeker.setDesiredSalary(25000000.0); // 25 million VND
        jobSeeker.setJobCategory("Information Technology");
        jobSeeker.setCareerLevel("Mid-level");
        jobSeeker.setWorkType("Full-time");
        
        // Skills and experience
        jobSeeker.setSkills("Java, Spring Boot, MySQL, JavaScript, React, Git, Docker, AWS");
        jobSeeker.setExperienceYears(3);
        jobSeeker.setEducation("Bachelor's Degree in Computer Science");
        
        // Profile summary
        jobSeeker.setProfileSummary("Experienced Java developer with 3+ years of experience in web development. " +
                                   "Proficient in Spring Boot, React, and cloud technologies. " +
                                   "Passionate about clean code and software architecture.");
        
        // Additional information
        jobSeeker.setLanguages("Vietnamese (Native), English (Fluent)");
        jobSeeker.setPortfolioUrl("https://github.com/nguyenvana");
        jobSeeker.setCreatedAt(new Date());
        jobSeeker.setUpdatedAt(new Date());
        jobSeeker.setActive(true);
        
        return jobSeeker;
    }
    
    /**
     * Create sample job posts for testing
     */
    private static Posts createSampleJobPost(int id, String title, String company, String location, 
                                           String salary, String requirements, String jobType, String experience) {
        Posts job = new Posts();
        
        job.setId(id);
        job.setTitle(title);
        job.setCompanyName(company);
        job.setLocation(location);
        job.setSalary(salary);
        job.setRequirements(requirements);
        job.setJobType(jobType);
        job.setExperience(experience);
        job.setStatus("active");
        job.setCreatedAt(new Date());
        job.setViewCount((int) (Math.random() * 100));
        job.setLikeCount((int) (Math.random() * 20));
        
        return job;
    }
    
    /**
     * Test the scoring algorithm with sample data
     */
    public static void testScoringAlgorithm() {
        System.out.println("\n=== Testing Scoring Algorithm ===");
        
        JobSeeker jobSeeker = createTestJobSeeker();
        
        // Create sample jobs with different characteristics
        Posts perfectMatch = createSampleJobPost(1, "Senior Java Developer", "FPT Software", "Hà Nội", 
                                               "25-35 triệu", "Java, Spring Boot, MySQL, 3+ years experience", 
                                               "Full-time", "3-5 years");
        
        Posts goodMatch = createSampleJobPost(2, "Java Backend Developer", "VNG Corporation", "Hà Nội", 
                                            "20-30 triệu", "Java, Spring, SQL, 2+ years experience", 
                                            "Full-time", "2-4 years");
        
        Posts partialMatch = createSampleJobPost(3, "Software Engineer", "TechViet Solutions", "TP.HCM", 
                                               "18-25 triệu", "Java, JavaScript, React, 1+ years experience", 
                                               "Full-time", "1-3 years");
        
        Posts poorMatch = createSampleJobPost(4, "UI/UX Designer", "Creative Agency", "Đà Nẵng", 
                                            "15-20 triệu", "Figma, Adobe XD, Photoshop, design experience", 
                                            "Full-time", "1-2 years");
        
        System.out.println("Sample jobs created for testing:");
        System.out.println("1. Perfect Match: " + perfectMatch.getTitle() + " at " + perfectMatch.getCompanyName());
        System.out.println("2. Good Match: " + goodMatch.getTitle() + " at " + goodMatch.getCompanyName());
        System.out.println("3. Partial Match: " + partialMatch.getTitle() + " at " + partialMatch.getCompanyName());
        System.out.println("4. Poor Match: " + poorMatch.getTitle() + " at " + poorMatch.getCompanyName());
        
        System.out.println("\nExpected scoring behavior:");
        System.out.println("- Perfect match should score highest (80-100%)");
        System.out.println("- Good match should score well (60-80%)");
        System.out.println("- Partial match should score moderately (30-60%)");
        System.out.println("- Poor match should score low (0-30%)");
    }
    
    /**
     * Test performance with different recommendation limits
     */
    public static void testPerformance() {
        System.out.println("\n=== Performance Testing ===");
        
        try {
            JobSeeker jobSeeker = createTestJobSeeker();
            JobRecommendationService service = new JobRecommendationService();
            
            int[] limits = {5, 10, 20, 50};
            
            for (int limit : limits) {
                long startTime = System.currentTimeMillis();
                List<JobRecommendationService.JobRecommendation> recommendations = 
                    service.getRecommendations(jobSeeker, limit);
                long endTime = System.currentTimeMillis();
                
                System.out.println("Limit: " + limit + " jobs");
                System.out.println("Time taken: " + (endTime - startTime) + "ms");
                System.out.println("Results returned: " + recommendations.size());
                System.out.println();
            }
            
        } catch (Exception e) {
            System.err.println("Performance test failed: " + e.getMessage());
        }
    }
} 