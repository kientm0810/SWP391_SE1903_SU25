<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sửa CV</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { font-family: 'Arial', sans-serif; }
    </style>
</head>
<body class="bg-gray-100">
    <div class="container mx-auto p-6">
        <h1 class="text-2xl font-bold text-gray-800 mb-6">Sửa CV</h1>
        
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

        <form action="/cv/update" method="post" class="bg-white shadow-md rounded-lg p-6">
            <input type="hidden" name="id" value="${cv.id}">
            <div class="mb-4">
                <label class="block text-gray-700 font-semibold mb-2" for="title">Tiêu đề CV *</label>
                <input type="text" id="title" name="title" required
                       class="w-full border rounded px-4 py-2" value="${cv.title}">
            </div>
            <div class="mb-4">
                <label class="block text-gray-700 font-semibold mb-2" for="summary">Giới thiệu bản thân</label>
                <textarea id="summary" name="summary" rows="4"
                          class="w-full border rounded px-4 py-2">${cv.summary}</textarea>
            </div>
            <div class="mb-4">
                <label class="block text-gray-700 font-semibold mb-2" for="education">Học vấn</label>
                <textarea id="education" name="education" rows="4"
                          class="w-full border rounded px-4 py-2">${cv.education}</textarea>
            </div>
            <div class="mb-4">
                <label class="block text-gray-700 font-semibold mb-2" for="experience">Kinh nghiệm làm việc</label>
                <textarea id="experience" name="experience" rows="4"
                          class="w-full border rounded px-4 py-2">${cv.experience}</textarea>
            </div>
            <div class="mb-4">
                <label class="block text-gray-700 font-semibold mb-2" for="skills">Kỹ năng</label>
                <input type="text" id="skills" name="skills"
                       class="w-full border rounded px-4 py-2" value="${cv.skills != null ? cv.skills.stream().collect(java.util.stream.Collectors.joining(',')) : ''}">
            </div>
            <div class="flex space-x-4">
                <button type="submit" class="bg-green-500 text-white px-6 py-2 rounded hover:bg-green-600">Cập nhật CV</button>
                <a href="/cv/list" class="bg-gray-500 text-white px-6 py-2 rounded hover:bg-gray-600">Hủy</a>
            </div>
        </form>
    </div>
</body>
</html>