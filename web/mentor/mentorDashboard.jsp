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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="../navbar.jsp" />

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