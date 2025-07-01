<!-- admin_add_recruiter.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Recruiter - Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <jsp:include page="admin-common-styles.jsp" />
</head>
<body>
    <div class="dashboard-container">
        <jsp:include page="sidebar.jsp" />
        
        <div class="main-content">
            <div class="page-header">
                <h1>Add New Recruiter</h1>
                <div class="header-actions">
                    <a href="AdminController?target=Recruiter" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>
                        Back to List
                    </a>
                </div>
            </div>
            
            <div class="form-container">
                <form action="AdminController" method="post">
                    <input type="hidden" name="target" value="Recruiter">
                    <input type="hidden" name="service" value="Add">
                    
                    <h3 style="color: #2e7d32; margin-bottom: 20px;">
                        <i class="fas fa-user"></i> Personal Information
                    </h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label>Username</label>
                            <input type="text" name="username" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Password</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" name="email" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Full Name</label>
                            <input type="text" name="fullName" class="form-control" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label>Phone</label>
                            <input type="text" name="phone" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Date of Birth</label>
                            <input type="date" name="dateOfBirth" class="form-control" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label>Gender</label>
                            <select name="gender" class="form-control" required>
                                <option value="">Select Gender</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Address</label>
                            <input type="text" name="address" class="form-control" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label>Profile Picture URL</label>
                        <input type="text" name="profilePicture" class="form-control">
                    </div>
                    
                    <hr style="margin: 30px 0; border-color: #e0e0e0;">
                    
                    <h3 style="color: #2e7d32; margin-bottom: 20px;">
                        <i class="fas fa-building"></i> Company Information
                    </h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label>Company Name</label>
                            <input type="text" name="companyName" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Tax Code</label>
                            <input type="text" name="taxCode" class="form-control" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label>Company Description</label>
                        <textarea name="companyDescription" class="form-control" rows="4" required></textarea>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label>Logo URL</label>
                            <input type="text" name="logo" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>Website</label>
                            <input type="url" name="website" class="form-control">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label>Company Address</label>
                        <input type="text" name="companyAddress" class="form-control" required>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label>Company Size</label>
                            <select name="companySize" class="form-control" required>
                                <option value="">Select Size</option>
                                <option value="1-10">1-10 employees</option>
                                <option value="11-50">11-50 employees</option>
                                <option value="51-200">51-200 employees</option>
                                <option value="201-500">201-500 employees</option>
                                <option value="500+">500+ employees</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Industry</label>
                            <input type="text" name="industry" class="form-control" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label>Loyalty Score</label>
                            <input type="number" name="loyaltyScore" value="0" step="0.1" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>Verification Status</label>
                            <select name="verificationStatus" class="form-control" required>
                                <option value="pending">Pending</option>
                                <option value="verified">Verified</option>
                                <option value="rejected">Rejected</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label>Created At</label>
                            <input type="date" name="createdAt" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Updated At</label>
                            <input type="date" name="updatedAt" class="form-control" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="checkbox-label">
                            <input type="checkbox" name="isActive" value="true" checked>
                            <span>Active Account</span>
                        </label>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" name="submit" value="Add" class="btn btn-primary">
                            <i class="fas fa-save"></i>
                            Add Recruiter
                        </button>
                        <a href="AdminController?target=Recruiter" class="btn btn-secondary">
                            <i class="fas fa-times"></i>
                            Cancel
                        </a>
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
        
        .radio-group,
        .checkbox-label {
            display: flex;
            gap: 20px;
            align-items: center;
            margin-top: 10px;
        }
        
        .radio-label,
        .checkbox-label {
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