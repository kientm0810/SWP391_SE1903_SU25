package controllers;

import daos.SavedJobDAO;
import daos.PostsDAO;
import models.SavedJob;
import models.Posts;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

@WebServlet(name = "SavedJobsController", urlPatterns = {"/saved-jobs"})
public class SavedJobsController extends HttpServlet {

    public SavedJobsController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            SavedJobDAO savedJobDAO = new SavedJobDAO();
            PostsDAO postsDAO = new PostsDAO();

            List<SavedJob> savedJobs = savedJobDAO.getSavedJobs(userId);
            List<Posts> savedPosts = new ArrayList<>();
            for (SavedJob savedJob : savedJobs) {
                Posts post = postsDAO.getPostById(savedJob.getPostId());
                if (post != null) {
                    post.setCreatedAt(savedJob.getSavedAt());
                    savedPosts.add(post);
                }
            }
            request.setAttribute("savedJobs", savedPosts);
            request.getRequestDispatcher("/saved_jobs.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            session.setAttribute("notification", "Bạn cần đăng nhập để thực hiện chức năng này.");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        String postIdStr = request.getParameter("postId");
        String referer = request.getHeader("Referer");

        if (action == null || postIdStr == null || postIdStr.trim().isEmpty()) {
            session.setAttribute("notification", "Hành động không hợp lệ.");
            response.sendRedirect(referer != null ? referer : request.getContextPath() + "/posts");
            return;
        }

        try {
            int postId = Integer.parseInt(postIdStr);
            SavedJobDAO savedJobDAO = new SavedJobDAO();

            if ("save".equals(action)) {
                if (!savedJobDAO.isJobSaved(userId, postId)) {
                    savedJobDAO.saveJob(userId, postId);
                    session.setAttribute("notification", "Đã lưu tin thành công!");
                } else {
                    session.setAttribute("notification", "Tin này đã được lưu trước đó.");
                }
            } else if ("unsave".equals(action)) {
                savedJobDAO.unsaveJob(userId, postId);
                session.setAttribute("notification", "Đã bỏ lưu tin.");
            }

            response.sendRedirect(referer != null && !referer.isEmpty() ? referer : request.getContextPath() + "/");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("notification", "Đã có lỗi xảy ra. Vui lòng thử lại.");
            response.sendRedirect(referer != null && !referer.isEmpty() ? referer : request.getContextPath() + "/error.jsp");
        }
    }
}
