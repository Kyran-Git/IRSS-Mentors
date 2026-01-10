/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.irssmentors.controller;

import com.irssmentors.dao.AdminDAO;
import com.irssmentors.model.Mentor;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author nikla
 */
public class AdminServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String mentorUsername = request.getParameter("mentorUsername");
        String mentorPassword = request.getParameter("mentorPassword");
        String mentorFullname = request.getParameter("mentorFullname");
        String mentorEmail = request.getParameter("mentorEmail");
        String mentorPhone = request.getParameter("mentorPhone");
        String mentorFaculty = request.getParameter("mentorFaculty");
        
        Mentor mentor = new Mentor(mentorUsername,mentorPassword,mentorFullname,mentorEmail,mentorPhone,mentorFaculty);
        AdminDAO adminDAO = new AdminDAO();
        String userValidate = adminDAO.registerNewMentor(mentor);
        
        if(userValidate.equals("SUCCESS")){
            request.getRequestDispatcher("admin/adminDashboard.jsp").forward(request, response);
        }
        else
        {
            request.setAttribute("errMessage", userValidate);
            request.getRequestDispatcher("Storyboard/index.html").forward(request, response);
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
