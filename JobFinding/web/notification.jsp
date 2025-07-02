<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Notifications</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/notification.css" rel="stylesheet">
</head>
<body class="bg-light">
    <%@ include file="header.jsp" %>
    <div class="container-fluid">
        <div class="row">
            <div class="p-3 border-bottom bg-white">
                <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">

                    <!-- Form chọn hiển thị (trái) -->
                    <form action="notification" method="post" class="d-flex align-items-center gap-2">
                        <label for="type" class="form-label m-0 text-success fw-bold">Display:</label>
                        <select name="type" id="filter" class="form-select form-select-sm w-auto border-success text-success" onchange="this.form.submit()">
                            <option value="all" <c:if test="${param.type == 'all'}">selected</c:if>>All</option>
                            <option value="unread" <c:if test="${param.type == 'unread'}">selected</c:if>>Unread</option>
                        </select>
                    </form>

                    <!-- Nút xóa (phải) -->
                    <div class="d-flex gap-2">
                        <form action="notification" method="post">
                            <button type="submit" name="service" value="deleteAll" class="btn btn-outline-success btn-sm">
                                Delete All
                            </button>
                        </form>
                        <form action="notification" method="post">
                            <button type="submit" name="service" value="deleteReaded" class="btn btn-outline-success btn-sm">
                                Delete All Readed
                            </button>
                        </form>
                    </div>

                </div>
            </div>

            <!-- Sidebar: Notification list -->
            <div class="col-md-4 border-end bg-white" style="height: 100vh; overflow-y: auto;">
                <ul class="list-group list-group-flush">
                    <c:forEach var="noti" items="${notice}">
                        <form action="notification" method="post">
                            <button type="submit" name="service" value="detail" style="all: unset; width: 100%;">
                                <li class="list-group-item noti-item ${noti.is_read ? 'read' : 'unread'}">
                                    <strong>${noti.title}</strong><br>
                                    <div class="notification-content">${noti.content}</div>
                                    <small>${noti.created_at}</small>
                                    <div class="d-flex justify-content-end gap-2">
                                        <a href="notification?service=markAsUnread&id=${noti.id}" class="btn btn-sm btn-outline-success">
                                            Mark as Unread
                                        </a>
                                        <a href="notification?service=deleteSpecific&id=${noti.id}" class="btn btn-sm btn-outline-success">
                                            Delete
                                        </a>
                                    </div>
                                </li>
                            </button>
                            <input type="hidden" name="id" value="${noti.id}">
                            <input type="hidden" name="type" value="${param.type}">
                        </form>
                        <hr class="my-2" />
                    </c:forEach>
                </ul>
            </div>

            <!-- Detail: Notification detail -->
            <div class="col-md-8 p-4 bg-white">
                <c:if test="${not empty specific}">
                    <h4 class="text-success">${specific.title}</h4>
                    <p>${specific.content}</p>
                    <small class="text-muted">Created at: ${specific.created_at}</small>
                    <a href="${specific.redirect_url}" class="btn btn-secondary">
                        Redirect link
                    </a>
                </c:if>

                <c:if test="${empty specific}">
                    <div class="text-center text-muted">
                        <h5>Select a notification to view details</h5>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <!-- jQuery & Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <!--<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>-->
</body>
</html>
