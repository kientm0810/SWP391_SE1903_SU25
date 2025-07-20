<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Edit Recruiter Profile</title>
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
        <div class="container my-5">
            <h2>Edit Profile</h2>
            <hr>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">${errorMessage}</div>
            </c:if>
            <form action="edit-recruiter-profile" method="post">
                <div class="row">
                    <!-- Personal Info -->
                    <div class="col-md-6">
                        <h4>Personal Information</h4>
                        <div class="form-group mb-3">
                            <label for="fullName">Full Name</label>
                            <input type="text" class="form-control" id="fullName" name="fullName" value="${recruiter.fullName}">
                        </div>
                        <div class="form-group mb-3">
                            <label for="phone">Phone</label>
                            <input type="text" class="form-control" id="phone" name="phone" value="${recruiter.phone}">
                        </div>
                        <div class="form-group mb-3">
                            <label for="dateOfBirth">Date of Birth</label>
                            <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" value="${recruiter.dateOfBirth}">
                        </div>
                        <div class="form-group mb-3">
                            <label for="gender">Gender</label>
                            <select class="form-control" id="gender" name="gender">
                                <option value="male" ${recruiter.gender == 'male' ? 'selected' : ''}>Male</option>
                                <option value="female" ${recruiter.gender == 'female' ? 'selected' : ''}>Female</option>
                                <option value="other" ${recruiter.gender == 'other' ? 'selected' : ''}>Other</option>
                            </select>
                        </div>
                        <div class="form-group mb-3">
                            <label for="address">Address</label>
                            <input type="text" class="form-control" id="address" name="address" value="${recruiter.address}">
                        </div>
                        <div class="form-group mb-3">
                            <label for="profilePicture">Profile Picture URL</label>
                            <input type="text" class="form-control" id="profilePicture" name="profilePicture" value="${recruiter.profilePicture}">
                        </div>
                    </div>

                    <!-- Company Info -->
                    <div class="col-md-6">
                        <h4>Company Information</h4>
                        <div class="form-group mb-3">
                            <label for="companyName">Company Name</label>
                            <input type="text" class="form-control" id="companyName" name="companyName" value="${recruiter.companyName}">
                        </div>
                        <div class="form-group mb-3">
                            <label for="companyDescription">Company Description</label>
                            <textarea class="form-control" id="companyDescription" name="companyDescription" rows="3">${recruiter.companyDescription}</textarea>
                        </div>
                        <div class="form-group mb-3">
                            <label for="logo">Company Logo URL</label>
                            <input type="text" class="form-control" id="logo" name="logo" value="${recruiter.logo}">
                        </div>
                        <div class="form-group mb-3">
                            <label for="website">Website</label>
                            <input type="text" class="form-control" id="website" name="website" value="${recruiter.website}">
                        </div>
                        <div class="form-group mb-3">
                            <label for="companyAddress">Company Address</label>
                            <input type="text" class="form-control" id="companyAddress" name="companyAddress" value="${recruiter.companyAddress}">
                        </div>
                        <div class="form-group mb-3">
                            <label for="companySize">Company Size</label>
                            <input type="text" class="form-control" id="companySize" name="companySize" value="${recruiter.companySize}">
                        </div>
                        <div class="form-group mb-3">
                            <label for="industry">Industry</label>
                            <input type="text" class="form-control" id="industry" name="industry" value="${recruiter.industry}">
                        </div>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary">Save Changes</button>
                <a href="recruiter-profile" class="btn btn-secondary">Cancel</a>
            </form>
        </div>
    </main>
    
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
