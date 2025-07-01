<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Phỏng vấn cuối - Quản lý tuyển dụng</title>
            <link rel="stylesheet" href="assets/css/admin-tables.css">
        </head>

        <body>
            <%@include file="header.jsp" %>
                <div class="container">
                    <h2>Giai đoạn: Phỏng vấn cuối</h2>
                    <a href="${pageContext.request.contextPath}/recruitment">&larr; Quay lại Dashboard</a>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID Quy trình</th>
                                <th>Application ID</th>
                                <th>HR phụ trách</th>
                                <th>Recruiter phụ trách</th>
                                <th>Thời gian cập nhật</th>
                                <th>Ghi chú</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="process" items="${processes}">
                                <tr>
                                    <td>${process.id}</td>
                                    <td>${process.applicationId}</td>
                                    <td>${process.assignedHrId}</td>
                                    <td>${process.assignedRecruiterId}</td>
                                    <td>${process.updatedAt}</td>
                                    <td>${process.notes}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
        </body>

        </html>