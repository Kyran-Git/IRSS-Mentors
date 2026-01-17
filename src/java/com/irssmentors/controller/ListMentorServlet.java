
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

@WebServlet(name = "ListMentorServlet", urlPatterns = {"/ListMentorServlet"})
public class ListMentorServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String searchName = request.getParameter("searchName");
        AdminDAO adminDAO = new AdminDAO();
        List<Mentor> mentorList;

        if (searchName != null && !searchName.trim().isEmpty()) {
            mentorList = adminDAO.searchMentorsByName(searchName);
        } else {
            mentorList = adminDAO.getMentorList();
        }

        request.setAttribute("showList", true); 

        request.setAttribute("mentorList", mentorList);
        request.getRequestDispatcher("admin/manageMentors.jsp").forward(request, response);
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
        return "Short description";
    }

}
