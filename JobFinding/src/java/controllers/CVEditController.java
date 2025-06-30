package controllers;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

import daos.CVTemplateDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import models.CVTemplate;
import models.JobSeeker;

@WebServlet(name = "CVEditController", urlPatterns = {"/cv-edit"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class CVEditController extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(CVEditController.class.getName());
    private static final String UPLOAD_DIR = "uploads/cvs";
    private static final long MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB
    
    private CVTemplateDAO cvDAO;
    
    @Override
    public void init() throws ServletException {
        cvDAO = new CVTemplateDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
            response.sendRedirect("login");
            return;
        }

        try {
            int cvId = Integer.parseInt(request.getParameter("id"));
            JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
            
            CVTemplate cv = cvDAO.getCVById(cvId, jobSeeker.getId());
            if (cv == null) {
                session.setAttribute("errorMessage", "Không tìm thấy CV!");
                response.sendRedirect("profile");
                return;
            }
            
            request.setAttribute("cv", cv);
            request.getRequestDispatcher("cv_edit.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "ID CV không hợp lệ!");
            response.sendRedirect("profile");
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching CV for edit", e);
            session.setAttribute("errorMessage", "Lỗi hệ thống khi tải CV!");
            response.sendRedirect("profile");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
            response.sendRedirect("login");
            return;
        }

        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");

        try {
            // Get CV ID
            int cvId = Integer.parseInt(request.getParameter("cvId"));
            
            // Get form parameters
            String fullName = request.getParameter("fullName");
            String jobPosition = request.getParameter("jobPosition");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String education = request.getParameter("education");
            String experienceYears = request.getParameter("experienceYears");
            String skills = request.getParameter("skills");
            String workExperience = request.getParameter("workExperience");

            // Combine education, experience years, and skills into certificates field
            StringBuilder certificates = new StringBuilder();
            if (education != null && !education.trim().isEmpty()) {
                certificates.append("Học vấn: ").append(education);
            }
            if (experienceYears != null && !experienceYears.trim().isEmpty()) {
                if (certificates.length() > 0) certificates.append(" | ");
                certificates.append("Kinh nghiệm: ").append(experienceYears).append(" năm");
            }
            if (skills != null && !skills.trim().isEmpty()) {
                if (certificates.length() > 0) certificates.append(" | ");
                certificates.append("Kỹ năng: ").append(skills);
            }

            // Validate required fields
            if (isInvalidInput(fullName, jobPosition, phone, email)) {
                session.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin bắt buộc!");
                response.sendRedirect("cv-edit?id=" + cvId);
                return;
            }

            // Get existing CV
            CVTemplate existingCV = cvDAO.getCVById(cvId, jobSeeker.getId());
            if (existingCV == null) {
                session.setAttribute("errorMessage", "Không tìm thấy CV!");
                response.sendRedirect("profile");
                return;
            }

            // Handle file upload (optional for update)
            Part filePart = request.getPart("pdfFile");
            String fileName = existingCV.getPdfFilePath(); // Keep existing file by default
            
            if (filePart != null && filePart.getSize() > 0) {
                String newFileName = handleFileUpload(filePart);
                if (newFileName != null) {
                    fileName = newFileName;
                    // TODO: Delete old file if needed
                }
            }

            // Update CV object
            existingCV.setFullName(fullName);
            existingCV.setJobPosition(jobPosition);
            existingCV.setPhone(phone);
            existingCV.setEmail(email);
            existingCV.setAddress(address);
            existingCV.setCertificates(certificates.toString());
            existingCV.setWorkExperience(workExperience);
            existingCV.setPdfFilePath(fileName);

            // Save to database
            boolean success = cvDAO.updateCV(existingCV);
            
            if (success) {
                session.setAttribute("successMessage", "CV đã được cập nhật thành công!");
                response.sendRedirect("profile");
            } else {
                session.setAttribute("errorMessage", "Không thể cập nhật CV. Vui lòng thử lại!");
                response.sendRedirect("cv-edit?id=" + cvId);
            }

        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "ID CV không hợp lệ!");
            response.sendRedirect("profile");
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating CV", e);
            session.setAttribute("errorMessage", "Lỗi hệ thống khi cập nhật CV!");
            response.sendRedirect("profile");
        }
    }

    private boolean isInvalidInput(String fullName, String jobPosition, String phone, String email) {
        return fullName == null || fullName.trim().isEmpty() ||
               jobPosition == null || jobPosition.trim().isEmpty() ||
               phone == null || phone.trim().isEmpty() ||
               email == null || email.trim().isEmpty();
    }

    private String handleFileUpload(Part filePart) {
        try {
            String fileName = getSubmittedFileName(filePart);
            
            if (!fileName.toLowerCase().endsWith(".pdf")) {
                LOGGER.log(Level.WARNING, "Invalid file type: " + fileName);
                return null;
            }

            if (filePart.getSize() > MAX_FILE_SIZE) {
                LOGGER.log(Level.WARNING, "File size too large: " + filePart.getSize());
                return null;
            }

            String fileExtension = fileName.substring(fileName.lastIndexOf('.'));
            String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

            String realPath = getServletContext().getRealPath("/");
            Path uploadPath = Paths.get(realPath, UPLOAD_DIR);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }
            Path filePath = uploadPath.resolve(uniqueFileName);

            filePart.write(filePath.toString());

            LOGGER.log(Level.INFO, "File uploaded successfully: " + uniqueFileName);
            return UPLOAD_DIR + "/" + uniqueFileName;

        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error uploading file", e);
            return null;
        }
    }

    private String getSubmittedFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String content : contentDisposition.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
} 