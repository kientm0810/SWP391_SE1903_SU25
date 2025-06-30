<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Seeker Details - Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <jsp:include page="admin-common-styles.jsp" />
    <style>
        .profile-header {
            display: flex;
            align-items: center;
            gap: 30px;
            margin-bottom: 30px;
        }
        
        .profile-picture {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid #e0e0e0;
        }
        
        .profile-info h2 {
            color: #2e7d32;
            margin-bottom: 10px;
        }
        
        .profile-info p {
            color: #666;
            margin-bottom: 5px;
        }
        
        .section-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 25px;
            margin-bottom: 20px;
        }
        
        .section-title {
            color: #2e7d32;
            font-size: 20px;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e8f5e9;
        }
        
        .skills-list {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }
        
        .skill-tag {
            background-color: #e8f5e9;
            color: #2e7d32;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 14px;
        }
        
        .cv-download {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background-color: #4caf50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        
        .cv-download:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <!-- Include Sidebar -->
        <jsp:include page="sidebar.jsp" />
        
        <!-- Main Content -->
        <div class="main-content">
            <!-- Page Header -->
            <div class="page-header">
                <h1>Job Seeker Details</h1>
                <div class="header-actions">
                    <a href="AdminController?target=JobSeeker" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>
                        Back to List
                    </a>
                    <a href="AdminController?target=JobSeeker&service=Update&ID=${JobSeeker.id}" 
                       class="btn btn-primary">
                        <i class="fas fa-edit"></i>
                        Edit
                    </a>
                </div>
            </div>
            
            <!-- Profile Header -->
            <div class="section-card">
                <div class="profile-header">
                    <img src="${JobSeeker.profilePicture != null ? JobSeeker.profilePicture : 'https://via.placeholder.com/150'}" 
                         alt="Profile Picture" class="profile-picture">
                    <div class="profile-info">
                        <h2>${JobSeeker.fullName}</h2>
                        <p><i class="fas fa-envelope"></i> ${JobSeeker.email}</p>
                        <p><i class="fas fa-phone"></i> ${JobSeeker.phone}</p>
                        <p><i class="fas fa-birthday-cake"></i> ${JobSeeker.dateOfBirth}</p>
                        <p>
                            <c:choose>
                                <c:when test="${JobSeeker.active}">
                                    <span class="status-badge status-active">Active Account</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge status-inactive">Inactive Account</span>
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>
            </div>
            
            <!-- Basic Information -->
            <div class="section-card">
                <h3 class="section-title">Basic Information</h3>
                <div class="detail-row">
                    <div class="detail-label">Username:</div>
                    <div class="detail-value">${JobSeeker.username}</div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Gender:</div>
                    <div class="detail-value">${JobSeeker.gender}</div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Address:</div>
                    <div class="detail-value">${JobSeeker.address}</div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Languages:</div>
                    <div class="detail-value">${JobSeeker.languages}</div>
                </div>
            </div>
            
            <!-- Professional Information -->
            <div class="section-card">
                <h3 class="section-title">Professional Information</h3>
                <div class="detail-row">
                    <div class="detail-label">Experience Years:</div>
                    <div class="detail-value">${JobSeeker.experienceYears} years</div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Education:</div>
                    <div class="detail-value">${JobSeeker.education}</div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Desired Job Title:</div>
                    <div class="detail-value">${JobSeeker.desiredJobTitle}</div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Desired Salary:</div>
                    <div class="detail-value">$${JobSeeker.desiredSalary}</div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Job Category:</div>
                    <div class="detail-value">${JobSeeker.jobCategory}</div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Preferred Location:</div>
                    <div class="detail-value">${JobSeeker.preferredLocation}</div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Career Level:</div>
                    <div class="detail-value">${JobSeeker.careerLevel}</div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Work Type:</div>
                    <div class="detail-value">${JobSeeker.workType}</div>
                </div>
            </div>
            
            <!-- Skills -->
            <div class="section-card">
                <h3 class="section-title">Skills</h3>
                <div class="skills-list">
                    <c:forEach var="skill" items="${JobSeeker.skills.split(',')}">
                        <span class="skill-tag">${skill.trim()}</span>
                    </c:forEach>
                </div>
            </div>
            
            <!-- Profile Summary -->
            <div class="section-card">
                <h3 class="section-title">Profile Summary</h3>
                <p>${JobSeeker.profileSummary}</p>
            </div>
            
            <!-- Additional Information -->
            <div class="section-card">
                <h3 class="section-title">Additional Information</h3>
                <div class="detail-row">
                    <div class="detail-label">Portfolio URL:</div>
                    <div class="detail-value">
                        <a href="${JobSeeker.portfolioUrl}" target="_blank">${JobSeeker.portfolioUrl}</a>
                    </div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">CV File:</div>
                    <div class="detail-value">
                        <c:if test="${JobSeeker.cvFile != null}">
                            <a href="${JobSeeker.cvFile}" class="cv-download" target="_blank">
                                <i class="fas fa-download"></i>
                                Download CV
                            </a>
                        </c:if>
                    </div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Account Created:</div>
                    <div class="detail-value">${JobSeeker.createdAt}</div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Last Updated:</div>
                    <div class="detail-value">${JobSeeker.updatedAt}</div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>