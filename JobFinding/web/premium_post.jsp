<%-- 
    Document   : newjsp
    Created on : Jul 2, 2025, 6:12:09 PM
    Author     : andin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!--Bài viết Premium -->
<div class="recent-posts-area section-pad-t30">
    <div class="container">
        <!-- Section Tittle -->
        <div class="row">
            <div class="col-lg-12">
                <div class="section-tittle text-center">
                    <span>Premium Jobs</span>
                    <h2>Premium Job Posts</h2>
                </div>
            </div>
        </div>

        <!-- Debug info -->
        <div class="row mb-4">
            <div class="col-12">
                <p>Number of posts: ${premiumPost != null ? premiumPost.size() : 0}</p>
            </div>
        </div>

        <div class="row">
            <c:if test="${empty premiumPost}">
                <div class="col-12 text-center">
                    <p>No premium posts available.</p>
                </div>
            </c:if>
            <c:forEach items="${premiumPost}" var="post">
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

    </div>
</div>
