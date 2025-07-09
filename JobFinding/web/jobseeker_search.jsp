<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Tìm kiếm ứng viên nâng cao</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <jsp:include page="header.jsp" />
            <div class="container mt-4">
                <h2 class="mb-4">Tìm kiếm ứng viên nâng cao</h2>
                <form action="jobseeker-search" method="get" class="row g-3 mb-4">
                    <div class="col-md-3">
                        <input type="text" name="skills" class="form-control"
                            placeholder="Kỹ năng (ngăn cách bởi dấu phẩy)" value="${param.skills}">
                    </div>
                    <div class="col-md-2">
                        <input type="number" name="experience" class="form-control" placeholder="Kinh nghiệm (năm)"
                            value="${param.experience}">
                    </div>
                    <div class="col-md-2">
                        <input type="text" name="education" class="form-control" placeholder="Học vấn"
                            value="${param.education}">
                    </div>
                    <div class="col-md-3">
                        <input type="text" name="desiredPosition" class="form-control" placeholder="Vị trí mong muốn"
                            value="${param.desiredPosition}">
                    </div>
                    <div class="col-md-2">
                        <input type="text" name="location" class="form-control" placeholder="Địa điểm"
                            value="${param.location}">
                    </div>
                    <div class="col-md-12">
                        <button type="submit" class="btn btn-success">Tìm kiếm</button>
                    </div>
                </form>
                <c:if test="${not empty jobseekers}">
                    <table class="table table-bordered table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>Họ tên</th>
                                <th>Email</th>
                                <th>Kỹ năng</th>
                                <th>Kinh nghiệm</th>
                                <th>Học vấn</th>
                                <th>Vị trí mong muốn</th>
                                <th>Địa điểm</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="js" items="${jobseekers}">
                                <tr>
                                    <td>${js.fullName}</td>
                                    <td>${js.email}</td>
                                    <td>${js.skills}</td>
                                    <td>${js.experience}</td>
                                    <td>${js.education}</td>
                                    <td>${js.desiredPosition}</td>
                                    <td>${js.location}</td>
                                    <td><a href="profile.jsp?id=${js.id}" class="btn btn-sm btn-outline-primary">Xem</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty jobseekers}">
                    <div class="alert alert-info">Không có kết quả phù hợp.</div>
                </c:if>
            </div>
        </body>

        </html>