/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.irssmentors.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import com.irssmentors.dao.MentorDAO;
import com.irssmentors.dao.MentorTimetableDAO;
import com.irssmentors.model.Mentee;
import com.irssmentors.model.Mentor;
import com.irssmentors.model.MentorTimetable;

/**
 *
 * @author nikla
 */
@WebServlet(name = "MentorServlet", urlPatterns = {"/MentorServlet"})
public class MentorServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Mentor currentMentor = (Mentor) session.getAttribute("mentorSession");
        
        // Security Check
        if (currentMentor == null) {
            response.sendRedirect("login.jsp?role=mentor");
            return;
        }
        
        String action = request.getParameter("action");
        if(action == null) action = "dashboard";
        
        MentorDAO mentorDAO = new MentorDAO();
        MentorTimetableDAO timetableDAO = new MentorTimetableDAO();

        switch(action) {
            case "dashboard":
                List<Mentee> mentees = mentorDAO.getMenteesByMentor(currentMentor.getMentorID());
                request.setAttribute("menteeList", mentees);
                request.getRequestDispatcher("mentor/mentorDashboard.jsp").forward(request, response);
                break;
                
            case "viewTimetable":
                // 1. Get List from DAO
                List<MentorTimetable> timetable = timetableDAO.getTimetable(currentMentor.getMentorID());
                
                // 2. Set as Attribute (Must match the name used in JSP <c:forEach>)
                request.setAttribute("timetableList", timetable);
                
                // 3. Forward to JSP
                request.getRequestDispatcher("mentor/timetable.jsp").forward(request, response);
                break;
                
            case "addSlot":
                String day = request.getParameter("availableDay");
                String time = request.getParameter("availableTime");
                
                MentorTimetable slot = new MentorTimetable();
                slot.setMentorID(currentMentor.getMentorID());
                slot.setAvailableDay(day);
                slot.setAvailableTime(time);
                
                timetableDAO.addSlot(slot);
                
                // Redirect back to viewTimetable to refresh the list
                response.sendRedirect("MentorServlet?action=viewTimetable");
                break;
                
            case "removeSlot":
                String id = request.getParameter("id");
                timetableDAO.removeSlot(id);
                response.sendRedirect("MentorServlet?action=viewTimetable");
                break;
        }
    }


    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
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
     *
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
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
