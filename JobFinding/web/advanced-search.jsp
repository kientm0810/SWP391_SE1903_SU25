<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Tìm kiếm việc làm nâng cao - JobFinding</title>

            <!-- Bootstrap CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- Font Awesome -->
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            <!-- Custom CSS -->
            <link href="assets/css/advanced-search.css" rel="stylesheet">

            <style>
                :root {
                    --topcv-primary: rgb(31, 136, 33);
                    --topcv-secondary: #19d225;
                    --topcv-accent: #07e207;
                    --topcv-light: #e3f2fd;
                    --topcv-dark: #23c015;
                    --topcv-text: #333333;
                    --topcv-gray: #757575;
                    --topcv-light-gray: #f5f5f5;
                }

                body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    color: var(--topcv-text);
                }

                .search-container {
                    background: linear-gradient(135deg, var(--topcv-primary) 0%, var(--topcv-secondary) 100%);
                    min-height: 300px;
                    padding: 60px 0;
                }

                .filter-card {
                    background: white;
                    border-radius: 12px;
                    box-shadow: 0 4px 20px rgba(30, 136, 229, 0.1);
                    margin-bottom: 20px;
                    border: 1px solid #e0e0e0;
                    transition: all 0.3s ease;
                }

                .filter-card:hover {
                    box-shadow: 0 8px 30px rgba(30, 136, 229, 0.15);
                    transform: translateY(-2px);
                }

                .filter-header {
                    background: var(--topcv-light);
                    padding: 18px 20px;
                    border-radius: 12px 12px 0 0;
                    border-bottom: 2px solid var(--topcv-primary);
                }

                .filter-header h5 {
                    color: var(--topcv-primary);
                    font-weight: 600;
                    margin: 0;
                }

                .filter-body {
                    padding: 20px;
                }

                .form-control,
                .form-select {
                    border-radius: 8px;
                    border: 2px solid #e0e0e0;
                    transition: all 0.3s ease;
                    padding: 12px 15px;
                }

                .form-control:focus,
                .form-select:focus {
                    border-color: var(--topcv-primary);
                    box-shadow: 0 0 0 0.2rem rgba(30, 136, 229, 0.25);
                }

                .form-label {
                    font-weight: 600;
                    color: var(--topcv-text);
                    margin-bottom: 8px;
                }

                .btn-primary {
                    background: linear-gradient(135deg, var(--topcv-primary) 0%, var(--topcv-secondary) 100%);
                    border: none;
                    border-radius: 8px;
                    padding: 12px 30px;
                    font-weight: 600;
                    transition: all 0.3s ease;
                }

                .btn-primary:hover {
                    background: linear-gradient(135deg, var(--topcv-secondary) 0%, var(--topcv-dark) 100%);
                    transform: translateY(-1px);
                    box-shadow: 0 4px 15px rgba(30, 136, 229, 0.3);
                }

                .btn-outline-secondary {
                    border-radius: 8px;
                    padding: 12px 30px;
                    border-color: var(--topcv-gray);
                    color: var(--topcv-gray);
                }

                .btn-outline-secondary:hover {
                    background-color: var(--topcv-gray);
                    border-color: var(--topcv-gray);
                }

                .btn-outline-primary {
                    border-radius: 8px;
                    padding: 12px 30px;
                    border-color: var(--topcv-primary);
                    color: var(--topcv-primary);
                }

                .btn-outline-primary:hover {
                    background-color: var(--topcv-primary);
                    border-color: var(--topcv-primary);
                }

                .suggestion-tag {
                    display: inline-block;
                    background: var(--topcv-light);
                    color: var(--topcv-primary);
                    padding: 8px 16px;
                    border-radius: 25px;
                    margin: 4px;
                    cursor: pointer;
                    transition: all 0.3s ease;
                    font-size: 0.9em;
                    border: 1px solid var(--topcv-primary);
                }

                .suggestion-tag:hover {
                    background: var(--topcv-primary);
                    color: white;
                    transform: translateY(-1px);
                }

                .stats-card {
                    background: linear-gradient(135deg, var(--topcv-primary) 0%, var(--topcv-secondary) 100%);
                    color: white;
                    border-radius: 12px;
                    padding: 25px;
                    margin-bottom: 20px;
                    box-shadow: 0 4px 20px rgba(30, 136, 229, 0.2);
                }

                .collapse-toggle {
                    cursor: pointer;
                    color: var(--topcv-primary);
                    transition: all 0.3s ease;
                }

                .collapse-toggle:hover {
                    color: var(--topcv-secondary);
                }

                .badge {
                    border-radius: 6px;
                    padding: 6px 12px;
                    font-size: 0.85em;
                }

                .badge.bg-primary {
                    background-color: var(--topcv-primary) !important;
                }

                .badge.bg-success {
                    background-color: #4caf50 !important;
                }

                .badge.bg-info {
                    background-color: var(--topcv-accent) !important;
                }

                .pagination .page-link {
                    color: var(--topcv-primary);
                    border-color: #e0e0e0;
                }

                .pagination .page-item.active .page-link {
                    background-color: var(--topcv-primary);
                    border-color: var(--topcv-primary);
                }

                .pagination .page-link:hover {
                    background-color: var(--topcv-light);
                    border-color: var(--topcv-primary);
                }

                .text-primary {
                    color: var(--topcv-primary) !important;
                }

                .alert-info {
                    background-color: var(--topcv-light);
                    border-color: var(--topcv-primary);
                    color: var(--topcv-text);
                }
            </style>
        </head>

        <body>
            <!-- Header -->
            <jsp:include page="header.jsp" />

            <!-- Search Container -->
            <div class="search-container">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-10">
                            <div class="text-center text-white mb-4">
                                <h1 class="display-4 fw-bold mb-3">
                                    <i class="fas fa-search-plus me-3"></i>
                                    Tìm kiếm việc làm nâng cao
                                </h1>
                                <p class="lead">Tìm kiếm việc làm phù hợp với kỹ năng và mong muốn của bạn</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="container my-5">
                <div class="row">
                    <!-- Filters Sidebar -->
                    <div class="col-lg-4">
                        <form id="advancedSearchForm" action="advanced-search" method="GET">

                            <!-- Basic Search -->
                            <div class="filter-card">
                                <div class="filter-header">
                                    <h5 class="mb-0">
                                        <i class="fas fa-search me-2"></i>
                                        Tìm kiếm cơ bản
                                    </h5>
                                </div>
                                <div class="filter-body">
                                    <div class="mb-3">
                                        <label for="keyword" class="form-label">
                                            <i class="fas fa-key me-2"></i>Từ khóa
                                        </label>
                                        <input type="text" class="form-control" id="keyword" name="keyword"
                                            placeholder="Vị trí, công ty, kỹ năng..." value="${param.keyword}">
                                    </div>

                                    <div class="mb-3">
                                        <label for="location" class="form-label">
                                            <i class="fas fa-map-marker-alt me-2"></i>Địa điểm
                                        </label>
                                        <input type="text" class="form-control" id="location" name="location"
                                            placeholder="Thành phố, tỉnh..." value="${param.location}">
                                    </div>

                                    <div class="mb-3">
                                        <label for="industry" class="form-label">
                                            <i class="fas fa-industry me-2"></i>Ngành nghề
                                        </label>
                                        <input type="text" class="form-control" id="industry" name="industry"
                                            placeholder="Nhập ngành nghề..." value="${param.industry}">
                                    </div>
                                </div>
                            </div>

                            <!-- Job Details -->
                            <div class="filter-card">
                                <div class="filter-header">
                                    <h5 class="mb-0">
                                        <i class="fas fa-briefcase me-2"></i>
                                        Chi tiết công việc
                                    </h5>
                                </div>
                                <div class="filter-body">
                                    <div class="mb-3">
                                        <label for="jobType" class="form-label">
                                            <i class="fas fa-clock me-2"></i>Loại hình công việc
                                        </label>
                                        <select class="form-select" id="jobType" name="jobType">
                                            <option value="">Tất cả loại</option>
                                            <option value="Full-time" ${param.jobType=='Full-time' ? 'selected' : '' }>
                                                Full-time</option>
                                            <option value="Part-time" ${param.jobType=='Part-time' ? 'selected' : '' }>
                                                Part-time</option>
                                            <option value="Contract" ${param.jobType=='Contract' ? 'selected' : '' }>Hợp
                                                đồng</option>
                                            <option value="Internship" ${param.jobType=='Internship' ? 'selected' : ''
                                                }>Thực tập</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="experience" class="form-label">
                                            <i class="fas fa-star me-2"></i>Kinh nghiệm
                                        </label>
                                        <input type="text" class="form-control" id="experience" name="experience"
                                            placeholder="Nhập yêu cầu kinh nghiệm..." value="${param.experience}">
                                    </div>

                                    <div class="mb-3">
                                        <label for="rank" class="form-label">
                                            <i class="fas fa-user-tie me-2"></i>Cấp bậc
                                        </label>
                                        <input type="text" class="form-control" id="rank" name="rank"
                                            placeholder="Nhập cấp bậc..." value="${param.rank}">
                                    </div>

                                    <div class="mb-3">
                                        <label for="workingTime" class="form-label">
                                            <i class="fas fa-calendar-alt me-2"></i>Thời gian làm việc
                                        </label>
                                        <input type="text" class="form-control" id="workingTime" name="workingTime"
                                            placeholder="Nhập thời gian làm việc..." value="${param.workingTime}">
                                    </div>
                                </div>
                            </div>

                            <!-- Salary Range -->
                            <div class="filter-card">
                                <div class="filter-header">
                                    <h5 class="mb-0">
                                        <i class="fas fa-money-bill-wave me-2"></i>
                                        Mức lương
                                    </h5>
                                </div>
                                <div class="filter-body">
                                    <div class="mb-3">
                                        <label for="salary" class="form-label">Mức lương</label>
                                        <input type="text" class="form-control" id="salary" name="salary"
                                            placeholder="Nhập mức lương..." value="${param.salary}">
                                    </div>
                                    <small class="text-muted">Ví dụ: 15-25 triệu VND/tháng</small>
                                </div>
                            </div>

                            <!-- Company Information -->
                            <div class="filter-card">
                                <div class="filter-header">
                                    <h5 class="mb-0 collapse-toggle" data-bs-toggle="collapse"
                                        data-bs-target="#companyInfo">
                                        <i class="fas fa-building me-2"></i>
                                        Thông tin công ty
                                        <i class="fas fa-chevron-down float-end"></i>
                                    </h5>
                                </div>
                                <div class="collapse show" id="companyInfo">
                                    <div class="filter-body">
                                        <div class="mb-3">
                                            <label for="companyName" class="form-label">Tên công ty</label>
                                            <input type="text" class="form-control" id="companyName" name="companyName"
                                                placeholder="Nhập tên công ty..." value="${param.companyName}">
                                        </div>

                                        <div class="mb-3">
                                            <label for="companySize" class="form-label">Quy mô công ty</label>
                                            <input type="text" class="form-control" id="companySize" name="companySize"
                                                placeholder="Nhập quy mô công ty..." value="${param.companySize}">
                                        </div>

                                        <div class="mb-3">
                                            <label for="contactAddress" class="form-label">Địa chỉ làm việc</label>
                                            <input type="text" class="form-control" id="contactAddress"
                                                name="contactAddress" placeholder="Nhập địa chỉ làm việc..."
                                                value="${param.contactAddress}">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Job Requirements -->
                            <div class="filter-card">
                                <div class="filter-header">
                                    <h5 class="mb-0 collapse-toggle" data-bs-toggle="collapse"
                                        data-bs-target="#jobRequirements">
                                        <i class="fas fa-tools me-2"></i>
                                        Yêu cầu công việc
                                        <i class="fas fa-chevron-down float-end"></i>
                                    </h5>
                                </div>
                                <div class="collapse" id="jobRequirements">
                                    <div class="filter-body">
                                        <div class="mb-3">
                                            <label for="requirements" class="form-label">Yêu cầu ứng viên</label>
                                            <input type="text" class="form-control" id="requirements"
                                                name="requirements" placeholder="Nhập yêu cầu..."
                                                value="${param.requirements}">
                                        </div>

                                        <div class="mb-3">
                                            <label for="benefits" class="form-label">Quyền lợi</label>
                                            <input type="text" class="form-control" id="benefits" name="benefits"
                                                placeholder="Nhập quyền lợi..." value="${param.benefits}">
                                        </div>

                                        <div class="mb-3">
                                            <label for="applicationMethod" class="form-label">Cách thức ứng
                                                tuyển</label>
                                            <input type="text" class="form-control" id="applicationMethod"
                                                name="applicationMethod" placeholder="Nhập cách thức ứng tuyển..."
                                                value="${param.applicationMethod}">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Sort Options -->
                            <div class="filter-card">
                                <div class="filter-header">
                                    <h5 class="mb-0">
                                        <i class="fas fa-sort me-2"></i>
                                        Sắp xếp
                                    </h5>
                                </div>
                                <div class="filter-body">
                                    <div class="mb-3">
                                        <label for="sortBy" class="form-label">Sắp xếp theo</label>
                                        <select class="form-select" id="sortBy" name="sortBy">
                                            <option value="created_at" ${param.sortBy=='created_at' ? 'selected' : '' }>
                                                Ngày đăng</option>
                                            <option value="title" ${param.sortBy=='title' ? 'selected' : '' }>Tên công
                                                việc</option>
                                            <option value="company_name" ${param.sortBy=='company_name' ? 'selected'
                                                : '' }>Tên công ty</option>
                                            <option value="salary" ${param.sortBy=='salary' ? 'selected' : '' }>
                                                Mức lương</option>
                                            <option value="deadline" ${param.sortBy=='deadline' ? 'selected' : '' }>
                                                Hạn nộp hồ sơ</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="sortOrder" class="form-label">Thứ tự</label>
                                        <select class="form-select" id="sortOrder" name="sortOrder">
                                            <option value="DESC" ${param.sortOrder=='DESC' ? 'selected' : '' }>Giảm dần
                                            </option>
                                            <option value="ASC" ${param.sortOrder=='ASC' ? 'selected' : '' }>Tăng dần
                                            </option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="filter-card">
                                <div class="filter-body">
                                    <div class="d-grid gap-2">
                                        <button type="submit" class="btn btn-primary btn-lg">
                                            <i class="fas fa-search me-2"></i>
                                            Tìm kiếm
                                        </button>
                                        <button type="button" class="btn btn-outline-secondary"
                                            onclick="clearFilters()">
                                            <i class="fas fa-eraser me-2"></i>
                                            Xóa bộ lọc
                                        </button>
                                        <button type="button" class="btn btn-outline-primary" onclick="saveSearch()">
                                            <i class="fas fa-bookmark me-2"></i>
                                            Lưu tìm kiếm
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- Results Section -->
                    <div class="col-lg-8">
                        <!-- Search Stats -->
                        <div class="stats-card">
                            <div class="row text-center">
                                <div class="col-4">
                                    <h3 class="mb-1">${totalJobs}</h3>
                                    <small>Việc làm tìm thấy</small>
                                </div>
                                <div class="col-4">
                                    <h3 class="mb-1">${totalPages}</h3>
                                    <small>Trang kết quả</small>
                                </div>
                                <div class="col-4">
                                    <h3 class="mb-1">${searchTime}</h3>
                                    <small>Giây tìm kiếm</small>
                                </div>
                            </div>
                        </div>

                        <!-- Search Suggestions -->
                        <div class="filter-card">
                            <div class="filter-header">
                                <h5 class="mb-0">
                                    <i class="fas fa-lightbulb me-2"></i>
                                    Gợi ý tìm kiếm
                                </h5>
                            </div>
                            <div class="filter-body">
                                <div class="mb-3">
                                    <strong>Từ khóa phổ biến:</strong>
                                    <div class="mt-2">
                                        <span class="suggestion-tag" onclick="setKeyword('Java Developer')">Java
                                            Developer</span>
                                        <span class="suggestion-tag" onclick="setKeyword('React Developer')">React
                                            Developer</span>
                                        <span class="suggestion-tag" onclick="setKeyword('Data Analyst')">Data
                                            Analyst</span>
                                        <span class="suggestion-tag" onclick="setKeyword('Product Manager')">Product
                                            Manager</span>
                                        <span class="suggestion-tag" onclick="setKeyword('UX Designer')">UX
                                            Designer</span>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <strong>Địa điểm phổ biến:</strong>
                                    <div class="mt-2">
                                        <span class="suggestion-tag" onclick="setLocation('Hà Nội')">Hà Nội</span>
                                        <span class="suggestion-tag" onclick="setLocation('TP. Hồ Chí Minh')">TP. Hồ Chí
                                            Minh</span>
                                        <span class="suggestion-tag" onclick="setLocation('Đà Nẵng')">Đà Nẵng</span>
                                        <span class="suggestion-tag" onclick="setLocation('Cần Thơ')">Cần Thơ</span>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <strong>Loại hình công việc:</strong>
                                    <div class="mt-2">
                                        <span class="suggestion-tag" onclick="setJobType('Full-time')">Full-time</span>
                                        <span class="suggestion-tag" onclick="setJobType('Part-time')">Part-time</span>
                                        <span class="suggestion-tag" onclick="setJobType('Contract')">Contract</span>
                                        <span class="suggestion-tag"
                                            onclick="setJobType('Internship')">Internship</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Search Results -->
                        <div id="searchResults">
                            <c:if test="${not empty jobs}">
                                <c:forEach var="job" items="${jobs}">
                                    <div class="filter-card">
                                        <div class="filter-body">
                                            <div class="row">
                                                <div class="col-md-8">
                                                    <h5 class="fw-bold text-primary mb-2">
                                                        <a href="post?id=${job.id}"
                                                            class="text-decoration-none">${job.title}</a>
                                                    </h5>
                                                    <p class="text-muted mb-2">
                                                        <i class="fas fa-building me-2"></i>${job.companyName}
                                                    </p>
                                                    <p class="text-muted mb-2">
                                                        <i class="fas fa-map-marker-alt me-2"></i>${job.location}
                                                    </p>
                                                    <div class="mb-2">
                                                        <span class="badge bg-primary me-2">${job.jobType}</span>
                                                        <span class="badge bg-success me-2">${job.salary}</span>
                                                        <c:if test="${not empty job.experience}">
                                                            <span class="badge bg-info">${job.experience}</span>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <div class="col-md-4 text-end">
                                                    <button class="btn btn-outline-primary btn-sm mb-2"
                                                        onclick="saveJob(${job.id})">
                                                        <i class="fas fa-bookmark me-1"></i>Lưu
                                                    </button>
                                                    <br>
                                                    <small class="text-muted">
                                                        <i class="fas fa-clock me-1"></i>${job.createdAt}
                                                    </small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>

                                <!-- Pagination -->
                                <c:if test="${totalPages > 1}">
                                    <nav aria-label="Search results pagination">
                                        <ul class="pagination justify-content-center">
                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                <a class="page-link"
                                                    href="?page=${currentPage - 1}&${queryString}">Trước</a>
                                            </li>

                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                    <a class="page-link" href="?page=${i}&${queryString}">${i}</a>
                                                </li>
                                            </c:forEach>

                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                <a class="page-link"
                                                    href="?page=${currentPage + 1}&${queryString}">Sau</a>
                                            </li>
                                        </ul>
                                    </nav>
                                </c:if>
                            </c:if>

                            <c:if test="${empty jobs and not empty param.keyword}">
                                <div class="filter-card">
                                    <div class="filter-body text-center">
                                        <i class="fas fa-search fa-3x text-muted mb-3"></i>
                                        <h5 class="text-muted">Không tìm thấy việc làm phù hợp</h5>
                                        <p class="text-muted">Hãy thử thay đổi bộ lọc hoặc từ khóa tìm kiếm</p>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <jsp:include page="footer.jsp" />

            <!-- Bootstrap JS -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <!-- jQuery -->
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

            <script>
                // Set keyword from suggestion
                function setKeyword(keyword) {
                    document.getElementById('keyword').value = keyword;
                }

                // Set location from suggestion
                function setLocation(location) {
                    document.getElementById('location').value = location;
                }

                // Set job type from suggestion
                function setJobType(jobType) {
                    document.getElementById('jobType').value = jobType;
                }

                // Clear all filters
                function clearFilters() {
                    document.getElementById('advancedSearchForm').reset();
                }

                // Save search
                function saveSearch() {
                    const searchName = prompt('Nhập tên cho tìm kiếm này:');
                    if (searchName) {
                        // Add hidden input for search name
                        const input = document.createElement('input');
                        input.type = 'hidden';
                        input.name = 'searchName';
                        input.value = searchName;
                        document.getElementById('advancedSearchForm').appendChild(input);

                        // Add hidden input for save flag
                        const saveInput = document.createElement('input');
                        saveInput.type = 'hidden';
                        saveInput.name = 'saveSearch';
                        saveInput.value = 'true';
                        document.getElementById('advancedSearchForm').appendChild(saveInput);

                        // Submit form
                        document.getElementById('advancedSearchForm').submit();
                    }
                }

                // Save job
                function saveJob(jobId) {
                    fetch('save-job', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: 'jobId=' + jobId
                    })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                alert('Đã lưu việc làm thành công!');
                            } else {
                                alert('Có lỗi xảy ra: ' + data.message);
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('Có lỗi xảy ra khi lưu việc làm');
                        });
                }

                // Auto-submit form when filters change
                document.addEventListener('DOMContentLoaded', function () {
                    const form = document.getElementById('advancedSearchForm');
                    const inputs = form.querySelectorAll('input, select');

                    inputs.forEach(input => {
                        input.addEventListener('change', function () {
                            // Don't auto-submit for certain fields
                            if (this.name !== 'searchName' && this.name !== 'saveSearch') {
                                form.submit();
                            }
                        });
                    });
                });
            </script>
        </body>

        </html>