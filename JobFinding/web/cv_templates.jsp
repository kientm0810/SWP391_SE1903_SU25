<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Mẫu CV | JobFinding</title>

            <!-- CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
            <link rel="stylesheet" href="assets/css/main.css">
        </head>

        <body>
            <div class="container py-5">
                <h1 class="text-center mb-4">Mẫu CV chuyên nghiệp</h1>
                <p class="text-center text-muted mb-5">Chọn mẫu CV phù hợp với ngành nghề của bạn</p>

                <!-- Template Categories -->
                <div class="row mb-4">
                    <div class="col-12">
                        <ul class="nav nav-pills justify-content-center">
                            <li class="nav-item">
                                <a class="nav-link active" href="#all">Tất cả</a>
                            </li>
                            <c:forEach items="${categories}" var="category">
                                <li class="nav-item">
                                    <a class="nav-link" href="#${category.id}">${category.name}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>

                <!-- Template Grid -->
                <div class="row g-4">
                    <c:forEach items="${templates}" var="template">
                        <div class="col-md-4">
                            <div class="card h-100">
                                <img src="${template.thumbnail}" class="card-img-top" alt="${template.name}">
                                <div class="card-body">
                                    <h5 class="card-title">${template.name}</h5>
                                    <p class="card-text text-muted">${template.description}</p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div class="btn-group">
                                            <a href="create_cv.jsp?template=${template.id}" class="btn btn-primary">
                                                <i class="fas fa-plus me-2"></i>Sử dụng mẫu này
                                            </a>
                                            <button type="button" class="btn btn-outline-secondary preview-template"
                                                data-template-id="${template.id}">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                        </div>
                                        <c:if test="${template.isPremium}">
                                            <span class="badge bg-warning">Premium</span>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Preview Modal -->
            <div class="modal fade" id="previewModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Xem trước mẫu CV</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <img src="" class="img-fluid" id="previewImage" alt="Preview CV">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <a href="#" class="btn btn-primary" id="useTemplateBtn">
                                <i class="fas fa-plus me-2"></i>Sử dụng mẫu này
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Scripts -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    // Preview template functionality
                    const previewBtns = document.querySelectorAll('.preview-template');
                    const previewModal = new bootstrap.Modal(document.getElementById('previewModal'));
                    const previewImage = document.getElementById('previewImage');
                    const useTemplateBtn = document.getElementById('useTemplateBtn');

                    previewBtns.forEach(btn => {
                        btn.addEventListener('click', function () {
                            const templateId = this.dataset.templateId;
                            // Update preview image source
                            previewImage.src = `assets/images/templates/${templateId}_preview.jpg`;
                            // Update use template button href
                            useTemplateBtn.href = `create_cv.jsp?template=${templateId}`;
                            previewModal.show();
                        });
                    });

                    // Filter templates by category
                    const filterLinks = document.querySelectorAll('.nav-pills .nav-link');
                    filterLinks.forEach(link => {
                        link.addEventListener('click', function (e) {
                            e.preventDefault();
                            filterLinks.forEach(l => l.classList.remove('active'));
                            this.classList.add('active');
                            // Add filter logic here
                        });
                    });
                });
            </script>
        </body>

        </html>