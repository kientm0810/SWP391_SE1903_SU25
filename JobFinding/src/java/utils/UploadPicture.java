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

/**
 *
 * @author andin
 */
public class UploadPicture {
    public static String uploadImage(Part filePart, String imageURL) throws ServletException{
        String res = imageURL;
        Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
            "cloud_name", "dlx6r02ap",
            "api_key", "476379442332742",
            "api_secret", "AP6fsHOrKHhHILISZmpUiUZCLIY"
        ));

//        String contentType = filePart.getContentType();
//
//        if (contentType == null || !contentType.startsWith("image/")) {
//            throw new ServletException("Chỉ cho phép upload ảnh định dạng PNG, JPG, JPEG.");
//        }

        
        try {
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
            res = result.get("secure_url").toString();
            tempFile.delete();

        } catch (Exception e) {
            //log(e.getMessage());
            System.out.println(e.getMessage());
        }
        
        return res;
    }
}
