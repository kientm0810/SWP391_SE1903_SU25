<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý CV</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { font-family: 'Arial', sans-serif; }
        .cv-card { transition: transform 0.2s; }
        .cv-card:hover { transform: scale(1.02); }
    </style>
</head>
<body class="bg-gray-100">
    <div class="container mx-auto p-6">
        <div class="flex justify-between items-center mb-6">
            <h1 class="text-2xl font-bold text-gray-800">Quản lý CV</h1>
            <div class="flex space-x-4">
                <a href="/cv/create" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600">Tạo CV mới</a>
                <a href="/login" class="bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600">Trở lại</a>
            </div>
        </div>
        
        <c:if test="${not empty message}">
            <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-4">
                ${message}
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4">
                ${error}
            </div>
        </c:if>

        <form class="mb-6" action="/cv/list" method="get">
            <input type="text" name="keyword" placeholder="Tìm kiếm CV..." 
                   class="border rounded px-4 py-2 w-64" value="${param.keyword}">
            <button type="submit" class="bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600">Tìm</button>
        </form>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <c:forEach var="cv" items="${cvs}">
                <div class="cv-card bg-white shadow-md rounded-lg p-6">
                    <h2 class="text-xl font-semibold text-gray-800">${cv.title}</h2>
                    <p class="text-gray-600 mt-2">
                        Ngày tạo: <fmt:formatDate value="${cv.createdAt}" pattern="dd/MM/yyyy"/>
                    </p>
                    <div class="mt-4 flex space-x-2">
                        <a href="/cv/update?id=${cv.id}" class="bg-blue-500 text-white px-3 py-1 rounded hover:bg-blue-600">Sửa</a>
                        <form action="/cv/delete" method="post" onsubmit="return confirm('Bạn có chắc muốn xóa CV này?');">
                            <input type="hidden" name="id" value="${cv.id}">
                            <button type="submit" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600">Xóa</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>