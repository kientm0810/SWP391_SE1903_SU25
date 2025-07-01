<!-- admin_add_manager.jsp -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:choose>
        <c:when test="${not empty manager.id}">Update Staff</c:when>
        <c:otherwise>Create New Staff</c:otherwise>
    </c:choose> - Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <jsp:include page="admin-common-styles.jsp" />
</head>
<body>
    <div class="dashboard-container">
        <jsp:include page="sidebar.jsp" />
        
        <div class="main-content">
            <div class="page-header">
                
                <c:choose>
                    <c:when test="${not empty manager.id}">
                        <h1>Update Staff</h1>
                    </c:when>
                    <c:otherwise>
                        <h1>Add New Staff</h1>
                    </c:otherwise>
                </c:choose>
                
                
                <div class="header-actions">
                    <a href="AdminController?target=Staff" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>
                        Back to List
                    </a>
                </div>
            </div>
            
            <div class="form-container">
                <form action="AdminController" method="POST" enctype="multipart/form-data">
                    <div class="form-row">
                        <div class="form-group">
                            <label>Username</label>
                            <input type="text" name="username" class="form-control" value="${manager.username}" required>
                        </div>
                        <div class="form-group">
                            <label>Password</label>
                            <input type="password" name="password" class="form-control" value="${manager.password}" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" name="email" class="form-control" value="${manager.email}" required>
                        </div>
                        <div class="form-group">
                            <label>Full Name</label>
                            <input type="text" name="fullName" class="form-control" value="${manager.fullName}" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label>Phone</label>
                            <input type="tel" name="phone" class="form-control" value="${manager.phone}" required>
                        </div>
                        <div class="form-group">
                            <label>Date of Birth</label>
                            <input type="date" name="dateOfBirth" class="form-control" value="${manager.dateOfBirth}" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label>Gender</label>
                            <select name="gender" class="form-control" required>
                                <option value="${manager.gender}">Select Gender</option>
                                <option value="male">Male</option>
                                <option value="female">Female</option>
                                <option value="other">Other</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Address</label>
                            <input type="text" name="address" class="form-control" value="${manager.address}" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label>Profile Picture URL</label>
                        <c:choose>
                            <c:when test="${not empty manager.id}">
                                <input type="file" name="profilePicture" accept="image/*" class="form-control">
                            </c:when>
                            <c:otherwise>
                                <input type="file" name="profilePicture" accept="image/*" class="form-control" required>
                            </c:otherwise>
                        </c:choose>
                        <c:if test="${not empty mustbeImg}">
                            ${mustbeImg}
                        </c:if>
                        
                        <label>Role</label>
                        <select name="role" class="form-control" required>
                            <option value="${manager.role}">Select role</option>
                            <option value="admin">Admin</option>
                            <option value="manager">Manager</option>
                            <option value="saler">Saler</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label>Status</label>
                        <div class="radio-group">
                            <label class="radio-label">
                                <input type="radio" name="isActive" value="true" checked>
                                <span>Active</span>
                            </label>
                            <label class="radio-label">
                                <input type="radio" name="isActive" value="false">
                                <span>Inactive</span>
                            </label>
                        </div>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" name="submit" value="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i>
                            Confirm
                        </button>
                        <button type="reset" class="btn btn-secondary">
                            <i class="fas fa-redo"></i>
                            Reset
                        </button>
                       
                        <c:choose>
                            <c:when test="${not empty manager.id}">
                                <input type="hidden" name="ID" value="${manager.id}">
                                <input type="hidden" name="service" value="Update">
                            </c:when>
                            <c:otherwise>
                                <input type="hidden" name="service" value="Add">
                            </c:otherwise>
                        </c:choose>
                        
                        
                        <input type="hidden" name="target" value="Staff">
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <style>
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .radio-group {
            display: flex;
            gap: 20px;
            align-items: center;
            margin-top: 10px;
        }
        
        .radio-label {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
        }
        
        .form-actions {
            margin-top: 30px;
            display: flex;
            gap: 15px;
        }
        
        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</body>
</html>