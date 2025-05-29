/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;

import models.JobSeeker;
import models.Recruiter;
import daos.JobSeekerDAO;
import daos.RecruiterDAO;
import daos.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Vector;
import java.sql.Date;

/**
 *
 * @author andin
 */
@WebServlet(name="AdminController", urlPatterns={"/AdminController"})
public class AdminController extends HttpServlet {
   
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
//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet AdminController</title>");  
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet AdminController at " + request.getContextPath () + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }

        String target = request.getParameter("target");
        if (target == null){
            target = "JobSeeker";
        }
        
        if (target.equals("JobSeeker")){
            String service = request.getParameter("service");
            if (service == null){
                service = "list";
            }
            
            if (service.equals("list")){
                String submit = request.getParameter("submit");
                if (submit == null){
                    submit = "";
                }
                
                if (submit.equals("Search")){
                    String name = (String)request.getParameter("JobSeekerName");
                    
                    JobSeekerDAO dao = new JobSeekerDAO();
                    Vector<JobSeeker> vec = dao.getJobSeekerByName(name);
                
                    request.setAttribute("vec", vec);
                } else {
                    JobSeekerDAO dao = new JobSeekerDAO();
                    Vector<JobSeeker> vec = dao.getAllJobSeeker();
                
                    request.setAttribute("vec", vec);
                }
                
                request.getRequestDispatcher("admin_manage_jobseeker.jsp").forward(request, response);
            } else if (service.equals("Add")){
                UserDAO dao = new UserDAO();
                
                String submit = request.getParameter("submit");
                if (submit == null){
                    request.getRequestDispatcher("admin_add_jobseeker.jsp").forward(request, response);
                } else {
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");
                    String email = request.getParameter("email");
                    String fullName = request.getParameter("fullName");
                    String phone = request.getParameter("phone");
                    String dateOfBirthStr = request.getParameter("dateOfBirth"); // cần parse sang Date
                    String gender = request.getParameter("gender");
                    String address = request.getParameter("address");
                    String profilePicture = request.getParameter("profilePicture");
                    String cvFile = request.getParameter("cvFile");
                    String skills = request.getParameter("skills");
                    String experienceYearsStr = request.getParameter("experienceYears"); // cần parse int
                    String education = request.getParameter("education");
                    String desiredJobTitle = request.getParameter("desiredJobTitle");
                    String desiredSalaryStr = request.getParameter("desiredSalary"); // cần parse double
                    String jobCategory = request.getParameter("jobCategory");
                    String preferredLocation = request.getParameter("preferredLocation");
                    String careerLevel = request.getParameter("careerLevel");
                    String workType = request.getParameter("workType");
                    String profileSummary = request.getParameter("profileSummary");
                    String portfolioUrl = request.getParameter("portfolioUrl");
                    String languages = request.getParameter("languages");
                    String createdAtStr = request.getParameter("createdAt"); // cần parse Date
                    String updatedAtStr = request.getParameter("updatedAt"); // cần parse Date
                    String isActiveStr = request.getParameter("isActive"); // cần parse boolean
                    Date dateOfBirth = Date.valueOf(dateOfBirthStr); // nếu format là yyyy-MM-dd
                    int experienceYears = Integer.parseInt(experienceYearsStr);
                    double desiredSalary = Double.parseDouble(desiredSalaryStr);
                    boolean isActive = Boolean.parseBoolean(isActiveStr);
                    Date createdAt = Date.valueOf(createdAtStr);
                    Date updatedAt = Date.valueOf(updatedAtStr);
                    
                    JobSeeker p = new JobSeeker(username, password, email, fullName, phone, 
                            dateOfBirth, gender, address, profilePicture, cvFile, skills, 
                            experienceYears, education, desiredJobTitle, desiredSalary, 
                            jobCategory, preferredLocation, careerLevel, workType, 
                            profileSummary, portfolioUrl, languages, createdAt, updatedAt, isActive);
                    
                    dao.registerJobSeeker(p);
                    
                    response.sendRedirect("AdminController?target=JobSeeker");

                }
               
            } else if (service.equals("Ban")){
                int ID = Integer.parseInt(request.getParameter("ID"));
                boolean status = Boolean.parseBoolean(request.getParameter("status"));
                
                JobSeekerDAO dao = new JobSeekerDAO();
                dao.changeStatus(ID, status);
                
                response.sendRedirect("AdminController?target=JobSeeker");
            } else if (service.equals("Detail")){
                int ID = Integer.parseInt(request.getParameter("ID"));
                
                JobSeekerDAO dao = new JobSeekerDAO();
                JobSeeker p = dao.getSpeccificJobSeeker(ID);
                
                request.setAttribute("JobSeeker", p);
                
                request.getRequestDispatcher("admin_detail_jobseeker.jsp").forward(request, response);
            }
        } else if (target.equals("Recruiter")){
            
            String service = request.getParameter("service");
            if (service == null){
                service = "list";
            }
            
            if (service.equals("list")){
               String submit = request.getParameter("submit");
                if (submit == null){
                    submit = "";
                }
                
                if (submit.equals("Search")){
                    String name = (String)request.getParameter("RecruiterName");
                    
                    RecruiterDAO dao = new RecruiterDAO();
                    Vector<Recruiter> vec = dao.getRecruiterByName(name);
                
                    request.setAttribute("vec", vec);
                } else {
                    RecruiterDAO dao = new RecruiterDAO();
                    Vector<Recruiter> vec = dao.getAllRecruiter();
                
                    request.setAttribute("vec", vec);
                }
                
                request.getRequestDispatcher("admin_manage_recruiter.jsp").forward(request, response);
            } else if (service.equals("Add")){
                UserDAO dao = new UserDAO();
                
                String submit = request.getParameter("submit");
                if (submit == null){
                    request.getRequestDispatcher("admin_add_recruiter.jsp").forward(request, response);
                } else {
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");
                    String email = request.getParameter("email");
                    String fullName = request.getParameter("fullName");
                    String phone = request.getParameter("phone");
                    String dateOfBirthStr = request.getParameter("dateOfBirth");
                    String gender = request.getParameter("gender");
                    String address = request.getParameter("address");
                    String profilePicture = request.getParameter("profilePicture");
                    String companyName = request.getParameter("companyName");
                    String companyDescription = request.getParameter("companyDescription");
                    String logo = request.getParameter("logo");
                    String website = request.getParameter("website");
                    String companyAddress = request.getParameter("companyAddress");
                    String companySize = request.getParameter("companySize");
                    String industry = request.getParameter("industry");
                    String taxCode = request.getParameter("taxCode");
                    String loyaltyScoreStr = request.getParameter("loyaltyScore");
                    String verificationStatus = request.getParameter("verificationStatus");
                    String createdAtStr = request.getParameter("createdAt");
                    String updatedAtStr = request.getParameter("updatedAt");
                    String isActiveStr = request.getParameter("isActive");
                    Date createdAt = Date.valueOf(createdAtStr);
                    Date updatedAt = Date.valueOf(updatedAtStr);
                    Date dateOfBirth = Date.valueOf(dateOfBirthStr); // hoặc dùng SimpleDateFormat nếu khác định dạng
                    double loyaltyScore = Double.parseDouble(loyaltyScoreStr);
                    boolean isActive = Boolean.parseBoolean(isActiveStr);


                    
                    Recruiter p = new Recruiter(username, password, email, fullName, phone, 
                            dateOfBirth, gender, address, profilePicture, companyName, 
                            companyDescription, logo, website, companyAddress, companySize, 
                            industry, taxCode, loyaltyScore, verificationStatus, 
                            createdAt, updatedAt, isActive);
                    
                    dao.registerRecruiter(p);
                    
                    response.sendRedirect("AdminController?target=Recruiter");

                }
               
            } else if (service.equals("Ban")){
                int ID = Integer.parseInt(request.getParameter("ID"));
                boolean status = Boolean.parseBoolean(request.getParameter("status"));
                
                RecruiterDAO dao = new RecruiterDAO();
                dao.changeStatus(ID, status);
                
                response.sendRedirect("AdminController?target=Recruiter");
            } else if (service.equals("Detail")){
                int ID = Integer.parseInt(request.getParameter("ID"));
                
                RecruiterDAO dao = new RecruiterDAO();
                Recruiter p = dao.getSpeccificRecruiter(ID);
                
                request.setAttribute("Recruiter", p);
                
                request.getRequestDispatcher("admin_detail_recruiter.jsp").forward(request, response);
            }
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
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
