/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.irssmentors.controller;

import com.irssmentors.dao.MenteeDAO;
import com.irssmentors.model.Mentee;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "RegisterMenteeServlet", urlPatterns = {"/RegisterMenteeServlet"})
public class RegisterMenteeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Retrieve Data
        String id = request.getParameter("menteeID");
        String name = request.getParameter("menteeFullname");
        String prog = request.getParameter("menteeProgramme");
        int sem = Integer.parseInt(request.getParameter("menteeSemester"));
        String email = request.getParameter("menteeEmail");
        String phone = request.getParameter("menteePhone");
        String user = request.getParameter("menteeUsername");
        String pass = request.getParameter("menteePassword");
        
        // 2. Populate Model
        Mentee mentee = new Mentee();
        mentee.setMenteeID(id);
        mentee.setMenteeFullname(name);
        mentee.setMenteeProgramme(prog);
        mentee.setMenteeSemester(sem);
        mentee.setMenteeEmail(email);
        mentee.setMenteePhone(phone);
        mentee.setMenteeUsername(user);
        mentee.setMenteePassword(pass);
        
        // 3. Call DAO
        MenteeDAO dao = new MenteeDAO();
        String result = dao.registerMentee(mentee);
        
        // 4. Handle Result
        if("SUCCESS".equals(result)) {
            // Redirect to Login Page with Success Message
            request.setAttribute("errMessage", "Registration Successful! Please Login.");
            request.getRequestDispatcher("login.jsp?role=mentee").forward(request, response);
        } else {
            // Failure: Go back to Register page with error
            request.setAttribute("errMessage", result);
            request.getRequestDispatcher("registerMentee.jsp").forward(request, response);
        }
    }
}