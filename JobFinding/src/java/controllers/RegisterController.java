/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;

import daos.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import models.JobSeeker;
import models.Recruiter;


/**
 *
 * @author MY PC
 */
@WebServlet(name="RegisterController", urlPatterns={"/register"})
public class RegisterController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
 @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    /**
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String role = req.getParameter("role");
        String email = req.getParameter("email");
        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");
        String dobStr = req.getParameter("dob");
        String gender = req.getParameter("gender");
        String address = req.getParameter("address");

        UserDAO dao = new UserDAO();

        if (dao.isUsernameTaken(username)) {
            req.setAttribute("error", "Tên đăng nhập đã tồn tại.");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date dob = sdf.parse(dobStr);

            boolean success = false;
            
            if ("job_seeker".equals(role)) {
                // Register as job seeker
                JobSeeker jobSeeker = new JobSeeker();
                jobSeeker.setUsername(username);
                jobSeeker.setPassword(password);
                jobSeeker.setEmail(email);
                jobSeeker.setFullName(fullName);
                jobSeeker.setPhone(phone);
                jobSeeker.setDateOfBirth(dob);
                jobSeeker.setGender(gender);
                jobSeeker.setAddress(address);
                // Set default values for job seeker specific fields
                jobSeeker.setSkills("");
                jobSeeker.setExperienceYears(0);
                jobSeeker.setEducation("");
                jobSeeker.setDesiredJobTitle("");
                jobSeeker.setDesiredSalary(0);
                jobSeeker.setJobCategory("");
                jobSeeker.setPreferredLocation("");
                jobSeeker.setCareerLevel("");
                jobSeeker.setWorkType("");
                jobSeeker.setProfileSummary("");
                
                success = dao.registerJobSeeker(jobSeeker);
            } else if ("recruiter".equals(role)) {
                // Register as recruiter
                Recruiter recruiter = new Recruiter();
                recruiter.setUsername(username);
                recruiter.setPassword(password);
                recruiter.setEmail(email);
                recruiter.setFullName(fullName);
                recruiter.setPhone(phone);
                recruiter.setDateOfBirth(dob);
                recruiter.setGender(gender);
                recruiter.setAddress(address);
                // Set default values for recruiter specific fields
                recruiter.setCompanyName("");
                recruiter.setCompanyDescription("");
                recruiter.setCompanyAddress("");
                recruiter.setCompanySize("");
                recruiter.setIndustry("");
                recruiter.setTaxCode("");
                
                success = dao.registerRecruiter(recruiter);
            } else {
                req.setAttribute("error", "Vai trò người dùng không hợp lệ.");
                req.getRequestDispatcher("register.jsp").forward(req, resp);
                return;
            }

            if (success) {
                req.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
                req.getRequestDispatcher("login.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Đăng ký thất bại.");
                req.getRequestDispatcher("register.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Dữ liệu không hợp lệ: " + e.getMessage());
            req.getRequestDispatcher("register.jsp").forward(req, resp);
        }
    }

    @Override
    public String getServletInfo() {
        return "Register Controller";
    }
}