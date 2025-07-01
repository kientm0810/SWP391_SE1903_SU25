package controllers;

import com.cloudinary.*;
import com.cloudinary.utils.ObjectUtils;
import io.github.cdimascio.dotenv.Dotenv;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.Map;

@MultipartConfig
public class UploadServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
            "cloud_name", "dlx6r02ap",
            "api_key", "476379442332742",
            "api_secret", "AP6fsHOrKHhHILISZmpUiUZCLIY"
        ));

//        response.setContentType("text/html;charset=UTF-8");
//        PrintWriter out = response.getWriter();

        try {
            Part filePart = request.getPart("file");

            // Lưu file tạm
            File tempFile = File.createTempFile("upload_", ".tmp");
            try (InputStream fileContent = filePart.getInputStream();
                 FileOutputStream outStream = new FileOutputStream(tempFile)) {
                fileContent.transferTo(outStream);
            }

            // Upload file
            Map result = cloudinary.uploader().upload(tempFile, ObjectUtils.asMap(
                "use_filename", true,
                "unique_filename", false,
                "overwrite", true
            ));
            String imageUrl = result.get("secure_url").toString();

            // Hiển thị ảnh
//            out.println("<html><body>");
//            out.println("<h2>Ảnh đã được upload thành công!</h2>");
//            out.println("<img src='" + imageUrl + "' width='400'/><br>");
//            out.println("<p>URL: <a href='" + imageUrl + "'>" + imageUrl + "</a></p>");
//            out.println("</body></html>");

            // Xoá file tạm
            tempFile.delete();

        } catch (Exception e) {
//            out.println("Upload thất bại: " + e.getMessage());
            log(e.getMessage());
//            e.printStackTrace(out);
        }

    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        processRequest(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        processRequest(request, response);
    }
}
