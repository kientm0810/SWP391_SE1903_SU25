package controllers;

import java.io.IOException;
import java.util.List;

import daos.SearchSuggestionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name="SearchSuggestionController", urlPatterns={"/search-suggestions"})
public class SearchSuggestionController extends HttpServlet {
    
    private SearchSuggestionDAO searchSuggestionDAO;
    
    @Override
    public void init() throws ServletException {
        searchSuggestionDAO = new SearchSuggestionDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            String query = request.getParameter("q");
            String type = request.getParameter("type");
            String limitStr = request.getParameter("limit");
            
            int limit = 10;
            if (limitStr != null && !limitStr.trim().isEmpty()) {
                try {
                    limit = Integer.parseInt(limitStr);
                } catch (NumberFormatException e) {
                    limit = 10;
                }
            }
            
            List<String> suggestions = null;
            
            if (query != null && !query.trim().isEmpty()) {
                // Search suggestions based on query
                if ("keyword".equals(type)) {
                    suggestions = searchSuggestionDAO.searchSuggestions(query, "job_title", limit);
                } else if ("location".equals(type)) {
                    suggestions = searchSuggestionDAO.searchSuggestions(query, "location", limit);
                } else if ("industry".equals(type)) {
                    suggestions = searchSuggestionDAO.searchSuggestions(query, "industry", limit);
                } else {
                    // Search all types
                    suggestions = searchSuggestionDAO.searchSuggestions(query, "job_title", limit);
                    suggestions.addAll(searchSuggestionDAO.searchSuggestions(query, "location", limit));
                    suggestions.addAll(searchSuggestionDAO.searchSuggestions(query, "industry", limit));
                }
            } else {
                // Get popular suggestions
                if ("keyword".equals(type)) {
                    suggestions = searchSuggestionDAO.getPopularKeywords(limit);
                } else if ("location".equals(type)) {
                    suggestions = searchSuggestionDAO.getPopularLocations(limit);
                } else if ("industry".equals(type)) {
                    suggestions = searchSuggestionDAO.getPopularIndustries(limit);
                } else {
                    // Get all popular suggestions
                    suggestions = searchSuggestionDAO.getPopularKeywords(limit);
                    suggestions.addAll(searchSuggestionDAO.getPopularLocations(limit));
                }
            }
            
            StringBuilder json = new StringBuilder();
            json.append("{\"success\":true,\"suggestions\":[");
            
            for (int i = 0; i < suggestions.size(); i++) {
                json.append("\"").append(suggestions.get(i).replace("\"", "\\\"")).append("\"");
                if (i < suggestions.size() - 1) {
                    json.append(",");
                }
            }
            
            json.append("],\"count\":").append(suggestions.size()).append("}");
            
            response.getWriter().write(json.toString());
            
        } catch (Exception e) {
            e.printStackTrace();
            
            String errorJson = "{\"success\":false,\"message\":\"Có lỗi xảy ra khi lấy gợi ý\"}";
            response.getWriter().write(errorJson);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
} 