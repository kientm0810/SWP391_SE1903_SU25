package controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import context.DBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DatabaseCheckController", urlPatterns = {"/check-database"})
public class DatabaseCheckController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            // Test database connection
            Connection conn = new DBContext().getConnection();
            
            response.getWriter().println("<html><body>");
            response.getWriter().println("<h2>Database Structure Check</h2>");
            response.getWriter().println("<p><strong>Database Connection:</strong> SUCCESS</p>");
            
            // Check Email_History table structure
            try (Statement stmt = conn.createStatement()) {
                ResultSet rs = stmt.executeQuery("SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Email_History' ORDER BY ORDINAL_POSITION");
                response.getWriter().println("<h3>Email_History Table Structure:</h3>");
                response.getWriter().println("<table border='1' style='border-collapse: collapse;'>");
                response.getWriter().println("<tr><th>Column Name</th><th>Data Type</th><th>Nullable</th></tr>");
                
                boolean hasRecruiterId = false;
                boolean hasTemplateName = false;
                
                while (rs.next()) {
                    String columnName = rs.getString("COLUMN_NAME");
                    String dataType = rs.getString("DATA_TYPE");
                    String nullable = rs.getString("IS_NULLABLE");
                    
                    response.getWriter().println("<tr>");
                    response.getWriter().println("<td>" + columnName + "</td>");
                    response.getWriter().println("<td>" + dataType + "</td>");
                    response.getWriter().println("<td>" + nullable + "</td>");
                    response.getWriter().println("</tr>");
                    
                    if ("recruiter_id".equals(columnName)) {
                        hasRecruiterId = true;
                    }
                    if ("template_name".equals(columnName)) {
                        hasTemplateName = true;
                    }
                }
                response.getWriter().println("</table>");
                
                response.getWriter().println("<h3>Column Check Results:</h3>");
                response.getWriter().println("<p><strong>recruiter_id column exists:</strong> " + (hasRecruiterId ? "YES" : "NO") + "</p>");
                response.getWriter().println("<p><strong>template_name column exists:</strong> " + (hasTemplateName ? "YES" : "NO") + "</p>");
            }
            
            // Check current records
            try (Statement stmt = conn.createStatement()) {
                ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM Email_History");
                if (rs.next()) {
                    int count = rs.getInt(1);
                    response.getWriter().println("<p><strong>Total records in Email_History:</strong> " + count + "</p>");
                }
            }
            
            // Test insert with current structure
            try (Statement stmt = conn.createStatement()) {
                response.getWriter().println("<h3>Testing Insert:</h3>");
                
                // Try to insert a test record
                String insertSql = "INSERT INTO Email_History (application_id, recruiter_id, template_name, recipient_email, subject, body_html, status, sent_at, created_at) VALUES (1, 1, 'Test', 'test@test.com', 'Test Subject', 'Test Content', 'sent', GETDATE(), GETDATE())";
                
                try {
                    int result = stmt.executeUpdate(insertSql);
                    response.getWriter().println("<p><strong>Test Insert Result:</strong> SUCCESS (" + result + " rows affected)</p>");
                    
                    // Clean up - delete the test record
                    stmt.executeUpdate("DELETE FROM Email_History WHERE recipient_email = 'test@test.com'");
                    response.getWriter().println("<p><strong>Test record cleaned up</strong></p>");
                    
                } catch (SQLException e) {
                    response.getWriter().println("<p><strong>Test Insert Result:</strong> FAILED</p>");
                    response.getWriter().println("<p><strong>Error:</strong> " + e.getMessage() + "</p>");
                }
            }
            
            conn.close();
            
        } catch (SQLException e) {
            response.getWriter().println("<h2>Database Error</h2>");
            response.getWriter().println("<p><strong>Error:</strong> " + e.getMessage() + "</p>");
            response.getWriter().println("<pre>" + e.toString() + "</pre>");
            e.printStackTrace();
        }
        
        response.getWriter().println("<p><a href='email-history-test'>Go to Email History Test</a></p>");
        response.getWriter().println("</body></html>");
    }
} 