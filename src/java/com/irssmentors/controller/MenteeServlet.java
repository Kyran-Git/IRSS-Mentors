package com.irssmentors.controller;

import com.irssmentors.model.Mentee;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "MenteeServlet", urlPatterns = {"/MenteeServlet"})
public class MenteeServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Mentee currentMentee = (Mentee) session.getAttribute("menteeSession");

        // Security Check
        if (currentMentee == null) {
            response.sendRedirect("login.jsp?role=mentee");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "dashboard";

        switch (action) {
            case "dashboard":
                response.sendRedirect("mentee/menteeDashboard.jsp");
                break;

            case "viewProfile":
                // The data is already in 'menteeSession', so we just forward to the JSP
                request.getRequestDispatcher("mentee/menteeProfile.jsp").forward(request, response);
                break;
                
            case "viewPerformance":
                // TODO: Add logic to fetch performance list from DAO later
                response.sendRedirect("mentee/menteeDashboard.jsp"); // Placeholder
                break;
                
            case "viewMentor":
                // TODO: Add logic to fetch Mentor details based on currentMentee.getMentorID()
                response.sendRedirect("mentee/menteeDashboard.jsp"); // Placeholder
                break;
                
            case "viewTimetable":
                 // TODO: Add logic to fetch Mentor Timetable
                response.sendRedirect("mentee/menteeDashboard.jsp"); // Placeholder
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}