/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.irssmentors.controller;

import com.irssmentors.dao.AdminDAO;
import com.irssmentors.model.Mentor;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "EditMentorServlet", urlPatterns = {"/EditMentorServlet"})
public class EditMentorServlet extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String username = request.getParameter("mentorUsername");
        String password = request.getParameter("mentorUsername");
        String fullname = request.getParameter("mentorFullname");
        String email = request.getParameter("mentorEmail");
        String phone = request.getParameter("mentorPhone");
        String faculty = request.getParameter("mentorFaculty");
        
        AdminDAO adminDao = new AdminDAO();
        List<Mentor> mentorList = adminDao.setMentor(username,password,fullname,email,phone,faculty);
        
        request.setAttribute("mentorList", mentorList);
        request.getRequestDispatcher("admin/manageMentors.jsp").forward(request, response);
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        AdminDAO adminDao = new AdminDAO();

        if (username != null && !username.isEmpty()) {
            Mentor mentorToEdit = adminDao.getMentorByUsername(username);
            request.setAttribute("selectedMentor", mentorToEdit);
        }

        request.getRequestDispatcher("admin/manageMentors.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("mentorUsername");
        String password = request.getParameter("mentorPassword");
        String fullname = request.getParameter("mentorFullname");
        String email = request.getParameter("mentorEmail");
        String phone = request.getParameter("mentorPhone");
        String faculty = request.getParameter("mentorFaculty");

        AdminDAO adminDao = new AdminDAO();
        adminDao.setMentor(username, password, fullname, email, phone, faculty);

        response.sendRedirect("ListMentorServlet");
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
