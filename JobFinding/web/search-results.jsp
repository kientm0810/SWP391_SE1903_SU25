<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Kết quả tìm kiếm - JobFinding</title>

                <!-- Bootstrap CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <!-- Font Awesome -->
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
                <!-- Custom CSS -->
                <link href="assets/css/advanced-search.css" rel="stylesheet">

                <style>
                    .result-header {
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        color: white;
                        padding: 40px 0;
                    }

                    .job-card {
                        background: white;
                        border-radius: 15px;
                        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
                        margin-bottom: 20px;
                        transition: all 0.3s ease;
                        border-left: 4px solid transparent;
                    }

                    .job-card:hover {
                        transform: translateY(-5px);
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
                        border-left-color: #667eea;
                    }

                    .job-title {
                        color: #667eea;
                        font-weight: 600;
                        text-decoration: none;
                    }

                    .job-title:hover {
                        color: #764ba2;
                    }

                    .company-name {
                        color: #6c757d;
                        font-weight: 500;
                    }

                    .job-meta {
                        font-size: 0.9rem;
                        color: #6c757d;
                    }

                    .badge-custom {
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        color: white;
                        border-radius: 20px;
                        padding: 5px 12px;
                        font-size: 0.8rem;
                    }

                    .filter-sidebar {
                        background: white;
                        border-radius: 15px;
                        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
                        padding: 20px;
                        position: sticky;
                        top: 20px;
                    }

                    .filter-group {
                        margin-bottom: 20px;
                        padding-bottom: 15px;
                        border-bottom: 1px solid #e9ecef;
                    }

                    .filter-group:last-child {
                        border-bottom: none;
                    }

                    .filter-title {
                        font-weight: 600;
                        color: #495057;
                        margin-bottom: 10px;
                    }

                    .filter-option {
                        display: flex;
                        align-items: center;
                        margin-bottom: 8px;
                        cursor: pointer;
                    }

                    .filter-option input[type="checkbox"] {
                        margin-right: 8px;
                    }

                    .filter-option label {
                        margin-bottom: 0;
                        cursor: pointer;
                        font-size: 0.9rem;
                    }

                    .filter-count {
                        color: #6c757d;
                        font-size: 0.8rem;
                        margin-left: auto;
                    }

                    .salary-range {
                        display: flex;
                        gap: 10px;
                        align-items: center;
                    }

                    .salary-input {
                        flex: 1;
                    }

                    .sort-dropdown {
                        background: white;
                        border: 2px solid #e9ecef;
                        border-radius: 10px;
                        padding: 8px 12px;
                    }

                    .pagination-custom .page-link {
                        border-radius: 8px;
                        margin: 0 2px;
                        border: none;
                        color: #667eea;
                    }

                    .pagination-custom .page-item.active .page-link {
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        border-color: #667eea;
                    }

                    .no-results {
                        text-align: center;
                        padding: 60px 20px;
                    }

                    .no-results i {
                        font-size: 4rem;
                        color: #6c757d;
                        margin-bottom: 20px;
                    }

                    .search-summary {
                        background: #f8f9fa;
                        border-radius: 10px;
                        padding: 15px;
                        margin-bottom: 20px;
                    }

                    .search-summary .badge {
                        background: #667eea;
                        margin-right: 5px;
                        margin-bottom: 5px;
                    }
                </style>
            </head>

            <body>
                <!-- Header -->
                <jsp:include page="header.jsp" />

                <!-- Result Header -->
                <div class="result-header">
                    <div class="container">
                        <div class="row align-items-center">
                            <div class="col-md-8">
                                <h1 class="mb-3">
                                    <i class="fas fa-search me-3"></i>
                                    Kết quả tìm kiếm
                                </h1>
                                <p class="lead mb-0">
                                    Tìm thấy <strong>${totalJobs}</strong> việc làm phù hợp
                                    <span class="ms-3">
                                        <i class="fas fa-clock me-1"></i>
                                        Tìm kiếm trong ${searchTime} giây
                                    </span>
                                </p>
                            </div>
                            <div class="col-md-4 text-end">
                                <a href="advanced-search" class="btn btn-outline-light">
                                    <i class="fas fa-edit me-2"></i>
                                    Chỉnh sửa tìm kiếm
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="container my-5">
                    <div class="row">
                        <!-- Filter Sidebar -->
                        <div class="col-lg-3">
                            <div class="filter-sidebar">
                                <h5 class="mb-4">
                                    <i class="fas fa-filter me-2"></i>
                                    Bộ lọc
                                </h5>

                                <!-- Search Summary -->
                                <c:if test="${criteria.hasFilters()}">
                                    <div class="search-summary">
                                        <h6 class="mb-2">Bộ lọc hiện tại:</h6>
                                        <c:if test="${not empty criteria.keyword}">
                                            <span class="badge">Từ khóa: ${criteria.keyword}</span>
                                        </c:if>
                                        <c:if test="${not empty criteria.location}">
                                            <span class="badge">Địa điểm: ${criteria.location}</span>
                                        </c:if>
                                        <c:if test="${not empty criteria.industry}">
                                            <span class="badge">Ngành: ${criteria.industry}</span>
                                        </c:if>
                                        <c:if test="${not empty criteria.jobType}">
                                            <span class="badge">Loại việc: ${criteria.jobType}</span>
                                        </c:if>
                                        <c:if test="${not empty criteria.experienceLevel}">
                                            <span class="badge">Kinh nghiệm: ${criteria.experienceLevel}</span>
                                        </c:if>
                                    </div>
                                </c:if>

                                <!-- Job Type Filter -->
                                <div class="filter-group">
                                    <div class="filter-title">Loại công việc</div>
                                    <div class="filter-option">
                                        <input type="checkbox" id="full_time" name="jobType" value="full_time"
                                            ${criteria.jobType=='full_time' ? 'checked' : '' }>
                                        <label for="full_time">Toàn thời gian</label>
                                    </div>
                                    <div class="filter-option">
                                        <input type="checkbox" id="part_time" name="jobType" value="part_time"
                                            ${criteria.jobType=='part_time' ? 'checked' : '' }>
                                        <label for="part_time">Bán thời gian</label>
                                    </div>
                                    <div class="filter-option">
                                        <input type="checkbox" id="contract" name="jobType" value="contract"
                                            ${criteria.jobType=='contract' ? 'checked' : '' }>
                                        <label for="contract">Hợp đồng</label>
                                    </div>
                                    <div class="filter-option">
                                        <input type="checkbox" id="internship" name="jobType" value="internship"
                                            ${criteria.jobType=='internship' ? 'checked' : '' }>
                                        <label for="internship">Thực tập</label>
                                    </div>
                                </div>

                                <!-- Experience Level Filter -->
                                <div class="filter-group">
                                    <div class="filter-title">Kinh nghiệm</div>
                                    <div class="filter-option">
                                        <input type="checkbox" id="entry" name="experienceLevel" value="entry"
                                            ${criteria.experienceLevel=='entry' ? 'checked' : '' }>
                                        <label for="entry">Mới tốt nghiệp</label>
                                    </div>
                                    <div class="filter-option">
                                        <input type="checkbox" id="junior" name="experienceLevel" value="junior"
                                            ${criteria.experienceLevel=='junior' ? 'checked' : '' }>
                                        <label for="junior">Junior (1-3 năm)</label>
                                    </div>
                                    <div class="filter-option">
                                        <input type="checkbox" id="mid" name="experienceLevel" value="mid"
                                            ${criteria.experienceLevel=='mid' ? 'checked' : '' }>
                                        <label for="mid">Mid-level (3-5 năm)</label>
                                    </div>
                                    <div class="filter-option">
                                        <input type="checkbox" id="senior" name="experienceLevel" value="senior"
                                            ${criteria.experienceLevel=='senior' ? 'checked' : '' }>
                                        <label for="senior">Senior (5+ năm)</label>
                                    </div>
                                </div>

                                <!-- Salary Range Filter -->
                                <div class="filter-group">
                                    <div class="filter-title">Mức lương (triệu VND/tháng)</div>
                                    <div class="salary-range">
                                        <input type="number" class="form-control salary-input" placeholder="Từ"
                                            value="${criteria.minSalary}">
                                        <span>-</span>
                                        <input type="number" class="form-control salary-input" placeholder="Đến"
                                            value="${criteria.maxSalary}">
                                    </div>
                                </div>

                                <!-- Work Type Filter -->
                                <div class="filter-group">
                                    <div class="filter-title">Hình thức làm việc</div>
                                    <div class="filter-option">
                                        <input type="checkbox" id="on_site" name="workType" value="on_site"
                                            ${criteria.workType=='on_site' ? 'checked' : '' }>
                                        <label for="on_site">Tại văn phòng</label>
                                    </div>
                                    <div class="filter-option">
                                        <input type="checkbox" id="remote" name="workType" value="remote"
                                            ${criteria.workType=='remote' ? 'checked' : '' }>
                                        <label for="remote">Làm từ xa</label>
                                    </div>
                                    <div class="filter-option">
                                        <input type="checkbox" id="hybrid" name="workType" value="hybrid"
                                            ${criteria.workType=='hybrid' ? 'checked' : '' }>
                                        <label for="hybrid">Kết hợp</label>
                                    </div>
                                </div>

                                <!-- Apply Filters Button -->
                                <button class="btn btn-primary w-100" onclick="applyFilters()">
                                    <i class="fas fa-filter me-2"></i>
                                    Áp dụng bộ lọc
                                </button>
                            </div>
                        </div>

                        <!-- Results Column -->
                        <div class="col-lg-9">
                            <!-- Sort and View Options -->
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <div>
                                    <span class="text-muted">Hiển thị ${(currentPage - 1) * criteria.pageSize + 1} -
                                        ${Math.min(currentPage * criteria.pageSize, totalJobs)} của ${totalJobs} kết
                                        quả</span>
                                </div>
                                <div class="d-flex align-items-center gap-3">
                                    <select class="form-select sort-dropdown" onchange="changeSort(this.value)">
                                        <option value="created_at DESC" ${criteria.sortBy=='created_at' &&
                                            criteria.sortOrder=='DESC' ? 'selected' : '' }>
                                            Mới nhất
                                        </option>
                                        <option value="salary_min DESC" ${criteria.sortBy=='salary_min' &&
                                            criteria.sortOrder=='DESC' ? 'selected' : '' }>
                                            Lương cao nhất
                                        </option>
                                        <option value="title ASC" ${criteria.sortBy=='title' &&
                                            criteria.sortOrder=='ASC' ? 'selected' : '' }>
                                            Tên A-Z
                                        </option>
                                        <option value="company_name ASC" ${criteria.sortBy=='company_name' &&
                                            criteria.sortOrder=='ASC' ? 'selected' : '' }>
                                            Công ty A-Z
                                        </option>
                                    </select>
                                </div>
                            </div>

                            <!-- Job Results -->
                            <c:if test="${not empty jobs}">
                                <c:forEach var="job" items="${jobs}">
                                    <div class="job-card p-4">
                                        <div class="row">
                                            <div class="col-md-8">
                                                <h5 class="job-title mb-2">
                                                    <a href="post?id=${job.id}"
                                                        class="text-decoration-none">${job.title}</a>
                                                </h5>
                                                <p class="company-name mb-2">
                                                    <i class="fas fa-building me-2"></i>${job.companyName}
                                                </p>
                                                <div class="job-meta mb-3">
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <i class="fas fa-map-marker-alt me-2"></i>${job.location}
                                                        </div>
                                                        <div class="col-md-6">
                                                            <i class="fas fa-clock me-2"></i>${job.jobType}
                                                        </div>
                                                    </div>
                                                    <div class="row mt-2">
                                                        <div class="col-md-6">
                                                            <i class="fas fa-money-bill-wave me-2"></i>${job.salary}
                                                        </div>
                                                        <div class="col-md-6">
                                                            <i class="fas fa-calendar me-2"></i>
                                                            <fmt:formatDate value="${job.createdAt}"
                                                                pattern="dd/MM/yyyy" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="mb-3">
                                                    <c:if test="${not empty job.jobType}">
                                                        <span class="badge badge-custom me-2">${job.jobType}</span>
                                                    </c:if>
                                                    <c:if test="${not empty job.experience}">
                                                        <span class="badge badge-custom me-2">${job.experience}</span>
                                                    </c:if>
                                                    <c:if test="${not empty job.industry}">
                                                        <span class="badge badge-custom">${job.industry}</span>
                                                    </c:if>
                                                </div>
                                                <c:if test="${not empty job.jobDescription}">
                                                    <p class="text-muted mb-0">
                                                        ${job.jobDescription.length() > 200 ?
                                                        job.jobDescription.substring(0, 200) + '...' :
                                                        job.jobDescription}
                                                    </p>
                                                </c:if>
                                            </div>
                                            <div class="col-md-4 text-end">
                                                <div class="d-grid gap-2">
                                                    <a href="post?id=${job.id}" class="btn btn-primary btn-sm">
                                                        <i class="fas fa-eye me-1"></i>Xem chi tiết
                                                    </a>
                                                    <button class="btn btn-outline-primary btn-sm"
                                                        onclick="saveJob(${job.id})">
                                                        <i class="fas fa-bookmark me-1"></i>Lưu việc làm
                                                    </button>
                                                    <button class="btn btn-outline-success btn-sm"
                                                        onclick="applyJob(${job.id})">
                                                        <i class="fas fa-paper-plane me-1"></i>Ứng tuyển
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>

                                <!-- Pagination -->
                                <c:if test="${totalPages > 1}">
                                    <nav aria-label="Search results pagination">
                                        <ul class="pagination pagination-custom justify-content-center">
                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                <a class="page-link" href="?page=${currentPage - 1}&${queryString}">
                                                    <i class="fas fa-chevron-left"></i>
                                                </a>
                                            </li>

                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <c:choose>
                                                    <c:when test="${i == currentPage}">
                                                        <li class="page-item active">
                                                            <span class="page-link">${i}</span>
                                                        </li>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <li class="page-item">
                                                            <a class="page-link"
                                                                href="?page=${i}&${queryString}">${i}</a>
                                                        </li>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>

                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                <a class="page-link" href="?page=${currentPage + 1}&${queryString}">
                                                    <i class="fas fa-chevron-right"></i>
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>
                                </c:if>
                            </c:if>

                            <!-- No Results -->
                            <c:if test="${empty jobs}">
                                <div class="no-results">
                                    <i class="fas fa-search"></i>
                                    <h4 class="text-muted">Không tìm thấy việc làm phù hợp</h4>
                                    <p class="text-muted">Hãy thử thay đổi bộ lọc hoặc từ khóa tìm kiếm</p>
                                    <a href="advanced-search" class="btn btn-primary">
                                        <i class="fas fa-edit me-2"></i>
                                        Thử tìm kiếm khác
                                    </a>
                                </div>
                            </c:if>
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
                    // Apply filters
                    function applyFilters() {
                        const form = document.createElement('form');
                        form.method = 'GET';
                        form.action = 'advanced-search';

                        // Add current search parameters
                        const currentParams = new URLSearchParams(window.location.search);
                        for (const [key, value] of currentParams) {
                            if (key !== 'page') { // Don't include page parameter
                                const input = document.createElement('input');
                                input.type = 'hidden';
                                input.name = key;
                                input.value = value;
                                form.appendChild(input);
                            }
                        }

                        // Add filter values
                        const jobTypes = document.querySelectorAll('input[name="jobType"]:checked');
                        jobTypes.forEach(checkbox => {
                            const input = document.createElement('input');
                            input.type = 'hidden';
                            input.name = 'jobType';
                            input.value = checkbox.value;
                            form.appendChild(input);
                        });

                        const experienceLevels = document.querySelectorAll('input[name="experienceLevel"]:checked');
                        experienceLevels.forEach(checkbox => {
                            const input = document.createElement('input');
                            input.type = 'hidden';
                            input.name = 'experienceLevel';
                            input.value = checkbox.value;
                            form.appendChild(input);
                        });

                        const workTypes = document.querySelectorAll('input[name="workType"]:checked');
                        workTypes.forEach(checkbox => {
                            const input = document.createElement('input');
                            input.type = 'hidden';
                            input.name = 'workType';
                            input.value = checkbox.value;
                            form.appendChild(input);
                        });

                        // Add salary range
                        const salaryInputs = document.querySelectorAll('.salary-input');
                        if (salaryInputs[0].value) {
                            const input = document.createElement('input');
                            input.type = 'hidden';
                            input.name = 'minSalary';
                            input.value = salaryInputs[0].value;
                            form.appendChild(input);
                        }

                        if (salaryInputs[1].value) {
                            const input = document.createElement('input');
                            input.type = 'hidden';
                            input.name = 'maxSalary';
                            input.value = salaryInputs[1].value;
                            form.appendChild(input);
                        }

                        document.body.appendChild(form);
                        form.submit();
                    }

                    // Change sort order
                    function changeSort(sortValue) {
                        const [sortBy, sortOrder] = sortValue.split(' ');
                        const url = new URL(window.location);
                        url.searchParams.set('sortBy', sortBy);
                        url.searchParams.set('sortOrder', sortOrder);
                        url.searchParams.delete('page'); // Reset to first page
                        window.location.href = url.toString();
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

                    // Apply for job
                    function applyJob(jobId) {
                        window.location.href = 'apply-job?jobId=' + jobId;
                    }

                    // Auto-submit form when filters change
                    document.addEventListener('DOMContentLoaded', function () {
                        const checkboxes = document.querySelectorAll('input[type="checkbox"]');
                        checkboxes.forEach(checkbox => {
                            checkbox.addEventListener('change', function () {
                                // Don't auto-submit for now, let user click apply button
                            });
                        });
                    });
                </script>
            </body>

            </html>