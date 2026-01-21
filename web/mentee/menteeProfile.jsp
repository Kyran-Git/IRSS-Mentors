<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if(session.getAttribute("menteeSession") == null) {
        response.sendRedirect("../login.jsp?role=mentee");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>My Profile</title>
        <style>
            body { margin: 0; font-family: 'Segoe UI', sans-serif; background-color: #1e2024; color: white; }
            .navbar { background-color: #2d3436; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; border-bottom: 3px solid #3498db; }
            .navbar h2 { margin: 0; color: #3498db; }
            .btn-back { padding: 8px 15px; background-color: #7f8c8d; color: white; text-decoration: none; border-radius: 5px; }
            
            .container { padding: 40px; max-width: 600px; margin: 0 auto; }
            .card { background-color: #2d3436; padding: 30px; border-radius: 10px; border: 1px solid #444; }
            
            table { width: 100%; border-collapse: collapse; margin-top: 10px; }
            td { padding: 12px; border-bottom: 1px solid #444; }
            td:first-child { font-weight: bold; color: #b2bec3; width: 40%; }
        </style>
    </head>
    <body>
        <div class="navbar">
            <h2>👤 My Profile</h2>
            <a href="${pageContext.request.contextPath}/MenteeServlet?action=dashboard" class="btn-back">← Back to Dashboard</a>
        </div>

        <div class="container">
            <div class="card">
                <h3 style="margin-top:0; border-bottom: 1px solid #3498db; padding-bottom: 10px;">Student Information</h3>
                
                <table>
                    <tr>
                        <td>Student ID</td>
                        <td>${menteeSession.menteeID}</td>
                    </tr>
                    <tr>
                        <td>Full Name</td>
                        <td>${menteeSession.menteeFullname}</td>
                    </tr>
                    <tr>
                        <td>Programme</td>
                        <td>${menteeSession.menteeProgramme}</td>
                    </tr>
                    <tr>
                        <td>Semester</td>
                        <td>${menteeSession.menteeSemester}</td>
                    </tr>
                    <tr>
                        <td>Email</td>
                        <td>${menteeSession.menteeEmail}</td>
                    </tr>
                    <tr>
                        <td>Phone</td>
                        <td>${menteeSession.menteePhone}</td>
                    </tr>
                    <tr>
                        <td>Assigned Mentor ID</td>
                        <td>${menteeSession.mentorID}</td>
                    </tr>
                </table>
            </div>
        </div>
    </body>
</html>