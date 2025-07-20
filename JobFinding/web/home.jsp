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
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap"
              rel="stylesheet">

        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
              rel="stylesheet">



        <!-- Original CSS files with updated paths -->
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
        <link rel="stylesheet" href="assets/css/styleHome.css">

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
                        <c:forEach items="${blogList}" var="blog">
                            <div class="col-xl-6 col-lg-6 col-md-6">
                                <div class="home-blog-single mb-30">
                                    <div class="blog-img-cap">
                                        <div class="blog-img">
                                            <img src="${blog.thumbnail}" alt="${blog.title}">
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

        <!-- Jquery Plugins, main Jquery -->
        <script src="./assets/js/plugins.js"></script>
        <script src="./assets/js/main.js"></script>

    </body>

</html>