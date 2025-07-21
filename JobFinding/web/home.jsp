<%-- Document : home Created on : May 18, 2025, 10:21:22 PM Author : SHD --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <!doctype html>
                <html class="no-js" lang="zxx">

                <head>
                    <meta charset="utf-8">
                    <meta http-equiv="x-ua-compatible" content="ie=edge">
                    <title>Home </title>
                    <meta name="description" content="">
                    <meta name="viewport" content="width=device-width, initial-scale=1">
                    <link rel="manifest" href="site.webmanifest">
                    <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">

        <!-- CSS here -->
        <link href="assets/css/Posts.css" rel="stylesheet" />
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap"
              rel="stylesheet">

                    <!-- Bootstrap 5 CSS -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
                        rel="stylesheet">



        <!-- Original CSS files with updated paths -->
        <link rel="stylesheet" href="assets/css/styleHome.css">
        <link rel="stylesheet" href="assets/css/owl.carousel.min.css">
        <link rel="stylesheet" href="assets/css/flaticon.css">
        <link rel="stylesheet" href="assets/css/price_rangs.css">
        <link rel="stylesheet" href="assets/css/slicknav.css">
        <link rel="stylesheet" href="assets/css/animate.min.css">
        <link rel="stylesheet" href="assets/css/magnific-popup.css">
        <link rel="stylesheet" href="assets/css/fontawesome-all.min.css">
        <link rel="stylesheet" href="assets/css/themify-icons.css">
        <link rel="stylesheet" href="assets/css/slick.css">
        <link rel="stylesheet" href="assets/css/nice-select.css">
        <link rel="stylesheet" href="assets/css/style.css">
        



                </head>

                <body>
                    <!-- Preloader Start -->
                    <div id="preloader-active">
                        <div class="preloader d-flex align-items-center justify-content-center">
                            <div class="preloader-inner position-relative">
                                <div class="preloader-circle"></div>
                                <div class="preloader-img pere-text">
                                    <img src="assets/img/logo/logo.png" alt="">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- slider Area End-->
            <br/>
            <br/>
            
            <!-- Premium Job -->
            
            <div class="container mt-4">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="section-tittle text-center">
                            <span>Premium Job</span>
                            <h2>Hotest Job</h2>
                        </div>
                    </div>
                </div>
                
                <!-- Job List Container -->
                <div class="row" id="jobList">
                    <c:forEach items="${posts}" var="post" varStatus="status">
                        <div class="col-xl-4 col-lg-4 col-md-6 job-item" data-index="${status.index}">
                            <div class="card job-card">
                                <div class="job-card-header-overlay d-flex justify-content-between align-items-center">
                                    <div class="job-badges-left d-flex gap-2">
                                        <c:if test="${post.postType == 'hot'}">
                                            <span class="job-badge badge-new">Tin mới</span>
                                        </c:if>
                                        <c:if test="${post.postType == 'pro'}">
                                            <span class="job-badge badge-featured">Nổi bật</span>
                                        </c:if>
                                    </div>
                                </div>

                                <div class="card-body">
                                    <div class="d-flex align-items-center mb-3">
                                        <img src="${post.companyLogo != null ? post.companyLogo : 'assets/img/icon/job-list1.png'}"
                                             alt="${post.companyName}" class="company-logo me-3">
                                        <div class="job-details">
                                            <h5 class="card-title mb-1">
                                                <a href="${pageContext.request.contextPath}/post/view?id=${post.id}"
                                                   class="text-decoration-none text-dark job-title-truncate">
                                                    ${post.title}
                                                </a>
                                            </h5>
                                            <p class="text-muted mb-1 company-name-truncate">${post.companyName}</p>
                                        </div>
                                    </div>

                                    <!-- Salary and Location Tags -->
                                    <div class="d-flex flex-wrap gap-2">
                                        <span class="job-info-tag salary-tag">${post.salary}</span>
                                        <span class="job-info-tag location-tag">${post.location}</span>

                                        <form action="${pageContext.request.contextPath}/saved-jobs" method="post"
                                              style="display:inline;">
                                            <input type="hidden" name="postId" value="${post.id}" />
                                            <input type="hidden" name="action" value="save" />
                                            <button type="submit" class="btn btn-outline-primary save-job ms-auto">
                                                <i class="far fa-heart"></i> Lưu tin
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Khu Phân trang Frontend -->
                <nav aria-label="Page navigation" class="mt-4" id="paginationNav">
                    <div class="simple-pagination d-flex justify-content-center align-items-center gap-3">
                        <!-- Nút trang trước -->
                        <a href="#" class="pagination-arrow" id="prevBtn" onclick="previousPage()">
                            <i class="fas fa-chevron-left"></i>
                        </a>

                        <span class="pagination-info">
                            <span class="current-page" id="currentPage">1</span> / <span class="total-pages" id="totalPages">1</span> trang
                        </span>

                        <!-- Nút trang sau -->
                        <a href="#" class="pagination-arrow" id="nextBtn" onclick="nextPage()">
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </div>
                </nav>
            </div>
            <!-- Premium Job end -->
            
            <!-- Our Services Start -->
            <div class="our-services section-pad-t30">
                <div class="container">
                    <!-- Section Tittle -->
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="section-tittle text-center">
                                <span>FEATURED TOURS Packages</span>
                                <h2>Browse Top Categories </h2>
                            </div>
                        </div>
                    </div>
                    <div class="row d-flex justify-contnet-center">
                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-6">
                            <div class="single-services text-center mb-30">
                                <div class="services-ion">
                                    <span class="flaticon-tour"></span>
                                </div>
                                <div class="services-cap">
                                    <h5><a href="job_listing.html">Design & Creative</a></h5>
                                    <span>(653)</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-6">
                            <div class="single-services text-center mb-30">
                                <div class="services-ion">
                                    <span class="flaticon-cms"></span>
                                </div>
                                <div class="services-cap">
                                    <h5><a href="job_listing.html">Design & Development</a></h5>
                                    <span>(658)</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-6">
                            <div class="single-services text-center mb-30">
                                <div class="services-ion">
                                    <span class="flaticon-report"></span>
                                </div>
                                <div class="services-cap">
                                    <h5><a href="job_listing.html">Sales & Marketing</a></h5>
                                    <span>(658)</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-6">
                            <div class="single-services text-center mb-30">
                                <div class="services-ion">
                                    <span class="flaticon-app"></span>
                                </div>
                                <div class="services-cap">
                                    <h5><a href="job_listing.html">Mobile Application</a></h5>
                                    <span>(658)</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-6">
                            <div class="single-services text-center mb-30">
                                <div class="services-ion">
                                    <span class="flaticon-helmet"></span>
                                </div>
                                <div class="services-cap">
                                    <h5><a href="job_listing.html">Construction</a></h5>
                                    <span>(658)</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-6">
                            <div class="single-services text-center mb-30">
                                <div class="services-ion">
                                    <span class="flaticon-high-tech"></span>
                                </div>
                                <div class="services-cap">
                                    <h5><a href="job_listing.html">Information Technology</a></h5>
                                    <span>(658)</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-6">
                            <div class="single-services text-center mb-30">
                                <div class="services-ion">
                                    <span class="flaticon-real-estate"></span>
                                </div>
                                <div class="services-cap">
                                    <h5><a href="job_listing.html">Real Estate</a></h5>
                                    <span>(658)</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-6">
                            <div class="single-services text-center mb-30">
                                <div class="services-ion">
                                    <span class="flaticon-content"></span>
                                </div>
                                <div class="services-cap">
                                    <h5><a href="job_listing.html">Content Writer</a></h5>
                                    <span>(658)</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- More Btn -->
                    <!-- Section Button -->
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="browse-btn2 text-center mt-50">
                                <a href="job_listing.html" class="border-btn2">Browse All Sectors</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Our Services End -->



            <!-- Online CV Area Start -->
            <div class="online-cv cv-bg section-overly pt-90 pb-120"
                 data-background="${banner2}">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-xl-10">
                            <div class="cv-caption text-center">
                                <p class="pera1">FEATURED TOURS Packages</p>
                                <p class="pera2"> Make a Difference with Your Online Resume!</p>
                                <a href="./profile" class="border-btn2 border-btn4">Upload your cv</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Online CV Area End-->



            <!--Khu Bài viết gần đây Start -->
            <div class="recent-posts-area section-pad-t30">
                <div class="container">
                    <!-- Section Tittle -->
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="section-tittle text-center">
                                <span>Recent Jobs</span>
                                <h2>Latest Job Posts</h2>
                            </div>
                        </div>
                    </div>

                    <!-- Debug info -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <p>Number of posts: ${recentPosts != null ? recentPosts.size() : 0}</p>
                        </div>
                    </div>

                    <div class="row">
                        <c:if test="${empty recentPosts}">
                            <div class="col-12 text-center">
                                <p>No recent posts available.</p>
                            </div>
                        </c:if>
                        <c:forEach items="${recentPosts}" var="post">
                            <div class="col-xl-4 col-lg-4 col-md-6">
                                <div class="job-card">
                                    <div class="job-header">
                                        <img src="${post.companyLogo}" alt="${post.companyName}"
                                             class="company-logo">
                                        <div class="job-info">
                                            <div class="job-title-wrapper">
                                                <h3 class="job-title">
                                                    <a href="post/view?id=${post.id}">${post.title}</a>
                                                </h3>
                                                <div class="job-tag">${post.jobType}</div>
                                            </div>
                                            <div class="company-name">${post.companyName}</div>
                                        </div>
                                    </div>
                                    <div class="job-meta">
                                        <div class="job-meta-item">
                                            <i class="fas fa-money-bill-wave"></i>
                                            <span class="salary">${post.salary}</span>
                                        </div>
                                        <div class="job-meta-item">
                                            <i class="fas fa-map-marker-alt"></i>
                                            <span class="location">${post.location}</span>
                                        </div>
                                        <div class="job-meta-item">
                                            <i class="fas fa-clock"></i>
                                            <span class="deadline">Deadline:
                                                <fmt:formatDate value="${post.deadline}"
                                                                pattern="dd/MM/yyyy" />
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Khu phân trang -->
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="pagination-area pb-115 text-center">
                                <c:if test="${totalPages > 1}">
                                    <nav aria-label="Page navigation" class="mt-4">
                                        <ul class="pagination justify-content-center">
                                            <!-- Trang đầu tiên -->
                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                <a class="page-link"
                                                   href="home?page=1${keyword != null ? '&keyword=' : ''}${keyword != null ? keyword : ''}${jobType != null ? '&jobType=' : ''}${jobType != null ? jobType : ''}${location != null ? '&location=' : ''}${location != null ? location : ''}"
                                                   aria-label="Trang đầu" title="Trang đầu">
                                                    <i class="fas fa-angle-double-left"></i>
                                                </a>
                                            </li>
                                            <!-- Nút trang trước -->
                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                <a class="page-link"
                                                   href="home?page=${currentPage - 1}${keyword != null ? '&keyword=' : ''}${keyword != null ? keyword : ''}${jobType != null ? '&jobType=' : ''}${jobType != null ? jobType : ''}${location != null ? '&location=' : ''}${location != null ? location : ''}"
                                                   aria-label="Trang trước" title="Trang trước">
                                                    <i class="fas fa-angle-left"></i>
                                                </a>
                                            </li>
                                            <!-- Số trang với dấu ... -->
                                            <c:set var="startPage" value="${currentPage - 2}" />
                                            <c:set var="endPage" value="${currentPage + 2}" />
                                            <c:if test="${startPage < 1}">
                                                <c:set var="startPage" value="1" />
                                            </c:if>
                                            <c:if test="${endPage > totalPages}">
                                                <c:set var="endPage" value="${totalPages}" />
                                            </c:if>
                                            <c:if test="${startPage > 1}">
                                                <li class="page-item">
                                                    <a class="page-link"
                                                       href="home?page=1${keyword != null ? '&keyword=' : ''}${keyword != null ? keyword : ''}${jobType != null ? '&jobType=' : ''}${jobType != null ? jobType : ''}${location != null ? '&location=' : ''}${location != null ? location : ''}">1</a>
                                                </li>
                                                <c:if test="${startPage > 2}">
                                                    <li class="page-item disabled">
                                                        <span class="page-link">...</span>
                                                    </li>
                                                </c:if>
                                            </c:if>
                                            <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                                <li
                                                    class="page-item ${currentPage == i ? 'active' : ''}">
                                                    <a class="page-link"
                                                       href="home?page=${i}${keyword != null ? '&keyword=' : ''}${keyword != null ? keyword : ''}${jobType != null ? '&jobType=' : ''}${jobType != null ? jobType : ''}${location != null ? '&location=' : ''}${location != null ? location : ''}">${i}</a>
                                                </li>
                                            </c:forEach>
                                            <c:if test="${endPage < totalPages}">
                                                <c:if test="${endPage < totalPages - 1}">
                                                    <li class="page-item disabled">
                                                        <span class="page-link">...</span>
                                                    </li>
                                                </c:if>
                                                <li class="page-item">
                                                    <a class="page-link"
                                                       href="home?page=${totalPages}${keyword != null ? '&keyword=' : ''}${keyword != null ? keyword : ''}${jobType != null ? '&jobType=' : ''}${jobType != null ? jobType : ''}${location != null ? '&location=' : ''}${location != null ? location : ''}">${totalPages}</a>
                                                </li>
                                            </c:if>
                                            <!-- Nút trang sau -->
                                            <li
                                                class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                <a class="page-link"
                                                   href="home?page=${currentPage + 1}${keyword != null ? '&keyword=' : ''}${keyword != null ? keyword : ''}${jobType != null ? '&jobType=' : ''}${jobType != null ? jobType : ''}${location != null ? '&location=' : ''}${location != null ? location : ''}"
                                                   aria-label="Trang sau" title="Trang sau">
                                                    <i class="fas fa-angle-right"></i>
                                                </a>
                                            </li>
                                            <!-- Trang cuối cùng -->
                                            <li
                                                class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                <a class="page-link"
                                                   href="home?page=${totalPages}${keyword != null ? '&keyword=' : ''}${keyword != null ? keyword : ''}${jobType != null ? '&jobType=' : ''}${jobType != null ? jobType : ''}${location != null ? '&location=' : ''}${location != null ? location : ''}"
                                                   aria-label="Trang cuối" title="Trang cuối">
                                                    <i class="fas fa-angle-double-right"></i>
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>
                                </c:if>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <!-- Khu Bài viết gần đây End -->





            <!-- How  Apply Process Start-->
            <div class="apply-process-area apply-bg pt-150 pb-150"
                 data-background="assets/img/gallery/how-applybg.png">
                <div class="container">
                    <!-- Section Tittle -->
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="section-tittle white-text text-center">
                                <span>Apply process</span>
                                <h2> How it works</h2>
                            </div>
                        </div>
                    </div>
                    <!-- Apply Process Caption -->
                    <div class="row">
                        <div class="col-lg-4 col-md-6">
                            <div class="single-process text-center mb-30">
                                <div class="process-ion">
                                    <span class="flaticon-search"></span>
                                </div>
                                <div class="process-cap">
                                    <h5>1. Search a job</h5>
                                    <p>Sorem spsum dolor sit amsectetur adipisclit, seddo eiusmod tempor
                                        incididunt ut laborea.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="single-process text-center mb-30">
                                <div class="process-ion">
                                    <span class="flaticon-curriculum-vitae"></span>
                                </div>
                                <div class="process-cap">
                                    <h5>2. Apply for job</h5>
                                    <p>Sorem spsum dolor sit amsectetur adipisclit, seddo eiusmod tempor
                                        incididunt ut laborea.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="single-process text-center mb-30">
                                <div class="process-ion">
                                    <span class="flaticon-tour"></span>
                                </div>
                                <div class="process-cap">
                                    <h5>3. Get your job</h5>
                                    <p>Sorem spsum dolor sit amsectetur adipisclit, seddo eiusmod tempor
                                        incididunt ut laborea.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- How  Apply Process End-->
            <!-- Testimonial Start -->
            <div class="testimonial-area testimonial-padding">
                <div class="container">
                    <!-- Testimonial contents -->
                    <div class="row d-flex justify-content-center">
                        <div class="col-xl-8 col-lg-8 col-md-10">
                            <div class="h1-testimonial-active dot-style">
                                <!-- Single Testimonial -->
                                <div class="single-testimonial text-center">
                                    <!-- Testimonial Content -->
                                    <div class="testimonial-caption ">
                                        <!-- founder -->
                                        <div class="testimonial-founder  ">
                                            <div class="founder-img mb-30">
                                                <img src="assets/img/testmonial/testimonial-founder.png"
                                                     alt="">
                                                <span>Margaret Lawson</span>
                                                <p>Creative Director</p>
                                            </div>
                                        </div>
                                        <div class="testimonial-top-cap">
                                            <p>"I am at an age where I just want to be fit and healthy
                                                our
                                                bodies are our responsibility! So start caring for your
                                                body and
                                                it will care for you. Eat clean it will care for you and
                                                workout
                                                hard."</p>
                                        </div>
                                    </div>
                                </div>
                                <!-- Single Testimonial -->
                                <div class="single-testimonial text-center">
                                    <!-- Testimonial Content -->
                                    <div class="testimonial-caption ">
                                        <!-- founder -->
                                        <div class="testimonial-founder  ">
                                            <div class="founder-img mb-30">
                                                <img src="assets/img/testmonial/testimonial-founder.png"
                                                     alt="">
                                                <span>Margaret Lawson</span>
                                                <p>Creative Director</p>
                                            </div>
                                        </div>
                                        <div class="testimonial-top-cap">
                                            <p>"I am at an age where I just want to be fit and healthy
                                                our
                                                bodies are our responsibility! So start caring for your
                                                body and
                                                it will care for you. Eat clean it will care for you and
                                                workout
                                                hard."</p>
                                        </div>
                                    </div>
                                </div>
                                <!-- Single Testimonial -->
                                <div class="single-testimonial text-center">
                                    <!-- Testimonial Content -->
                                    <div class="testimonial-caption ">
                                        <!-- founder -->
                                        <div class="testimonial-founder  ">
                                            <div class="founder-img mb-30">
                                                <img src="assets/img/testmonial/testimonial-founder.png"
                                                     alt="">
                                                <span>Margaret Lawson</span>
                                                <p>Creative Director</p>
                                            </div>
                                        </div>
                                        <div class="testimonial-top-cap">
                                            <p>"I am at an age where I just want to be fit and healthy
                                                our
                                                bodies are our responsibility! So start caring for your
                                                body and
                                                it will care for you. Eat clean it will care for you and
                                                workout
                                                hard."</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Testimonial End -->
            <!-- Support Company Start-->
<!--            <div class="support-company-area support-padding fix">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-xl-6 col-lg-6">
                            <div class="right-caption">
                                 Section Tittle 
                                <div class="section-tittle section-tittle2">
                                    <span>What we are doing</span>
                                    <h2>24k Talented people are getting Jobs</h2>
                                </div>
                                <div class="support-caption">
                                    <p class="pera-top">Mollit anim laborum duis au dolor in voluptate
                                        velit ess
                                        cillum dolore eu lore dsu quality mollit anim laborumuis au
                                        dolor in
                                        voluptate velit cillum.</p>
                                    <p>Mollit anim laborum.Duis aute irufg dhjkolohr in re voluptate
                                        velit
                                        esscillumlore eu quife nrulla parihatur. Excghcepteur signjnt
                                        occa
                                        cupidatat non inulpadeserunt mollit aboru. temnthp incididbnt ut
                                        labore
                                        mollit anim laborum suis aute.</p>
                                    <a href="job_listing.jsp" class="btn post-btn">Post a job</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-6 col-lg-6">
                            <div class="support-location-img">
                                <img src="assets/img/service/support-img.jpg" alt="">
                                <div class="support-img-cap text-center">
                                    <p>Since</p>
                                    <span>1994</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>-->
            <!-- Support Company End-->
            <!-- Blog Area Start -->
            <div class="home-blog-area blog-h-padding">
                <div class="container">
                    <!-- Section Tittle -->
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="section-tittle text-center">
                                <span>Our latest blog</span>
                                <h2>Our recent news</h2>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <c:forEach items="${blogList}" var="blog">
                            <div class="col-xl-6 col-lg-6 col-md-6">
                                <div class="home-blog-single mb-30">
                                    <div class="blog-img-cap">
                                        <div class="blog-img">
                                            <img src="/JobFinding/${blog.thumbnail}" alt="${blog.title}">
                                            <!-- Blog date -->
                                            <div class="blog-date text-center">
                                                <span><fmt:formatDate value="${blog.created_at}" pattern="dd"/></span>
                                                <p><fmt:formatDate value="${blog.created_at}" pattern="MMM"/></p>
                                            </div>
                                        </div>
                                        <div class="blog-cap">
                                            <p>| Blog</p>
                                            <h3><a href="#">${blog.title}</a></h3>
                                            <a href="#" class="more-btn">Read more »</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${empty blogList}">
                            <div class="col-12 text-center">
                                <p>No blog posts available.</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
            <!-- Blog Area End -->

        </main>
                        
                        
        <footer>
            <!-- Footer Start-->
            <div class="footer-area footer-bg footer-padding">
                <div class="container">
                    <div class="row d-flex justify-content-between">
                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-6">
                            <div class="single-footer-caption mb-50">
                                <div class="single-footer-caption mb-30">
                                    <div class="footer-tittle">
                                        <h4>About Us</h4>
                                        <div class="footer-pera">
                                            <p>Heaven frucvitful doesn't cover lesser dvsays appear
                                                creeping
                                                seasons so behold.</p>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-5">
                            <div class="single-footer-caption mb-50">
                                <div class="footer-tittle">
                                    <h4>Contact Info</h4>
                                    <ul>
                                        <li>
                                            <p>Address :Your address goes
                                                here, your demo address.</p>
                                        </li>
                                        <li><a href="#">Phone : +8880 44338899</a></li>
                                        <li><a href="#">Email : info@colorlib.com</a></li>
                                    </ul>
                                </div>

                            </div>
                        </div>
                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-5">
                            <div class="single-footer-caption mb-50">
                                <div class="footer-tittle">
                                    <h4>Important Link</h4>
                                    <ul>
                                        <li><a href="#"> View Project</a></li>
                                        <li><a href="#">Contact Us</a></li>
                                        <li><a href="#">Testimonial</a></li>
                                        <li><a href="#">Proparties</a></li>
                                        <li><a href="#">Support</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-5">
                            <div class="single-footer-caption mb-50">
                                <div class="footer-tittle">
                                    <h4>Newsletter</h4>
                                    <div class="footer-pera footer-pera2">
                                        <p>Heaven fruitful doesn't over lesser in days. Appear creeping.
                                        </p>
                                    </div>
                                    <!-- Form -->
<!--                                    <div class="footer-form">
                                        <div id="mc_embed_signup">
                                            <form target="_blank"
                                                  action="https://spondonit.us12.list-manage.com/subscribe/post?u=1462626880ade1ac87bd9c93a&amp;id=92a4423d01"
                                                  method="get" class="subscribe_form relative mail_part">
                                                <input type="email" name="email"
                                                       id="newsletter-form-email"
                                                       placeholder="Email Address"
                                                       class="placeholder hide-on-focus"
                                                       onfocus="this.placeholder = ''"
                                                       onblur="this.placeholder = ' Email Address '">
                                                <div class="form-icon">
                                                    <button type="submit" name="submit"
                                                            id="newsletter-submit"
                                                            class="email_icon newsletter-submit button-contactForm"><img
                                                            src="assets/img/icon/form.png"
                                                            alt=""></button>
                                                </div>
                                            </div>
                                            <!-- Search Box -->
                                            <div class="row">
                                                <div class="col-xl-8">
                                                    <!-- form -->
                                                    <form action="home" class="search-box">
                                                        <div class="input-form">
                                                            <input type="text" name="keyword"
                                                                placeholder="Job Tittle or keyword"
                                                                value="${keyword != null ? keyword : ''}">
                                                        </div>
                                                        <div class="select-form">
                                                            <div class="select-itms">
                                                                <select name="location" id="select1">
                                                                    <option value="">Location BD</option>
                                                                    <option value="Hà Nội" ${location=='Hà Nội'
                                                                        ? 'selected' : '' }>Hà Nội</option>
                                                                    <option value="Hồ Chí Minh"
                                                                        ${location=='Hồ Chí Minh' ? 'selected' : '' }>Hồ
                                                                        Chí Minh</option>
                                                                    <option value="Đà Nẵng" ${location=='Đà Nẵng'
                                                                        ? 'selected' : '' }>Đà Nẵng</option>
                                                                    <option value="" ${location=='' ? 'selected' : '' }>
                                                                        Any Location</option>
                                                                </select>
                                                            </div>
                                                            <div class="select-itms">
                                                                <select name="jobType" id="select2">
                                                                    <option value="">Job Type</option>
                                                                    <option value="Full-time" ${jobType=='Full-time'
                                                                        ? 'selected' : '' }>Full-time</option>
                                                                    <option value="Part-time" ${jobType=='Part-time'
                                                                        ? 'selected' : '' }>Part-time</option>
                                                                    <option value="Remote" ${jobType=='Remote'
                                                                        ? 'selected' : '' }>Remote</option>
                                                                    <option value="Internship" ${jobType=='Internship'
                                                                        ? 'selected' : '' }>Internship</option>
                                                                    <option value="Contract" ${jobType=='Contract'
                                                                        ? 'selected' : '' }>Contract</option>
                                                                    <option value="" ${jobType=='' ? 'selected' : '' }>
                                                                        Any Type</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="search-form">
                                                            <button type="submit">Find job</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--  -->
<!--                    <div class="row footer-wejed justify-content-between">
                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-6">
                             logo 
                            <div class="footer-logo mb-20">
                                <a href="index.html"><img src="assets/img/logo/logo2_footer.png"
                                                          alt=""></a>
                            </div>
                        </div>
                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-5">
                            <div class="footer-tittle-bottom">
                                <span>5000+</span>
                                <p>Talented Hunter</p>
                            </div>
                        </div>
                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-5">
                            <div class="footer-tittle-bottom">
                                <span>451</span>
                                <p>Talented Hunter</p>
                            </div>
                        </div>
                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-5">
                             Footer Bottom Tittle 
                            <div class="footer-tittle-bottom">
                                <span>568</span>
                                <p>Talented Hunter</p>
                            </div>
                        </div>
                    </div>-->


                </div>
            </div>
            <!-- footer-bottom area -->
            <div class="footer-bottom-area footer-bg">
                <div class="container">
                    <div class="footer-border">
                        <div class="row d-flex justify-content-between align-items-center">
                            <div class="col-xl-10 col-lg-10 ">
                                <div class="footer-copy-right">
                                    <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                                        Copyright &copy;
                                        <script>document.write(new Date().getFullYear());</script> All
                                        rights
                                        reserved | This template is made with <i class="fa fa-heart"
                                                                                 aria-hidden="true"></i> by <a href="https://colorlib.com"
                                                                                 target="_blank">Colorlib</a>
                                        <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                                    </p>
                                </div>
                            </div>
                            <!-- Our Services End -->



                            <!-- Online CV Area Start -->
                            <div class="online-cv cv-bg section-overly pt-90 pb-120"
                                data-background="assets/img/gallery/cv_bg.jpg">
                                <div class="container">
                                    <div class="row justify-content-center">
                                        <div class="col-xl-10">
                                            <div class="cv-caption text-center">
                                                <p class="pera1">FEATURED TOURS Packages</p>
                                                <p class="pera2"> Make a Difference with Your Online Resume!</p>
                                                <a href="#" class="border-btn2 border-btn4">Upload your cv</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Online CV Area End-->



                            <!--Khu Bài viết gần đây Start -->
                            <div class="recent-posts-area section-pad-t30">
                                <div class="container">
                                    <!-- Section Tittle -->
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="section-tittle text-center">
                                                <span>Recent Jobs</span>
                                                <h2>Latest Job Posts</h2>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Debug info -->
                                    <div class="row mb-4">
                                        <div class="col-12">
                                            <p>Number of posts: ${recentPosts != null ? recentPosts.size() : 0}</p>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <c:if test="${empty recentPosts}">
                                            <div class="col-12 text-center">
                                                <div class="empty-state">
                                                    <i class="fas fa-search"></i>
                                                    <h4 class="mt-3">Không có tin tuyển dụng nào</h4>
                                                    <p class="text-muted">Hãy quay lại sau hoặc thử tìm kiếm với từ khóa
                                                        khác</p>
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:forEach items="${recentPosts}" var="post">
                                            <div class="col-xl-4 col-lg-4 col-md-6">
                                                <div class="card job-card">
                                                    <!-- Job Card Header with Badges -->
                                                    <div
                                                        class="job-card-header-overlay d-flex justify-content-between align-items-center">
                                                        <div class="job-badges-left d-flex gap-2">
                                                            <c:if test="${post.postType == 'hot'}">
                                                                <span class="job-badge badge-new">Tin mới</span>
                                                            </c:if>
                                                            <c:if test="${post.postType == 'pro'}">
                                                                <span class="job-badge badge-featured">Nổi bật</span>
                                                            </c:if>
                                                        </div>
                                                    </div>

                                                    <div class="card-body">
                                                        <div class="d-flex align-items-center mb-3">
                                                            <img src="${post.companyLogo != null ? post.companyLogo : 'assets/img/icon/job-list1.png'}"
                                                                alt="${post.companyName}" class="company-logo me-3">
                                                            <div class="job-details">
                                                                <h5 class="card-title mb-1">
                                                                    <a href="${pageContext.request.contextPath}/post/view?id=${post.id}"
                                                                        class="text-decoration-none text-dark job-title-truncate">
                                                                        ${post.title}
                                                                    </a>
                                                                </h5>
                                                                <p class="text-muted mb-1 company-name-truncate">
                                                                    ${post.companyName}</p>
                                                            </div>
                                                        </div>

                                                        <!-- Salary and Location Tags -->
                                                        <div class="d-flex flex-wrap gap-2">
                                                            <span class="job-info-tag salary-tag">${post.salary}</span>
                                                            <span
                                                                class="job-info-tag location-tag">${post.location}</span>

                                                            <!-- Save Job Button -->
                                                            <c:if test="${sessionScope.userType == 'jobseeker'}">
                                                                <form
                                                                    action="${pageContext.request.contextPath}/saved-jobs"
                                                                    method="post" style="display:inline;">
                                                                    <input type="hidden" name="postId"
                                                                        value="${post.id}" />
                                                                    <input type="hidden" name="action" value="save" />
                                                                    <button type="submit"
                                                                        class="btn btn-outline-primary save-job ms-auto">
                                                                        <i class="far fa-heart"></i> Lưu tin
                                                                    </button>
                                                                </form>
                                                            </c:if>
                                                        </div>

                                                        <!-- Additional Job Info -->
                                                        <div class="job-meta mt-3">
                                                            <div class="job-meta-item">
                                                                <i class="fas fa-clock"></i>
                                                                <span class="deadline">Deadline:
                                                                    <fmt:formatDate value="${post.deadline}"
                                                                        pattern="dd/MM/yyyy" />
                                                                </span>
                                                            </div>
                                                            <div class="job-meta-item">
                                                                <i class="fas fa-briefcase"></i>
                                                                <span class="job-type">${post.jobType}</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>

                                    <!-- Khu phân trang -->
                                    <c:if test="${totalPages > 1}">
                                        <nav aria-label="Page navigation" class="mt-4">
                                            <div
                                                class="simple-pagination d-flex justify-content-center align-items-center gap-3">
                                                <!-- Nút trang trước -->
                                                <a href="${currentPage == 1 ? '#' : pageContext.request.contextPath}/home?page=${currentPage - 1}&keyword=${param.keyword}&jobType=${param.jobType}&location=${param.location}"
                                                    class="pagination-arrow ${currentPage == 1 ? 'disabled' : ''}">
                                                    <i class="fas fa-chevron-left"></i>
                                                </a>

                                                <span class="pagination-info">
                                                    <span class="current-page">${currentPage}</span> / <span
                                                        class="total-pages">${totalPages}</span> trang
                                                </span>

                                                <!-- Nút trang sau -->
                                                <a href="${currentPage == totalPages ? '#' : pageContext.request.contextPath}/home?page=${currentPage + 1}&keyword=${param.keyword}&jobType=${param.jobType}&location=${param.location}"
                                                    class="pagination-arrow ${currentPage == totalPages ? 'disabled' : ''}">
                                                    <i class="fas fa-chevron-right"></i>
                                                </a>
                                            </div>
                                        </nav>
                                    </c:if>

                                </div>
                            </div>
                            <!-- Khu Bài viết gần đây End -->

                            <!-- Tìm việc làm liên quan - TopCV Style -->
                            <div class="related-jobs-section section-pad-t30 bg-light">
                                <div class="container">
                                    <!-- Section Title -->
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="section-tittle text-center">
                                                <span>Smart Job Search</span>
                                                <h2>Tìm việc làm phù hợp với bạn</h2>
                                                <p class="text-muted">Khám phá cơ hội việc làm được gợi ý dựa trên sở
                                                    thích và kinh nghiệm của bạn</p>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Advanced Search Form -->
                                    <div class="row justify-content-center mb-5">
                                        <div class="col-lg-10">
                                            <div class="advanced-search-form bg-white rounded-lg shadow-sm p-4">
                                                <form action="search-job" method="GET" id="advancedSearchForm">
                                                    <div class="row g-3">
                                                        <!-- Keyword Search -->
                                                        <div class="col-md-6">
                                                            <label for="keyword" class="form-label fw-bold">
                                                                <i class="fas fa-search text-primary me-2"></i>Từ khóa
                                                                tìm kiếm
                                                            </label>
                                                            <input type="text" class="form-control form-control-lg"
                                                                id="keyword" name="keyword"
                                                                placeholder="Vị trí, công ty, kỹ năng..."
                                                                value="${param.keyword}">
                                                        </div>

                                                        <!-- Location -->
                                                        <div class="col-md-6">
                                                            <label for="location" class="form-label fw-bold">
                                                                <i
                                                                    class="fas fa-map-marker-alt text-primary me-2"></i>Địa
                                                                điểm
                                                            </label>
                                                            <select class="form-select form-select-lg" id="location"
                                                                name="location">
                                                                <option value="">Tất cả địa điểm</option>
                                                                <option value="Hà Nội" ${param.location=='Hà Nội'
                                                                    ? 'selected' : '' }>Hà Nội</option>
                                                                <option value="TP. Hồ Chí Minh"
                                                                    ${param.location=='TP. Hồ Chí Minh' ? 'selected'
                                                                    : '' }>TP. Hồ Chí Minh</option>
                                                                <option value="Đà Nẵng" ${param.location=='Đà Nẵng'
                                                                    ? 'selected' : '' }>Đà Nẵng</option>
                                                                <option value="Hải Phòng" ${param.location=='Hải Phòng'
                                                                    ? 'selected' : '' }>Hải Phòng</option>
                                                                <option value="Cần Thơ" ${param.location=='Cần Thơ'
                                                                    ? 'selected' : '' }>Cần Thơ</option>
                                                                <option value="Remote" ${param.location=='Remote'
                                                                    ? 'selected' : '' }>Làm việc từ xa</option>
                                                            </select>
                                                        </div>

                                                        <!-- Job Type -->
                                                        <div class="col-md-4">
                                                            <label for="jobType" class="form-label fw-bold">
                                                                <i class="fas fa-briefcase text-primary me-2"></i>Loại
                                                                công việc
                                                            </label>
                                                            <select class="form-select" id="jobType" name="jobType">
                                                                <option value="">Tất cả loại</option>
                                                                <option value="full_time" ${param.jobType=='full_time'
                                                                    ? 'selected' : '' }>Toàn thời gian</option>
                                                                <option value="part_time" ${param.jobType=='part_time'
                                                                    ? 'selected' : '' }>Bán thời gian</option>
                                                                <option value="contract" ${param.jobType=='contract'
                                                                    ? 'selected' : '' }>Hợp đồng</option>
                                                                <option value="internship" ${param.jobType=='internship'
                                                                    ? 'selected' : '' }>Thực tập</option>
                                                                <option value="freelance" ${param.jobType=='freelance'
                                                                    ? 'selected' : '' }>Freelance</option>
                                                            </select>
                                                        </div>

                                                        <!-- Industry -->
                                                        <div class="col-md-4">
                                                            <label for="industry" class="form-label fw-bold">
                                                                <i class="fas fa-industry text-primary me-2"></i>Ngành
                                                                nghề
                                                            </label>
                                                            <select class="form-select" id="industry" name="industry">
                                                                <option value="">Tất cả ngành</option>
                                                                <option value="IT" ${param.industry=='IT' ? 'selected'
                                                                    : '' }>Công nghệ thông tin</option>
                                                                <option value="Marketing" ${param.industry=='Marketing'
                                                                    ? 'selected' : '' }>Marketing</option>
                                                                <option value="Finance" ${param.industry=='Finance'
                                                                    ? 'selected' : '' }>Tài chính</option>
                                                                <option value="Education" ${param.industry=='Education'
                                                                    ? 'selected' : '' }>Giáo dục</option>
                                                                <option value="Healthcare"
                                                                    ${param.industry=='Healthcare' ? 'selected' : '' }>Y
                                                                    tế</option>
                                                                <option value="Manufacturing"
                                                                    ${param.industry=='Manufacturing' ? 'selected' : ''
                                                                    }>Sản xuất</option>
                                                                <option value="Retail" ${param.industry=='Retail'
                                                                    ? 'selected' : '' }>Bán lẻ</option>
                                                            </select>
                                                        </div>

                                                        <!-- Experience -->
                                                        <div class="col-md-4">
                                                            <label for="experience" class="form-label fw-bold">
                                                                <i class="fas fa-star text-primary me-2"></i>Kinh nghiệm
                                                            </label>
                                                            <select class="form-select" id="experience"
                                                                name="experience">
                                                                <option value="">Tất cả cấp độ</option>
                                                                <option value="Fresher" ${param.experience=='Fresher'
                                                                    ? 'selected' : '' }>Mới tốt nghiệp</option>
                                                                <option value="1-3 years"
                                                                    ${param.experience=='1-3 years' ? 'selected' : '' }>
                                                                    1-3 năm</option>
                                                                <option value="3-5 years"
                                                                    ${param.experience=='3-5 years' ? 'selected' : '' }>
                                                                    3-5 năm</option>
                                                                <option value="5-10 years"
                                                                    ${param.experience=='5-10 years' ? 'selected' : ''
                                                                    }>5-10 năm</option>
                                                                <option value="10+ years"
                                                                    ${param.experience=='10+ years' ? 'selected' : '' }>
                                                                    Trên 10 năm</option>
                                                            </select>
                                                        </div>

                                                        <!-- Salary Range -->
                                                        <div class="col-md-6">
                                                            <label for="minSalary" class="form-label fw-bold">
                                                                <i
                                                                    class="fas fa-money-bill-wave text-primary me-2"></i>Mức
                                                                lương tối thiểu (triệu VND)
                                                            </label>
                                                            <input type="number" class="form-control" id="minSalary"
                                                                name="minSalary" placeholder="0" min="0" step="0.1"
                                                                value="${param.minSalary}">
                                                        </div>

                                                        <div class="col-md-6">
                                                            <label for="maxSalary" class="form-label fw-bold">
                                                                <i
                                                                    class="fas fa-money-bill-wave text-primary me-2"></i>Mức
                                                                lương tối đa (triệu VND)
                                                            </label>
                                                            <input type="number" class="form-control" id="maxSalary"
                                                                name="maxSalary" placeholder="100" min="0" step="0.1"
                                                                value="${param.maxSalary}">
                                                        </div>

                                                        <!-- Search Button -->
                                                        <div class="col-12 text-center">
                                                            <button type="submit" class="btn btn-primary btn-lg px-5">
                                                                <i class="fas fa-search me-2"></i>Tìm kiếm việc làm
                                                            </button>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Job Statistics -->
                                    <div class="row mb-5">
                                        <div class="col-md-3">
                                            <div class="stat-card text-center bg-white rounded-lg shadow-sm p-4">
                                                <div class="stat-icon mb-3">
                                                    <i class="fas fa-briefcase fa-2x text-primary"></i>
                                                </div>
                                                <div class="stat-number h3 fw-bold text-primary">1,234</div>
                                                <div class="stat-label text-muted">Việc làm mới</div>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="stat-card text-center bg-white rounded-lg shadow-sm p-4">
                                                <div class="stat-icon mb-3">
                                                    <i class="fas fa-building fa-2x text-success"></i>
                                                </div>
                                                <div class="stat-number h3 fw-bold text-success">567</div>
                                                <div class="stat-label text-muted">Công ty tuyển dụng</div>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="stat-card text-center bg-white rounded-lg shadow-sm p-4">
                                                <div class="stat-icon mb-3">
                                                    <i class="fas fa-users fa-2x text-info"></i>
                                                </div>
                                                <div class="stat-number h3 fw-bold text-info">89</div>
                                                <div class="stat-label text-muted">Ngành nghề</div>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="stat-card text-center bg-white rounded-lg shadow-sm p-4">
                                                <div class="stat-icon mb-3">
                                                    <i class="fas fa-map-marker-alt fa-2x text-warning"></i>
                                                </div>
                                                <div class="stat-number h3 fw-bold text-warning">45</div>
                                                <div class="stat-label text-muted">Tỉnh thành</div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Popular Keywords -->
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="popular-keywords bg-white rounded-lg shadow-sm p-4">
                                                <h5 class="fw-bold mb-3">
                                                    <i class="fas fa-fire text-danger me-2"></i>Từ khóa phổ biến
                                                </h5>
                                                <div class="keyword-tags">
                                                    <a href="search-job?keyword=Java Developer" class="keyword-tag">Java
                                                        Developer</a>
                                                    <a href="search-job?keyword=React" class="keyword-tag">React</a>
                                                    <a href="search-job?keyword=Python" class="keyword-tag">Python</a>
                                                    <a href="search-job?keyword=Marketing"
                                                        class="keyword-tag">Marketing</a>
                                                    <a href="search-job?keyword=Sales" class="keyword-tag">Sales</a>
                                                    <a href="search-job?keyword=Designer"
                                                        class="keyword-tag">Designer</a>
                                                    <a href="search-job?keyword=Manager" class="keyword-tag">Manager</a>
                                                    <a href="search-job?keyword=Analyst" class="keyword-tag">Analyst</a>
                                                    <a href="search-job?keyword=Frontend"
                                                        class="keyword-tag">Frontend</a>
                                                    <a href="search-job?keyword=Backend" class="keyword-tag">Backend</a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="popular-locations bg-white rounded-lg shadow-sm p-4">
                                                <h5 class="fw-bold mb-3">
                                                    <i class="fas fa-map-marker-alt text-primary me-2"></i>Địa điểm phổ
                                                    biến
                                                </h5>
                                                <div class="location-tags">
                                                    <a href="search-job?location=Hà Nội" class="location-tag">Hà Nội</a>
                                                    <a href="search-job?location=TP. Hồ Chí Minh"
                                                        class="location-tag">TP. Hồ Chí Minh</a>
                                                    <a href="search-job?location=Đà Nẵng" class="location-tag">Đà
                                                        Nẵng</a>
                                                    <a href="search-job?location=Hải Phòng" class="location-tag">Hải
                                                        Phòng</a>
                                                    <a href="search-job?location=Cần Thơ" class="location-tag">Cần
                                                        Thơ</a>
                                                    <a href="search-job?location=Remote" class="location-tag">Làm việc
                                                        từ xa</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Suggested Jobs Section -->
                                    <c:if test="${sessionScope.role == 'job-seeker'}">
                                        <div class="row mt-5">
                                            <div class="col-12">
                                                <div class="suggested-jobs bg-white rounded-lg shadow-sm p-4">
                                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                                        <h5 class="fw-bold mb-0">
                                                            <i class="fas fa-lightbulb text-warning me-2"></i>Việc làm
                                                            gợi ý cho bạn
                                                        </h5>
                                                        <a href="related-jobs" class="btn btn-outline-primary btn-sm">
                                                            Xem tất cả <i class="fas fa-arrow-right ms-1"></i>
                                                        </a>
                                                    </div>
                                                    <div class="row" id="suggestedJobsContainer">
                                                        <!-- Suggested jobs will be loaded here via AJAX -->
                                                        <div class="col-12 text-center">
                                                            <div class="spinner-border text-primary" role="status">
                                                                <span class="visually-hidden">Loading...</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                            <!-- Tìm việc làm liên quan End -->

                            <!-- How  Apply Process Start-->
                            <div class="apply-process-area apply-bg pt-150 pb-150"
                                data-background="assets/img/gallery/how-applybg.png">
                                <div class="container">
                                    <!-- Section Tittle -->
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="section-tittle white-text text-center">
                                                <span>Apply process</span>
                                                <h2> How it works</h2>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Apply Process Caption -->
                                    <div class="row">
                                        <div class="col-lg-4 col-md-6">
                                            <div class="single-process text-center mb-30">
                                                <div class="process-ion">
                                                    <span class="flaticon-search"></span>
                                                </div>
                                                <div class="process-cap">
                                                    <h5>1. Search a job</h5>
                                                    <p>Sorem spsum dolor sit amsectetur adipisclit, seddo eiusmod tempor
                                                        incididunt ut laborea.</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-6">
                                            <div class="single-process text-center mb-30">
                                                <div class="process-ion">
                                                    <span class="flaticon-curriculum-vitae"></span>
                                                </div>
                                                <div class="process-cap">
                                                    <h5>2. Apply for job</h5>
                                                    <p>Sorem spsum dolor sit amsectetur adipisclit, seddo eiusmod tempor
                                                        incididunt ut laborea.</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-6">
                                            <div class="single-process text-center mb-30">
                                                <div class="process-ion">
                                                    <span class="flaticon-tour"></span>
                                                </div>
                                                <div class="process-cap">
                                                    <h5>3. Get your job</h5>
                                                    <p>Sorem spsum dolor sit amsectetur adipisclit, seddo eiusmod tempor
                                                        incididunt ut laborea.</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- How  Apply Process End-->
                            <!-- Testimonial Start -->
                            <div class="testimonial-area testimonial-padding">
                                <div class="container">
                                    <!-- Testimonial contents -->
                                    <div class="row d-flex justify-content-center">
                                        <div class="col-xl-8 col-lg-8 col-md-10">
                                            <div class="h1-testimonial-active dot-style">
                                                <!-- Single Testimonial -->
                                                <div class="single-testimonial text-center">
                                                    <!-- Testimonial Content -->
                                                    <div class="testimonial-caption ">
                                                        <!-- founder -->
                                                        <div class="testimonial-founder  ">
                                                            <div class="founder-img mb-30">
                                                                <img src="assets/img/testmonial/testimonial-founder.png"
                                                                    alt="">
                                                                <span>Margaret Lawson</span>
                                                                <p>Creative Director</p>
                                                            </div>
                                                        </div>
                                                        <div class="testimonial-top-cap">
                                                            <p>"I am at an age where I just want to be fit and healthy
                                                                our
                                                                bodies are our responsibility! So start caring for your
                                                                body and
                                                                it will care for you. Eat clean it will care for you and
                                                                workout
                                                                hard."</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- Single Testimonial -->
                                                <div class="single-testimonial text-center">
                                                    <!-- Testimonial Content -->
                                                    <div class="testimonial-caption ">
                                                        <!-- founder -->
                                                        <div class="testimonial-founder  ">
                                                            <div class="founder-img mb-30">
                                                                <img src="assets/img/testmonial/testimonial-founder.png"
                                                                    alt="">
                                                                <span>Margaret Lawson</span>
                                                                <p>Creative Director</p>
                                                            </div>
                                                        </div>
                                                        <div class="testimonial-top-cap">
                                                            <p>"I am at an age where I just want to be fit and healthy
                                                                our
                                                                bodies are our responsibility! So start caring for your
                                                                body and
                                                                it will care for you. Eat clean it will care for you and
                                                                workout
                                                                hard."</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- Single Testimonial -->
                                                <div class="single-testimonial text-center">
                                                    <!-- Testimonial Content -->
                                                    <div class="testimonial-caption ">
                                                        <!-- founder -->
                                                        <div class="testimonial-founder  ">
                                                            <div class="founder-img mb-30">
                                                                <img src="assets/img/testmonial/testimonial-founder.png"
                                                                    alt="">
                                                                <span>Margaret Lawson</span>
                                                                <p>Creative Director</p>
                                                            </div>
                                                        </div>
                                                        <div class="testimonial-top-cap">
                                                            <p>"I am at an age where I just want to be fit and healthy
                                                                our
                                                                bodies are our responsibility! So start caring for your
                                                                body and
                                                                it will care for you. Eat clean it will care for you and
                                                                workout
                                                                hard."</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Testimonial End -->
                            <!-- Support Company Start-->
                            <div class="support-company-area support-padding fix">
                                <div class="container">
                                    <div class="row align-items-center">
                                        <div class="col-xl-6 col-lg-6">
                                            <div class="right-caption">
                                                <!-- Section Tittle -->
                                                <div class="section-tittle section-tittle2">
                                                    <span>What we are doing</span>
                                                    <h2>24k Talented people are getting Jobs</h2>
                                                </div>
                                                <div class="support-caption">
                                                    <p class="pera-top">Mollit anim laborum duis au dolor in voluptate
                                                        velit ess
                                                        cillum dolore eu lore dsu quality mollit anim laborumuis au
                                                        dolor in
                                                        voluptate velit cillum.</p>
                                                    <p>Mollit anim laborum.Duis aute irufg dhjkolohr in re voluptate
                                                        velit
                                                        esscillumlore eu quife nrulla parihatur. Excghcepteur signjnt
                                                        occa
                                                        cupidatat non inulpadeserunt mollit aboru. temnthp incididbnt ut
                                                        labore
                                                        mollit anim laborum suis aute.</p>
                                                    <a href="job_listing.jsp" class="btn post-btn">Post a job</a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-6 col-lg-6">
                                            <div class="support-location-img">
                                                <img src="assets/img/service/support-img.jpg" alt="">
                                                <div class="support-img-cap text-center">
                                                    <p>Since</p>
                                                    <span>1994</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Support Company End-->
                            <!-- Blog Area Start -->
                            <div class="home-blog-area blog-h-padding">
                                <div class="container">
                                    <!-- Section Tittle -->
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="section-tittle text-center">
                                                <span>Our latest blog</span>
                                                <h2>Our recent news</h2>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xl-6 col-lg-6 col-md-6">
                                            <div class="home-blog-single mb-30">
                                                <div class="blog-img-cap">
                                                    <div class="blog-img">
                                                        <img src="assets/img/blog/home-blog1.jpg" alt="">
                                                        <!-- Blog date -->
                                                        <div class="blog-date text-center">
                                                            <span>24</span>
                                                            <p>Now</p>
                                                        </div>
                                                    </div>
                                                    <div class="blog-cap">
                                                        <p>| Properties</p>
                                                        <h3><a href="single-blog.html">Footprints in Time is perfect
                                                                House in
                                                                Kurashiki</a></h3>
                                                        <a href="#" class="more-btn">Read more »</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-6 col-lg-6 col-md-6">
                                            <div class="home-blog-single mb-30">
                                                <div class="blog-img-cap">
                                                    <div class="blog-img">
                                                        <img src="assets/img/blog/home-blog2.jpg" alt="">
                                                        <!-- Blog date -->
                                                        <div class="blog-date text-center">
                                                            <span>24</span>
                                                            <p>Now</p>
                                                        </div>
                                                    </div>
                                                    <div class="blog-cap">
                                                        <p>| Properties</p>
                                                        <h3><a href="single-blog.html">Footprints in Time is perfect
                                                                House in
                                                                Kurashiki</a></h3>
                                                        <a href="#" class="more-btn">Read more »</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Blog Area End -->

                        </main>

                        <!-- Toast Notification Container -->
                        <div class="toast-container position-fixed bottom-0 end-0 p-3">
                            <c:if test="${not empty sessionScope.notification}">
                                <div class="toast show" role="alert" aria-live="assertive" aria-atomic="true">
                                    <div class="toast-header">
                                        <i class="fas fa-check-circle text-success me-2"></i>
                                        <strong class="me-auto">Thông báo</strong>
                                        <button type="button" class="btn-close" data-bs-dismiss="toast"
                                            aria-label="Close"></button>
                                    </div>
                                    <div class="toast-body">${sessionScope.notification}</div>
                                </div>
                                <c:remove var="notification" scope="session" />
                            </c:if>
                        </div>

                        <footer>
                            <!-- Footer Start-->
                            <div class="footer-area footer-bg footer-padding">
                                <div class="container">
                                    <div class="row d-flex justify-content-between">
                                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-6">
                                            <div class="single-footer-caption mb-50">
                                                <div class="single-footer-caption mb-30">
                                                    <div class="footer-tittle">
                                                        <h4>About Us</h4>
                                                        <div class="footer-pera">
                                                            <p>Heaven frucvitful doesn't cover lesser dvsays appear
                                                                creeping
                                                                seasons so behold.</p>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-5">
                                            <div class="single-footer-caption mb-50">
                                                <div class="footer-tittle">
                                                    <h4>Contact Info</h4>
                                                    <ul>
                                                        <li>
                                                            <p>Address :Your address goes
                                                                here, your demo address.</p>
                                                        </li>
                                                        <li><a href="#">Phone : +8880 44338899</a></li>
                                                        <li><a href="#">Email : info@colorlib.com</a></li>
                                                    </ul>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-5">
                                            <div class="single-footer-caption mb-50">
                                                <div class="footer-tittle">
                                                    <h4>Important Link</h4>
                                                    <ul>
                                                        <li><a href="#"> View Project</a></li>
                                                        <li><a href="#">Contact Us</a></li>
                                                        <li><a href="#">Testimonial</a></li>
                                                        <li><a href="#">Proparties</a></li>
                                                        <li><a href="#">Support</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-5">
                                            <div class="single-footer-caption mb-50">
                                                <div class="footer-tittle">
                                                    <h4>Newsletter</h4>
                                                    <div class="footer-pera footer-pera2">
                                                        <p>Heaven fruitful doesn't over lesser in days. Appear creeping.
                                                        </p>
                                                    </div>
                                                    <!-- Form -->
                                                    <div class="footer-form">
                                                        <div id="mc_embed_signup">
                                                            <form target="_blank"
                                                                action="https://spondonit.us12.list-manage.com/subscribe/post?u=1462626880ade1ac87bd9c93a&amp;id=92a4423d01"
                                                                method="get" class="subscribe_form relative mail_part">
                                                                <input type="email" name="email"
                                                                    id="newsletter-form-email"
                                                                    placeholder="Email Address"
                                                                    class="placeholder hide-on-focus"
                                                                    onfocus="this.placeholder = ''"
                                                                    onblur="this.placeholder = ' Email Address '">
                                                                <div class="form-icon">
                                                                    <button type="submit" name="submit"
                                                                        id="newsletter-submit"
                                                                        class="email_icon newsletter-submit button-contactForm"><img
                                                                            src="assets/img/icon/form.png"
                                                                            alt=""></button>
                                                                </div>
                                                                <div class="mt-10 info"></div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--  -->
                                    <div class="row footer-wejed justify-content-between">
                                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-6">
                                            <!-- logo -->
                                            <div class="footer-logo mb-20">
                                                <a href="index.html"><img src="assets/img/logo/logo2_footer.png"
                                                        alt=""></a>
                                            </div>
                                        </div>
                                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-5">
                                            <div class="footer-tittle-bottom">
                                                <span>5000+</span>
                                                <p>Talented Hunter</p>
                                            </div>
                                        </div>
                                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-5">
                                            <div class="footer-tittle-bottom">
                                                <span>451</span>
                                                <p>Talented Hunter</p>
                                            </div>
                                        </div>
                                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-5">
                                            <!-- Footer Bottom Tittle -->
                                            <div class="footer-tittle-bottom">
                                                <span>568</span>
                                                <p>Talented Hunter</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- footer-bottom area -->
                            <div class="footer-bottom-area footer-bg">
                                <div class="container">
                                    <div class="footer-border">
                                        <div class="row d-flex justify-content-between align-items-center">
                                            <div class="col-xl-10 col-lg-10 ">
                                                <div class="footer-copy-right">
                                                    <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                                                        Copyright &copy;
                                                        <script>document.write(new Date().getFullYear());</script> All
                                                        rights
                                                        reserved | This template is made with <i class="fa fa-heart"
                                                            aria-hidden="true"></i> by <a href="https://colorlib.com"
                                                            target="_blank">Colorlib</a>
                                                        <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="col-xl-2 col-lg-2">
                                                <div class="footer-social f-right">
                                                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                                                    <a href="#"><i class="fab fa-twitter"></i></a>
                                                    <a href="#"><i class="fas fa-globe"></i></a>
                                                    <a href="#"><i class="fab fa-behance"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Footer End-->
                        </footer>

                        <!-- JS here -->

                        <!-- All JS Custom Plugins Link Here here -->
                        <script src="./assets/js/vendor/modernizr-3.5.0.min.js"></script>
                        <!-- Jquery, Popper, Bootstrap -->
                        <script src="./assets/js/vendor/jquery-1.12.4.min.js"></script>
                        <script src="./assets/js/popper.min.js"></script>
                        <script src="./assets/js/bootstrap.min.js"></script>
                        <!-- Jquery Mobile Menu -->
                        <script src="./assets/js/jquery.slicknav.min.js"></script>

        <!-- contact js -->
        <script src="./assets/js/contact.js"></script>
        <script src="./assets/js/jquery.form.js"></script>
        <script src="./assets/js/jquery.validate.min.js"></script>
        <script src="./assets/js/mail-script.js"></script>
        <script src="./assets/js/jquery.ajaxchimp.min.js"></script>
        <script src="./assets/js/header.js"></script>

                        <!-- One Page, Animated-HeadLin -->
                        <script src="./assets/js/wow.min.js"></script>
                        <script src="./assets/js/animated.headline.js"></script>
                        <script src="./assets/js/jquery.magnific-popup.js"></script>

    </body>
    
    <script>
let currentPage = 1;
let itemsPerPage = 6;
let totalItems = 0;
let totalPages = 0;

// Khởi tạo khi trang load
document.addEventListener('DOMContentLoaded', function() {
    const jobItems = document.querySelectorAll('.job-item');
    totalItems = jobItems.length;
    
    console.log('Total items found:', totalItems); // Debug
    
    if (totalItems === 0) {
        document.getElementById('paginationNav').style.display = 'none';
        return;
    }
    
    totalPages = Math.ceil(totalItems / itemsPerPage);
    console.log('Total pages calculated:', totalPages); // Debug
    
    // Cập nhật hiển thị tổng số trang ngay lập tức
    document.getElementById('totalPages').textContent = totalPages;
    
    // Ẩn pagination nếu chỉ có 1 trang
    if (totalPages <= 1) {
        document.getElementById('paginationNav').style.display = 'none';
    }
    
    showPage(1);
});

function showPage(page) {
    const jobItems = document.querySelectorAll('.job-item');
    const startIndex = (page - 1) * itemsPerPage;
    const endIndex = startIndex + itemsPerPage;
    
    console.log(`Showing page ${page}, items ${startIndex} to ${endIndex-1}`); // Debug
    
    // Ẩn TẤT CẢ job items trước
    jobItems.forEach((item, index) => {
        const jobCard = item.querySelector('.job-card');
        jobCard.classList.remove('show');
        jobCard.style.display = 'none'; // Force hide
    });
    
    // Hiện những job items trong trang hiện tại
    jobItems.forEach((item, index) => {
        if (index >= startIndex && index < endIndex) {
            const jobCard = item.querySelector('.job-card');
            setTimeout(() => {
                jobCard.style.display = 'block'; // Force show
                jobCard.classList.add('show');
            }, (index - startIndex) * 50);
        }
    });
    
    currentPage = page;
    updatePaginationControls();
    
    // Smooth scroll to top
    document.getElementById('jobList').scrollIntoView({ 
        behavior: 'smooth',
        block: 'start'
    });
}

function updatePaginationControls() {
    // Update page info
    document.getElementById('currentPage').textContent = currentPage;
    document.getElementById('totalPages').textContent = totalPages;
    
    // Update button states
    const prevBtn = document.getElementById('prevBtn');
    const nextBtn = document.getElementById('nextBtn');
    
    if (currentPage === 1) {
        prevBtn.classList.add('disabled');
        prevBtn.onclick = null;
    } else {
        prevBtn.classList.remove('disabled');
        prevBtn.onclick = previousPage;
    }
    
    if (currentPage === totalPages) {
        nextBtn.classList.add('disabled');
        nextBtn.onclick = null;
    } else {
        nextBtn.classList.remove('disabled');
        nextBtn.onclick = nextPage;
    }
}

function previousPage() {
    if (currentPage > 1) {
        showPage(currentPage - 1);
    }
}

function nextPage() {
    if (currentPage < totalPages) {
        showPage(currentPage + 1);
    }
}
</script>

                        <!-- contact js -->
                        <script src="./assets/js/contact.js"></script>
                        <script src="./assets/js/jquery.form.js"></script>
                        <script src="./assets/js/jquery.validate.min.js"></script>
                        <script src="./assets/js/mail-script.js"></script>
                        <script src="./assets/js/jquery.ajaxchimp.min.js"></script>

                        <!-- Jquery Plugins, main Jquery -->
                        <script src="./assets/js/plugins.js"></script>
                        <script src="./assets/js/main.js"></script>

                        <!-- Custom JavaScript for Related Jobs -->
                        <script>
                            // Load suggested jobs when page loads
                            document.addEventListener('DOMContentLoaded', function () {
                                loadSuggestedJobs();

                                // Auto-submit form when filters change
                                const form = document.getElementById('advancedSearchForm');
                                const filters = ['jobType', 'industry', 'experience'];

                                filters.forEach(filter => {
                                    const element = document.getElementById(filter);
                                    if (element) {
                                        element.addEventListener('change', function () {
                                            // Only auto-submit if there's a keyword or location
                                            const keyword = document.getElementById('keyword').value;
                                            const location = document.getElementById('location').value;

                                            if (keyword.trim() || location.trim()) {
                                                form.submit();
                                            }
                                        });
                                    }
                                });

                                // Salary range validation
                                const minSalary = document.getElementById('minSalary');
                                const maxSalary = document.getElementById('maxSalary');

                                if (minSalary && maxSalary) {
                                    maxSalary.addEventListener('change', function () {
                                        const min = parseFloat(minSalary.value) || 0;
                                        const max = parseFloat(maxSalary.value) || 0;

                                        if (max > 0 && min > max) {
                                            alert('Mức lương tối đa phải lớn hơn mức lương tối thiểu');
                                            maxSalary.value = '';
                                        }
                                    });
                                }
                            });

                            // Function to load suggested jobs
                            function loadSuggestedJobs() {
                                const container = document.getElementById('suggestedJobsContainer');
                                if (!container) return;

                                // Show loading spinner
                                container.innerHTML = `
                                    <div class="col-12 text-center">
                                        <div class="spinner-border text-primary" role="status">
                                            <span class="visually-hidden">Loading...</span>
                                        </div>
                                    </div>
                                `;

                                // Fetch suggested jobs from server
                                fetch('related-jobs?limit=6')
                                    .then(response => response.text())
                                    .then(html => {
                                        // Parse the HTML and extract job cards
                                        const parser = new DOMParser();
                                        const doc = parser.parseFromString(html, 'text/html');
                                        const jobCards = doc.querySelectorAll('.job-card');

                                        if (jobCards.length > 0) {
                                            let jobsHTML = '';
                                            jobCards.forEach((card, index) => {
                                                if (index < 6) { // Limit to 6 jobs
                                                    // Convert to suggested job format
                                                    const jobTitle = card.querySelector('.job-title-truncate')?.textContent || 'N/A';
                                                    const companyName = card.querySelector('.company-name-truncate')?.textContent || 'N/A';
                                                    const salary = card.querySelector('.salary-tag')?.textContent || 'N/A';
                                                    const location = card.querySelector('.location-tag')?.textContent || 'N/A';
                                                    const jobType = card.querySelector('.job-type')?.textContent || 'N/A';
                                                    const jobLink = card.querySelector('.job-title-truncate')?.href || '#';
                                                    const companyLogo = card.querySelector('.company-logo')?.src || 'assets/img/icon/job-list1.png';

                                                    // Generate random match score
                                                    const matchScore = Math.floor(Math.random() * 30) + 70; // 70-100%

                                                    jobsHTML += `
                                                        <div class="col-lg-6 col-md-6 mb-3">
                                                            <div class="suggested-job-card p-3">
                                                                <div class="d-flex justify-content-between align-items-start mb-2">
                                                                    <div class="d-flex align-items-center">
                                                                        <img src="${companyLogo}" alt="${companyName}" class="company-logo-small me-3">
                                                                        <div>
                                                                            <a href="${jobLink}" class="job-title-small">${jobTitle}</a>
                                                                            <div class="company-name-small">${companyName}</div>
                                                                        </div>
                                                                    </div>
                                                                    <span class="match-score">${matchScore}%</span>
                                                                </div>
                                                                <div class="job-meta-small">
                                                                    <div><i class="fas fa-money-bill-wave"></i>${salary}</div>
                                                                    <div><i class="fas fa-map-marker-alt"></i>${location}</div>
                                                                    <div><i class="fas fa-briefcase"></i>${jobType}</div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    `;
                                                }
                                            });

                                            container.innerHTML = jobsHTML;
                                        } else {
                                            // Show fallback content
                                            container.innerHTML = `
                                                <div class="col-12 text-center">
                                                    <div class="text-muted">
                                                        <i class="fas fa-search fa-2x mb-3"></i>
                                                        <p>Chưa có việc làm gợi ý. Hãy thử tìm kiếm với từ khóa khác.</p>
                                                    </div>
                                                </div>
                                            `;
                                        }
                                    })
                                    .catch(error => {
                                        console.error('Error loading suggested jobs:', error);
                                        container.innerHTML = `
                                            <div class="col-12 text-center">
                                                <div class="text-muted">
                                                    <i class="fas fa-exclamation-triangle fa-2x mb-3"></i>
                                                    <p>Có lỗi xảy ra khi tải việc làm gợi ý.</p>
                                                </div>
                                            </div>
                                        `;
                                    });
                            }

                            // Function to handle keyword tag clicks
                            function handleKeywordClick(keyword) {
                                document.getElementById('keyword').value = keyword;
                                document.getElementById('advancedSearchForm').submit();
                            }

                            // Function to handle location tag clicks
                            function handleLocationClick(location) {
                                document.getElementById('location').value = location;
                                document.getElementById('advancedSearchForm').submit();
                            }
                        </script>

                </body>

                </html>