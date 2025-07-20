package controllers;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet(name = "ImageUploadController", urlPatterns = {"/upload/image"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class ImageUploadController extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "uploads/images";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Tạo thư mục upload nếu chưa tồn tại
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadFilePath = applicationPath + File.separator + UPLOAD_DIRECTORY;
            
            File uploadDir = new File(uploadFilePath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Lấy file từ request
            Part filePart = request.getPart("file");
            if (filePart == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"error\": \"No file uploaded\"}");
                return;
            }

            // Kiểm tra loại file
            String fileName = getSubmittedFileName(filePart);
            String fileExtension = getFileExtension(fileName);
            
            if (!isValidImageExtension(fileExtension)) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"error\": \"Invalid image format. Allowed: jpg, jpeg, png, gif, webp\"}");
                return;
            }

            // Tạo tên file mới để tránh trùng lặp
            String newFileName = UUID.randomUUID().toString() + "." + fileExtension;
            String filePath = uploadFilePath + File.separator + newFileName;

            // Lưu file
            filePart.write(filePath);

            // Tạo URL để truy cập file
            String fileUrl = request.getContextPath() + "/" + UPLOAD_DIRECTORY + "/" + newFileName;

            // Trả về JSON response cho TinyMCE
            out.print("{\"location\": \"" + fileUrl + "\"}");

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\": \"Upload failed: " + e.getMessage() + "\"}");
        }
    }

    private String getSubmittedFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }

    private String getFileExtension(String fileName) {
        if (fileName.lastIndexOf(".") != -1 && fileName.lastIndexOf(".") != 0) {
            return fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
        }
        return "";
    }

    private boolean isValidImageExtension(String extension) {
        String[] allowedExtensions = {"jpg", "jpeg", "png", "gif", "webp"};
        for (String allowed : allowedExtensions) {
            if (allowed.equals(extension)) {
                return true;
            }
        }
        return false;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to home page
        response.sendRedirect(request.getContextPath() + "/home");
    }
} 