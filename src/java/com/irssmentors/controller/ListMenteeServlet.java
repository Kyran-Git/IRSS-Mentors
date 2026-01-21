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

@WebServlet(name = "ListMenteeServlet", urlPatterns = {"/ListMenteeServlet"})
public class ListMenteeServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        AdminDAO adminDAO = new AdminDAO();

        // 1. HANDLE ASSIGNMENT
        String menteeID = request.getParameter("menteeID");
        String mentorID = request.getParameter("mentorID");
        if (menteeID != null && mentorID != null) {
            adminDAO.assignMentorToMentee(menteeID, mentorID);
        }

        // 2. GET PARAMETERS
        String searchName = request.getParameter("searchName");
        String filterMentorID = request.getParameter("filterMentorID");
        String sortBy = request.getParameter("sortBy");

        List<Mentee> menteeList;

        // 3. LOGIC LADDER (Prioritizes Search > Filter > Sort > Default)
        if (searchName != null && !searchName.trim().isEmpty()) {
            menteeList = adminDAO.searchMenteesByName(searchName);
        } 
        else if (filterMentorID != null && !filterMentorID.trim().isEmpty()) {
            menteeList = adminDAO.getMenteesByMentor(filterMentorID);
        } 
        else if (sortBy != null && !sortBy.isEmpty()) {
            menteeList = adminDAO.getSortedMenteeList(sortBy);
        } 
        else {
            menteeList = adminDAO.getMenteeList();
        }

        // 4. NEXT SORT CYCLE (Reverted: Name -> Programme -> Status -> Name)
        String nextSort;
        if ("fullname".equals(sortBy)) {
            nextSort = "programme";
        } else if ("programme".equals(sortBy)) {
            nextSort = "status";
        } else {
            nextSort = "fullname";
        }

        // 5. SET ATTRIBUTES AND FORWARD
        request.setAttribute("menteeList", menteeList);
        request.setAttribute("mentorList", adminDAO.getMentorList());
        request.setAttribute("nextSort", nextSort);

        request.getRequestDispatcher("admin/manageMentees.jsp").forward(request, response);
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
}