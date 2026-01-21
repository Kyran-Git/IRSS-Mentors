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

        // 1. HANDLE UPDATES (POST Action)
        if ("updatePerformance".equals(action)) {
            String menteeID = request.getParameter("menteeID");
            String cgpaStr = request.getParameter("cgpa");
            
            if (menteeID != null && cgpaStr != null) {
                try {
                    double cgpa = Double.parseDouble(cgpaStr);
                    adminDAO.updateMenteePerformance(menteeID, cgpa);
                    request.setAttribute("message", "Performance updated successfully for " + menteeID);
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid CGPA format. Please enter a valid number.");
                }
            }
        }

        // 2. GET PARAMETERS FOR SEARCH AND SORT
        String searchName = request.getParameter("searchName");
        String sortBy = request.getParameter("sortBy");
        List<Mentee> menteeList;

        // 3. LOGIC LADDER (Prioritizes Search > Sort > Default)
        if (searchName != null && !searchName.trim().isEmpty()) {
            // Reusing your existing search method from the DAO
            menteeList = adminDAO.searchMenteesByName(searchName);
        } 
        else if (sortBy != null && !sortBy.isEmpty()) {
            // Reusing your existing sort method from the DAO
            menteeList = adminDAO.getSortedMenteeList(sortBy);
        } 
        else {
            // Default View
            menteeList = adminDAO.getMenteeList();
        }

        // 4. DETERMINE NEXT SORT STATE (Toggle Logic)
        // Cycles: fullname -> cgpa -> fullname
        String nextSort;
        if ("fullname".equals(sortBy)) {
            nextSort = "cgpa"; // This allows the button to toggle to CGPA sorting next
        } else {
            nextSort = "fullname"; // Default or reset toggle
        }

        // 5. SET ATTRIBUTES AND FORWARD
        request.setAttribute("menteeList", menteeList);
        request.setAttribute("nextSort", nextSort);
        
        // Forward to the consistent Performance JSP
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
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Controller for Admin to manage and filter Mentee academic performance";
    }
}