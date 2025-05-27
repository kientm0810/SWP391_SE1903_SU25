<%-- 
    Document   : admin_detail_jobseeker
    Created on : May 27, 2025, 10:41:56 AM
    Author     : andin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector, models.Recruiter" %>
<!DOCTYPE html>
<html>
    <% Recruiter p = (Recruiter) request.getAttribute("Recruiter");%>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <table>
                <tr>              
                    <td>id</td>
                    <td><%= p.getId()%></td>
                </tr>
                <tr>              
                    <td>username</td>
                    <td><%= p.getUsername()%></td>
                </tr>
                <tr>
                    <td>password</td>
                    <td><%= p.getPassword()%></td>
                </tr>
                <tr>
                    <td>email</td>
                    <td><%= p.getEmail()%></td>
                </tr>
                <tr>
                    <td>fullName</td>
                    <td><%= p.getFullName()%></td>
                </tr>
                <tr>
                    <td>phone</td>
                    <td><%= p.getPhone()%></td>
                </tr>
                <tr>
                    <td>dateOfBirth</td>
                    <td><%= p.getDateOfBirth()%></td>
                </tr>
                <tr>
                    <td>gender</td>
                    <td><%= p.getGender()%></td>
                </tr>
                <tr>
                    <td>address</td>
                    <td><%= p.getAddress()%></td>
                </tr>
                <tr>
                    <td>profilePicture</td>
                    <td><%= p.getProfilePicture()%></td>
                </tr>
                
                <tr>
                    <td>companyName</td>
                    <td><%= p.getCompanyName()%></td>
                </tr>
                <tr>
                    <td>companyDescription</td>
                    <td><%= p.getCompanyDescription()%></td>
                </tr>
                <tr>
                    <td>logo</td>
                    <td><%= p.getLogo()%></td>
                </tr>
                <tr>
                    <td>website</td>
                    <td><%= p.getWebsite()%></td>
                </tr>
                <tr>
                    <td>companyAddress</td>
                    <td><%= p.getCompanyAddress()%></td>
                </tr>
                <tr>
                    <td>companySize</td>
                    <td><%= p.getCompanySize()%></td>
                </tr>
                <tr>
                    <td>industry</td>
                    <td><%= p.getIndustry()%></td>
                </tr>
                <tr>
                    <td>taxCode</td>
                    <td><%= p.getTaxCode()%></td>
                </tr>
                <tr>
                    <td>loyaltyScore</td>
                    <td><%= p.getLoyaltyScore()%></td>
                </tr>
                <tr>
                    <td>verificationStatus</td>
                    <td><%= p.getVerificationStatus()%></td>
                </tr>
                
                <tr>
                    <td>createdAt</td>
                    <td><%= p.getCreatedAt()%></td>
                </tr>
                <tr>
                    <td>updatedAt</td>
                    <td><%= p.getUpdatedAt()%></td>
                </tr>
                <tr>
                    <td>isActive</td>
                    <td><%= p.isActive() == true ? "Active" : "Banned"%></td>
                </tr>
            </table>
    </body>
</html>
