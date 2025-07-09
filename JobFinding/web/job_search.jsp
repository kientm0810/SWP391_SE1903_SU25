<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Tìm kiếm việc làm nâng cao</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <jsp:include page="header.jsp" />
            <div class="container mt-4">
                <h2 class="mb-4">Tìm kiếm việc làm nâng cao</h2>
                <form action="job-search" method="get" class="row g-3 mb-4">
                    <div class="col-md-4">
                        <input type="text" name="keyword" class="form-control"
                            placeholder="Từ khóa (tên công việc, mô tả...)" value="${param.keyword}">
                    </div>
                    <div class="col-md-2">
                        <input type="text" name="position" class="form-control" placeholder="Vị trí"
                            value="${param.position}">
                    </div>
                    <div class="col-md-2">
                        <input type="text" name="industry" class="form-control" placeholder="Ngành nghề"
                            value="${param.industry}">
                    </div>
                    <div class="col-md-2">
                        <input type="text" name="location" class="form-control" placeholder="Địa điểm"
                            value="${param.location}">
                    </div>
                    <div class="col-md-1">
                        <input type="number" name="salary" class="form-control" placeholder="Lương từ"
                            value="${param.salary}">
                    </div>
                    <div class="col-md-1">
                        <select name="jobType" class="form-select">
                            <option value="">Loại hình</option>
                            <option value="fulltime" ${param.jobType=='fulltime' ? 'selected' : '' }>Toàn thời gian
                            </option>
                            <option value="parttime" ${param.jobType=='parttime' ? 'selected' : '' }>Bán thời gian
                            </option>
                            <option value="intern" ${param.jobType=='intern' ? 'selected' : '' }>Thực tập</option>
                        </select>
                    </div>
                    <div class="col-md-12">
                        <button type="submit" class="btn btn-success">Tìm kiếm</button>
                    </div>
                </form>
                <c:if test="${not empty jobs}">
                    <table class="table table-bordered table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>Vị trí</th>
                                <th>Công ty</th>
                                <th>Địa điểm</th>
                                <th>Mức lương</th>
                                <th>Loại hình</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="job" items="${jobs}">
                                <tr>
                                    <td>${job.title}</td>
                                    <td>${job.companyName}</td>
                                    <td>${job.location}</td>
                                    <td>${job.salary}</td>
                                    <td>${job.jobType}</td>
                                    <td><a href="view-post.jsp?id=${job.id}"
                                            class="btn btn-sm btn-outline-primary">Xem</a></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty jobs}">
                    <div class="alert alert-info">Không có kết quả phù hợp.</div>
                </c:if>
            </div>
        </body>

        </html>