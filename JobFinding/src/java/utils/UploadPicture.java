/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Map;
import java.io.*;
import java.nio.file.*;
import java.util.UUID;

/**
 *
 * @author andin
 */
public class UploadPicture {
//    public static String uploadImage(Part filePart, String imageURL) throws ServletException{
//        String res = imageURL;
//        Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
//            "cloud_name", "dlx6r02ap",
//            "api_key", "476379442332742",
//            "api_secret", "AP6fsHOrKHhHILISZmpUiUZCLIY"
//        ));
//
////        String contentType = filePart.getContentType();
////
////        if (contentType == null || !contentType.startsWith("image/")) {
////            throw new ServletException("Chỉ cho phép upload ảnh định dạng PNG, JPG, JPEG.");
////        }
//
//        
//        try {
//            // Lưu file tạm
//            File tempFile = File.createTempFile("upload_", ".tmp");
//            try (InputStream fileContent = filePart.getInputStream();
//                 FileOutputStream outStream = new FileOutputStream(tempFile)) {
//                fileContent.transferTo(outStream);
//            }
//
//            // Upload file
//            Map result = cloudinary.uploader().upload(tempFile, ObjectUtils.asMap(
//                "use_filename", true,
//                "unique_filename", false,
//                "overwrite", true
//            ));
//            res = result.get("secure_url").toString();
//            tempFile.delete();
//
//        } catch (Exception e) {
//            //log(e.getMessage());
//            System.out.println(e.getMessage());
//        }
//        
//        return res;
//    }
    
    public static String uploadImage(Part filePart, String oldImageURL, String basePath) throws ServletException {
        String res = oldImageURL;

        // Đảm bảo basePath không có dấu / dư thừa, rồi cộng thêm /uploads
        String uploadDir = basePath;
        if (!uploadDir.endsWith(File.separator)) {
            uploadDir += File.separator;
        }
        uploadDir += "uploads";

        try {
            // kiểm tra và tạo thư mục nếu chưa có
            File uploadFolder = new File(uploadDir);
            if (!uploadFolder.exists()) {
                uploadFolder.mkdirs();
            }

//            String contentType = filePart.getContentType();
//            if (contentType == null || !contentType.startsWith("image/")) {
//                throw new ServletException("Chỉ cho phép upload ảnh định dạng PNG, JPG, JPEG.");
//            }

            // Lấy tên file gốc và phần mở rộng
            String submittedFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String extension = "";
            int dotIndex = submittedFileName.lastIndexOf('.');
            if (dotIndex >= 0) {
                extension = submittedFileName.substring(dotIndex);
            }

            // Tạo tên file ngẫu nhiên
            String randomFileName = UUID.randomUUID().toString() + extension;

            // Đường dẫn file thật
            File fileToSave = new File(uploadFolder, randomFileName);

            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, fileToSave.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }

            // Kết quả trả về: đường dẫn tương đối để lưu DB
            res = "uploads/" + randomFileName;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return res;
    }
}