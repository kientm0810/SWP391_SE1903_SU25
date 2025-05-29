<%-- 
    Document   : admin_manage_jobseeker
    Created on : May 26, 2025, 9:05:43 AM
    Author     : andin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector, models.Recruiter" %>
<!DOCTYPE html>
<html>
    <%//get data from servlet (controller)
        Vector<Recruiter> vec = (Vector<Recruiter>)request.getAttribute("vec");
    %>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String RecruiterName = (String) request.getAttribute("RecruiterName");
            if (RecruiterName == null){
                RecruiterName = "";
            }
        %>
        
        <form action="AdminController">
            <p>Search Recruiter by name:
                <input type="text" name="RecruiterName" value="<%=RecruiterName%>">
                <input type="submit" name="submit" value="Search">
                <input type="reset" value="Reset">
                <input type="hidden" name="service" value="list">
                <input type="hidden" name="target" value="Recruiter">
            </p>
        </form>
        <h1>Hello World!</h1>
        
        <table border="1">
            <thead>
                <tr>               
                    <th>RecruiterID</th>
                    <th>Logo</th>
                    <th>Company Name</th>
                    <th>Loyal score</th>
                    <th>View detail</th>
                    <th>Ban/ Reassign</th>
                </tr>
            </thead>
            <tbody>
                <%for (Recruiter i : vec) {%>                   
                <tr>
                    <td><%=i.getId()%></td>
                    <td><%=i.getLogo()%></td>
                    <td><%=i.getCompanyName()%></td>
                    <td><%=i.getLoyaltyScore()%></td>
                    <td>
                        <button>
                            <a href="AdminController?target=Recruiter&service=Detail&ID=<%=i.getId()%>">
                                View
                            </a>
                        </button>
                    </td>
                    <td>
                        <button>
                            <a href="AdminController?target=Recruiter&service=Ban&ID=<%=i.getId()%>&status=<%=i.isActive() == true ? true : false%>">
                                <%=i.isActive() == true ? "Ban" : "Reassign"%>
                            </a>
                        </button>
                    </td>
                </tr>
                <%}%>
            </tbody>
        </table>
            
        <p><a href="AdminController?target=Recruiter&service=Add">Add Recruiter</a></p>
    </body>
</html>
