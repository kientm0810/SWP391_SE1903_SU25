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
                        
                        <select name="verificationStatus" class="form-control" style="width: 150px;">
                            <option value="">All Verification</option>
                            <option value="pending" ${param.verificationStatus == 'pending' ? 'selected' : ''}>Pending</option>
                            <option value="verified" ${param.verificationStatus == 'verified' ? 'selected' : ''}>Verified</option>
                            <option value="rejected" ${param.verificationStatus == 'rejected' ? 'selected' : ''}>Rejected</option>
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
                    
                    <!-- Thêm phần sort và records per page controls -->
                    <div class="search-filter-row" style="margin-top: 10px;">
                        <div style="display: flex; gap: 15px; align-items: center;">
                            <div>
                                <label style="margin-right: 5px;">Sort by:</label>
                                <select id="sortField" name="sortField" class="form-control" style="width: 150px; display: inline-block;">
                                    <option value="id" ${sortField == 'id' ? 'selected' : ''}>ID</option>
                                    <option value="company_name" ${sortField == 'company_name' ? 'selected' : ''}>Company Name</option>
                                    <option value="email" ${sortField == 'email' ? 'selected' : ''}>Email</option>
                                    <option value="created_at" ${sortField == 'created_at' ? 'selected' : ''}>Created Date</option>
                                    <option value="loyalty_score" ${sortField == 'loyalty_score' ? 'selected' : ''}>Loyalty Score</option>
                                </select>
                            </div>

                            <div>
                                <select id="sortOrder" name="sortOrder" class="form-control" style="width: 100px;">
                                    <option value="ASC" ${sortOrder == 'ASC' ? 'selected' : ''}>ASC</option>
                                    <option value="DESC" ${sortOrder == 'DESC' ? 'selected' : ''}>DESC</option>
                                </select>
                            </div>

                            <div>
                                <label style="margin-right: 5px;">Show:</label>
                                <select id="recordsPerPage" name="recordsPerPage" class="form-control" style="width: 80px; display: inline-block;" onchange="changeRecordsPerPage()">
                                    <option value="5" ${recordsPerPage == 5 ? 'selected' : ''}>5</option>
                                    <option value="10" ${recordsPerPage == 10 ? 'selected' : ''}>10</option>
                                    <option value="20" ${recordsPerPage == 20 ? 'selected' : ''}>20</option>
                                    <option value="50" ${recordsPerPage == 50 ? 'selected' : ''}>50</option>
                                </select>
                                <span style="margin-left: 5px;">records</span>
                            </div>

                            <div style="margin-left: auto;">
                                <span>Total: ${totalRecords} records</span>
                            </div>
                        </div>
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
                
                <!-- Pagination -->
                <div class="pagination-area" style="margin-top: 30px;">
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center custom-pagination">

                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="AdminController?target=Recruiter&page=${currentPage - 1}&recordsPerPage=${recordsPerPage}&sortField=${sortField}&sortOrder=${sortOrder}${searchParams != null ? '&submit=Search&companyName=' + searchParams.companyName + '&verificationStatus=' + searchParams.verificationStatus : ''}">
                                        <i class="fas fa-chevron-left"></i>
                                    </a>
                                </li>
                            </c:if>

                            <c:forEach begin="${currentPage > 3 ? currentPage - 2 : 1}" 
                                       end="${currentPage + 2 > totalPages ? totalPages : currentPage + 2}" var="i">
                                <c:choose>
                                    <c:when test="${currentPage eq i}">
                                        <li class="page-item active">
                                            <span class="page-link">${i}</span>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="page-item">
                                            <a class="page-link" href="AdminController?target=Recruiter&page=${i}&recordsPerPage=${recordsPerPage}&sortField=${sortField}&sortOrder=${sortOrder}${searchParams != null ? '&submit=Search&companyName=' + searchParams.companyName + '&verificationStatus=' + searchParams.verificationStatus : ''}">${i}</a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="AdminController?target=Recruiter&page=${currentPage + 1}&recordsPerPage=${recordsPerPage}&sortField=${sortField}&sortOrder=${sortOrder}${searchParams != null ? '&submit=Search&companyName=' + searchParams.companyName + '&verificationStatus=' + searchParams.verificationStatus : ''}">
                                        <i class="fas fa-chevron-right"></i>
                                    </a>
                                </li>
                            </c:if>

                        </ul>
                    </nav>
                </div>

                
            </div>
        </div>
    </div>
</body>
</html>

<script>
    function changeRecordsPerPage() {
        var recordsPerPage = document.getElementById('recordsPerPage').value;
        var sortField = document.getElementById('sortField').value;
        var sortOrder = document.getElementById('sortOrder').value;
        window.location.href = 'AdminController?target=Recruiter&recordsPerPage=' + recordsPerPage + '&sortField=' + sortField + '&sortOrder=' + sortOrder;
    }
    
    document.getElementById('sortField').addEventListener('change', function() {
        changeRecordsPerPage();
    });
    
    document.getElementById('sortOrder').addEventListener('change', function() {
        changeRecordsPerPage();
    });
</script>

<style>
    .pagination-area {
        text-align: center;
        margin-top: 30px;
        margin-bottom: 30px;
    }

    .pagination {
        display: flex;
        justify-content: center;
        flex-wrap: wrap; /* Cho phép xuống dòng nếu thiếu chỗ */
        gap: 5px;
        list-style: none;
        padding-left: 0;
    }

    .pagination .page-item {
        display: inline-block;
    }

    .pagination .page-link {
        display: block;
        padding: 8px 14px;
        background-color: #f8f9fa;
        border: 1px solid #dee2e6;
        color: #333;
        border-radius: 8px;
        text-decoration: none;
        font-weight: 500;
        transition: 0.2s;
    }

    .pagination .page-link:hover {
        background-color: #e2e6ea;
        color: #212529;
    }

    .pagination .page-item.active .page-link {
        background-color: #28a745;
        border-color: #28a745;
        color: white;
        font-weight: bold;
        pointer-events: none;
    }
</style>