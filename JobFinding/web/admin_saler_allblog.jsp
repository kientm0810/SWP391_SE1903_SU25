<!-- admin_saler_allblog.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Blogs - Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <jsp:include page="admin-common-styles.jsp" />
    <style>
        .blog-thumbnail {
            width: 80px;
            height: 60px;
            object-fit: cover;
            border-radius: 5px;
        }
        
        .blog-title {
            max-width: 300px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        
        .blog-description {
            max-width: 400px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            color: #666;
            font-size: 14px;
        }

        .pagination-area {
            text-align: center;
            margin-top: 30px;
            margin-bottom: 30px;
        }

        .pagination {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 5px;
            list-style: none;
            padding-left: 0;
        }

        .pagination .page-item {
            display: inline-block;
        }

        .pagination .page-link {
            display: block;
            padding: 8px 14px;
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            color: #333;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: 0.2s;
        }

        .pagination .page-link:hover {
            background-color: #e2e6ea;
            color: #212529;
        }

        .pagination .page-item.active .page-link {
            background-color: #28a745;
            border-color: #28a745;
            color: white;
            font-weight: bold;
            pointer-events: none;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <jsp:include page="sidebar.jsp" />
        
        <div class="main-content">
            <div class="page-header">
                <h1>Manage Blogs</h1>
                <div class="header-actions">
                    <a href="AdminSalerController?target=blog&service=Add" class="btn btn-primary">
                        <i class="fas fa-plus"></i>
                        Create New Blog
                    </a>
                </div>
            </div>
            
            <div class="search-filter-section">
                <form action="AdminSalerController" method="get">
                    <input type="hidden" name="target" value="blog">
                    <input type="hidden" name="service" value="listAll">
                    
                    <div class="search-filter-row">
                        <div class="search-box">
                            <input type="text" name="title" placeholder="Search by title..." 
                                   value="${searchTitle}">
                            <i class="fas fa-search"></i>
                        </div>
                        
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-search"></i>
                            Search
                        </button>
                        
                        <a href="AdminSalerController?target=blog" class="btn btn-secondary">
                            <i class="fas fa-redo"></i>
                            Reset
                        </a>
                    </div>
                    
                    <!-- Sort and records per page controls -->
                    <div class="search-filter-row" style="margin-top: 10px;">
                        <div style="display: flex; gap: 15px; align-items: center;">
                            <div>
                                <label style="margin-right: 5px;">Sort by:</label>
                                <select id="sortField" name="sortField" class="form-control" style="width: 150px; display: inline-block;">
                                    <option value="id" ${sortField == 'id' ? 'selected' : ''}>ID</option>
                                    <option value="title" ${sortField == 'title' ? 'selected' : ''}>Title</option>
                                    <option value="created_at" ${sortField == 'created_at' ? 'selected' : ''}>Created Date</option>
                                    <option value="status" ${sortField == 'status' ? 'selected' : ''}>Status</option>
                                </select>
                            </div>

                            <div>
                                <select id="sortOrder" name="sortOrder" class="form-control" style="width: 100px;">
                                    <option value="ASC" ${sortOrder == 'ASC' ? 'selected' : ''}>ASC</option>
                                    <option value="DESC" ${sortOrder == 'DESC' ? 'selected' : ''}>DESC</option>
                                </select>
                            </div>

                            <div>
                                <label style="margin-right: 5px;">Show:</label>
                                <select id="recordsPerPage" name="recordsPerPage" class="form-control" style="width: 80px; display: inline-block;" onchange="changeRecordsPerPage()">
                                    <option value="5" ${recordsPerPage == 5 ? 'selected' : ''}>5</option>
                                    <option value="10" ${recordsPerPage == 10 ? 'selected' : ''}>10</option>
                                    <option value="20" ${recordsPerPage == 20 ? 'selected' : ''}>20</option>
                                    <option value="50" ${recordsPerPage == 50 ? 'selected' : ''}>50</option>
                                </select>
                                <span style="margin-left: 5px;">records</span>
                            </div>

                            <div style="margin-left: auto;">
                                <span>Total: ${totalRecords} records</span>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            
            <div class="table-container">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Thumbnail</th>
                            <th>Title</th>
                            <th>Author</th>
                            <th>Created Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="blog" items="${blogs}">
                            <tr>
                                <td>#${blog.id}</td>
                                <td>
                                    <img src="${blog.thumbnail}" alt="Blog thumbnail" class="blog-thumbnail">
                                </td>
                                <td>
                                    <div class="blog-title" title="${blog.title}">
                                        ${blog.title}
                                    </div>
                                </td>
                                <td>Admin #${blog.admin_id}</td>
                                <td>${blog.created_at}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${blog.status == 'published'}">
                                            <span class="status-badge status-published">Published</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-draft">Draft</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="AdminSalerController?target=blog&service=Detail&blogId=${blog.id}" 
                                           class="action-btn view-btn">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="AdminSalerController?target=blog&service=Update&blogId=${blog.id}" 
                                           class="action-btn edit-btn">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="AdminSalerController?target=blog&service=Delete&blogId=${blog.id}" 
                                           class="action-btn delete-btn"
                                           onclick="return confirm('Are you sure you want to delete this blog?')">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty blogs}">
                            <tr>
                                <td colspan="7" class="text-center">No blogs found.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
                
                <!-- Pagination -->
                <div class="pagination-area">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="AdminSalerController?target=blog&page=${currentPage - 1}&recordsPerPage=${recordsPerPage}&sortField=${sortField}&sortOrder=${sortOrder}${searchTitle != null && !searchTitle.isEmpty() ? '&title=' + searchTitle : ''}">
                                        <i class="fas fa-chevron-left"></i>
                                    </a>
                                </li>
                            </c:if>

                            <c:forEach begin="${currentPage > 3 ? currentPage - 2 : 1}" 
                                      end="${currentPage + 2 > totalPages ? totalPages : currentPage + 2}" var="i">
                                <c:choose>
                                    <c:when test="${currentPage eq i}">
                                        <li class="page-item active">
                                            <span class="page-link">${i}</span>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="page-item">
                                            <a class="page-link" href="AdminSalerController?target=blog&page=${i}&recordsPerPage=${recordsPerPage}&sortField=${sortField}&sortOrder=${sortOrder}${searchTitle != null && !searchTitle.isEmpty() ? '&title=' + searchTitle : ''}">${i}</a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="AdminSalerController?target=blog&page=${currentPage + 1}&recordsPerPage=${recordsPerPage}&sortField=${sortField}&sortOrder=${sortOrder}${searchTitle != null && !searchTitle.isEmpty() ? '&title=' + searchTitle : ''}">
                                        <i class="fas fa-chevron-right"></i>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        function changeRecordsPerPage() {
            var recordsPerPage = document.getElementById('recordsPerPage').value;
            var sortField = document.getElementById('sortField').value;
            var sortOrder = document.getElementById('sortOrder').value;
            var title = '${searchTitle}';
            var url = 'AdminSalerController?target=blog&recordsPerPage=' + recordsPerPage + '&sortField=' + sortField + '&sortOrder=' + sortOrder;
            if (title) {
                url += '&title=' + encodeURIComponent(title);
            }
            window.location.href = url;
        }
        
        document.getElementById('sortField').addEventListener('change', function() {
            changeRecordsPerPage();
        });
        
        document.getElementById('sortOrder').addEventListener('change', function() {
            changeRecordsPerPage();
        });
    </script>
</body>
</html>