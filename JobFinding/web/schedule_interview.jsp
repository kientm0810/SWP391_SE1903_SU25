<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Lên lịch phỏng vấn</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <jsp:include page="header.jsp" />
            <div class="container mt-4">
                <h2 class="mb-4">Lên lịch phỏng vấn</h2>
                <form action="schedule-interview" method="post" class="row g-3">
                    <input type="hidden" name="applicationId" value="${param.applicationId}" />
                    <div class="col-md-4">
                        <label class="form-label">Thời gian</label>
                        <input type="datetime-local" name="time" class="form-control" required />
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Địa điểm</label>
                        <input type="text" name="location" class="form-control" />
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Vòng</label>
                        <input type="text" name="round" class="form-control" placeholder="Phone, Test, Final..." />
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Trạng thái</label>
                        <select name="status" class="form-select">
                            <option value="scheduled">Đã lên lịch</option>
                            <option value="done">Đã phỏng vấn</option>
                            <option value="canceled">Đã hủy</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Kết quả</label>
                        <select name="result" class="form-select">
                            <option value="pending">Chưa có kết quả</option>
                            <option value="pass">Đạt</option>
                            <option value="fail">Không đạt</option>
                        </select>
                    </div>
                    <div class="col-md-12">
                        <label class="form-label">Ghi chú</label>
                        <textarea name="note" class="form-control" rows="2"></textarea>
                    </div>
                    <div class="col-md-12">
                        <button type="submit" class="btn btn-success">Lưu lịch phỏng vấn</button>
                    </div>
                </form>
            </div>
        </body>

        </html>