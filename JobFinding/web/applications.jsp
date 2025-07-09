<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Danh sách hồ sơ đã ứng tuyển</title>

                <!-- CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
                <link rel="stylesheet" href="assets/css/main.css">
            </head>

            <body>
                <jsp:include page="header.jsp" />
                <div class="container mt-4">
                    <h2 class="mb-4">Hồ sơ đã ứng tuyển</h2>
                    <c:if test="${not empty success}">
                        <div class="alert alert-success">Ứng tuyển thành công!</div>
                    </c:if>
                    <c:if test="${empty applications}">
                        <div class="alert alert-info">Bạn chưa ứng tuyển công việc nào.</div>
                    </c:if>
                    <c:if test="${not empty applications}">
                        <table class="table table-bordered table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>Công việc</th>
                                    <th>Công ty</th>
                                    <th>Ngày ứng tuyển</th>
                                    <th>Trạng thái</th>
                                    <th>Lịch phỏng vấn</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="app" items="${applications}">
                                    <tr>
                                        <td>${app.jobTitle}</td>
                                        <td>${app.companyName}</td>
                                        <td>${app.appliedAt}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${app.status eq 'new'}">Đã nhận</c:when>
                                                <c:when test="${app.status eq 'reviewed'}">Đang xử lý</c:when>
                                                <c:when test="${app.status eq 'interviewed'}">Đã phỏng vấn</c:when>
                                                <c:when test="${app.status eq 'offered'}">Đã nhận offer</c:when>
                                                <c:when test="${app.status eq 'rejected'}">Đã từ chối</c:when>
                                                <c:otherwise>${app.status}</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><a href="view-application?id=${app.id}"
                                                class="btn btn-sm btn-outline-info">Xem</a></td>
                                        <td><a href="view-application.jsp?id=${app.id}"
                                                class="btn btn-sm btn-outline-primary">Chi tiết</a></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </div>

                <!-- Scripts -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>