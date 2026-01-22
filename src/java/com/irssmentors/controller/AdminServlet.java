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
public class AdminServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        AdminDAO adminDAO = new AdminDAO();
        String action = request.getParameter("action");

        // 1. HANDLE POST UPDATES
        if ("updatePerformance".equals(action)) {
            String menteeID = request.getParameter("menteeID");
            String cgpaStr = request.getParameter("cgpa");
            
            if (menteeID != null && cgpaStr != null) {
                try {
                    double cgpa = Double.parseDouble(cgpaStr);
                    adminDAO.updateMenteePerformance(menteeID, cgpa);
                    request.setAttribute("message", "Performance updated for " + menteeID);
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid CGPA format.");
                }
            }
        }

        // 2. GET SEARCH AND SORT PARAMS
        String searchName = request.getParameter("searchName");
        String sortBy = request.getParameter("sortBy");
        List<Mentee> menteeList;

        // 3. SELECTION LOGIC
        if (searchName != null && !searchName.trim().isEmpty()) {
            menteeList = adminDAO.searchMenteesByName(searchName);
        } else if (sortBy != null && !sortBy.isEmpty()) {
            menteeList = adminDAO.getSortedMenteeList(sortBy);
        } else {
            menteeList = adminDAO.getMenteeList();
        }

        // 4. NEXT SORT STATE (3-WAY TOGGLE: Name -> CGPA -> Programme -> Name)
        String nextSort;
        if ("fullname".equals(sortBy)) {
            nextSort = "cgpa";
        } else if ("cgpa".equals(sortBy)) {
            nextSort = "programme";
        } else {
            nextSort = "fullname";
        }

        // 5. FORWARD
        request.setAttribute("menteeList", menteeList);
        request.setAttribute("nextSort", nextSort);
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