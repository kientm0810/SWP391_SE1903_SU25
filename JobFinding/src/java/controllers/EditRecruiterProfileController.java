/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import daos.RecruiterDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import models.Recruiter;

@WebServlet(name = "EditRecruiterProfileController", urlPatterns = {"/edit-recruiter-profile"})
public class EditRecruiterProfileController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Recruiter recruiter = (Recruiter) session.getAttribute("user");

        if (recruiter == null || !session.getAttribute("role").equals("recruiter")) {
            response.sendRedirect("login");
            return;
        }

        request.setAttribute("recruiter", recruiter);
        request.getRequestDispatcher("edit_recruiter_profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Recruiter recruiter = (Recruiter) session.getAttribute("user");

        if (recruiter == null || !session.getAttribute("role").equals("recruiter")) {
            response.sendRedirect("login");
            return;
        }

        try {
            // Get parameters from the form
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String dob = request.getParameter("dateOfBirth");
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

            // Update recruiter object
            recruiter.setFullName(fullName);
            recruiter.setPhone(phone);
            if (dob != null && !dob.isEmpty()) {
                recruiter.setDateOfBirth(Date.valueOf(dob));
            }
            recruiter.setGender(gender);
            recruiter.setAddress(address);
            recruiter.setProfilePicture(profilePicture);
            recruiter.setCompanyName(companyName);
            recruiter.setCompanyDescription(companyDescription);
            recruiter.setLogo(logo);
            recruiter.setWebsite(website);
            recruiter.setCompanyAddress(companyAddress);
            recruiter.setCompanySize(companySize);
            recruiter.setIndustry(industry);

            // Update database
            RecruiterDAO recruiterDAO = new RecruiterDAO();
            boolean success = recruiterDAO.updateRecruiter(recruiter);

            if (success) {
                session.setAttribute("user", recruiter);
                response.sendRedirect("recruiter-profile");
            } else {
                request.setAttribute("errorMessage", "Failed to update profile. Please try again.");
                request.getRequestDispatcher("edit_recruiter_profile.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while updating the profile.");
            request.getRequestDispatcher("edit_recruiter_profile.jsp").forward(request, response);
        }
    }
}
