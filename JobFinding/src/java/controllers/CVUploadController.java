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

@WebServlet(name = "CVUploadController", urlPatterns = {"/cv-upload"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class CVUploadController extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(CVUploadController.class.getName());
    private static final String UPLOAD_DIR = "uploads/cvs";
    private static final long MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB
    
    private CVTemplateDAO cvDAO;
    
    @Override
    public void init() throws ServletException {
        cvDAO = new CVTemplateDAO();
        
        // Create upload directory if it doesn't exist
        try {
            String realPath = getServletContext().getRealPath("/");
            Path uploadPath = Paths.get(realPath, UPLOAD_DIR);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Failed to create upload directory", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in and is a job seeker
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
            response.sendRedirect("login");
            return;
        }

        // Forward to CV upload form
        request.getRequestDispatcher("cv_upload.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in and is a job seeker
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
            response.sendRedirect("login");
            return;
        }

        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");

        try {
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
                response.sendRedirect("cv-upload");
                return;
            }

            // Handle file upload
            Part filePart = request.getPart("pdfFile");
            String fileName = null;
            
            if (filePart != null && filePart.getSize() > 0) {
                fileName = handleFileUpload(filePart);
                if (fileName == null) {
                    session.setAttribute("errorMessage", "Lỗi khi upload file PDF. Vui lòng thử lại!");
                    response.sendRedirect("cv-upload");
                    return;
                }
            }

            // Create CV object
            CVTemplate cv = new CVTemplate();
            cv.setJobSeekerId(jobSeeker.getId());
            cv.setFullName(fullName);
            cv.setJobPosition(jobPosition);
            cv.setPhone(phone);
            cv.setEmail(email);
            cv.setAddress(address);
            cv.setCertificates(certificates.toString());
            cv.setWorkExperience(workExperience);
            cv.setPdfFilePath(fileName);

            // Save to database
            boolean success = cvDAO.createCV(cv);
            
            if (success) {
                session.setAttribute("successMessage", "CV đã được tạo thành công!");
                response.sendRedirect("profile");
            } else {
                session.setAttribute("errorMessage", "Không thể tạo CV. Vui lòng thử lại!");
                response.sendRedirect("cv-upload");
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating CV", e);
            session.setAttribute("errorMessage", "Lỗi hệ thống khi tạo CV!");
            response.sendRedirect("cv-upload");
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
            
            // Validate file type
            if (!fileName.toLowerCase().endsWith(".pdf")) {
                LOGGER.log(Level.WARNING, "Invalid file type: " + fileName);
                return null;
            }

            // Validate file size
            if (filePart.getSize() > MAX_FILE_SIZE) {
                LOGGER.log(Level.WARNING, "File size too large: " + filePart.getSize());
                return null;
            }

            // Generate unique filename
            String fileExtension = fileName.substring(fileName.lastIndexOf('.'));
            String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

            // Save file
            String realPath = getServletContext().getRealPath("/");
            Path uploadPath = Paths.get(realPath, UPLOAD_DIR);
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