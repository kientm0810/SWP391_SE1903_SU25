<%-- 
    Document   : admin_add_jobseeker
    Created on : May 26, 2025, 10:46:21 AM
    Author     : andin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add jobseeker</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <form action="AdminController" method="POST">
            <table>
                <tr>              
                    <td>username</td>
                    <td><input type="text" name="username"></td>
                </tr>
                <tr>
                    <td>password</td>
                    <td><input type="text" name="password"></td>
                </tr>
                <tr>
                    <td>email</td>
                    <td><input type="text" name="email"></td>
                </tr>
                <tr>
                    <td>fullName</td>
                    <td><input type="text" name="fullName"></td>
                </tr>
                <tr>
                    <td>phone</td>
                    <td><input type="text" name="phone"></td>
                </tr>
                <tr>
                    <td>dateOfBirth</td>
                    <td><input type="date" name="dateOfBirth"></td>
                </tr>
                <tr>
                    <td>gender</td>
                    <td>
                        <select name="gender">                 
                            <option value="male">male</option> 
                            <option value="female">female</option> 
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>address</td>
                    <td><input type="text" name="address"></td>
                </tr>
                <tr>
                    <td>profilePicture</td>
                    <td><input type="text" name="profilePicture"></td>
                </tr>
                <tr>
                    <td>cvFile</td>
                    <td><input type="text" name="cvFile"></td>
                </tr>
                <tr>
                    <td>skills</td>
                    <td><input type="text" name="skills"></td>
                </tr>
                <tr>
                    <td>experienceYears</td>
                    <td><input type="text" name="experienceYears"></td>
                </tr>
                <tr>
                    <td>education</td>
                    <td><input type="text" name="education"></td>
                </tr>
                <tr>
                    <td>desiredJobTitle</td>
                    <td><input type="text" name="desiredJobTitle"></td>
                </tr>
                <tr>
                    <td>desiredSalary</td>
                    <td><input type="text" name="desiredSalary"></td>
                </tr>
                <tr>
                    <td>jobCategory</td>
                    <td><input type="text" name="jobCategory"></td>
                </tr>
                <tr>
                    <td>preferredLocation</td>
                    <td><input type="text" name="preferredLocation"></td>
                </tr>
                <tr>
                    <td>careerLevel</td>
                    <td><input type="text" name="careerLevel"></td>
                </tr>
                <tr>
                    <td>workType</td>
                    <td><input type="text" name="workType"></td>
                </tr>
                <tr>
                    <td>profileSummary</td>
                    <td><input type="text" name="profileSummary"></td>
                </tr>
                <tr>
                    <td>portfolioUrl</td>
                    <td><input type="text" name="portfolioUrl"></td>
                </tr>
                <tr>
                    <td>languages</td>
                    <td><input type="text" name="languages"></td>
                </tr>
                <tr>
                    <td>createdAt</td>
                    <td><input type="date" name="createdAt"></td>
                </tr>
                <tr>
                    <td>updatedAt</td>
                    <td><input type="date" name="updatedAt"></td>
                </tr>
                <tr>
                    <td>isActive</td>
                    <td><input type="radio" name="isActive" value="true" checked>Active
                        <input type="radio" name="isActive" value="false">DeActive
                    </td>
                </tr>
                <tr>
                    <td><input type="submit" name="submit" value="Add JobSeeker"></td>
                    <td><input type="reset" value="Reset">
                        <input type="hidden" name="service" value="Add">
                        <input type="hidden" name="target" value="JobSeeker">
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>
