<%-- 
    Document   : admin_test_vnpay
    Created on : Jun 30, 2025, 11:48:30 AM
    Author     : andin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <form action="payment" method="post">
            <input type="hidden" name="totalBill" value="50000">
            <button>Thanh toan</button>
        </form>
        <span>${num}</span>
        <span>${transResult}</span>
    </body>
</html>
