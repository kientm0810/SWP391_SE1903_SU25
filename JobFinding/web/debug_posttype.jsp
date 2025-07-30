<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="daos.PostTypeDAO" %>
<%@ page import="models.PostType" %>
<%@ page import="java.util.Vector" %>
<!DOCTYPE html>
<html>
<head>
    <title>Debug PostType</title>
</head>
<body>
    <h1>Debug PostType DAO</h1>
    
    <%
    try {
        out.println("<h2>Step 1: Creating PostTypeDAO</h2>");
        PostTypeDAO postTypeDAO = new PostTypeDAO();
        out.println("<p style='color: green;'>✓ PostTypeDAO created successfully</p>");
        
        out.println("<h2>Step 2: Calling getAllPostTypes()</h2>");
        Vector<PostType> postTypes = postTypeDAO.getAllPostTypes();
        out.println("<p style='color: green;'>✓ getAllPostTypes() called successfully</p>");
        out.println("<p>Total PostTypes: " + postTypes.size() + "</p>");
        
        if (postTypes.isEmpty()) {
            out.println("<p style='color: orange;'>⚠ No PostTypes found in database</p>");
            out.println("<p>Please run: database/post_type_blog_type_tables.sql</p>");
        } else {
            out.println("<p style='color: green;'>✓ PostTypes found!</p>");
            out.println("<h3>PostTypes List:</h3>");
            out.println("<ul>");
            for (PostType pt : postTypes) {
                out.println("<li>" + pt.getId() + " - " + pt.getTypeName() + " (" + pt.getTypeCode() + ")</li>");
            }
            out.println("</ul>");
        }
        
        out.println("<h2>Step 3: Calling getPostTypeStats()</h2>");
        Vector<Object[]> stats = postTypeDAO.getPostTypeStats();
        out.println("<p style='color: green;'>✓ getPostTypeStats() called successfully</p>");
        out.println("<p>Total stats: " + stats.size() + "</p>");
        
    } catch (Exception e) {
        out.println("<p style='color: red;'>✗ Error: " + e.getMessage() + "</p>");
        out.println("<h3>Stack Trace:</h3>");
        out.println("<pre>");
        e.printStackTrace();
        out.println("</pre>");
    }
    %>
    
    <h2>Database Connection Test</h2>
    <%
    try {
        PostTypeDAO testDAO = new PostTypeDAO();
        out.println("<p style='color: green;'>✓ Database connection successful</p>");
    } catch (Exception e) {
        out.println("<p style='color: red;'>✗ Database connection failed: " + e.getMessage() + "</p>");
    }
    %>
</body>
</html> 