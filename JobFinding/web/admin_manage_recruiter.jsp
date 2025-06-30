<!-- admin_manage_recruiter.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Recruiters - Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <jsp:include page="admin-common-styles.jsp" />
</head>
<body>
    <div class="dashboard-container">
        <jsp:include page="sidebar.jsp" />
        
        <div class="main-content">
            <div class="page-header">
                <h1>Manage Recruiters</h1>
                <div class="header-actions">
                    <a href="AdminController?target=Recruiter&service=Add" class="btn btn-primary">
                        <i class="fas fa-plus"></i>
                        Add New Recruiter
                    </a>
                </div>
            </div>
            
            <div class="search-filter-section">
                <form action="AdminController" method="get">
                    <input type="hidden" name="target" value="Recruiter">
                    <input type="hidden" name="service" value="list">
                    
                    <div class="search-filter-row">
                        <div class="search-box">
                            <input type="text" name="companyName" placeholder="Search by company name..." 
                                   value="${param.companyName}">
                            <i class="fas fa-search"></i>
                        </div>
                        
                        <input type="text" name="email" class="form-control" 
                               placeholder="Email" value="${param.email}" style="width: 200px;">
                        
                        <select name="verificationStatus" class="form-control" style="width: 150px;">
                            <option value="">All Verification</option>
                            <option value="pending" ${param.verificationStatus == 'pending' ? 'selected' : ''}>Pending</option>
                            <option value="verified" ${param.verificationStatus == 'verified' ? 'selected' : ''}>Verified</option>
                            <option value="rejected" ${param.verificationStatus == 'rejected' ? 'selected' : ''}>Rejected</option>
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
                        
                        <a href="AdminController?target=Recruiter" class="btn btn-secondary">
                            <i class="fas fa-redo"></i>
                            Reset
                        </a>
                    </div>
                </form>
            </div>
            
            <div class="table-container">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Company Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Industry</th>
                            <th>Company Size</th>
                            <th>Verification</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="recruiter" items="${vec}">
                            <tr>
                                <td>#${recruiter.id}</td>
                                <td>${recruiter.companyName}</td>
                                <td>${recruiter.email}</td>
                                <td>${recruiter.phone}</td>
                                <td>${recruiter.industry}</td>
                                <td>${recruiter.companySize}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${recruiter.verificationStatus == 'verified'}">
                                            <span class="status-badge status-verified">Verified</span>
                                        </c:when>
                                        <c:when test="${recruiter.verificationStatus == 'pending'}">
                                            <span class="status-badge status-pending">Pending</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-inactive">Rejected</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${recruiter.active}">
                                            <span class="status-badge status-active">Active</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-inactive">Inactive</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="AdminController?target=Recruiter&service=Detail&ID=${recruiter.id}" 
                                           class="action-btn view-btn">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        
                                        <c:if test="${recruiter.verificationStatus == 'pending'}">
                                            <a href="AdminController?target=Recruiter&service=UpdateVerificationStatus&id=${recruiter.id}&verificationStatus=verified&email=${recruiter.email}" 
                                               class="action-btn edit-btn"
                                               onclick="return confirm('Approve this recruiter?')">
                                                <i class="fas fa-check"></i>
                                            </a>
                                            <a href="AdminController?target=Recruiter&service=UpdateVerificationStatus&id=${recruiter.id}&verificationStatus=rejected&email=${recruiter.email}" 
                                               class="action-btn delete-btn"
                                               onclick="return confirm('Reject this recruiter?')">
                                                <i class="fas fa-times"></i>
                                            </a>
                                        </c:if>
                                        
                                        <a href="AdminController?target=Recruiter&service=Ban&ID=${recruiter.id}&status=${recruiter.active}" 
                                           class="action-btn ${recruiter.active ? 'delete-btn' : 'edit-btn'}"
                                           onclick="return confirm('Are you sure you want to change the status?')">
                                            <i class="fas ${recruiter.active ? 'fa-ban' : 'fa-check-circle'}"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty vec}">
                            <tr>
                                <td colspan="9" class="text-center">No recruiters found.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>