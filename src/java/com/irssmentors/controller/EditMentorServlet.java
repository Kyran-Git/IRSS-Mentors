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

    // Note: We removed 'processRequest' to clearly separate GET (Load/Delete) and POST (Update)

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        String action = request.getParameter("action");
        AdminDAO adminDao = new AdminDAO();

        // 1. DELETE LOGIC
        if ("delete".equals(action)) {
            adminDao.deleteMentor(id); // Using ID, not username
            response.sendRedirect("ListMentorServlet");
            return;
        }

        // 2. LOAD EDIT FORM LOGIC
        if (id != null && !id.isEmpty()) {
            // Get specific mentor by ID to populate form
            Mentor mentorToEdit = adminDao.getMentorByID(id);
            request.setAttribute("selectedMentor", mentorToEdit);
            
            // Also fetch the list so the table at the bottom is still visible
            request.setAttribute("mentorList", adminDao.getMentorList());
            
            // Forward (Keep the data alive)
            request.getRequestDispatcher("admin/manageMentors.jsp").forward(request, response);
        } else {
            response.sendRedirect("ListMentorServlet");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // UPDATE LOGIC
        String mentorID = request.getParameter("mentorID"); // Hidden field
        String username = request.getParameter("mentorUsername");
        String password = request.getParameter("mentorPassword");
        String fullname = request.getParameter("mentorFullname");
        String email = request.getParameter("mentorEmail");
        String phone = request.getParameter("mentorPhone");
        String faculty = request.getParameter("mentorFaculty");

        Mentor mentor = new Mentor();
        mentor.setMentorID(mentorID);
        mentor.setMentorUsername(username);
        mentor.setMentorPassword(password);
        mentor.setMentorFullname(fullname);
        mentor.setMentorEmail(email);
        mentor.setMentorPhone(phone);
        mentor.setMentorFaculty(faculty);

        AdminDAO adminDao = new AdminDAO();
        adminDao.updateMentor(mentor); // Calls the update method in DAO

        // Redirect to refresh list
        response.sendRedirect("ListMentorServlet");
    }
}