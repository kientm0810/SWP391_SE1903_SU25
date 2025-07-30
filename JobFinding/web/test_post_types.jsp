<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="daos.PostTypeDAO" %>
<%@ page import="models.PostType" %>
<%@ page import="java.util.Vector" %>
<!DOCTYPE html>
<html>
<head>
    <title>Test PostTypes</title>
</head>
<body>
    <h1>Test PostTypes Database</h1>
    
    <%
    try {
        PostTypeDAO postTypeDAO = new PostTypeDAO();
        Vector<PostType> postTypes = postTypeDAO.getAllPostTypes();
        
        out.println("<h2>Total PostTypes: " + postTypes.size() + "</h2>");
        
        if (postTypes.isEmpty()) {
            out.println("<p style='color: red;'>No PostTypes found in database!</p>");
            out.println("<p>Please run the database script: database/post_type_blog_type_tables.sql</p>");
        } else {
            out.println("<table border='1' style='border-collapse: collapse;'>");
            out.println("<tr><th>ID</th><th>Code</th><th>Name</th><th>Category</th><th>Active</th></tr>");
            
            for (PostType pt : postTypes) {
                out.println("<tr>");
                out.println("<td>" + pt.getId() + "</td>");
                out.println("<td>" + pt.getTypeCode() + "</td>");
                out.println("<td>" + pt.getTypeName() + "</td>");
                out.println("<td>" + pt.getCategory() + "</td>");
                out.println("<td>" + pt.isActive() + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");
        }
        
    } catch (Exception e) {
        out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    }
    %>
    
    <h2>Database Connection Test</h2>
    <%
    try {
        PostTypeDAO postTypeDAO = new PostTypeDAO();
        out.println("<p style='color: green;'>Database connection successful!</p>");
    } catch (Exception e) {
        out.println("<p style='color: red;'>Database connection failed: " + e.getMessage() + "</p>");
    }
    %>
</body>
</html> 