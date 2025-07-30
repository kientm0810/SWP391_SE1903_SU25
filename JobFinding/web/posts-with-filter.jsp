<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Danh sách Bài đăng - JobFinding</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            <style>
                .filter-badge {
                    display: inline-flex;
                    align-items: center;
                    gap: 8px;
                    padding: 8px 16px;
                    border-radius: 20px;
                    font-size: 14px;
                    font-weight: 500;
                    cursor: pointer;
                    transition: all 0.3s ease;
                    border: 2px solid transparent;
                    margin: 5px;
                }

                .filter-badge:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                }

                .filter-badge.active {
                    border-color: #007bff;
                    background-color: #007bff;
                    color: white;
                }

                .filter-badge i {
                    font-size: 16px;
                }

                .post-card {
                    border: 1px solid #dee2e6;
                    border-radius: 10px;
                    transition: all 0.3s ease;
                    margin-bottom: 20px;
                }

                .post-card:hover {
                    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                    transform: translateY(-2px);
                }

                .post-type-badge {
                    position: absolute;
                    top: 10px;
                    right: 10px;
                    padding: 4px 8px;
                    border-radius: 12px;
                    font-size: 12px;
                    font-weight: 500;
                }

                .search-box {
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    color: white;
                    border-radius: 10px;
                    padding: 20px;
                    margin-bottom: 30px;
                }

                .stats-card {
                    background: #f8f9fa;
                    border-radius: 10px;
                    padding: 15px;
                    text-align: center;
                    margin-bottom: 20px;
                }

                .stats-card h4 {
                    color: #007bff;
                    margin-bottom: 5px;
                }

                .stats-card p {
                    color: #6c757d;
                    margin-bottom: 0;
                }
            </style>
        </head>

        <body>
            <div class="container-fluid">
                <!-- Header -->
                <div class="search-box">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h4><i class="fas fa-search"></i> Tìm kiếm việc làm</h4>
                            <p class="mb-0">Khám phá hàng nghìn cơ hội việc làm phù hợp với bạn</p>
                        </div>
                        <div class="col-md-4 text-end">
                            <a href="create-post-with-type.jsp" class="btn btn-light">
                                <i class="fas fa-plus"></i> Đăng tin tuyển dụng
                            </a>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <!-- Sidebar Filters -->
                    <div class="col-md-3">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">
                                    <i class="fas fa-filter"></i> Bộ lọc
                                </h5>
                            </div>
                            <div class="card-body">
                                <!-- Post Type Filter -->
                                <div class="mb-4">
                                    <h6 class="mb-3">Loại bài đăng</h6>
                                    <div class="d-flex flex-wrap">
                                        <div class="filter-badge active" onclick="filterByType('all')">
                                            <i class="fas fa-th"></i>
                                            <span>Tất cả</span>
                                        </div>
                                        <c:forEach var="postType" items="${postTypes}">
                                            <div class="filter-badge" onclick="filterByType('${postType.typeCode}')"
                                                data-type="${postType.typeCode}">
                                                <i class="${postType.iconClass}"
                                                    style="color: ${postType.colorCode};"></i>
                                                <span>${postType.typeName}</span>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>

                                <!-- Category Filter -->
                                <div class="mb-4">
                                    <h6 class="mb-3">Danh mục</h6>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="job_posting"
                                            id="categoryJobPosting">
                                        <label class="form-check-label" for="categoryJobPosting">
                                            Job Posting
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="content"
                                            id="categoryContent">
                                        <label class="form-check-label" for="categoryContent">
                                            Content
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="announcement"
                                            id="categoryAnnouncement">
                                        <label class="form-check-label" for="categoryAnnouncement">
                                            Announcement
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="event"
                                            id="categoryEvent">
                                        <label class="form-check-label" for="categoryEvent">
                                            Event
                                        </label>
                                    </div>
                                </div>

                                <!-- Location Filter -->
                                <div class="mb-4">
                                    <h6 class="mb-3">Địa điểm</h6>
                                    <select class="form-select" id="locationFilter">
                                        <option value="">Tất cả địa điểm</option>
                                        <option value="hanoi">Hà Nội</option>
                                        <option value="hcm">TP. Hồ Chí Minh</option>
                                        <option value="danang">Đà Nẵng</option>
                                        <option value="cantho">Cần Thơ</option>
                                        <option value="remote">Làm việc từ xa</option>
                                    </select>
                                </div>

                                <!-- Job Type Filter -->
                                <div class="mb-4">
                                    <h6 class="mb-3">Loại công việc</h6>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="full_time"
                                            id="jobTypeFullTime">
                                        <label class="form-check-label" for="jobTypeFullTime">
                                            Toàn thời gian
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="part_time"
                                            id="jobTypePartTime">
                                        <label class="form-check-label" for="jobTypePartTime">
                                            Bán thời gian
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="contract"
                                            id="jobTypeContract">
                                        <label class="form-check-label" for="jobTypeContract">
                                            Hợp đồng
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="internship"
                                            id="jobTypeInternship">
                                        <label class="form-check-label" for="jobTypeInternship">
                                            Thực tập
                                        </label>
                                    </div>
                                </div>

                                <!-- Apply Filters Button -->
                                <button type="button" class="btn btn-primary w-100" onclick="applyFilters()">
                                    <i class="fas fa-search"></i> Áp dụng bộ lọc
                                </button>
                            </div>
                        </div>

                        <!-- Statistics -->
                        <div class="stats-card">
                            <h4>${totalPosts}</h4>
                            <p>Bài đăng</p>
                        </div>
                        <div class="stats-card">
                            <h4>${activePosts}</h4>
                            <p>Đang hoạt động</p>
                        </div>
                    </div>

                    <!-- Main Content -->
                    <div class="col-md-9">
                        <!-- Search Bar -->
                        <div class="mb-4">
                            <div class="input-group">
                                <input type="text" class="form-control" id="searchInput"
                                    placeholder="Tìm kiếm theo tiêu đề, công ty, địa điểm...">
                                <button class="btn btn-primary" type="button" onclick="searchPosts()">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </div>

                        <!-- Sort Options -->
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div>
                                <span class="text-muted">Hiển thị ${posts.size()} kết quả</span>
                            </div>
                            <div class="d-flex align-items-center">
                                <label class="me-2">Sắp xếp:</label>
                                <select class="form-select" id="sortSelect" onchange="sortPosts()">
                                    <option value="newest">Mới nhất</option>
                                    <option value="oldest">Cũ nhất</option>
                                    <option value="salary_high">Lương cao nhất</option>
                                    <option value="salary_low">Lương thấp nhất</option>
                                    <option value="deadline">Hạn nộp gần nhất</option>
                                </select>
                            </div>
                        </div>

                        <!-- Posts List -->
                        <div id="postsContainer">
                            <c:forEach var="post" items="${posts}">
                                <div class="card post-card" data-type="${post.postType.typeCode}"
                                    data-category="${post.postType.category}">
                                    <div class="card-body position-relative">
                                        <!-- Post Type Badge -->
                                        <div class="post-type-badge"
                                            style="background-color: ${post.postType.colorCode}; color: white;">
                                            <i class="${post.postType.iconClass}"></i>
                                            ${post.postType.typeName}
                                        </div>

                                        <div class="row">
                                            <div class="col-md-8">
                                                <h5 class="card-title">
                                                    <a href="post-detail.jsp?id=${post.id}"
                                                        class="text-decoration-none">
                                                        ${post.title}
                                                    </a>
                                                </h5>
                                                <p class="card-text text-muted mb-2">
                                                    <i class="fas fa-building"></i> ${post.companyName}
                                                </p>
                                                <div class="row mb-3">
                                                    <div class="col-md-4">
                                                        <small class="text-muted">
                                                            <i class="fas fa-map-marker-alt"></i> ${post.location}
                                                        </small>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <small class="text-muted">
                                                            <i class="fas fa-money-bill-wave"></i> ${post.salary}
                                                        </small>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <small class="text-muted">
                                                            <i class="fas fa-clock"></i> ${post.jobType}
                                                        </small>
                                                    </div>
                                                </div>
                                                <p class="card-text">
                                                    ${post.jobDescription.length() > 200 ?
                                                    post.jobDescription.substring(0, 200) + '...' : post.jobDescription}
                                                </p>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="text-end">
                                                    <small class="text-muted">
                                                        <i class="fas fa-calendar"></i> Đăng: ${post.createdAt}
                                                    </small>
                                                    <br>
                                                    <small class="text-danger">
                                                        <i class="fas fa-clock"></i> Hạn: ${post.deadline}
                                                    </small>
                                                </div>
                                                <div class="mt-3">
                                                    <a href="post-detail.jsp?id=${post.id}"
                                                        class="btn btn-outline-primary btn-sm">
                                                        <i class="fas fa-eye"></i> Xem chi tiết
                                                    </a>
                                                    <button class="btn btn-outline-success btn-sm"
                                                        onclick="applyJob(${post.id})">
                                                        <i class="fas fa-paper-plane"></i> Ứng tuyển
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Pagination -->
                        <nav aria-label="Posts pagination">
                            <ul class="pagination justify-content-center">
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="?page=${currentPage - 1}">Trước</a>
                                </li>
                                <c:forEach var="i" begin="1" end="${totalPages}">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" href="?page=${i}">${i}</a>
                                    </li>
                                </c:forEach>
                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="?page=${currentPage + 1}">Sau</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                let currentFilter = 'all';
                let currentSearch = '';

                function filterByType(type) {
                    // Update active filter badge
                    document.querySelectorAll('.filter-badge').forEach(badge => {
                        badge.classList.remove('active');
                    });
                    event.target.closest('.filter-badge').classList.add('active');

                    currentFilter = type;
                    applyFilters();
                }

                function applyFilters() {
                    const posts = document.querySelectorAll('.post-card');
                    const categoryFilters = getSelectedCategories();
                    const locationFilter = document.getElementById('locationFilter').value;
                    const jobTypeFilters = getSelectedJobTypes();

                    posts.forEach(post => {
                        let show = true;

                        // Filter by post type
                        if (currentFilter !== 'all') {
                            const postType = post.getAttribute('data-type');
                            if (postType !== currentFilter) {
                                show = false;
                            }
                        }

                        // Filter by category
                        if (categoryFilters.length > 0) {
                            const postCategory = post.getAttribute('data-category');
                            if (!categoryFilters.includes(postCategory)) {
                                show = false;
                            }
                        }

                        // Filter by location
                        if (locationFilter) {
                            const postLocation = post.querySelector('.text-muted').textContent.toLowerCase();
                            if (!postLocation.includes(locationFilter.toLowerCase())) {
                                show = false;
                            }
                        }

                        // Show/hide post
                        post.style.display = show ? 'block' : 'none';
                    });

                    updateResultsCount();
                }

                function getSelectedCategories() {
                    const categories = [];
                    document.querySelectorAll('input[type="checkbox"]:checked').forEach(checkbox => {
                        if (checkbox.id.startsWith('category')) {
                            categories.push(checkbox.value);
                        }
                    });
                    return categories;
                }

                function getSelectedJobTypes() {
                    const jobTypes = [];
                    document.querySelectorAll('input[type="checkbox"]:checked').forEach(checkbox => {
                        if (checkbox.id.startsWith('jobType')) {
                            jobTypes.push(checkbox.value);
                        }
                    });
                    return jobTypes;
                }

                function searchPosts() {
                    currentSearch = document.getElementById('searchInput').value.toLowerCase();
                    const posts = document.querySelectorAll('.post-card');

                    posts.forEach(post => {
                        const title = post.querySelector('.card-title').textContent.toLowerCase();
                        const company = post.querySelector('.text-muted').textContent.toLowerCase();
                        const location = post.querySelector('.text-muted').textContent.toLowerCase();

                        if (title.includes(currentSearch) || company.includes(currentSearch) || location.includes(currentSearch)) {
                            post.style.display = 'block';
                        } else {
                            post.style.display = 'none';
                        }
                    });

                    updateResultsCount();
                }

                function sortPosts() {
                    const sortBy = document.getElementById('sortSelect').value;
                    const postsContainer = document.getElementById('postsContainer');
                    const posts = Array.from(postsContainer.children);

                    posts.sort((a, b) => {
                        switch (sortBy) {
                            case 'newest':
                                return new Date(b.querySelector('.text-muted').textContent) - new Date(a.querySelector('.text-muted').textContent);
                            case 'oldest':
                                return new Date(a.querySelector('.text-muted').textContent) - new Date(b.querySelector('.text-muted').textContent);
                            case 'salary_high':
                                return parseFloat(b.querySelector('.text-muted').textContent) - parseFloat(a.querySelector('.text-muted').textContent);
                            case 'salary_low':
                                return parseFloat(a.querySelector('.text-muted').textContent) - parseFloat(b.querySelector('.text-muted').textContent);
                            case 'deadline':
                                return new Date(a.querySelector('.text-danger').textContent) - new Date(b.querySelector('.text-danger').textContent);
                            default:
                                return 0;
                        }
                    });

                    posts.forEach(post => postsContainer.appendChild(post));
                }

                function updateResultsCount() {
                    const visiblePosts = document.querySelectorAll('.post-card[style="display: block"], .post-card:not([style*="display: none"])');
                    const countElement = document.querySelector('.text-muted');
                    countElement.textContent = `Hiển thị ${visiblePosts.length} kết quả`;
                }

                function applyJob(postId) {
                    // Redirect to application form
                    window.location.href = `apply-job.jsp?postId=${postId}`;
                }

                // Search on Enter key
                document.getElementById('searchInput').addEventListener('keypress', function (e) {
                    if (e.key === 'Enter') {
                        searchPosts();
                    }
                });

                // Initialize
                document.addEventListener('DOMContentLoaded', function () {
                    updateResultsCount();
                });
            </script>
        </body>

        </html>