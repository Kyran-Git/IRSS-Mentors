package com.irssmentors.controller;

import com.irssmentors.dao.AdminDAO;
import com.irssmentors.model.Mentee;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminServlet", urlPatterns = {"/AdminServlet"})
public class ListMenteePerformance extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        AdminDAO adminDAO = new AdminDAO();
        String searchName = request.getParameter("searchName");
        String sortBy = request.getParameter("sortBy");
        List<Mentee> menteeList;

        if (searchName != null && !searchName.trim().isEmpty()) {
            menteeList = adminDAO.searchMenteesByName(searchName);
        } else if (sortBy != null && !sortBy.isEmpty()) {
            menteeList = adminDAO.getSortedMenteeList(sortBy);
        } else {
            menteeList = adminDAO.getMenteeList();
        }

        String nextSort;
        if ("fullname".equals(sortBy)) {
            nextSort = "programme";
        } else {
            nextSort = "fullname";
        }

        // 3. SET ATTRIBUTES
        request.setAttribute("menteeList", menteeList);
        request.setAttribute("nextSort", nextSort);

        request.getRequestDispatcher("admin/manageMenteePerformance.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String action = request.getParameter("action");
        AdminDAO adminDAO = new AdminDAO();

        if ("insertGPA".equals(action)) {
            String menteeID = request.getParameter("menteeID");
            int semester = Integer.parseInt(request.getParameter("semester"));
            double gpa = Double.parseDouble(request.getParameter("gpa"));

            boolean success = adminDAO.insertMenteeGPA(menteeID, semester, gpa);

            if (success) {
                request.setAttribute("message", "GPA added successfully for " + menteeID);
            } else {
                request.setAttribute("error", "Failed to add GPA. Check if record already exists.");
            }
        }
        processRequest(request, response);
    }
}