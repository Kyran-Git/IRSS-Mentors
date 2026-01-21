package com.irssmentors.controller;

import com.irssmentors.dao.AdminDAO;
import com.irssmentors.model.Mentor;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "CreateMentorServlet", urlPatterns = {"/CreateMentorServlet"})
public class CreateMentorServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("ListMentorServlet");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // 1. Get ALL parameters
        String mentorID = request.getParameter("mentorID");
        String mentorUsername = request.getParameter("mentorUsername");
        String mentorPassword = request.getParameter("mentorPassword");
        String mentorFullname = request.getParameter("mentorFullname");
        String mentorEmail = request.getParameter("mentorEmail");
        String mentorPhone = request.getParameter("mentorPhone");
        String mentorFaculty = request.getParameter("mentorFaculty");
        
        // 2. Set Object
        Mentor mentor = new Mentor();
        mentor.setMentorID(mentorID);
        mentor.setMentorUsername(mentorUsername);
        mentor.setMentorPassword(mentorPassword);
        mentor.setMentorFullname(mentorFullname);
        mentor.setMentorEmail(mentorEmail);
        mentor.setMentorPhone(mentorPhone);
        mentor.setMentorFaculty(mentorFaculty);
        
        // 3. Database Operation
        AdminDAO adminDAO = new AdminDAO();
        String userValidate = adminDAO.registerNewMentor(mentor);
        
        if(userValidate.equals("SUCCESS")){
            response.sendRedirect("ListMentorServlet");
        }
        else {
            request.setAttribute("errMessage", userValidate);
            request.setAttribute("mentorList", adminDAO.getMentorList());
            request.getRequestDispatcher("admin/manageMentors.jsp").forward(request, response);
        }
    }
}