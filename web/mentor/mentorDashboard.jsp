<%-- 
    Document   : mentorDashboard
    Created on : Dec 14, 2025, 3:10:38 AM
    Author     : nikla
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    // SECURITY LOCK: Only allow if session is Mentor
    if(session.getAttribute("mentorSession") == null) {
        response.sendRedirect("../login.jsp?role=mentor");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Mentor Dashboard</title>
    <style>
        /* Shared Dark Theme */
        body { margin: 0; font-family: 'Segoe UI', sans-serif; background-color: #1e2024; color: white; }
        
        /* Navbar */
        .navbar { background-color: #2d3436; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; border-bottom: 3px solid #3498db; }
        .navbar h2 { margin: 0; color: #3498db; }
        .btn-logout { padding: 8px 15px; background-color: #2980b9; color: white; text-decoration: none; border-radius: 5px; font-size: 14px; }

        /* Content */
        .container { padding: 40px; max-width: 1200px; margin: 0 auto; }
        .dashboard-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(350px, 1fr)); gap: 20px; margin-top: 20px; }

        .card { background-color: #2d3436; padding: 25px; border-radius: 10px; border: 1px solid #444; transition: 0.3s; }
        .card:hover { transform: translateY(-5px); border-color: #3498db; }
        
        .list-item { padding: 10px; border-bottom: 1px solid #444; display: flex; justify-content: space-between; align-items: center; }
        .list-item:last-child { border-bottom: none; }
        
        /* Inputs */
        select, input { padding: 8px; background: #1e2024; border: 1px solid #555; color: white; border-radius: 4px; }
        .btn-add { background: #3498db; border: none; padding: 8px 15px; color: white; border-radius: 4px; cursor: pointer; }
        .btn-remove { color: #e74c3c; text-decoration: none; font-size: 12px; border: 1px solid #e74c3c; padding: 2px 5px; border-radius: 3px; }
        .btn-remove:hover { background: #e74c3c; color: white; }
    </style>
</head>
<body>
    <div class="navbar">
        <h2>👨‍🏫 Mentor Dashboard</h2>
        <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn-logout">Logout</a>
    </div>

    <!-- ... Headers ... -->
    <div class="container">
        <h1>Welcome, ${mentorSession.mentorFullname}</h1>
        <div class="dashboard-grid">

            <!-- TIMETABLE SUMMARY -->
            <div class="card">
                <h3>📅 My Timetable</h3>
                <p>Manage your availability slots.</p>

                <!-- Link to the dedicated page -->
                <a href="${pageContext.request.contextPath}/MentorServlet?action=viewTimetable" class="btn-view">Manage Timetable</a>

                <br><br>
                <!-- Optional Preview -->
                <c:forEach var="slot" items="${timetableList}">
                    <div class="list-item">
                        <span>${slot.availableDay} - <small>${slot.availableTime}</small></span>
                    </div>
                </c:forEach>
            </div>

            <!-- MENTEE LIST -->
            <div class="card">
                <h3>🎓 My Assigned Mentees</h3>
                <c:choose>
                    <c:when test="${not empty menteeList}">
                        <c:forEach var="mentee" items="${menteeList}">
                            <div class="list-item">
                                ${mentee.menteeFullname} <br>
                                <small>${mentee.menteeProgramme} (Sem ${mentee.menteeSemester})</small>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise><p>No mentees assigned.</p></c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    </body>
</html>