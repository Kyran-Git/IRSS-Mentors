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

        request.setAttribute("menteeList", menteeList);
        request.getRequestDispatcher("admin/manageMenteePerformance.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}