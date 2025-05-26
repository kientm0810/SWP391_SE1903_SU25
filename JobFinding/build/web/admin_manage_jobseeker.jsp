<%-- 
    Document   : admin_manage_jobseeker
    Created on : May 26, 2025, 9:05:43 AM
    Author     : andin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector, models.JobSeeker" %>
<!DOCTYPE html>
<html>
    <%//get data from servlet (controller)
        Vector<JobSeeker> vec = (Vector<JobSeeker>)request.getAttribute("vec");
    %>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        
        <table border="1">
            <thead>
                <tr>               
                    <th>JobSeekerID</th>
                    <th>Profile picture</th>
                    <th>Full name</th>
                    <th>View detail</th>
                </tr>
            </thead>
            <tbody>
                <%for (Products product : list) {%>                   
                <tr>
                    <td><%=product.getProductID()%></td>
                    <td><%=product.getProductName()%></td>
                </tr>
                <%}%>
            </tbody>
        </table>
    </body>
</html>
