<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Posts for ${promotionProgram.name} - Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <jsp:include page="admin-common-styles.jsp" />
    <style>
        .program-header {
            background: linear-gradient(135deg, #4caf50 0%, #2e7d32 100%);
            color: white;
            padding: 30px;
            border-radius: 12px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(76,175,80,0.3);
        }
        
        .program-header h2 {
            color: white;
            margin-bottom: 15px;
            font-size: 28px;
        }
        
        .program-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        
        .program-info-item {
            background: rgba(255,255,255,0.1);
            padding: 15px;
            border-radius: 8px;
            text-align: center;
        }
        
        .program-info-value {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        .program-info-label {
            font-size: 14px;
            opacity: 0.9;
        }
        
        .posts-table {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .table-header {
            background: #f8f9fa;
            padding: 20px;
            border-bottom: 1px solid #e9ecef;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .table-title {
            font-size: 20px;
            font-weight: bold;
            color: #2e7d32;
        }
        
        .search-box {
            position: relative;
            width: 300px;
        }
        
        .search-box input {
            width: 100%;
            padding: 10px 40px 10px 15px;
            border: 1px solid #ddd;
            border-radius: 25px;
            font-size: 14px;
        }
        
        .search-box i {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
        }
        
        .posts-grid {
            display: grid;
            gap: 20px;
            padding: 20px;
        }
        
        .post-card {
            border: 1px solid #e9ecef;
            border-radius: 8px;
            padding: 20px;
            transition: all 0.3s ease;
            background: white;
        }
        
        .post-card:hover {
            border-color: #4caf50;
            box-shadow: 0 4px 15px rgba(76,175,80,0.1);
        }
        
        .post-header {
            display: flex;
            align-items: flex-start;
            gap: 15px;
            margin-bottom: 15px;
        }
        
        .company-logo {
            width: 60px;
            height: 60px;
            border-radius: 8px;
            object-fit: cover;
            border: 2px solid #e9ecef;
        }
        
        .post-info {
            flex: 1;
        }
        
        .post-title {
            font-size: 18px;
            font-weight: bold;
            color: #2e7d32;
            margin-bottom: 8px;
            line-height: 1.3;
        }
        
        .company-name {
            color: #666;
            font-size: 14px;
            margin-bottom: 10px;
        }
        
        .post-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 15px;
        }
        
        .meta-item {
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: 13px;
            color: #666;
        }
        
        .meta-item i {
            color: #4caf50;
        }
        
        .promotion-info {
            background: #f8f9fa;
            border-radius: 6px;
            padding: 12px;
            margin-bottom: 15px;
            border-left: 4px solid #4caf50;
        }
        
        .promotion-stats {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }
        
        .stat-badge {
            display: flex;
            align-items: center;
            gap: 6px;
            color: #2e7d32;
            font-size: 13px;
            font-weight: 500;
        }
        
        .stat-badge i {
            color: #4caf50;
        }
        
        .post-stats {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 15px;
            border-top: 1px solid #f1f1f1;
        }
        
        .stats-left {
            display: flex;
            gap: 20px;
        }
        
        .stat-item {
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: 13px;
            color: #666;
        }
        
        .post-actions {
            display: flex;
            gap: 10px;
        }
        
        .btn-action {
            padding: 6px 12px;
            font-size: 12px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            transition: all 0.3s;
        }
        
        .btn-view {
            background: #2196f3;
            color: white;
        }
        
        .btn-view:hover {
            background: #1976d2;
            color: white;
        }
        
        .btn-edit {
            background: #ff9800;
            color: white;
        }
        
        .btn-edit:hover {
            background: #f57c00;
            color: white;
        }
        
        .pagination-area {
            padding: 20px;
            border-top: 1px solid #e9ecef;
            background: #f8f9fa;
        }
        
        .no-posts {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        
        .no-posts i {
            font-size: 48px;
            margin-bottom: 20px;
            opacity: 0.5;
        }
        
        .back-btn {
            background: #6c757d;
            color: white;
            padding: 10px 20px;
            border-radius: 6px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            transition: background 0.3s;
        }
        
        .back-btn:hover {
            background: #5a6268;
            color: white;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <jsp:include page="sidebar.jsp" />
        
        <div class="main-content">
            <div class="page-header">
                <h1>Danh sách bài đăng theo chương trình</h1>
                <div class="header-actions">
                    <a href="AdminController?target=program" class="back-btn">
                        <i class="fas fa-arrow-left"></i>
                        Quay lại
                    </a>
                </div>
            </div>
            
            <!-- Thông tin promotion program -->
            <div class="program-header">
                <h2>${promotionProgram.name}</h2>
                <p>${promotionProgram.description}</p>
                
                <div class="program-info">
                    <div class="program-info-item">
                        <div class="program-info-value">
                            <fmt:formatNumber value="${promotionProgram.cost}" pattern="#,###" /> VNĐ
                        </div>
                        <div class="program-info-label">Giá chương trình</div>
                    </div>
                    <div class="program-info-item">
                        <div class="program-info-value">${promotionProgram.durationDays}</div>
                        <div class="program-info-label">Số ngày</div>
                    </div>
                    <div class="program-info-item">
                        <div class="program-info-value">${totalPosts}</div>
                        <div class="program-info-label">Tổng bài đăng</div>
                    </div>
                    <div class="program-info-item">
                        <div class="program-info-value">
                            <fmt:formatNumber value="${totalRevenue}" pattern="#,###" /> VNĐ
                        </div>
                        <div class="program-info-label">Tổng doanh thu</div>
                    </div>
                </div>
            </div>
            
            <!-- Search Form -->
            <div class="search-filter-section">
                <form action="AdminController" method="get">
                    <input type="hidden" name="target" value="program">
                    <input type="hidden" name="service" value="viewPosts">
                    <input type="hidden" name="programId" value="${promotionProgram.id}">
                    
                    <div class="search-filter-row">
                        <div class="search-box">
                            <input type="text" name="title" placeholder="Tìm theo tiêu đề..." 
                                   value="${searchTitle}">
                            <i class="fas fa-search"></i>
                        </div>
                        
                        <button type="submit" name="submit" value="Search" class="btn btn-primary">
                            <i class="fas fa-filter"></i>
                            Tìm kiếm
                        </button>
                        
                        <a href="AdminController?target=program&service=viewPosts&programId=${promotionProgram.id}" class="btn btn-secondary">
                            <i class="fas fa-redo"></i>
                            Reset
                        </a>
                    </div>
                    
                    <!-- Sort và records per page controls -->
                    <div class="search-filter-row" style="margin-top: 10px;">
                        <div style="display: flex; gap: 15px; align-items: center;">
                            <div>
                                <label style="margin-right: 5px;">Sắp xếp:</label>
                                <select id="sortField" name="sortField" class="form-control" style="width: 120px; display: inline-block;">
                                    <option value="created_at" ${sortField == 'created_at' ? 'selected' : ''}>Ngày tạo</option>
                                    <option value="title" ${sortField == 'title' ? 'selected' : ''}>Tiêu đề</option>
                                    <option value="company_name" ${sortField == 'company_name' ? 'selected' : ''}>Công ty</option>
                                    <option value="view_count" ${sortField == 'view_count' ? 'selected' : ''}>Lượt xem</option>
                                </select>
                            </div>

                            <div>
                                <select id="sortOrder" name="sortOrder" class="form-control" style="width: 80px;">
                                    <option value="DESC" ${sortOrder == 'DESC' ? 'selected' : ''}>Giảm</option>
                                    <option value="ASC" ${sortOrder == 'ASC' ? 'selected' : ''}>Tăng</option>
                                </select>
                            </div>

                            <div>
                                <label style="margin-right: 5px;">Hiển thị:</label>
                                <select id="recordsPerPage" name="recordsPerPage" class="form-control" style="width: 60px; display: inline-block;">
                                    <option value="5" ${recordsPerPage == 5 ? 'selected' : ''}>5</option>
                                    <option value="10" ${recordsPerPage == 10 ? 'selected' : ''}>10</option>
                                    <option value="20" ${recordsPerPage == 20 ? 'selected' : ''}>20</option>
                                </select>
                            </div>

                            <div style="margin-left: auto;">
                                <span>Tổng: ${totalRecords} bài đăng duy nhất</span>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Bảng danh sách posts -->
            <div class="posts-table">
                <div class="table-header">
                    <div class="table-title">
                        Danh sách bài đăng (${posts.size()} bài)
                    </div>
                </div>
                
                <div class="posts-grid" id="postsGrid">
                    <c:forEach var="postInfo" items="${posts}">
                        <div class="post-card" data-title="${postInfo.post.title}" data-company="${postInfo.post.companyName}">
                            <div class="post-header">
                                <img src="${postInfo.post.companyLogo}" alt="${postInfo.post.companyName}" 
                                     class="company-logo" onerror="this.src='assets/img/default-company.png'">
                                <div class="post-info">
                                    <div class="post-title">${postInfo.post.title}</div>
                                    <div class="company-name">${postInfo.post.companyName}</div>
                                    <div class="post-meta">
                                        <div class="meta-item">
                                            <i class="fas fa-money-bill"></i>
                                            <span>${postInfo.post.salary}</span>
                                        </div>
                                        <div class="meta-item">
                                            <i class="fas fa-map-marker-alt"></i>
                                            <span>${postInfo.post.location}</span>
                                        </div>
                                        <div class="meta-item">
                                            <i class="fas fa-briefcase"></i>
                                            <span>${postInfo.post.jobType}</span>
                                        </div>
                                        <div class="meta-item">
                                            <i class="fas fa-clock"></i>
                                            <span>${postInfo.post.experience}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Thông tin đăng ký chương trình -->
                            <div class="promotion-info">
                                <div class="promotion-stats">
                                    <div class="stat-badge">
                                        <i class="fas fa-repeat"></i>
                                        <span>Đăng ký: ${postInfo.registrationCount} lần</span>
                                    </div>
                                    <div class="stat-badge">
                                        <i class="fas fa-calendar-alt"></i>
                                        <span>Gần nhất: 
                                            <fmt:formatDate value="${postInfo.latestRegistration}" pattern="dd/MM/yyyy HH:mm" />
                                        </span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="post-stats">
                                <div class="stats-left">
                                    <div class="stat-item">
                                        <i class="fas fa-eye"></i>
                                        <span>${postInfo.post.viewCount} lượt xem</span>
                                    </div>
                                    <div class="stat-item">
                                        <i class="fas fa-heart"></i>
                                        <span>${postInfo.post.likeCount} lượt thích</span>
                                    </div>
                                    <div class="stat-item">
                                        <i class="fas fa-calendar"></i>
                                        <span>
                                            <fmt:formatDate value="${postInfo.post.createdAt}" pattern="dd/MM/yyyy" />
                                        </span>
                                    </div>
                                </div>
                                
                                <div class="post-actions">
                                    <a href="posts?action=detail&id=${postInfo.post.id}" class="btn-action btn-view">
                                        <i class="fas fa-eye"></i>
                                        Xem
                                    </a>
                                    <a href="AdminController?target=posts&service=edit&id=${postInfo.post.id}" 
                                       class="btn-action btn-edit">
                                        <i class="fas fa-edit"></i>
                                        Sửa
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    
                    <c:if test="${empty posts}">
                        <div class="no-posts">
                            <i class="fas fa-inbox"></i>
                            <h3>Chưa có bài đăng nào</h3>
                            <p>Chương trình này chưa có bài đăng nào được đăng ký.</p>
                        </div>
                    </c:if>
                </div>
                
                <!-- Pagination nếu cần -->
                <c:if test="${totalPages > 1}">
                    <div class="pagination-area">
                        <nav aria-label="Page navigation">
                            <ul class="pagination justify-content-center">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="?programId=${promotionProgram.id}&page=${currentPage - 1}">
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
                                                <a class="page-link" href="?programId=${promotionProgram.id}&page=${i}">${i}</a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>

                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="?programId=${promotionProgram.id}&page=${currentPage + 1}">
                                            <i class="fas fa-chevron-right"></i>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    
    <script>
        function searchPosts() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const postCards = document.querySelectorAll('.post-card');
            
            postCards.forEach(card => {
                const title = card.dataset.title.toLowerCase();
                const company = card.dataset.company.toLowerCase();
                
                if (title.includes(searchTerm) || company.includes(searchTerm)) {
                    card.style.display = '';
                } else {
                    card.style.display = 'none';
                }
            });
        }
    </script>
</body>
</html>