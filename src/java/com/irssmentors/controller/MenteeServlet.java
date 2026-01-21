package com.irssmentors.controller;

import com.irssmentors.dao.MenteePerformanceDAO;
import com.irssmentors.model.Mentor;
import com.irssmentors.dao.MentorDAO;
import com.irssmentors.model.Mentee;
import com.irssmentors.model.MenteePerformance;
import com.irssmentors.controller.MenteeServlet;
import com.irssmentors.dao.MentorTimetableDAO;
import com.irssmentors.model.MentorTimetable;
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
            // Get mentor ID from the mentee object in session
            String mentorID = currentMentee.getMentorID(); 

            MentorDAO mentorDAO = new MentorDAO();
            Mentor assignedMentor = mentorDAO.getMentorByID(mentorID);

            // Pass the mentor object to the JSP
            request.setAttribute("mentor", assignedMentor);
            request.getRequestDispatcher("mentee/mentorDetail.jsp").forward(request, response);
            break;
                
                case "viewTimetable":
            // 1. Get the current mentee's assigned mentor ID
            String mID = currentMentee.getMentorID(); 

            // 2. Fetch the timetable slots using your existing DAO
            MentorTimetableDAO ttDAO = new MentorTimetableDAO();
            List<MentorTimetable> slots = ttDAO.getTimetable(mID);

            // 3. Set attribute for JSP and forward
            request.setAttribute("slotList", slots);
            request.getRequestDispatcher("mentee/timetable.jsp").forward(request, response);
            break;
            
            case "bookSlot":
            String slotID = request.getParameter("slotID");
            String menteeID = currentMentee.getMenteeID();

            MentorTimetableDAO mtDAO = new MentorTimetableDAO();
            mtDAO.bookSlot(slotID, menteeID);

            // Redirect back to the timetable to see the updated status
            response.sendRedirect("MenteeServlet?action=viewTimetable");
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