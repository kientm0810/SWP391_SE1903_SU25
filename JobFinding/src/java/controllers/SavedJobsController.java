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
        String userRole = (String) session.getAttribute("role");

        if (userId == null || userRole == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            SavedJobDAO savedJobDAO = new SavedJobDAO();
            PostsDAO postsDAO = new PostsDAO();
            List<SavedJob> savedJobs;

            if ("job-seeker".equalsIgnoreCase(userRole)) {
                savedJobs = savedJobDAO.getSavedJobsByJobSeeker(userId);
            } else if ("recruiter".equalsIgnoreCase(userRole)) {
                savedJobs = savedJobDAO.getSavedJobsByRecruiter(userId);
            } else {
                savedJobs = new ArrayList<>();
            }
            
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
        String userRole = (String) session.getAttribute("role");

        if (userId == null || userRole == null) {
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

            if ("job-seeker".equalsIgnoreCase(userRole)) {
                handleJobSeekerAction(savedJobDAO, action, userId, postId, session);
            } else if ("recruiter".equalsIgnoreCase(userRole)) {
                handleRecruiterAction(savedJobDAO, action, userId, postId, session);
            } else {
                session.setAttribute("notification", "Vai trò người dùng không hợp lệ.");
            }

            response.sendRedirect(referer != null && !referer.isEmpty() ? referer : request.getContextPath() + "/");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("notification", "Đã có lỗi xảy ra. Vui lòng thử lại.");
            response.sendRedirect(referer != null && !referer.isEmpty() ? referer : request.getContextPath() + "/error.jsp");
        }
    }
    
    private void handleJobSeekerAction(SavedJobDAO dao, String action, int userId, int postId, HttpSession session) throws Exception {
        if ("save".equals(action)) {
            if (!dao.isJobSavedByJobSeeker(userId, postId)) {
                dao.saveJobForJobSeeker(userId, postId);
                session.setAttribute("notification", "Đã lưu tin thành công!");
            } else {
                session.setAttribute("notification", "Tin này đã được lưu trước đó.");
            }
        } else if ("unsave".equals(action)) {
            dao.unsaveJobForJobSeeker(userId, postId);
            session.setAttribute("notification", "Đã bỏ lưu tin.");
        }
    }

    private void handleRecruiterAction(SavedJobDAO dao, String action, int userId, int postId, HttpSession session) throws Exception {
        if ("save".equals(action)) {
            if (!dao.isJobSavedByRecruiter(userId, postId)) {
                dao.saveJobForRecruiter(userId, postId);
                session.setAttribute("notification", "Đã lưu tin thành công!");
            } else {
                session.setAttribute("notification", "Tin này đã được lưu trước đó.");
            }
        } else if ("unsave".equals(action)) {
            dao.unsaveJobForRecruiter(userId, postId);
            session.setAttribute("notification", "Đã bỏ lưu tin.");
        }
    }
}
 