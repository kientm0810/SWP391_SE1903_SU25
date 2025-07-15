package controllers;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AddProfileSectionController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uri = request.getRequestURI();
        if (uri.endsWith("/experience-add")) {
            request.getRequestDispatcher("experience-add.jsp").forward(request, response);
        } else if (uri.endsWith("/education-add")) {
            request.getRequestDispatcher("education-add.jsp").forward(request, response);
        } else if (uri.endsWith("/certificate-add")) {
            request.getRequestDispatcher("certificate-add.jsp").forward(request, response);
        } else if (uri.endsWith("/award-add")) {
            request.getRequestDispatcher("award-add.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
} 