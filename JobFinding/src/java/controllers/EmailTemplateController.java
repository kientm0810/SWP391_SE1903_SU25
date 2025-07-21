package controllers;

import java.io.IOException;
import java.util.List;

import daos.EmailTemplateDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.EmailTemplate;

@WebServlet(name = "EmailTemplateController", urlPatterns = {"/load-email-templates"})
public class EmailTemplateController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String emailType = request.getParameter("emailType");
        
        if (emailType == null || emailType.trim().isEmpty()) {
            sendErrorResponse(response, "Email type is required");
            return;
        }

        try {
            EmailTemplateDAO templateDAO = new EmailTemplateDAO();
            
            // Kiểm tra và tạo dữ liệu mẫu nếu cần
            templateDAO.checkAndCreateSampleData();
            
            // Lấy templates theo type
            List<EmailTemplate> templates = templateDAO.getTemplatesByType(emailType);
            
            System.out.println("EmailTemplateController: Found " + templates.size() + " templates for type: " + emailType);
            
            // Convert to JSON manually
            String jsonResponse = convertTemplatesToJson(templates);
            
            System.out.println("EmailTemplateController: JSON Response length: " + jsonResponse.length());
            
            // Set response headers
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonResponse);
            
        } catch (Exception e) {
            System.err.println("EmailTemplateController Error: " + e.getMessage());
            e.printStackTrace();
            sendErrorResponse(response, "Error loading templates: " + e.getMessage());
        }
    }

    private String convertTemplatesToJson(List<EmailTemplate> templates) {
        StringBuilder json = new StringBuilder();
        json.append("[");
        
        for (int i = 0; i < templates.size(); i++) {
            EmailTemplate template = templates.get(i);
            json.append("{");
            json.append("\"id\":").append(template.getId()).append(",");
            json.append("\"templateName\":\"").append(escapeJson(template.getTemplateName())).append("\",");
            json.append("\"templateType\":\"").append(escapeJson(template.getTemplateType())).append("\",");
            json.append("\"subject\":\"").append(escapeJson(template.getSubject())).append("\",");
            json.append("\"bodyHtml\":\"").append(escapeJson(template.getBodyHtml())).append("\",");
            json.append("\"bodyText\":\"").append(escapeJson(template.getBodyText())).append("\",");
            json.append("\"variables\":\"").append(escapeJson(template.getVariables())).append("\",");
            json.append("\"isActive\":").append(template.isActive()).append(",");
            json.append("\"createdBy\":").append(template.getCreatedBy());
            json.append("}");
            
            if (i < templates.size() - 1) {
                json.append(",");
            }
        }
        
        json.append("]");
        return json.toString();
    }
    
    private String escapeJson(String text) {
        if (text == null) return "";
        return text.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }

    private void sendErrorResponse(HttpServletResponse response, String message) throws IOException {
        String errorResponse = "{\"error\":\"" + escapeJson(message) + "\"}";
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        response.getWriter().write(errorResponse);
    }
} 