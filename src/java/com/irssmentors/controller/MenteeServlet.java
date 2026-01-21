package com.irssmentors.controller;

import com.irssmentors.dao.MenteePerformanceDAO;
import com.irssmentors.model.Mentee;
import com.irssmentors.model.MenteePerformance;
import java.io.IOException;
import java.util.List;
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
                
                request.getRequestDispatcher("mentee/menteeProfile.jsp").forward(request, response);
                break;
                
            case "viewPerformance":
                // 1. Fetch Performance Data using the MenteeID from session
                MenteePerformanceDAO perfDAO = new MenteePerformanceDAO();

                // This assumes currentMentee is not null (checked at top of Servlet)
                List<MenteePerformance> perfList = perfDAO.getPerformanceByMentee(currentMentee.getMenteeID());

                // 2. Set Attribute so JSP can see it
                request.setAttribute("performanceList", perfList);

                // 3. Forward to the JSP
                request.getRequestDispatcher("mentee/performance.jsp").forward(request, response);
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