package controllers;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import daos.AwardDAO;
import daos.CVTemplateDAO;
import daos.CertificateDAO;
import daos.EducationDAO;
import daos.ExperienceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Award;
import models.CVTemplate;
import models.Certificate;
import models.Education;
import models.Experience;
import models.JobSeeker;
@WebServlet(name = "ProfileController", urlPatterns = {"/profile"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1MB
    maxFileSize = 1024 * 1024 * 5,    // 5MB
    maxRequestSize = 1024 * 1024 * 10 // 10MB
)
public class ProfileController extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(ProfileController.class.getName());
    private static final int PAGE_SIZE = 5; // Number of CVs per page
    
    private CVTemplateDAO cvDAO;
    private ExperienceDAO experienceDAO;
    private CertificateDAO certificateDAO;
    private EducationDAO educationDAO;
    private AwardDAO awardDAO;
    
    @Override
    public void init() throws ServletException {
        cvDAO = new CVTemplateDAO();
        experienceDAO = new ExperienceDAO();
        certificateDAO = new CertificateDAO();
        educationDAO = new EducationDAO();
        awardDAO = new AwardDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
            response.sendRedirect("login");
            return;
        }
        
        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
        
        try {
            // Calculate pagination (remove getTotalCVCount)
            List<CVTemplate> cvTemplates = cvDAO.getCVsByJobSeeker(jobSeeker.getId());
            int totalCVs = cvTemplates.size();
            int currentPage = 1;
            int totalPages = 1;
            int startIndex = 0;
            int endIndex = totalCVs;
            
            // Get profile sections data
            List<Experience> experiences = experienceDAO.getExperiencesByJobSeeker(jobSeeker.getId());
            List<Certificate> certificates = certificateDAO.getCertificatesByJobSeeker(jobSeeker.getId());
            List<Education> educations = educationDAO.getEducationsByJobSeeker(jobSeeker.getId());
            List<Award> awards = awardDAO.getAwardsByJobSeeker(jobSeeker.getId());
            
            // Set attributes for JSP
            request.setAttribute("cvTemplates", cvTemplates);
            request.setAttribute("cvList", cvTemplates); // Fix: provide cvList for JSP
            request.setAttribute("experiences", experiences);
            request.setAttribute("certificates", certificates);
            request.setAttribute("educations", educations);
            request.setAttribute("awards", awards);
            
            // Pagination attributes
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalCVs", totalCVs);
            request.setAttribute("startIndex", startIndex + 1);
            request.setAttribute("endIndex", endIndex);
            
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error loading profile data", e);
            request.setAttribute("errorMessage", "Lỗi hệ thống khi tải thông tin hồ sơ!");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        switch (action != null ? action : "") {
            case "delete":
                handleDeleteCV(request, response);
                break;
            case "deleteExperience":
                handleDeleteExperience(request, response);
                break;
            case "deleteCertificate":
                handleDeleteCertificate(request, response);
                break;
            case "deleteEducation":
                handleDeleteEducation(request, response);
                break;
            case "deleteAward":
                handleDeleteAward(request, response);
                break;
            case "addExperience":
                handleAddExperience(request, response);
                break;
            case "addCertificate":
                handleAddCertificate(request, response);
                break;
            case "addEducation":
                handleAddEducation(request, response);
                break;
            case "addAward":
                handleAddAward(request, response);
                break;
            case "editExperience":
                handleEditExperience(request, response);
                break;
            case "editCertificate":
                handleEditCertificate(request, response);
                break;
            case "editEducation":
                handleEditEducation(request, response);
                break;
            case "editAward":
                handleEditAward(request, response);
                break;
            case "editContact":
                handleEditContact(request, response);
                break;
            default:
                response.sendRedirect("profile");
                break;
        }
    }
    
    private void handleDeleteCV(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
            response.sendRedirect("login");
            return;
        }

        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
        
        try {
            String cvIdStr = request.getParameter("cvId");
            if (cvIdStr != null && !cvIdStr.trim().isEmpty()) {
                int cvId = Integer.parseInt(cvIdStr);
                
                // Verify that the CV belongs to the current user
                CVTemplate cv = cvDAO.getCVById(cvId, jobSeeker.getId());
                if (cv != null && cv.getJobSeekerId() == jobSeeker.getId()) {
                    boolean deleted = cvDAO.deleteCV(cvId, jobSeeker.getId());
                    
                    if (deleted) {
                        session.setAttribute("successMessage", "CV đã được xóa thành công!");
                    } else {
                        session.setAttribute("errorMessage", "Không thể xóa CV. Vui lòng thử lại!");
                    }
                } else {
                    session.setAttribute("errorMessage", "CV không tồn tại hoặc bạn không có quyền xóa!");
                }
            }
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid CV ID format: " + request.getParameter("cvId"));
            session.setAttribute("errorMessage", "ID CV không hợp lệ!");
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting CV", e);
            session.setAttribute("errorMessage", "Lỗi hệ thống khi xóa CV!");
        }
        
        response.sendRedirect("profile");
    }
    
    private void handleDeleteExperience(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
            response.sendRedirect("login");
            return;
        }

        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
        
        try {
            String experienceIdStr = request.getParameter("experienceId");
            if (experienceIdStr != null && !experienceIdStr.trim().isEmpty()) {
                int experienceId = Integer.parseInt(experienceIdStr);
                
                boolean deleted = experienceDAO.deleteExperience(experienceId);
                
                if (deleted) {
                    session.setAttribute("successMessage", "Kinh nghiệm làm việc đã được xóa thành công!");
                } else {
                    session.setAttribute("errorMessage", "Không thể xóa kinh nghiệm làm việc. Vui lòng thử lại!");
                }
            }
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid Experience ID format: " + request.getParameter("experienceId"));
            session.setAttribute("errorMessage", "ID kinh nghiệm không hợp lệ!");
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting experience", e);
            session.setAttribute("errorMessage", "Lỗi hệ thống khi xóa kinh nghiệm làm việc!");
        }
        
        response.sendRedirect("profile");
    }
    
    private void handleDeleteCertificate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
            response.sendRedirect("login");
            return;
        }

        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
        
        try {
            String certificateIdStr = request.getParameter("certificateId");
            if (certificateIdStr != null && !certificateIdStr.trim().isEmpty()) {
                int certificateId = Integer.parseInt(certificateIdStr);
                
                boolean deleted = certificateDAO.deleteCertificate(certificateId);
                
                if (deleted) {
                    session.setAttribute("successMessage", "Chứng chỉ đã được xóa thành công!");
                } else {
                    session.setAttribute("errorMessage", "Không thể xóa chứng chỉ. Vui lòng thử lại!");
                }
            }
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid Certificate ID format: " + request.getParameter("certificateId"));
            session.setAttribute("errorMessage", "ID chứng chỉ không hợp lệ!");
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting certificate", e);
            session.setAttribute("errorMessage", "Lỗi hệ thống khi xóa chứng chỉ!");
        }
        
        response.sendRedirect("profile");
    }
    
    private void handleDeleteEducation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
            response.sendRedirect("login");
            return;
        }

        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
        
        try {
            String educationIdStr = request.getParameter("educationId");
            if (educationIdStr != null && !educationIdStr.trim().isEmpty()) {
                int educationId = Integer.parseInt(educationIdStr);
                
                boolean deleted = educationDAO.deleteEducation(educationId);
                
                if (deleted) {
                    session.setAttribute("successMessage", "Học vấn đã được xóa thành công!");
                } else {
                    session.setAttribute("errorMessage", "Không thể xóa học vấn. Vui lòng thử lại!");
                }
            }
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid Education ID format: " + request.getParameter("educationId"));
            session.setAttribute("errorMessage", "ID học vấn không hợp lệ!");
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting education", e);
            session.setAttribute("errorMessage", "Lỗi hệ thống khi xóa học vấn!");
        }
        
        response.sendRedirect("profile");
    }
    
    private void handleDeleteAward(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
            response.sendRedirect("login");
            return;
        }

        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
        
        try {
            String awardIdStr = request.getParameter("awardId");
            if (awardIdStr != null && !awardIdStr.trim().isEmpty()) {
                int awardId = Integer.parseInt(awardIdStr);
                
                boolean deleted = awardDAO.deleteAward(awardId);
                
                if (deleted) {
                    session.setAttribute("successMessage", "Giải thưởng đã được xóa thành công!");
                } else {
                    session.setAttribute("errorMessage", "Không thể xóa giải thưởng. Vui lòng thử lại!");
                }
            }
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid Award ID format: " + request.getParameter("awardId"));
            session.setAttribute("errorMessage", "ID giải thưởng không hợp lệ!");
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting award", e);
            session.setAttribute("errorMessage", "Lỗi hệ thống khi xóa giải thưởng!");
        }
        
        response.sendRedirect("profile");
    }
    
    private void handleAddExperience(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
            response.sendRedirect("login");
            return;
        }

        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
        
        try {
            String position = request.getParameter("position");
            String company = request.getParameter("company");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String skillsUsed = request.getParameter("skillsUsed");
            String achievements = request.getParameter("achievements");
            boolean isCurrent = "true".equals(request.getParameter("isCurrent"));
            
            if (position == null || company == null || startDateStr == null || 
                position.trim().isEmpty() || company.trim().isEmpty()) {
                session.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin bắt buộc!");
                response.sendRedirect("profile");
                return;
            }
            
            Experience experience = new Experience();
            experience.setJobSeekerId(jobSeeker.getId());
            experience.setPosition(position.trim());
            experience.setCompanyName(company.trim());
            experience.setStartDate(Date.valueOf(startDateStr));
            
            if (!isCurrent && endDateStr != null && !endDateStr.trim().isEmpty()) {
                experience.setEndDate(Date.valueOf(endDateStr));
            }
            
            experience.setSkillsUsed(skillsUsed != null ? skillsUsed.trim() : "");
            experience.setAchievements(achievements != null ? achievements.trim() : "");
            experience.setCurrent(isCurrent);
            
            boolean added = experienceDAO.addExperience(experience);
            
            if (added) {
                session.setAttribute("successMessage", "Kinh nghiệm làm việc đã được thêm thành công!");
            } else {
                session.setAttribute("errorMessage", "Không thể thêm kinh nghiệm làm việc. Vui lòng thử lại!");
            }
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error adding experience", e);
            session.setAttribute("errorMessage", "Lỗi hệ thống khi thêm kinh nghiệm làm việc!");
        }
        
        response.sendRedirect("profile");
    }
    
    private void handleAddCertificate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
            response.sendRedirect("login");
            return;
        }

        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
        
        try {
            String name = request.getParameter("name");
            String organization = request.getParameter("organization");
            String issueDateStr = request.getParameter("issueDate");
            String expiryDateStr = request.getParameter("expiryDate");
            String credentialId = request.getParameter("credentialId");
            String credentialUrl = request.getParameter("credentialUrl");
            boolean noExpiry = "true".equals(request.getParameter("noExpiry"));
            String description = request.getParameter("description");
            
            if (name == null || organization == null || issueDateStr == null || 
                name.trim().isEmpty() || organization.trim().isEmpty()) {
                session.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin bắt buộc!");
                response.sendRedirect("profile");
                return;
            }
            
            Certificate certificate = new Certificate();
            certificate.setJobSeekerId(jobSeeker.getId());
            certificate.setCertificateName(name.trim());
            certificate.setIssuingOrganization(organization.trim());
            certificate.setIssueDate(Date.valueOf(issueDateStr));
            
            if (!noExpiry && expiryDateStr != null && !expiryDateStr.trim().isEmpty()) {
                certificate.setExpiryDate(Date.valueOf(expiryDateStr));
            }
            
            certificate.setCredentialId(credentialId != null ? credentialId.trim() : "");
            certificate.setCredentialUrl(credentialUrl != null ? credentialUrl.trim() : "");
            certificate.setDescription(description != null ? description.trim() : "");
            certificate.setImagePath(""); // Handle file upload separately if needed
            
            boolean added = certificateDAO.addCertificate(certificate);
            
            if (added) {
                session.setAttribute("successMessage", "Chứng chỉ đã được thêm thành công!");
            } else {
                session.setAttribute("errorMessage", "Không thể thêm chứng chỉ. Vui lòng thử lại!");
            }
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error adding certificate", e);
            session.setAttribute("errorMessage", "Lỗi hệ thống khi thêm chứng chỉ!");
        }
        
        response.sendRedirect("profile");
    }
    
    private void handleAddEducation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
            response.sendRedirect("login");
            return;
        }

        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
        
        try {
            String degree = request.getParameter("degree");
            String fieldOfStudy = request.getParameter("fieldOfStudy");
            String institution = request.getParameter("institution");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String gpaStr = request.getParameter("gpa");
            String activities = request.getParameter("activities");
            boolean isCurrent = "true".equals(request.getParameter("isCurrent"));
            
            if (degree == null || fieldOfStudy == null || institution == null || startDateStr == null ||
                degree.trim().isEmpty() || fieldOfStudy.trim().isEmpty() || institution.trim().isEmpty()) {
                session.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin bắt buộc!");
                response.sendRedirect("profile");
                return;
            }
            
            Education education = new Education();
            education.setJobSeekerId(jobSeeker.getId());
            education.setDegree(degree.trim());
            education.setFieldOfStudy(fieldOfStudy.trim());
            education.setInstitutionName(institution.trim());
            education.setStartDate(Date.valueOf(startDateStr));
            
            if (!isCurrent && endDateStr != null && !endDateStr.trim().isEmpty()) {
                education.setEndDate(Date.valueOf(endDateStr));
            }
            
            if (gpaStr != null && !gpaStr.trim().isEmpty()) {
                education.setGpa(new java.math.BigDecimal(gpaStr));
            }
            
            education.setActivities(activities != null ? activities.trim() : "");
            education.setCurrent(isCurrent);
            
            boolean added = educationDAO.addEducation(education);
            
            if (added) {
                session.setAttribute("successMessage", "Học vấn đã được thêm thành công!");
            } else {
                session.setAttribute("errorMessage", "Không thể thêm học vấn. Vui lòng thử lại!");
            }
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error adding education", e);
            session.setAttribute("errorMessage", "Lỗi hệ thống khi thêm học vấn!");
        }
        
        response.sendRedirect("profile");
    }
    
    private void handleAddAward(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
            response.sendRedirect("login");
            return;
        }

        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
        
        try {
            String name = request.getParameter("name");
            String organization = request.getParameter("organization");
            String awardDateStr = request.getParameter("awardDate");
            String level = request.getParameter("level");
            String rank = request.getParameter("rank");
            String category = request.getParameter("category");
            String description = request.getParameter("description");
            
            if (name == null || organization == null || awardDateStr == null ||
                name.trim().isEmpty() || organization.trim().isEmpty()) {
                session.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin bắt buộc!");
                response.sendRedirect("profile");
                return;
            }
            
            Award award = new Award();
            award.setJobSeekerId(jobSeeker.getId());
            award.setAwardName(name.trim());
            award.setIssuingOrganization(organization.trim());
            award.setDateReceived(Date.valueOf(awardDateStr));
            award.setDescription(description != null ? description.trim() : "");
            
            boolean added = awardDAO.addAward(award);
            
            if (added) {
                session.setAttribute("successMessage", "Giải thưởng đã được thêm thành công!");
            } else {
                session.setAttribute("errorMessage", "Không thể thêm giải thưởng. Vui lòng thử lại!");
            }
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error adding award", e);
            session.setAttribute("errorMessage", "Lỗi hệ thống khi thêm giải thưởng!");
        }
        
        response.sendRedirect("profile");
    }

    private void handleEditExperience(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
            response.sendRedirect("login");
            return;
        }
        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
        try {
            int experienceId = Integer.parseInt(request.getParameter("experienceId"));
            String position = request.getParameter("position");
            String company = request.getParameter("company");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String skillsUsed = request.getParameter("skillsUsed");
            String achievements = request.getParameter("achievements");
            boolean isCurrent = "true".equals(request.getParameter("isCurrent"));
            if (position == null || company == null || startDateStr == null || position.trim().isEmpty() || company.trim().isEmpty()) {
                session.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin bắt buộc!");
                response.sendRedirect("profile");
                return;
            }
            Experience experience = experienceDAO.getExperienceById(experienceId);
            if (experience == null || experience.getJobSeekerId() != jobSeeker.getId()) {
                session.setAttribute("errorMessage", "Không tìm thấy kinh nghiệm hoặc bạn không có quyền sửa!");
                response.sendRedirect("profile");
                return;
            }
            experience.setPosition(position.trim());
            experience.setCompanyName(company.trim());
            experience.setStartDate(Date.valueOf(startDateStr));
            if (!isCurrent && endDateStr != null && !endDateStr.trim().isEmpty()) {
                experience.setEndDate(Date.valueOf(endDateStr));
            } else {
                experience.setEndDate(null);
            }
            experience.setSkillsUsed(skillsUsed != null ? skillsUsed.trim() : "");
            experience.setAchievements(achievements != null ? achievements.trim() : "");
            experience.setCurrent(isCurrent);
            boolean updated = experienceDAO.updateExperience(experience);
            if (updated) {
                session.setAttribute("successMessage", "Kinh nghiệm làm việc đã được cập nhật thành công!");
            } else {
                session.setAttribute("errorMessage", "Không thể cập nhật kinh nghiệm làm việc. Vui lòng thử lại!");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error editing experience", e);
            session.setAttribute("errorMessage", "Lỗi hệ thống khi cập nhật kinh nghiệm làm việc!");
        }
        response.sendRedirect("profile");
    }

    private void handleEditCertificate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
            response.sendRedirect("login");
            return;
        }
        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
        try {
            int certificateId = Integer.parseInt(request.getParameter("certificateId"));
            String name = request.getParameter("name");
            String organization = request.getParameter("organization");
            String issueDateStr = request.getParameter("issueDate");
            String credentialId = request.getParameter("credentialId");
            String credentialUrl = request.getParameter("credentialUrl");
            String description = request.getParameter("description");
            if (name == null || organization == null || issueDateStr == null || name.trim().isEmpty() || organization.trim().isEmpty()) {
                session.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin bắt buộc!");
                response.sendRedirect("profile");
                return;
            }
            Certificate certificate = certificateDAO.getCertificateById(certificateId);
            if (certificate == null || certificate.getJobSeekerId() != jobSeeker.getId()) {
                session.setAttribute("errorMessage", "Không tìm thấy chứng chỉ hoặc bạn không có quyền sửa!");
                response.sendRedirect("profile");
                return;
            }
            certificate.setCertificateName(name.trim());
            certificate.setIssuingOrganization(organization.trim());
            certificate.setIssueDate(Date.valueOf(issueDateStr));
            certificate.setCredentialId(credentialId != null ? credentialId.trim() : "");
            certificate.setCredentialUrl(credentialUrl != null ? credentialUrl.trim() : "");
            certificate.setDescription(description != null ? description.trim() : "");
            boolean updated = certificateDAO.updateCertificate(certificate);
            if (updated) {
                session.setAttribute("successMessage", "Chứng chỉ đã được cập nhật thành công!");
            } else {
                session.setAttribute("errorMessage", "Không thể cập nhật chứng chỉ. Vui lòng thử lại!");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error editing certificate", e);
            session.setAttribute("errorMessage", "Lỗi hệ thống khi cập nhật chứng chỉ!");
        }
        response.sendRedirect("profile");
    }

    private void handleEditEducation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
            response.sendRedirect("login");
            return;
        }
        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
        try {
            int educationId = Integer.parseInt(request.getParameter("educationId"));
            String degree = request.getParameter("degree");
            String fieldOfStudy = request.getParameter("fieldOfStudy");
            String institution = request.getParameter("institution");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String activities = request.getParameter("activities");
            boolean isCurrent = "true".equals(request.getParameter("isCurrent"));
            if (degree == null || fieldOfStudy == null || institution == null || startDateStr == null || degree.trim().isEmpty() || fieldOfStudy.trim().isEmpty() || institution.trim().isEmpty()) {
                session.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin bắt buộc!");
                response.sendRedirect("profile");
                return;
            }
            Education education = educationDAO.getEducationById(educationId);
            if (education == null || education.getJobSeekerId() != jobSeeker.getId()) {
                session.setAttribute("errorMessage", "Không tìm thấy học vấn hoặc bạn không có quyền sửa!");
                response.sendRedirect("profile");
                return;
            }
            education.setDegree(degree.trim());
            education.setFieldOfStudy(fieldOfStudy.trim());
            education.setInstitutionName(institution.trim());
            education.setStartDate(Date.valueOf(startDateStr));
            if (!isCurrent && endDateStr != null && !endDateStr.trim().isEmpty()) {
                education.setEndDate(Date.valueOf(endDateStr));
            } else {
                education.setEndDate(null);
            }
            education.setActivities(activities != null ? activities.trim() : "");
            education.setCurrent(isCurrent);
            boolean updated = educationDAO.updateEducation(education);
            if (updated) {
                session.setAttribute("successMessage", "Học vấn đã được cập nhật thành công!");
            } else {
                session.setAttribute("errorMessage", "Không thể cập nhật học vấn. Vui lòng thử lại!");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error editing education", e);
            session.setAttribute("errorMessage", "Lỗi hệ thống khi cập nhật học vấn!");
        }
        response.sendRedirect("profile");
    }

    private void handleEditAward(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
            response.sendRedirect("login");
            return;
        }
        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
        try {
            int awardId = Integer.parseInt(request.getParameter("awardId"));
            String name = request.getParameter("name");
            String organization = request.getParameter("organization");
            String issueDateStr = request.getParameter("issueDate");
            String description = request.getParameter("description");
            if (name == null || organization == null || issueDateStr == null || name.trim().isEmpty() || organization.trim().isEmpty()) {
                session.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin bắt buộc!");
                response.sendRedirect("profile");
                return;
            }
            Award award = awardDAO.getAwardById(awardId);
            if (award == null || award.getJobSeekerId() != jobSeeker.getId()) {
                session.setAttribute("errorMessage", "Không tìm thấy giải thưởng hoặc bạn không có quyền sửa!");
                response.sendRedirect("profile");
                return;
            }
            award.setAwardName(name.trim());
            award.setIssuingOrganization(organization.trim());
            award.setDateReceived(Date.valueOf(issueDateStr));
            award.setDescription(description != null ? description.trim() : "");
            boolean updated = awardDAO.updateAward(award);
            if (updated) {
                session.setAttribute("successMessage", "Giải thưởng đã được cập nhật thành công!");
            } else {
                session.setAttribute("errorMessage", "Không thể cập nhật giải thưởng. Vui lòng thử lại!");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error editing award", e);
            session.setAttribute("errorMessage", "Lỗi hệ thống khi cập nhật giải thưởng!");
        }
        response.sendRedirect("profile");
    }

    private void handleEditContact(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
            response.sendRedirect("login");
            return;
        }

        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        try {
            boolean changed = false;
            if (fullName != null && !fullName.trim().isEmpty()) {
                jobSeeker.setFullName(fullName.trim());
                changed = true;
            }
            if (email != null && !email.trim().isEmpty()) {
                jobSeeker.setEmail(email.trim());
                changed = true;
            }
            if (phone != null) {
                jobSeeker.setPhone(phone.trim());
                changed = true;
            }
            if (address != null) {
                jobSeeker.setAddress(address.trim());
                changed = true;
            }
            if (changed) {
                // Persist changes (assume JobSeekerDAO exists)
                daos.JobSeekerDAO jobSeekerDAO = new daos.JobSeekerDAO();
                boolean updated = jobSeekerDAO.updateContactInfo(jobSeeker);
                if (updated) {
                    session.setAttribute("user", jobSeeker); // update session
                    session.setAttribute("successMessage", "Contact information updated successfully!");
                } else {
                    session.setAttribute("errorMessage", "Failed to update contact information. Please try again!");
                }
            } else {
                session.setAttribute("errorMessage", "No changes detected in contact information.");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error updating contact info", e);
            session.setAttribute("errorMessage", "System error while updating contact information!");
        }
        response.sendRedirect("profile");
    }
} 