/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.irssmentors.controller;

import com.irssmentors.dao.AdminDAO;
import com.irssmentors.model.Admin;
import com.irssmentors.dao.MenteeDAO;
import com.irssmentors.dao.MentorDAO;
import com.irssmentors.model.Mentee;
import com.irssmentors.model.Mentor;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author nikla
 */
@WebServlet(name = "LoginServlet", urlPatterns = { "/LoginServlet" })
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get Form Data
        String role = request.getParameter("role"); // Ensure your HTML select/radio has name="role"
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Admin admin = new Admin(username, password);
        AdminDAO adminDao = new AdminDAO();

        Mentee mentee = new Mentee(username, password);
        MenteeDAO menteeDao = new MenteeDAO();
        String userValidate = "";

        if ("Admin".equals(role)) {
            userValidate = adminDao.authenticateUser(admin);
        } else if ("Mentor".equals(role)) {
            // Mentor
        } else if ("Mentee".equals(role)) {
            userValidate = menteeDao.authenticateUser(mentee);
        } else {
            request.setAttribute("error", "Invalid login");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }

        if (userValidate.equals("SUCCESS")) {
            request.setAttribute("username", username);
            request.getRequestDispatcher("admin/adminDashboard.jsp").forward(request, response);
        } else {
            request.setAttribute("errMessage", userValidate);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
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

    // 2. Route based on Role
    if("admin".equalsIgnoreCase(role))

    {
        Admin admin = new Admin(username, password);
        AdminDAO adminDAO = new AdminDAO();
        admin.setUsername(username);
        admin.setPassword(password);

        // Check credentials
        if (adminDAO.authenticateUser(admin).equals("SUCCESS")) {
            // Set Session
            session.setAttribute("adminSession", admin);
            session.setAttribute("userRole", "admin");

            response.sendRedirect("admin/adminDashboard.jsp");
        } else {
            // Login Failed
            request.setAttribute("errMessage", "Invalid Admin Credentials");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }

    }else if("mentor".equalsIgnoreCase(role))
    {
        MentorDAO mentorDAO = new MentorDAO();
        Mentor mentor = mentorDAO.login(username, password);

        if (mentor != null) {
            session.setAttribute("mentorSession", mentor);
            response.sendRedirect("MentorServlet?action=dashboard");
        } else {
            request.setAttribute("errMessage", "Invalid Mentor Credentials");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }

    }else if("mentee".equalsIgnoreCase(role))
    {
        Mentee mentee = new Mentee(username, password);
        MenteeDAO menteeDAO = new MenteeDAO();
        mentee.setMenteeUsername(username);
        mentee.setMenteePassword(password);

        if (mentee != null) {
            session.setAttribute("menteeSession", mentee);
            response.sendRedirect("MenteeServlet?action=dashboard");
        } else {
            request.setAttribute("errMessage", "Invalid Mentee Credentials");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }

    }else
    {
        // Default or Mentee logic here
        request.setAttribute("errMessage", "Please select a valid role.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}}
