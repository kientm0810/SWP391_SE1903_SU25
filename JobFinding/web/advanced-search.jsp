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
                .search-container {
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    min-height: 300px;
                    padding: 60px 0;
                }

                .filter-card {
                    background: white;
                    border-radius: 15px;
                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                    margin-bottom: 20px;
                }

                .filter-header {
                    background: #f8f9fa;
                    padding: 15px 20px;
                    border-radius: 15px 15px 0 0;
                    border-bottom: 1px solid #e9ecef;
                }

                .filter-body {
                    padding: 20px;
                }

                .form-control,
                .form-select {
                    border-radius: 10px;
                    border: 2px solid #e9ecef;
                    transition: all 0.3s ease;
                }

                .form-control:focus,
                .form-select:focus {
                    border-color: #667eea;
                    box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
                }

                .btn-primary {
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    border: none;
                    border-radius: 10px;
                    padding: 12px 30px;
                    font-weight: 600;
                }

                .btn-outline-secondary {
                    border-radius: 10px;
                    padding: 12px 30px;
                }

                .suggestion-tag {
                    display: inline-block;
                    background: #e9ecef;
                    color: #495057;
                    padding: 5px 12px;
                    border-radius: 20px;
                    margin: 2px;
                    cursor: pointer;
                    transition: all 0.3s ease;
                    font-size: 0.9em;
                }

                .suggestion-tag:hover {
                    background: #667eea;
                    color: white;
                }

                .stats-card {
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    color: white;
                    border-radius: 15px;
                    padding: 20px;
                    margin-bottom: 20px;
                }

                .collapse-toggle {
                    cursor: pointer;
                    color: #667eea;
                }

                .collapse-toggle:hover {
                    color: #764ba2;
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
                                        <label for="keyword" class="form-label fw-bold">
                                            <i class="fas fa-key me-2"></i>Từ khóa
                                        </label>
                                        <input type="text" class="form-control" id="keyword" name="keyword"
                                            placeholder="Vị trí, công ty, kỹ năng..." value="${param.keyword}">
                                    </div>

                                    <div class="mb-3">
                                        <label for="location" class="form-label fw-bold">
                                            <i class="fas fa-map-marker-alt me-2"></i>Địa điểm
                                        </label>
                                        <input type="text" class="form-control" id="location" name="location"
                                            placeholder="Thành phố, tỉnh..." value="${param.location}">
                                    </div>

                                    <div class="mb-3">
                                        <label for="industry" class="form-label fw-bold">
                                            <i class="fas fa-industry me-2"></i>Ngành nghề
                                        </label>
                                        <select class="form-select" id="industry" name="industry">
                                            <option value="">Tất cả ngành nghề</option>
                                            <option value="IT/Software" ${param.industry=='IT/Software' ? 'selected'
                                                : '' }>IT/Phần mềm</option>
                                            <option value="Marketing" ${param.industry=='Marketing' ? 'selected' : '' }>
                                                Marketing</option>
                                            <option value="Finance" ${param.industry=='Finance' ? 'selected' : '' }>Tài
                                                chính</option>
                                            <option value="Education" ${param.industry=='Education' ? 'selected' : '' }>
                                                Giáo dục</option>
                                            <option value="Healthcare" ${param.industry=='Healthcare' ? 'selected' : ''
                                                }>Y tế</option>
                                            <option value="Manufacturing" ${param.industry=='Manufacturing' ? 'selected'
                                                : '' }>Sản xuất</option>
                                            <option value="Retail" ${param.industry=='Retail' ? 'selected' : '' }>Bán lẻ
                                            </option>
                                            <option value="Other" ${param.industry=='Other' ? 'selected' : '' }>Khác
                                            </option>
                                        </select>
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
                                        <label for="jobType" class="form-label fw-bold">
                                            <i class="fas fa-clock me-2"></i>Loại công việc
                                        </label>
                                        <select class="form-select" id="jobType" name="jobType">
                                            <option value="">Tất cả loại</option>
                                            <option value="Full-time" ${param.jobType=='Full-time' ? 'selected' : '' }>
                                                Toàn thời gian</option>
                                            <option value="Part-time" ${param.jobType=='Part-time' ? 'selected' : '' }>
                                                Bán thời gian</option>
                                            <option value="Contract" ${param.jobType=='Contract' ? 'selected' : '' }>Hợp
                                                đồng</option>
                                            <option value="Internship" ${param.jobType=='Internship' ? 'selected' : ''
                                                }>Thực tập</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="experienceLevel" class="form-label fw-bold">
                                            <i class="fas fa-star me-2"></i>Kinh nghiệm
                                        </label>
                                        <select class="form-select" id="experienceLevel" name="experienceLevel">
                                            <option value="">Tất cả mức</option>
                                            <option value="entry" ${param.experienceLevel=='entry' ? 'selected' : '' }>
                                                Mới tốt nghiệp</option>
                                            <option value="junior" ${param.experienceLevel=='junior' ? 'selected' : ''
                                                }>Junior (1-3 năm)</option>
                                            <option value="mid" ${param.experienceLevel=='mid' ? 'selected' : '' }>
                                                Mid-level (3-5 năm)</option>
                                            <option value="senior" ${param.experienceLevel=='senior' ? 'selected' : ''
                                                }>Senior (5+ năm)</option>
                                            <option value="lead" ${param.experienceLevel=='lead' ? 'selected' : '' }>
                                                Lead/Manager</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="workType" class="form-label fw-bold">
                                            <i class="fas fa-home me-2"></i>Hình thức làm việc
                                        </label>
                                        <select class="form-select" id="workType" name="workType">
                                            <option value="">Tất cả hình thức</option>
                                            <option value="on_site" ${param.workType=='on_site' ? 'selected' : '' }>Tại
                                                văn phòng</option>
                                            <option value="remote" ${param.workType=='remote' ? 'selected' : '' }>Làm từ
                                                xa</option>
                                            <option value="hybrid" ${param.workType=='hybrid' ? 'selected' : '' }>Kết
                                                hợp</option>
                                        </select>
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
                                    <div class="row">
                                        <div class="col-6">
                                            <label for="minSalary" class="form-label fw-bold">Tối thiểu</label>
                                            <input type="number" class="form-control" id="minSalary" name="minSalary"
                                                placeholder="0" value="${param.minSalary}">
                                        </div>
                                        <div class="col-6">
                                            <label for="maxSalary" class="form-label fw-bold">Tối đa</label>
                                            <input type="number" class="form-control" id="maxSalary" name="maxSalary"
                                                placeholder="Không giới hạn" value="${param.maxSalary}">
                                        </div>
                                    </div>
                                    <small class="text-muted">Đơn vị: triệu VND/tháng</small>
                                </div>
                            </div>

                            <!-- Company & Benefits -->
                            <div class="filter-card">
                                <div class="filter-header">
                                    <h5 class="mb-0 collapse-toggle" data-bs-toggle="collapse"
                                        data-bs-target="#companyBenefits">
                                        <i class="fas fa-building me-2"></i>
                                        Công ty & Phúc lợi
                                        <i class="fas fa-chevron-down float-end"></i>
                                    </h5>
                                </div>
                                <div class="collapse show" id="companyBenefits">
                                    <div class="filter-body">
                                        <div class="mb-3">
                                            <label for="companySize" class="form-label fw-bold">Quy mô công ty</label>
                                            <select class="form-select" id="companySize" name="companySize">
                                                <option value="">Tất cả quy mô</option>
                                                <option value="startup" ${param.companySize=='startup' ? 'selected' : ''
                                                    }>Startup (< 50)</option>
                                                <option value="small" ${param.companySize=='small' ? 'selected' : '' }>
                                                    Nhỏ (50-200)</option>
                                                <option value="medium" ${param.companySize=='medium' ? 'selected' : ''
                                                    }>Vừa (200-1000)</option>
                                                <option value="large" ${param.companySize=='large' ? 'selected' : '' }>
                                                    Lớn (1000+)</option>
                                            </select>
                                        </div>

                                        <div class="mb-3">
                                            <label for="benefits" class="form-label fw-bold">Phúc lợi</label>
                                            <input type="text" class="form-control" id="benefits" name="benefits"
                                                placeholder="Bảo hiểm, thưởng..." value="${param.benefits}">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Skills & Requirements -->
                            <div class="filter-card">
                                <div class="filter-header">
                                    <h5 class="mb-0 collapse-toggle" data-bs-toggle="collapse"
                                        data-bs-target="#skillsRequirements">
                                        <i class="fas fa-tools me-2"></i>
                                        Kỹ năng & Yêu cầu
                                        <i class="fas fa-chevron-down float-end"></i>
                                    </h5>
                                </div>
                                <div class="collapse" id="skillsRequirements">
                                    <div class="filter-body">
                                        <div class="mb-3">
                                            <label for="skills" class="form-label fw-bold">Kỹ năng</label>
                                            <input type="text" class="form-control" id="skills" name="skills"
                                                placeholder="Java, React, SQL..." value="${param.skills}">
                                        </div>

                                        <div class="mb-3">
                                            <label for="education" class="form-label fw-bold">Học vấn</label>
                                            <select class="form-select" id="education" name="education">
                                                <option value="">Tất cả trình độ</option>
                                                <option value="high_school" ${param.education=='high_school'
                                                    ? 'selected' : '' }>Trung học phổ thông</option>
                                                <option value="college" ${param.education=='college' ? 'selected' : ''
                                                    }>Cao đẳng</option>
                                                <option value="bachelor" ${param.education=='bachelor' ? 'selected' : ''
                                                    }>Đại học</option>
                                                <option value="master" ${param.education=='master' ? 'selected' : '' }>
                                                    Thạc sĩ</option>
                                                <option value="phd" ${param.education=='phd' ? 'selected' : '' }>Tiến sĩ
                                                </option>
                                            </select>
                                        </div>

                                        <div class="mb-3">
                                            <label for="language" class="form-label fw-bold">Ngoại ngữ</label>
                                            <input type="text" class="form-control" id="language" name="language"
                                                placeholder="Tiếng Anh, Tiếng Nhật..." value="${param.language}">
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
                                        <label for="sortBy" class="form-label fw-bold">Sắp xếp theo</label>
                                        <select class="form-select" id="sortBy" name="sortBy">
                                            <option value="created_at" ${param.sortBy=='created_at' ? 'selected' : '' }>
                                                Ngày đăng</option>
                                            <option value="salary_min" ${param.sortBy=='salary_min' ? 'selected' : '' }>
                                                Mức lương</option>
                                            <option value="title" ${param.sortBy=='title' ? 'selected' : '' }>Tên công
                                                việc</option>
                                            <option value="company_name" ${param.sortBy=='company_name' ? 'selected'
                                                : '' }>Tên công ty</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="sortOrder" class="form-label fw-bold">Thứ tự</label>
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
                            <input type="hidden" name="action" value="search">
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
            <!--<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>-->
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
//                document.addEventListener('DOMContentLoaded', function () {
//                    const form = document.getElementById('advancedSearchForm');
//                    const inputs = form.querySelectorAll('input, select');
//
//                    inputs.forEach(input => {
//                        input.addEventListener('change', function () {
//                            // Don't auto-submit for certain fields
//                            if (this.name !== 'searchName' && this.name !== 'saveSearch') {
//                                form.submit();
//                            }
//                        });
//                    });
//                });
            </script>
        </body>

        </html>