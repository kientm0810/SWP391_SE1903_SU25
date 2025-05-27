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
        <title>Add Recruiter</title>
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
                    <td>companyName</td>
                    <td><input type="text" name="companyName"></td>
                </tr>
                <tr>
                    <td>companyDescription</td>
                    <td><input type="text" name="companyDescription"></td>
                </tr>
                <tr>
                    <td>logo</td>
                    <td><input type="text" name="logo"></td>
                </tr>
                <tr>
                    <td>website</td>
                    <td><input type="text" name="website"></td>
                </tr>
                <tr>
                    <td>companyAddress</td>
                    <td><input type="text" name="companyAddress"></td>
                </tr>
                <tr>
                    <td>companySize</td>
                    <td><input type="text" name="companySize"></td>
                </tr>
                <tr>
                    <td>industry</td>
                    <td><input type="text" name="industry"></td>
                </tr>
                <tr>
                    <td>taxCode</td>
                    <td><input type="text" name="taxCode"></td>
                </tr>
                <tr>
                    <td>loyaltyScore</td>
                    <td><input type="text" name="loyaltyScore"></td>
                </tr>
                <tr>
                    <td>verificationStatus</td>
                    <td><input type="text" name="verificationStatus"></td>
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
                    <td><input type="submit" name="submit" value="Add Recruiter"></td>
                    <td><input type="reset" value="Reset">
                        <input type="hidden" name="service" value="Add">
                        <input type="hidden" name="target" value="Recruiter">
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>
