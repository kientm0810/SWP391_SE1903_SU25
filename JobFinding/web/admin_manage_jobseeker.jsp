<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Job Seekers - Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <jsp:include page="admin-common-styles.jsp" />
</head>
<body>
    <div class="dashboard-container">
        <!-- Include Sidebar -->
        <jsp:include page="sidebar.jsp" />
        
        <!-- Main Content -->
        <div class="main-content">
            <!-- Page Header -->
            <div class="page-header">
                <h1>Manage Job Seekers</h1>
                <div class="header-actions">
                    <a href="AdminController?target=JobSeeker&service=Add" class="btn btn-primary">
                        <i class="fas fa-plus"></i>
                        Add New Job Seeker
                    </a>
                </div>
            </div>
            
            <!-- Search and Filter -->
            <div class="search-filter-section">
                <form action="AdminController" method="get">
                    <input type="hidden" name="target" value="JobSeeker">
                    <input type="hidden" name="service" value="list">
                    
                    <div class="search-filter-row">
                        <div class="search-box">
                            <input type="text" name="fullName" placeholder="Search by name..." 
                                   value="${param.fullName}">
                            <i class="fas fa-search"></i>
                        </div>
                        
                        <input type="text" name="email" class="form-control" 
                               placeholder="Email" value="${param.email}" style="width: 200px;">
                        
                        <input type="text" name="phone" class="form-control" 
                               placeholder="Phone" value="${param.phone}" style="width: 150px;">
                        
                        <select name="gender" class="form-control" style="width: 120px;">
                            <option value="">All Gender</option>
                            <option value="Male" ${param.gender == 'Male' ? 'selected' : ''}>Male</option>
                            <option value="Female" ${param.gender == 'Female' ? 'selected' : ''}>Female</option>
                            <option value="Other" ${param.gender == 'Other' ? 'selected' : ''}>Other</option>
                        </select>
                        
                        <select name="isActive" class="form-control" style="width: 120px;">
                            <option value="">All Status</option>
                            <option value="true" ${param.isActive == 'true' ? 'selected' : ''}>Active</option>
                            <option value="false" ${param.isActive == 'false' ? 'selected' : ''}>Inactive</option>
                        </select>
                        
                        <button type="submit" name="submit" value="Search" class="btn btn-primary">
                            <i class="fas fa-filter"></i>
                            Search
                        </button>
                        
                        <a href="AdminController?target=JobSeeker" class="btn btn-secondary">
                            <i class="fas fa-redo"></i>
                            Reset
                        </a>
                    </div>
                </form>
            </div>
            
            <!-- Data Table -->
            <div class="table-container">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Gender</th>
                            <th>Experience</th>
                            <th>Education</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="jobSeeker" items="${vec}">
                            <tr>
                                <td>#${jobSeeker.id}</td>
                                <td>${jobSeeker.fullName}</td>
                                <td>${jobSeeker.email}</td>
                                <td>${jobSeeker.phone}</td>
                                <td>${jobSeeker.gender}</td>
                                <td>${jobSeeker.experienceYears} years</td>
                                <td>${jobSeeker.education}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${jobSeeker.active}">
                                            <span class="status-badge status-active">Active</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-inactive">Inactive</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="AdminController?target=JobSeeker&service=Detail&ID=${jobSeeker.id}" 
                                           class="action-btn view-btn">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="AdminController?target=JobSeeker&service=Update&ID=${jobSeeker.id}" 
                                           class="action-btn edit-btn">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="AdminController?target=JobSeeker&service=Ban&ID=${jobSeeker.id}&status=${jobSeeker.active}" 
                                           class="action-btn delete-btn"
                                           onclick="return confirm('Are you sure you want to change the status?')">
                                            <i class="fas fa-ban"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty vec}">
                            <tr>
                                <td colspan="9" class="text-center">No job seekers found.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>