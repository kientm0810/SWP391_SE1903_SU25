<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title><c:choose><c:when test="${not empty job}">Edit Job</c:when><c:otherwise>Update Post</c:otherwise></c:choose></title>
        <style>
            :root {
                --primary-color: #1A73E8;
                --primary-hover: #0d5bba;
                --secondary-color: #5F6368;
                --light-gray: #F5F7FA;
                --border-color: #DADCE0;
                --white: #FFFFFF;
                --box-shadow: 0 1px 2px 0 rgba(60,64,67,0.3), 0 2px 6px 2px rgba(60,64,67,0.15);
            }
            
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }
            
            body {
                font-family: 'Google Sans', 'Segoe UI', Roboto, Arial, sans-serif;
                line-height: 1.5;
                color: #202124;
                background-color: var(--light-gray);
                padding: 0;
                margin: 0;
            }
            
            .container {
                max-width: 900px;
                margin: 40px auto;
                padding: 0 20px;
            }
            
            .topcv-header {
                background-color: var(--white);
                box-shadow: 0 1px 2px 0 rgba(0,0,0,0.1);
                padding: 15px 0;
                margin-bottom: 30px;
            }
            
            .topcv-logo {
                color: var(--primary-color);
                font-size: 24px;
                font-weight: 500;
                text-align: center;
            }
            
            h2 {
                color: var(--primary-color);
                margin-bottom: 25px;
                font-weight: 500;
                font-size: 24px;
                text-align: center;
            }
            
            .job-form {
                background: var(--white);
                padding: 40px;
                border-radius: 8px;
                box-shadow: var(--box-shadow);
                margin-bottom: 40px;
            }
            
            .form-group {
                margin-bottom: 25px;
            }
            
            label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
                color: var(--secondary-color);
                font-size: 14px;
            }
            
            input[type="text"],
            input[type="number"],
            input[type="date"],
            select,
            textarea {
                width: 100%;
                padding: 12px 16px;
                border: 1px solid var(--border-color);
                border-radius: 4px;
                font-size: 14px;
                transition: all 0.3s;
                background-color: var(--white);
            }
            
            input[type="text"]:focus,
            input[type="number"]:focus,
            input[type="date"]:focus,
            select:focus,
            textarea:focus {
                border-color: var(--primary-color);
                outline: none;
                box-shadow: 0 0 0 2px rgba(26, 115, 232, 0.2);
            }
            
            textarea {
                min-height: 150px;
                resize: vertical;
                line-height: 1.5;
            }
            
            .checkbox-group {
                display: flex;
                align-items: center;
            }
            
            input[type="checkbox"] {
                width: 18px;
                height: 18px;
                margin-left: 10px;
                accent-color: var(--primary-color);
            }
            
            .form-actions {
                display: flex;
                justify-content: flex-end;
                align-items: center;
                margin-top: 30px;
                gap: 15px;
            }
            
            .btn {
                padding: 10px 24px;
                font-size: 14px;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 500;
                transition: all 0.3s;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                height: 40px;
            }
            
            .btn-primary {
                background-color: var(--primary-color);
                color: var(--white);
                border: none;
            }
            
            .btn-primary:hover {
                background-color: var(--primary-hover);
                box-shadow: 0 1px 2px 0 rgba(26,115,232,0.3), 0 1px 3px 1px rgba(26,115,232,0.15);
            }
            
            .btn-outline {
                color: var(--primary-color);
                background: var(--white);
                border: 1px solid var(--primary-color);
            }
            
            .btn-outline:hover {
                background-color: #E8F0FE;
            }
            
            /* Style for select dropdown */
            select {
                appearance: none;
                -webkit-appearance: none;
                -moz-appearance: none;
                background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%235F6368'%3e%3cpath d='M7 10l5 5 5-5z'/%3e%3c/svg%3e");
                background-repeat: no-repeat;
                background-position: right 12px center;
                background-size: 20px;
                padding-right: 40px;
            }
            
            /* Required field indicator */
            .required:after {
                content: " *";
                color: #D93025;
            }
            
            /* Responsive design */
            @media (max-width: 768px) {
                .container {
                    margin: 20px auto;
                    padding: 0 15px;
                }
                
                .job-form {
                    padding: 25px;
                }
                
                .form-actions {
                    flex-direction: column-reverse;
                    gap: 10px;
                }
                
                .btn {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>
        <header class="topcv-header">
            <div class="topcv-logo">Update Post</div>
        </header>
        
        <div class="container">
           
            
            <form method="post" action="job_listing" class="job-form">
                <input type="hidden" name="id" value="${job.id}"/>
                
                <div class="form-group">
                    <label for="title" class="required">Job Title</label>
                    <input type="text" id="title" name="title" value="${job.title}" required placeholder="Enter job title"/>
                </div>
                
                <div class="form-group">
                    <label for="description" class="required">Job Description</label>
                    <textarea id="description" name="description" required placeholder="Describe the job responsibilities and expectations">${job.description}</textarea>
                </div>
                
                <div class="form-group">
                    <label for="requirements">Requirements</label>
                    <textarea id="requirements" name="requirements" placeholder="List the required skills and qualifications">${job.requirements}</textarea>
                </div>
                
                <div class="form-group">
                    <label for="location">Location</label>
                    <input type="text" id="location" name="location" value="${job.location}" placeholder="e.g., Ha Noi, Ho Chi Minh City"/>
                </div>
                
                <div class="form-row" style="display: flex; gap: 20px;">
                    <div class="form-group" style="flex: 1;">
                        <label for="salary_min">Minimum Salary</label>
                        <input type="number" step="0.01" id="salary_min" name="salary_min" value="${job.salaryMin}" placeholder="0.00"/>
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <label for="salary_max">Maximum Salary</label>
                        <input type="number" step="0.01" id="salary_max" name="salary_max" value="${job.salaryMax}" placeholder="0.00"/>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="job_type" class="required">Job Type</label>
                    <select id="job_type" name="job_type" required>
                        <option value="">Select job type</option>
                        <option value="full_time" ${job.jobType == 'full_time' ? 'selected' : ''}>Full Time</option>
                        <option value="part_time" ${job.jobType == 'part_time' ? 'selected' : ''}>Part Time</option>
                        <option value="freelance" ${job.jobType == 'freelance' ? 'selected' : ''}>Freelance</option>
                        <option value="internship" ${job.jobType == 'internship' ? 'selected' : ''}>Internship</option>
                        <option value="contract" ${job.jobType == 'contract' ? 'selected' : ''}>Contract</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="experience_level">Experience Level</label>
                    <input type="text" id="experience_level" name="experience_level" value="${job.experienceLevel}" placeholder="e.g., 2+ years"/>
                </div>
                
                <div class="form-group">
                    <div class="checkbox-group">
                        <label for="is_featured">Featured Job Listing</label>
                        <input type="checkbox" id="is_featured" name="is_featured" <c:if test="${job.isFeatured}">checked</c:if> />
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="status" class="required">Status</label>
                    <select id="status" name="status" required>
                        <option value="">Select status</option>
                        <option value="active" ${job.status == 'active' ? 'selected' : ''}>Active</option>
                        <option value="paused" ${job.status == 'paused' ? 'selected' : ''}>Paused</option>
                        <option value="filled" ${job.status == 'filled' ? 'selected' : ''}>Filled</option>
                        <option value="expired" ${job.status == 'expired' ? 'selected' : ''}>Expired</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="application_deadline">Application Deadline</label>
                    <input type="date" id="application_deadline" name="application_deadline" value="<c:out value='${job.applicationDeadline}'/>"/>
                </div>
                
                <div class="form-actions">
                    <a href="home.jsp" class="btn btn-outline">Cancel</a>
                    <button type="submit" class="btn btn-primary">
                        <c:choose>
                            <c:when test="${not empty job}">Update Job</c:when>
                            <c:otherwise>Create Job</c:otherwise>
                        </c:choose>
                    </button>
                </div>
            </form>
        </div>
    </body>
</html>