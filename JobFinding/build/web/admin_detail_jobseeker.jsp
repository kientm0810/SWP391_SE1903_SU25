<%-- 
    Document   : admin_detail_jobseeker
    Created on : May 27, 2025, 10:41:56 AM
    Author     : andin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector, models.JobSeeker" %>
<!DOCTYPE html>
<html>
    <% JobSeeker p = (JobSeeker) request.getAttribute("JobSeeker");%>
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
                    <td>cvFile</td>
                    <td><%= p.getCvFile()%></td>
                </tr>
                <tr>
                    <td>skills</td>
                    <td><%= p.getSkills()%></td>
                </tr>
                <tr>
                    <td>experienceYears</td>
                    <td><%= p.getExperienceYears()%></td>
                </tr>
                <tr>
                    <td>education</td>
                    <td><%= p.getEducation()%></td>
                </tr>
                <tr>
                    <td>desiredJobTitle</td>
                    <td><%= p.getDesiredJobTitle()%></td>
                </tr>
                <tr>
                    <td>desiredSalary</td>
                    <td><%= p.getDesiredSalary()%></td>
                </tr>
                <tr>
                    <td>jobCategory</td>
                    <td><%= p.getJobCategory()%></td>
                </tr>
                <tr>
                    <td>preferredLocation</td>
                    <td><%= p.getPreferredLocation()%></td>
                </tr>
                <tr>
                    <td>careerLevel</td>
                    <td><%= p.getCareerLevel()%></td>
                </tr>
                <tr>
                    <td>workType</td>
                    <td><%= p.getWorkType()%></td>
                </tr>
                <tr>
                    <td>profileSummary</td>
                    <td><%= p.getProfileSummary()%></td>
                </tr>
                <tr>
                    <td>portfolioUrl</td>
                    <td><%= p.getPortfolioUrl()%></td>
                </tr>
                <tr>
                    <td>languages</td>
                    <td><%= p.getLanguages()%></td>
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
