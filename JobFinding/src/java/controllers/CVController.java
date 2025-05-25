/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;

import daos.CVDAO;
import models.CV;
//import models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet("/cv/*")
public class CVController extends HttpServlet {
    private CVDAO cvDao;

    @Override
    public void init() throws ServletException {
        cvDao = new CVDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equals("job_seeker")) {
            response.sendRedirect("login");
            return;
        }

        String path = request.getPathInfo();
        if (path == null) path = "/";

        switch (path) {
            case "/create":
                request.getRequestDispatcher("/create_cv.jsp").forward(request, response);
                break;
            case "/update":
                String cvId = request.getParameter("id");
                if (cvId != null) {
                    // Lấy CV để hiển thị trong form
                    List<CV> cvs = cvDao.searchCVs(user.getId(), "");
                    CV cv = cvs.stream().filter(c -> c.getId() == Integer.parseInt(cvId)).findFirst().orElse(null);
                    if (cv != null) {
                        request.setAttribute("cv", cv);
                        request.getRequestDispatcher("/update_cv.jsp").forward(request, response);
                    } else {
                        request.setAttribute("error", "CV không tồn tại.");
                        request.getRequestDispatcher("/search_cv.jsp").forward(request, response);
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu ID CV");
                }
                break;
            case "/search":
                String keyword = request.getParameter("keyword");
                keyword = (keyword == null) ? "" : keyword;
                List<CV> cvs = cvDao.searchCVs(user.getId(), keyword);
                request.setAttribute("cvs", cvs);
                request.getRequestDispatcher("/search_cv.jsp").forward(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equals("job_seeker")) {
            response.sendRedirect("login");
            return;
        }

        String path = request.getPathInfo();
        if (path == null) path = "/";

        switch (path) {
            case "/create":
                CV newCV = new CV();
                newCV.setJobSeekerId(user.getId());
                newCV.setTitle(request.getParameter("title"));
                newCV.setSummary(request.getParameter("summary"));
                newCV.setEducation(request.getParameter("education"));
                newCV.setExperience(request.getParameter("experience"));
                String skills = request.getParameter("skills");
                if (skills != null && !skills.isEmpty()) {
                    newCV.setSkills(Arrays.asList(skills.split(",")));
                }
                if (cvDao.createCV(newCV)) {
                    request.setAttribute("message", "Tạo CV thành công!");
                } else {
                    request.setAttribute("error", "Tạo CV thất bại.");
                }
                request.getRequestDispatcher("/create_cv.jsp").forward(request, response);
                break;
            case "/update":
                String cvId = request.getParameter("id");
                if (cvId != null) {
                    CV cv = new CV();
                    cv.setId(Integer.parseInt(cvId));
                    cv.setJobSeekerId(user.getId());
                    cv.setTitle(request.getParameter("title"));
                    cv.setSummary(request.getParameter("summary"));
                    cv.setEducation(request.getParameter("education"));
                    cv.setExperience(request.getParameter("experience"));
                    String updateSkills = request.getParameter("skills");
                    if (updateSkills != null && !updateSkills.isEmpty()) {
                        cv.setSkills(Arrays.asList(updateSkills.split(",")));
                    }
                    if (cvDao.updateCV(cv)) {
                        request.setAttribute("message", "Cập nhật CV thành công!");
                    } else {
                        request.setAttribute("error", "Cập nhật CV thất bại.");
                    }
                    request.setAttribute("cv", cv);
                    request.getRequestDispatcher("/update_cv.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu ID CV");
                }
                break;
            case "/delete":
                cvId = request.getParameter("id");
                if (cvId != null && cvDao.deleteCV(Integer.parseInt(cvId), user.getId())) {
                    request.setAttribute("message", "Xóa CV thành công!");
                } else {
                    request.setAttribute("error", "Xóa CV thất bại.");
                }
                List<CV> cvs = cvDao.searchCVs(user.getId(), "");
                request.setAttribute("cvs", cvs);
                request.getRequestDispatcher("/search_cv.jsp").forward(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}