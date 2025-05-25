<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Blog | JobFinding</title>

                <!-- CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
                <link rel="stylesheet" href="assets/css/main.css">
            </head>

            <body>
                <div class="container py-5">
                    <div class="row">
                        <!-- Main Content -->
                        <div class="col-lg-8">
                            <h1 class="mb-4">Blog</h1>

                            <!-- Featured Post -->
                            <c:if test="${not empty featuredPost}">
                                <div class="card mb-4">
                                    <img src="${featuredPost.thumbnail}" class="card-img-top"
                                        alt="${featuredPost.title}">
                                    <div class="card-body">
                                        <div class="d-flex align-items-center mb-2">
                                            <span class="badge bg-primary me-2">${featuredPost.category}</span>
                                            <small class="text-muted">
                                                <fmt:formatDate value="${featuredPost.publishedAt}"
                                                    pattern="dd/MM/yyyy" />
                                            </small>
                                        </div>
                                        <h2 class="card-title h4">
                                            <a href="post_detail.jsp?id=${featuredPost.id}"
                                                class="text-decoration-none text-dark">
                                                ${featuredPost.title}
                                            </a>
                                        </h2>
                                        <p class="card-text">${featuredPost.excerpt}</p>
                                        <div class="d-flex align-items-center">
                                            <img src="${featuredPost.author.avatar}" class="rounded-circle me-2"
                                                width="32" height="32" alt="${featuredPost.author.name}">
                                            <span class="text-muted">${featuredPost.author.name}</span>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <!-- Post List -->
                            <div class="row g-4">
                                <c:forEach items="${posts}" var="post">
                                    <div class="col-md-6">
                                        <div class="card h-100">
                                            <img src="${post.thumbnail}" class="card-img-top" alt="${post.title}">
                                            <div class="card-body">
                                                <div class="d-flex align-items-center mb-2">
                                                    <span class="badge bg-secondary me-2">${post.category}</span>
                                                    <small class="text-muted">
                                                        <fmt:formatDate value="${post.publishedAt}"
                                                            pattern="dd/MM/yyyy" />
                                                    </small>
                                                </div>
                                                <h3 class="card-title h5">
                                                    <a href="post_detail.jsp?id=${post.id}"
                                                        class="text-decoration-none text-dark">
                                                        ${post.title}
                                                    </a>
                                                </h3>
                                                <p class="card-text">${post.excerpt}</p>
                                            </div>
                                            <div class="card-footer bg-transparent">
                                                <div class="d-flex align-items-center">
                                                    <img src="${post.author.avatar}" class="rounded-circle me-2"
                                                        width="24" height="24" alt="${post.author.name}">
                                                    <small class="text-muted">${post.author.name}</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- Pagination -->
                            <c:if test="${totalPages > 1}">
                                <nav aria-label="Blog pagination" class="mt-4">
                                    <ul class="pagination justify-content-center">
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <a class="page-link" href="?page=${currentPage - 1}" tabindex="-1">
                                                <i class="fas fa-chevron-left"></i>
                                            </a>
                                        </li>
                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link" href="?page=${i}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                            <a class="page-link" href="?page=${currentPage + 1}">
                                                <i class="fas fa-chevron-right"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </c:if>
                        </div>

                        <!-- Sidebar -->
                        <div class="col-lg-4">
                            <!-- Search -->
                            <div class="card mb-4">
                                <div class="card-body">
                                    <form action="blog" method="GET">
                                        <div class="input-group">
                                            <input type="text" class="form-control" name="keyword"
                                                placeholder="Tìm kiếm bài viết..." value="${param.keyword}">
                                            <button class="btn btn-primary" type="submit">
                                                <i class="fas fa-search"></i>
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <!-- Categories -->
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Danh mục</h5>
                                </div>
                                <div class="list-group list-group-flush">
                                    <c:forEach items="${categories}" var="category">
                                        <a href="?category=${category.id}"
                                            class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                            ${category.name}
                                            <span class="badge bg-primary rounded-pill">${category.postCount}</span>
                                        </a>
                                    </c:forEach>
                                </div>
                            </div>

                            <!-- Popular Posts -->
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Bài viết nổi bật</h5>
                                </div>
                                <div class="list-group list-group-flush">
                                    <c:forEach items="${popularPosts}" var="post">
                                        <a href="post_detail.jsp?id=${post.id}"
                                            class="list-group-item list-group-item-action">
                                            <div class="d-flex w-100 justify-content-between">
                                                <h6 class="mb-1">${post.title}</h6>
                                                <small class="text-muted">
                                                    <fmt:formatDate value="${post.publishedAt}" pattern="dd/MM" />
                                                </small>
                                            </div>
                                            <small class="text-muted">${post.category}</small>
                                        </a>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Scripts -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script src="assets/js/main.js"></script>
            </body>

            </html>