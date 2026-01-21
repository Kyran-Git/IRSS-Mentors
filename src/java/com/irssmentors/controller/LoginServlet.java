package com.irssmentors.controller;

import com.irssmentors.dao.AdminDAO;
import com.irssmentors.dao.MenteeDAO;
import com.irssmentors.dao.MentorDAO;
import com.irssmentors.model.Admin;
import com.irssmentors.model.Mentee;
import com.irssmentors.model.Mentor;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = { "/LoginServlet" })
public class LoginServlet extends HttpServlet {

    /**
     * Handles the HTTP POST method (Form Submission)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get Form Data
        String role = request.getParameter("role"); 
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // 2. Prepare Session
        HttpSession session = request.getSession();

        // 3. Route Logic based on Role
        
        // --- ADMIN LOGIC ---
        if ("admin".equalsIgnoreCase(role)) {
            AdminDAO adminDao = new AdminDAO();
            Admin admin = new Admin();
            admin.setUsername(username);
            admin.setPassword(password);

            // Verify Credentials
            if (adminDao.authenticateUser(admin).equals("SUCCESS")) {
                // A. Create Session Attribute (Required for Security Lock)
                session.setAttribute("adminSession", admin);
                
                // B. Redirect to Dashboard
                // We redirect to adminDashboard.jsp (Assuming it has the failsafe script we added)
                // Or you can redirect to "ListMentorServlet" to be safe.
                response.sendRedirect("admin/adminDashboard.jsp");
            } else {
                failLogin(request, response, role, "Invalid Admin Credentials");
            }
        } 
        
        // --- MENTOR LOGIC ---
        else if ("mentor".equalsIgnoreCase(role)) {
            MentorDAO mentorDAO = new MentorDAO();
            // Assuming MentorDAO.login returns a Mentor object if success, or null if fail
            Mentor mentor = mentorDAO.login(username, password);

            if (mentor != null) {
                // A. Create Session Attribute
                session.setAttribute("mentorSession", mentor);
                
                // B. Redirect to MentorServlet (Vital to load the Mentee List)
                response.sendRedirect("MentorServlet?action=dashboard");
            } else {
                failLogin(request, response, role, "Invalid Mentor Credentials");
            }
        } 
        
        // --- MENTEE LOGIC ---
        else if ("mentee".equalsIgnoreCase(role)) {
            MenteeDAO menteeDAO = new MenteeDAO();
            // Assuming MenteeDAO.login returns a Mentee object if success, or null if fail
            Mentee mentee = menteeDAO.login(username, password);

            if (mentee != null) {
                // A. Create Session Attribute
                session.setAttribute("menteeSession", mentee);
                
                // B. Redirect to Mentee Dashboard
                // Using sendRedirect avoids form resubmission issues
                response.sendRedirect("mentee/menteeDashboard.jsp");
            } else {
                failLogin(request, response, role, "Invalid Mentee Credentials");
            }
        } 
        
        // --- INVALID ROLE ---
        else {
            failLogin(request, response, "mentee", "Please select a valid role.");
        }
    }

    /**
     * Helper method to handle failed logins.
     * Keeps the user on login.jsp and shows the error.
     */
    private void failLogin(HttpServletRequest request, HttpServletResponse response, String role, String message) 
            throws ServletException, IOException {
        request.setAttribute("errMessage", message);
        // Forward back to login.jsp, preserving the role parameter so the styling (color) stays correct
        request.getRequestDispatcher("login.jsp?role=" + role).forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests back to the main page or login page
        response.sendRedirect("index.jsp");
    }
}