package controllers;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import daos.JobSearchDAO;
import daos.PostsDAO;
import daos.SearchSuggestionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.AdvancedSearchCriteria;
import models.JobSearch;
import models.Posts;

@WebServlet(name="AdvancedSearchController", urlPatterns={"/advanced-search"})
public class AdvancedSearchController extends HttpServlet {
    
    private PostsDAO postsDAO;
    private JobSearchDAO jobSearchDAO;
    private SearchSuggestionDAO searchSuggestionDAO;
    
    @Override
    public void init() throws ServletException {
        postsDAO = new PostsDAO();
        jobSearchDAO = new JobSearchDAO();
        searchSuggestionDAO = new SearchSuggestionDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Parse search criteria from request parameters
            AdvancedSearchCriteria criteria = parseSearchCriteria(request);
            
            String action = request.getParameter("action");
            if (action == null){
                action = "";
            }
            
            // Get search results
            List<Posts> jobs = postsDAO.advancedSearch(criteria);
            int totalJobs = postsDAO.countAdvancedSearchResults(criteria);
            
            if (!action.equals("search")){
                jobs = postsDAO.getAllPosts(); // can fix
                totalJobs = jobs.size();
            }
            
            // Calculate pagination
            int totalPages = (int) Math.ceil((double) totalJobs / criteria.getPageSize());
            
            // Save search history if user is logged in
            HttpSession session = request.getSession();
            Integer jobSeekerId = (Integer) session.getAttribute("userId");
            if (jobSeekerId != null && criteria.hasFilters()) {
                try {
                    saveSearchHistory(jobSeekerId, criteria, totalJobs);
                } catch (Exception e) {
                    // Log error but don't fail the search
                    System.err.println("Error saving search history: " + e.getMessage());
                }
            }
            
            // Get search suggestions
            List<String> popularKeywords = new ArrayList<>();
            List<String> popularLocations = new ArrayList<>();
            try {
                popularKeywords = searchSuggestionDAO.getPopularKeywords(10);
                popularLocations = searchSuggestionDAO.getPopularLocations(10);
            } catch (Exception e) {
                // Log error but don't fail the search
                System.err.println("Error getting search suggestions: " + e.getMessage());
            }
            
            // Set attributes for JSP
            request.setAttribute("jobs", jobs);
            request.setAttribute("totalJobs", totalJobs);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", criteria.getPage());
            request.setAttribute("searchTime", 0);
            request.setAttribute("popularKeywords", popularKeywords);
            request.setAttribute("popularLocations", popularLocations);
            request.setAttribute("criteria", criteria);
            
            // Build query string for pagination
            String queryString = buildQueryString(request);
            request.setAttribute("queryString", queryString);
            
            // Forward to JSP
            request.getRequestDispatcher("/advanced-search.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Có lỗi xảy ra khi tìm kiếm: " + e.getMessage());
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    private AdvancedSearchCriteria parseSearchCriteria(HttpServletRequest request) {
        AdvancedSearchCriteria criteria = new AdvancedSearchCriteria();
        
        // Basic search
        criteria.setKeyword(request.getParameter("keyword"));
        criteria.setLocation(request.getParameter("location"));
        criteria.setIndustry(request.getParameter("industry"));
        
        // Job details
        criteria.setJobType(request.getParameter("jobType"));
        criteria.setExperienceLevel(request.getParameter("experienceLevel"));
        criteria.setWorkType(request.getParameter("workType"));
        
        // Salary range
        String minSalaryStr = request.getParameter("minSalary");
        if (minSalaryStr != null && !minSalaryStr.trim().isEmpty()) {
            try {
                criteria.setMinSalary(new BigDecimal(minSalaryStr));
            } catch (NumberFormatException e) {
                // Ignore invalid salary
            }
        }
        
        String maxSalaryStr = request.getParameter("maxSalary");
        if (maxSalaryStr != null && !maxSalaryStr.trim().isEmpty()) {
            try {
                criteria.setMaxSalary(new BigDecimal(maxSalaryStr));
            } catch (NumberFormatException e) {
                // Ignore invalid salary
            }
        }
        
        // Company & benefits
        criteria.setCompanySize(request.getParameter("companySize"));
        criteria.setBenefits(request.getParameter("benefits"));
        
        // Skills & requirements
        criteria.setSkills(request.getParameter("skills"));
        criteria.setEducation(request.getParameter("education"));
        criteria.setLanguage(request.getParameter("language"));
        
        // Sort options
        criteria.setSortBy(request.getParameter("sortBy"));
        criteria.setSortOrder(request.getParameter("sortOrder"));
        
        // Pagination
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.trim().isEmpty()) {
            try {
                criteria.setPage(Integer.parseInt(pageStr));
            } catch (NumberFormatException e) {
                criteria.setPage(1);
            }
        }
        
        String pageSizeStr = request.getParameter("pageSize");
        if (pageSizeStr != null && !pageSizeStr.trim().isEmpty()) {
            try {
                criteria.setPageSize(Integer.parseInt(pageSizeStr));
            } catch (NumberFormatException e) {
                criteria.setPageSize(10);
            }
        }
        
        // Save search options
        String saveSearch = request.getParameter("saveSearch");
        if ("true".equals(saveSearch)) {
            criteria.setSaved(true);
            criteria.setSearchName(request.getParameter("searchName"));
        }
        
        return criteria;
    }
    
    private void saveSearchHistory(Integer jobSeekerId, AdvancedSearchCriteria criteria, int resultCount) {
        try {
            JobSearch jobSearch = new JobSearch();
            jobSearch.setJobSeekerId(jobSeekerId);
            jobSearch.setSearchType("advanced");
            jobSearch.setKeyword(criteria.getKeyword());
            jobSearch.setLocation(criteria.getLocation());
            jobSearch.setIndustry(criteria.getIndustry());
            jobSearch.setJobLevel(criteria.getExperienceLevel());
            jobSearch.setJobType(criteria.getJobType());
            jobSearch.setMinSalary(criteria.getMinSalary());
            jobSearch.setMaxSalary(criteria.getMaxSalary());
            jobSearch.setBenefits(criteria.getBenefits());
            jobSearch.setLanguage(criteria.getLanguage());
            jobSearch.setSortBy(criteria.getSortBy());
            jobSearch.setSortOrder(criteria.getSortOrder());
            jobSearch.setIsSaved(criteria.isSaved() ? true : false);
            jobSearch.setSearchName(criteria.getSearchName());
            jobSearch.setResultCount(resultCount);
            jobSearch.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            jobSearch.setLastUsed(new Timestamp(System.currentTimeMillis()));
            
            jobSearchDAO.saveJobSearch(jobSearch);
            
            // Update search suggestions
            try {
                if (criteria.getKeyword() != null && !criteria.getKeyword().trim().isEmpty()) {
                    searchSuggestionDAO.updateKeywordFrequency(criteria.getKeyword(), "job_title");
                }
                if (criteria.getLocation() != null && !criteria.getLocation().trim().isEmpty()) {
                    searchSuggestionDAO.updateKeywordFrequency(criteria.getLocation(), "location");
                }
            } catch (Exception e) {
                // Log error but don't fail the search
                System.err.println("Error updating search suggestions: " + e.getMessage());
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            // Log error but don't fail the search
        }
    }
    
    private String buildQueryString(HttpServletRequest request) {
        StringBuilder queryString = new StringBuilder();
        
        String[] params = {
            "keyword", "location", "industry", "jobType", "experienceLevel", 
            "workType", "minSalary", "maxSalary", "companySize", "benefits",
            "skills", "education", "language", "sortBy", "sortOrder"
        };
        
        for (String param : params) {
            String value = request.getParameter(param);
            if (value != null && !value.trim().isEmpty()) {
                if (queryString.length() > 0) {
                    queryString.append("&");
                }
                queryString.append(param).append("=").append(value);
            }
        }
        
        return queryString.toString();
    }
} 