<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Recruiter Profile</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="manifest" href="site.webmanifest">
    <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">

    <!-- CSS here -->
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
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
    <link rel="stylesheet" href="assets/css/recruiter_profile.css">
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
    <jsp:include page="header.jsp" />
    <main>
        <div class="container mt-5 mb-5">
            <div class="row">
                <div class="col-lg-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <img src="${recruiter.profilePicture}" alt="avatar"
                                 class="rounded-circle img-fluid" style="width: 150px;">
                            <h5 class="my-3">${recruiter.fullName}</h5>
                            <p class="text-muted mb-1">${recruiter.companyName}</p>
                            <p class="text-muted mb-4">${recruiter.address}</p>
                            <div class="d-flex justify-content-center mb-2">
                                <a href="edit-recruiter-profile" class="btn btn-primary">Edit Profile</a>
                            </div>
                        </div>
                    </div>
                    <div class="card mt-4">
                         <div class="card-body">
                            <h5 class="card-title">Company Information</h5>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item"><strong>Company:</strong> ${recruiter.companyName}</li>
                                <li class="list-group-item"><strong>Industry:</strong> ${recruiter.industry}</li>
                                <li class="list-group-item"><strong>Company Size:</strong> ${recruiter.companySize}</li>
                                <li class="list-group-item"><strong>Website:</strong> <a href="${recruiter.website}" target="_blank">${recruiter.website}</a></li>
                                <li class="list-group-item"><strong>Address:</strong> ${recruiter.companyAddress}</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-lg-8">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">About</h5>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Full Name</p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted mb-0">${recruiter.fullName}</p>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Email</p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted mb-0">${recruiter.email}</p>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Phone</p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted mb-0">${recruiter.phone}</p>
                                </div>
                            </div>
                             <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Date of Birth</p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted mb-0">${recruiter.dateOfBirth}</p>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Address</p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted mb-0">${recruiter.address}</p>
                                </div>
                            </div>
                            <hr>
                             <div class="row">
                                <div class="col-sm-12">
                                    <p class="mb-0"><strong>Company Description</strong></p>
                                    <p class="text-muted mb-0">${recruiter.companyDescription}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card mt-4">
                        <div class="card-body">
                            <h5 class="card-title">Posted Jobs</h5>
                            <div class="job-listings">
                                <c:forEach var="post" items="${postList}">
                                    <div class="single-job-items mb-30">
                                        <div class="job-items">
                                            <div class="company-img">
                                                <a href="post/view?id=${post.id}"><img src="${post.companyLogo}" alt=""></a>
                                            </div>
                                            <div class="job-tittle job-tittle2">
                                                <a href="post/view?id=${post.id}">
                                                    <h4>${post.title}</h4>
                                                </a>
                                                <ul>
                                                    <li>${post.companyName}</li>
                                                    <li><i class="fas fa-map-marker-alt"></i>${post.location}</li>
                                                    <li>${post.salary}</li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="items-link items-link2 f-right">
                                            <a href="post/view?id=${post.id}">View Details</a>
                                            <span>${post.jobType}</span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <%-- <jsp:include page="footer.jsp" /> --%>
    
    <!-- JS here -->
    <script src="./assets/js/vendor/modernizr-3.5.0.min.js"></script>
    <script src="./assets/js/vendor/jquery-1.12.4.min.js"></script>
    <script src="./assets/js/popper.min.js"></script>
    <script src="./assets/js/bootstrap.min.js"></script>
    <script src="./assets/js/jquery.slicknav.min.js"></script>
    <script src="./assets/js/owl.carousel.min.js"></script>
    <script src="./assets/js/slick.min.js"></script>
    <script src="./assets/js/price_rangs.js"></script>
    <script src="./assets/js/wow.min.js"></script>
    <script src="./assets/js/animated.headline.js"></script>
    <script src="./assets/js/jquery.magnific-popup.js"></script>
    <script src="./assets/js/jquery.scrollUp.min.js"></script>
    <script src="./assets/js/jquery.nice-select.min.js"></script>
    <script src="./assets/js/jquery.sticky.js"></script>
    <script src="./assets/js/contact.js"></script>
    <script src="./assets/js/jquery.form.js"></script>
    <script src="./assets/js/jquery.validate.min.js"></script>
    <script src="./assets/js/mail-script.js"></script>
    <script src="./assets/js/jquery.ajaxchimp.min.js"></script>
    <script src="./assets/js/plugins.js"></script>
    <script src="./assets/js/main.js"></script>
</body>
</html>
