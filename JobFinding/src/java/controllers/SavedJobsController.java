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

import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

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
        doGet(request, response);
    }
}
