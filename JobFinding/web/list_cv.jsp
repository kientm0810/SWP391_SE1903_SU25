<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CV Management | JobFinding</title>
    
    <!-- CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="assets/css/main.css">
    
    <style>
        :root {
            --primary-color: #28a745;
            --primary-hover: #218838;
            --secondary-color: #20c997;
            --accent-color: #17a2b8;
            --success-color: #28a745;
            --warning-color: #ffc107;
            --danger-color: #dc3545;
            --light-bg: #f8f9fa;
            --border-color: #e9ecef;
            --text-muted: #6c757d;
            --text-dark: #2c3e50;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }

        .cv-management-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            margin: 20px auto;
            overflow: hidden;
        }

        .page-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 40px 30px;
            text-align: center;
            position: relative;
        }

        .page-header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--accent-color), var(--warning-color));
        }

        .page-header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .page-header p {
            font-size: 1.1rem;
            opacity: 0.9;
            margin: 0;
        }

        .stats-section {
            background: var(--light-bg);
            padding: 30px;
            border-bottom: 1px solid var(--border-color);
        }

        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            border: 1px solid var(--border-color);
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            font-size: 1.5rem;
            color: white;
        }

        .stat-icon.total { background: linear-gradient(45deg, var(--primary-color), var(--secondary-color)); }
        .stat-icon.active { background: linear-gradient(45deg, var(--success-color), #20c997); }
        .stat-icon.draft { background: linear-gradient(45deg, var(--warning-color), #fd7e14); }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 5px;
        }

        .stat-label {
            color: var(--text-muted);
            font-size: 0.9rem;
            font-weight: 500;
        }

        .actions-section {
            padding: 30px;
            border-bottom: 1px solid var(--border-color);
        }

        .search-box {
            position: relative;
            max-width: 500px;
        }

        .search-box .form-control {
            border-radius: 25px;
            padding: 12px 20px 12px 50px;
            border: 2px solid var(--border-color);
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .search-box .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
        }

        .search-box .search-icon {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            z-index: 10;
        }

        .btn-create-cv {
            background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
            border: none;
            border-radius: 25px;
            padding: 12px 30px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
        }

        .btn-create-cv:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(40, 167, 69, 0.4);
            background: linear-gradient(45deg, var(--primary-hover), #1e7e34);
        }

        .cv-grid {
            padding: 30px;
        }

        .cv-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            border: 1px solid var(--border-color);
            overflow: hidden;
            transition: all 0.3s ease;
            height: 100%;
        }

        .cv-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
        }

        .cv-header {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            padding: 20px;
            border-bottom: 1px solid var(--border-color);
            position: relative;
        }



        .cv-title {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 5px;
        }

        .cv-position {
            color: var(--primary-color);
            font-weight: 600;
            font-size: 1rem;
            margin-bottom: 10px;
        }

        .cv-meta {
            display: flex;
            align-items: center;
            gap: 15px;
            font-size: 0.85rem;
            color: var(--text-muted);
        }

        .cv-meta i {
            color: var(--primary-color);
        }

        .cv-body {
            padding: 20px;
        }

        .cv-info {
            margin-bottom: 15px;
        }

        .cv-info-item {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 8px;
            font-size: 0.9rem;
        }

        .cv-info-item i {
            color: var(--primary-color);
            width: 16px;
        }

        .cv-actions {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .btn-cv-action {
            flex: 1;
            min-width: 80px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            padding: 8px 12px;
            transition: all 0.3s ease;
        }

        .btn-cv-action:hover {
            transform: translateY(-2px);
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: var(--text-muted);
        }

        .empty-state-icon {
            font-size: 4rem;
            color: var(--border-color);
            margin-bottom: 20px;
        }

        .empty-state h4 {
            color: var(--text-dark);
            margin-bottom: 10px;
        }

        .empty-state p {
            font-size: 1.1rem;
            margin-bottom: 30px;
        }





        @media (max-width: 768px) {
            .page-header h1 {
                font-size: 2rem;
            }
            
            .cv-actions {
                flex-direction: column;
            }
            
            .btn-cv-action {
                width: 100%;
            }
        }

        .loading-spinner {
            display: none;
            text-align: center;
            padding: 40px;
        }

        .fade-in {
            animation: fadeIn 0.5s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>
    
    <div class="container-fluid">
        <div class="cv-management-container">
            <!-- Page Header -->
            <div class="page-header">
                <h1><i class="fas fa-file-alt me-3"></i>CV Management</h1>
                <p>Create, manage, and organize your professional CVs</p>
            </div>

            <!-- Success/Error Messages -->
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success alert-dismissible fade show m-3" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                    ${sessionScope.successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="successMessage" scope="session" />
            </c:if>

            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show m-3" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    ${sessionScope.errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="errorMessage" scope="session" />
            </c:if>

            <!-- Statistics Section -->
            <div class="stats-section">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <div class="stat-card">
                            <div class="stat-icon total">
                                <i class="fas fa-file-alt"></i>
                            </div>
                            <div class="stat-number">${cvs != null ? cvs.size() : 0}</div>
                            <div class="stat-label">Total CVs</div>
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <div class="stat-card">
                            <div class="stat-icon active">
                                <i class="fas fa-clock"></i>
                            </div>
                            <div class="stat-number">
                                <c:set var="recentCount" value="0" />
                                <c:forEach items="${cvs}" var="cv">
                                    <c:if test="${cv.createdAt != null}">
                                        <c:set var="now" value="<%= new java.util.Date() %>" />
                                        <c:set var="diffInDays" value="${(now.time - cv.createdAt.time) / (1000 * 60 * 60 * 24)}" />
                                        <c:if test="${diffInDays <= 7}">
                                            <c:set var="recentCount" value="${recentCount + 1}" />
                                        </c:if>
                                    </c:if>
                                </c:forEach>
                                ${recentCount}
                            </div>
                            <div class="stat-label">Recent CVs (7 days)</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Actions Section -->
            <div class="actions-section">
                <div class="row align-items-center">
                    <div class="col-lg-6 mb-3">
                        <div class="search-box">
                            <i class="fas fa-search search-icon"></i>
                            <form method="get" action="list_cv" class="position-relative">
                                <input type="text" 
                                       class="form-control" 
                                       name="search" 
                                       placeholder="Search CVs by name, position, or keywords..." 
                                       value="${searchTerm}">
                                <input type="hidden" name="page" value="1">
                            </form>
                        </div>
                    </div>
                    <div class="col-lg-6 mb-3 text-lg-end">
                        <a href="cv-upload" class="btn btn-create-cv">
                            <i class="fas fa-plus me-2"></i>Create New CV
                        </a>
                    </div>
                </div>


            </div>

            <!-- CV Grid -->
            <div class="cv-grid">
                <div class="loading-spinner">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${empty cvs}">
                        <div class="empty-state">
                            <div class="empty-state-icon">
                                <i class="fas fa-file-alt"></i>
                            </div>
                            <h4>No CVs Found</h4>
                            <p>Start building your professional profile by creating your first CV</p>
                            <a href="cv-upload" class="btn btn-create-cv">
                                <i class="fas fa-plus me-2"></i>Create Your First CV
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row g-4">
                            <c:forEach var="cv" items="${cvs}">
                                <div class="col-lg-4 col-md-6 cv-item fade-in">
                                    <div class="cv-card">
                                        <div class="cv-header">
                                            <div class="cv-title">${cv.fullName}</div>
                                            <div class="cv-position">${cv.jobPosition}</div>
                                            <div class="cv-meta">
                                                <span><i class="fas fa-calendar"></i> 
                                                    <fmt:formatDate value="${cv.createdAt}" pattern="dd/MM/yyyy" />
                                                </span>
                                                <c:if test="${not empty cv.pdfFilePath}">
                                                    <span><i class="fas fa-file-pdf"></i> PDF</span>
                                                </c:if>
                                            </div>
                                        </div>
                                        <div class="cv-body">
                                            <div class="cv-info">
                                                <div class="cv-info-item">
                                                    <i class="fas fa-user"></i>
                                                    <span>${cv.fullName}</span>
                                                </div>
                                                <div class="cv-info-item">
                                                    <i class="fas fa-envelope"></i>
                                                    <span>${cv.email}</span>
                                                </div>
                                                <c:if test="${not empty cv.phone}">
                                                    <div class="cv-info-item">
                                                        <i class="fas fa-phone"></i>
                                                        <span>${cv.phone}</span>
                                                    </div>
                                                </c:if>
                                            </div>
                                            <div class="cv-actions">
                                                <a href="cv-edit?id=${cv.id}" class="btn btn-outline-primary btn-cv-action" title="Edit CV">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <c:if test="${not empty cv.pdfFilePath}">
                                                    <a href="${cv.pdfFilePath}" target="_blank" class="btn btn-outline-success btn-cv-action" title="Download PDF">
                                                        <i class="fas fa-download"></i>
                                                    </a>
                                                </c:if>
                                                <button class="btn btn-outline-info btn-cv-action" onclick="previewCV('${cv.id}')" title="Preview CV">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                                <button class="btn btn-outline-danger btn-cv-action" onclick="confirmDelete(${cv.id}, '${cv.jobPosition}')" title="Delete CV">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>


                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-exclamation-triangle text-warning me-2"></i>
                        Confirm Delete CV
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the CV "<span id="cvName"></span>"?</p>
                    <p class="text-muted small">This action cannot be undone.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <form id="deleteForm" method="post" action="list_cv" class="d-inline">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="cvId" id="deleteCvId">
                        <input type="hidden" name="csrfToken" id="csrfTokenInput" value="${sessionScope.csrfToken}">
                        <button type="submit" class="btn btn-danger">
                            <i class="fas fa-trash me-2"></i>Delete CV
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Preview Modal -->
    <div class="modal fade" id="previewModal" tabindex="-1">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-eye me-2"></i>
                        CV Preview
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div id="previewContent" class="text-center">
                        <div class="spinner-border text-primary" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <a href="#" id="editCvLink" class="btn btn-primary">
                        <i class="fas fa-edit me-2"></i>Edit CV
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/main.js"></script>
    
    <script>
        // Delete confirmation
        function confirmDelete(cvId, cvName) {
            document.getElementById('deleteCvId').value = cvId;
            document.getElementById('cvName').textContent = cvName;
            // Set CSRF token from a global JS variable or from the DOM if available
            var csrfToken = '${sessionScope.csrfToken}';
            if (csrfToken && document.getElementById('csrfTokenInput')) {
                document.getElementById('csrfTokenInput').value = csrfToken;
            }
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }

        // Preview CV
        function previewCV(cvId) {
            const modal = new bootstrap.Modal(document.getElementById('previewModal'));
            const previewContent = document.getElementById('previewContent');
            const editLink = document.getElementById('editCvLink');
            
            modal.show();
            previewContent.innerHTML = '<div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div>';
            editLink.href = `cv-edit?id=${cvId}`;
            
            // Guard: check for invalid or missing cvId
            if (!cvId || isNaN(Number(cvId)) || Number(cvId) <= 0) {
                previewContent.innerHTML = '<div class="alert alert-danger">Invalid CV ID. Please try again.</div>';
                return;
            }
            // Load CV preview content
            fetch(`cv-preview?id=${cvId}`)
                .then(response => response.text())
                .then(html => {
                    previewContent.innerHTML = html;
                })
                .catch(error => {
                    previewContent.innerHTML = '<div class="alert alert-danger">Error loading CV preview</div>';
                });
        }



        // Auto-submit search form when typing (with debounce)
        let searchTimeout;
        const searchInput = document.querySelector('input[name="search"]');
        if (searchInput) {
            searchInput.addEventListener('input', function() {
                clearTimeout(searchTimeout);
                searchTimeout = setTimeout(() => {
                    this.form.submit();
                }, 500);
            });
        }

        // Auto-hide alerts after 5 seconds
        setTimeout(() => {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                if (alert.querySelector('.btn-close')) {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                }
            });
        }, 5000);

        // Add fade-in animation to CV cards
        document.addEventListener('DOMContentLoaded', function() {
            const cvItems = document.querySelectorAll('.cv-item');
            cvItems.forEach((item, index) => {
                item.style.animationDelay = `${index * 0.1}s`;
            });
        });
    </script>
</body>
</html>