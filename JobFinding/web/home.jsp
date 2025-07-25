<%-- Document : home Created on : May 18, 2025, 10:21:22 PM Author : SHD --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
        <!-- Preloader Start -->
        <%@ include file="header.jsp" %>
        <main>

            <!-- Resolve banner images from DB or fallback -->
            <c:choose>
                <c:when test="${not empty banners}">
                    <c:set var="banner1" value="${banners[0].image_url}" />
                </c:when>
                <c:otherwise>
                    <c:set var="banner1" value="assets/img/hero/h1_hero.jpg" />
                </c:otherwise>
            </c:choose>

            <c:choose>
                <c:when test="${not empty banners and fn:length(banners) >= 2}">
                    <c:set var="banner2" value="${banners[1].image_url}" />
                </c:when>
                <c:otherwise>
                    <c:set var="banner2" value="assets/img/gallery/cv_bg.jpg" />
                </c:otherwise>
            </c:choose>

            <!-- slider Area Start-->
            <div class="slider-area ">
                <!-- Mobile Menu -->
                <div class="slider-active">
                    <div class="single-slider slider-height d-flex align-items-center"
                         data-background="${banner1}">
                        <div class="container">
                            <div class="row">
                                <div class="col-xl-6 col-lg-9 col-md-10">
                                </div>
                            </div>
                            <!-- Search Box -->
                            <div class="row">
                                <div class="col-xl-8">
                                    <!-- form -->
                                    <form action="${pageContext.request.contextPath}/post" method="GET" class="search-box">
                                        <div class="input-form">
                                            <input type="text" name="keyword"
                                                   placeholder="Tìm kiếm theo tiêu đề, công ty..."
                                                   value="${param.keyword}">
                                        </div>
                                        <div class="select-form">
                                            <div class="select-itms">
                                                <select name="location" id="select1">
                                                    <option value="">Tất cả địa điểm</option>
                                                    <option value="Hà Nội" ${param.location=='Hà Nội' ? 'selected' : '' }>Hà Nội</option>
                                                    <option value="Hồ Chí Minh" ${param.location=='Hồ Chí Minh' ? 'selected' : '' }>Hồ Chí Minh</option>
                                                    <option value="Đà Nẵng" ${param.location=='Đà Nẵng' ? 'selected' : '' }>Đà Nẵng</option>
                                                    <option value="Remote" ${param.location=='Remote' ? 'selected' : '' }>Remote</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="search-form">
                                            <button type="submit" class="btn btn-primary w-100" style="height: 100%; border-radius: 0 5px 5px 0;">Tìm kiếm</button>
                                        </div>
                                    </form>
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
            <div class="container mt-4 premium-section">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="section-tittle text-center">
                            <span class="text-warning fw-bold text-uppercase">Premium Job</span>
                            <h2 class="text-dark">Hotest Job</h2>
                        </div>
                    </div>
                </div>

                <!-- Debug info -->
                <div class="row mb-4">
                    <div class="col-12">
                        <p class="text-muted">Number of posts: ${posts != null ? posts.size() : 0}</p>
                    </div>
                </div>

                <!-- Job List Container -->
                <div class="row" id="jobList">
                    <c:forEach items="${posts}" var="post" varStatus="status">
                        <div class="col-xl-4 col-lg-4 col-md-6 job-item premium-job-item" data-index="${status.index}">
                            <div class="card job-card border border-warning shadow-sm premium-card">
                                <div class="job-card-header-overlay d-flex justify-content-between align-items-center bg-warning bg-opacity-10 p-2 rounded-top">
                                    <div class="job-badges-left d-flex gap-2">
                                        <c:if test="${post.postType == 'hot'}">
                                            <span class="job-badge badge-new bg-danger text-white">Tin mới</span>
                                        </c:if>
                                        <c:if test="${post.postType == 'pro'}">
                                            <span class="job-badge badge-featured bg-warning text-dark">Nổi bật</span>
                                        </c:if>
                                    </div>
                                </div>

                                <div class="card-body">
                                    <div class="d-flex align-items-center mb-3">
                                        <img src="${post.companyLogo != null ? post.companyLogo : 'assets/img/icon/job-list1.png'}"
                                             alt="${post.companyName}" class="company-logo me-3 rounded premium-logo">
                                        <div class="job-details">
                                            <h5 class="card-title mb-1">
                                                <a href="${pageContext.request.contextPath}/post/view?id=${post.id}"
                                                   class="text-decoration-none text-dark job-title-truncate premium-job-title">
                                                    ${post.title}
                                                </a>
                                            </h5>
                                            <p class="text-muted mb-1 company-name-truncate">${post.companyName}</p>
                                        </div>
                                    </div>

                                    <!-- Salary and Location Tags -->
                                    <div class="d-flex flex-wrap gap-2">
                                        <span class="job-info-tag salary-tag premium-salary">${post.salary}</span>
                                        <span class="job-info-tag location-tag premium-location">${post.location}</span>

                                        <form action="${pageContext.request.contextPath}/saved-jobs" method="post" style="display:inline;">
                                            <input type="hidden" name="postId" value="${post.id}" />
                                            <input type="hidden" name="action" value="save" />
                                            <button type="submit" class="btn btn-outline-warning save-job ms-auto premium-save-btn">
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
                <nav aria-label="Page navigation" class="mt-4 premium-pagination" id="paginationNav">
                    <div class="simple-pagination d-flex justify-content-center align-items-center gap-3">
                        <!-- Nút trang trước -->
                        <a href="#" class="pagination-arrow" id="prevBtn" onclick="previousPage()">
                            <i class="fas fa-chevron-left"></i>
                        </a>

                        <span class="pagination-info">
                            <span class="current-page" id="currentPage">1</span> /
                            <span class="total-pages" id="totalPages">1</span> trang
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
            <!--            <div class="our-services section-pad-t30">
                            <div class="container">
                                 Section Tittle 
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
                                 More Btn 
                                 Section Button 
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="browse-btn2 text-center mt-50">
                                            <a href="job_listing.html" class="border-btn2">Browse All Sectors</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>-->
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

                    <!-- Job List Container -->
                    <div class="row" id="recentJobList">
                        <c:forEach items="${recentPosts}" var="post" varStatus="status">
                            <div class="col-xl-4 col-lg-4 col-md-6 job-item-recent" data-index="${status.index}">
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

                    <!-- Pagination for Recent Posts -->
                    <nav aria-label="Page navigation" class="mt-4" id="recentPaginationNav">
                        <div class="simple-pagination d-flex justify-content-center align-items-center gap-3">
                            <a href="#" class="pagination-arrow" id="recentPrevBtn">
                                <i class="fas fa-chevron-left"></i>
                            </a>

                            <span class="pagination-info">
                                <span class="current-page" id="recentCurrentPage">1</span> /
                                <span class="total-pages" id="recentTotalPages">1</span> trang
                            </span>

                            <a href="#" class="pagination-arrow" id="recentNextBtn">
                                <i class="fas fa-chevron-right"></i>
                            </a>
                        </div>
                    </nav>

                </div>
            </div>
            <!-- Khu Bài viết gần đây End -->





            <!-- How  Apply Process Start-->
            <!--            <div class="apply-process-area apply-bg pt-150 pb-150"
                             data-background="assets/img/gallery/how-applybg.png">
                            <div class="container">
                                 Section Tittle 
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="section-tittle white-text text-center">
                                            <span>Apply process</span>
                                            <h2> How it works</h2>
                                        </div>
                                    </div>
                                </div>
                                 Apply Process Caption 
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
                        </div>-->

            <!-- Apply Process Section Fragment -->
            <!-- Apply Process Caption -->
            
            <c:choose>
                <c:when test="${not empty banners and fn:length(banners) >= 3}">
                    <c:set var="banner3" value="${banners[2].image_url}" />
                </c:when>
                <c:otherwise>
                    <c:set var="banner3" value="assets/img/gallery/how-applybg.png" />
                </c:otherwise>
            </c:choose>
            <div class="apply-process-area apply-bg pt-150 pb-150"
                 data-background="${banner3}">
            
                <div class="container">
                    Section Tittle 
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="section-tittle white-text text-center">
                                <span>Apply process</span>
                                <h2> How it works</h2>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <c:forEach var="process" items="${applyProcesses}">
                            <div class="col-lg-4 col-md-6">
                                <div class="single-process text-center mb-30">
                                    <div class="process-ion">
                                        <span class="${process.iconClass}"></span>
                                    </div>
                                    <div class="process-cap">
                                        <h5>${process.title}</h5>
                                        <p>${process.content}</p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>


            <!-- How  Apply Process End-->
            <!--             Testimonial Start 
                        <div class="testimonial-area testimonial-padding">
                            <div class="container">
                                 Testimonial contents 
                                <div class="row d-flex justify-content-center">
                                    <div class="col-xl-8 col-lg-8 col-md-10">
                                        <div class="h1-testimonial-active dot-style">
                                             Single Testimonial 
                                            <div class="single-testimonial text-center">
                                                 Testimonial Content 
                                                <div class="testimonial-caption ">
                                                     founder 
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
                                             Single Testimonial 
                                            <div class="single-testimonial text-center">
                                                 Testimonial Content 
                                                <div class="testimonial-caption ">
                                                     founder 
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
                                             Single Testimonial 
                                            <div class="single-testimonial text-center">
                                                 Testimonial Content 
                                                <div class="testimonial-caption ">
                                                     founder 
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
                        </div>-->
            <!-- Testimonial Start -->
            <div class="testimonial-area testimonial-padding">
                <div class="container">
                    <!-- Testimonial contents -->
                    <div class="row d-flex justify-content-center">
                        <div class="col-xl-8 col-lg-8 col-md-10">
                            <div class="h1-testimonial-active dot-style">
                                <c:forEach var="testimonial" items="${testimonials}">
                                    <!-- Single Testimonial -->
                                    <div class="single-testimonial text-center">
                                        <!-- Testimonial Content -->
                                        <div class="testimonial-caption">
                                            <!-- founder -->
                                            <div class="testimonial-founder">
                                                <div class="founder-img mb-30">
                                                    <c:choose>
                                                        <c:when test="${not empty testimonial.img}">
                                                            <img style="
                                                                 width: 130px;
                                                                 height: 130px;
                                                                 border-radius: 50%;
                                                                 object-fit: cover;
                                                                 box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                                                                 "  
                                                                 src="/JobFinding/${testimonial.img}" alt="${testimonial.name}">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="assets/img/testmonial/testimonial-founder.png" alt="${testimonial.name}">
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <!--<img src="assets/img/testmonial/testimonial-founder.png" alt="${testimonial.name}">-->
                                                    <span>${testimonial.name}</span>
                                                    <p>${testimonial.title}</p>
                                                </div>
                                            </div>
                                            <div class="testimonial-top-cap">
                                                <p>"${testimonial.content}"</p>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Testimonial End -->


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
                                            <h3><a href="BlogController?service=detail&id=${blog.id}">${blog.title}</a></h3>
                                            <a href="BlogController?service=detail&id=${blog.id}" class="more-btn">Read more »</a>
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
                                                                                    <div class="mt-10 info"></div>
                                                                                </form>
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

        <!-- Jquery Slick , Owl-Carousel Plugins -->
        <script src="./assets/js/owl.carousel.min.js"></script>
        <script src="./assets/js/slick.min.js"></script>
        <script src="./assets/js/price_rangs.js"></script>

        <!-- One Page, Animated-HeadLin -->
        <script src="./assets/js/wow.min.js"></script>
        <script src="./assets/js/animated.headline.js"></script>
        <script src="./assets/js/jquery.magnific-popup.js"></script>

        <!-- Scrollup, nice-select, sticky -->
        <script src="./assets/js/jquery.scrollUp.min.js"></script>
        <script src="./assets/js/jquery.nice-select.min.js"></script>
        <script src="./assets/js/jquery.sticky.js"></script>

        <!-- contact js -->
        <script src="./assets/js/contact.js"></script>
        <script src="./assets/js/jquery.form.js"></script>
        <script src="./assets/js/jquery.validate.min.js"></script>
        <script src="./assets/js/mail-script.js"></script>
        <script src="./assets/js/jquery.ajaxchimp.min.js"></script>
        <script src="./assets/js/header.js"></script>

        <!-- Jquery Plugins, main Jquery -->
        <script src="./assets/js/plugins.js"></script>
        <script src="./assets/js/main.js"></script>

    </body>

    <script>
                                            let currentPage = 1;
                                            let itemsPerPage = 6;
                                            let totalItems = 0;
                                            let totalPages = 0;

// Khởi tạo khi trang load
                                            document.addEventListener('DOMContentLoaded', function () {
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

                                            let recentCurrentPage = 1;
                                            let recentItemsPerPage = 6;
                                            let recentTotalItems = 0;
                                            let recentTotalPages = 0;

                                            document.addEventListener('DOMContentLoaded', function () {
                                                const recentJobItems = document.querySelectorAll('.job-item-recent');
                                                recentTotalItems = recentJobItems.length;

                                                if (recentTotalItems === 0) {
                                                    document.getElementById('recentPaginationNav').style.display = 'none';
                                                    return;
                                                }

                                                recentTotalPages = Math.ceil(recentTotalItems / recentItemsPerPage);
                                                document.getElementById('recentTotalPages').textContent = recentTotalPages;

                                                if (recentTotalPages <= 1) {
                                                    document.getElementById('recentPaginationNav').style.display = 'none';
                                                }

                                                showRecentPage(1);

                                                // Gắn lại sự kiện click (sau khi DOM loaded)
                                                document.getElementById('recentPrevBtn').addEventListener('click', recentPreviousPage);
                                                document.getElementById('recentNextBtn').addEventListener('click', recentNextPage);
                                            });

                                            function showRecentPage(page) {
                                                const recentJobItems = document.querySelectorAll('.job-item-recent');
                                                const startIndex = (page - 1) * recentItemsPerPage;
                                                const endIndex = startIndex + recentItemsPerPage;

                                                recentJobItems.forEach((item, index) => {
                                                    const jobCard = item.querySelector('.job-card');
                                                    jobCard.classList.remove('show');
                                                    jobCard.style.display = 'none';
                                                });

                                                recentJobItems.forEach((item, index) => {
                                                    if (index >= startIndex && index < endIndex) {
                                                        const jobCard = item.querySelector('.job-card');
                                                        setTimeout(() => {
                                                            jobCard.style.display = 'block';
                                                            jobCard.classList.add('show');
                                                        }, (index - startIndex) * 50);
                                                    }
                                                });

                                                recentCurrentPage = page;
                                                updateRecentPaginationControls();

                                                document.getElementById('recentJobList').scrollIntoView({
                                                    behavior: 'smooth',
                                                    block: 'start'
                                                });
                                            }

                                            function updateRecentPaginationControls() {
                                                document.getElementById('recentCurrentPage').textContent = recentCurrentPage;
                                                document.getElementById('recentTotalPages').textContent = recentTotalPages;

                                                const prevBtn = document.getElementById('recentPrevBtn');
                                                const nextBtn = document.getElementById('recentNextBtn');

                                                prevBtn.classList.toggle('disabled', recentCurrentPage === 1);
                                                nextBtn.classList.toggle('disabled', recentCurrentPage === recentTotalPages);
                                            }

                                            function recentPreviousPage(event) {
                                                event.preventDefault();
                                                if (recentCurrentPage > 1) {
                                                    showRecentPage(recentCurrentPage - 1);
                                                }
                                            }

                                            function recentNextPage(event) {
                                                event.preventDefault();
                                                if (recentCurrentPage < recentTotalPages) {
                                                    showRecentPage(recentCurrentPage + 1);
                                                }
                                            }
    </script>

    <style>
        .premium-section .section-tittle span {
            font-size: 14px;
            letter-spacing: 1px;
        }

        .premium-job-item .job-card {
            transition: 0.3s ease;
            border: 2px solid #ffc107 !important;
            box-shadow: 0 4px 12px rgba(255, 193, 7, 0.2);
        }

        .premium-job-item .job-card:hover {
            transform: scale(1.02);
        }

        .premium-save-btn {
            border-color: #ffc107 !important;
            color: #ffc107;
        }

        .premium-save-btn:hover {
            background-color: #ffc107 !important;
            color: white;
        }
    </style>

</html>