<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Chi tiết đơn ứng tuyển</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <jsp:include page="header.jsp" />
            <div class="container mt-4">
                <h2 class="mb-4">Chi tiết đơn ứng tuyển</h2>
                <c:if test="${not empty application}">
                    <div class="mb-3">
                        <b>Công việc:</b> ${application.jobTitle}<br />
                        <b>Công ty:</b> ${application.companyName}<br />
                        <b>Trạng thái:</b> ${application.status}<br />
                        <b>Ngày ứng tuyển:</b> ${application.appliedAt}<br />
                    </div>
                    <a href="schedule_interview.jsp?applicationId=${application.id}" class="btn btn-success mb-3">Lên
                        lịch phỏng vấn</a>
                    <h4>Lịch phỏng vấn</h4>
                    <c:if test="${empty interviews}">
                        <div class="alert alert-info">Chưa có lịch phỏng vấn nào.</div>
                    </c:if>
                    <c:if test="${not empty interviews}">
                        <table class="table table-bordered table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>Thời gian</th>
                                    <th>Địa điểm</th>
                                    <th>Vòng</th>
                                    <th>Trạng thái</th>
                                    <th>Kết quả</th>
                                    <th>Ghi chú</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="iv" items="${interviews}">
                                    <tr>
                                        <td>${iv.time}</td>
                                        <td>${iv.location}</td>
                                        <td>${iv.round}</td>
                                        <td>${iv.status}</td>
                                        <td>${iv.result}</td>
                                        <td>${iv.note}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </c:if>
                <c:if test="${empty application}">
                    <div class="alert alert-danger">Không tìm thấy đơn ứng tuyển.</div>
                </c:if>
            </div>
        </body>

        </html>