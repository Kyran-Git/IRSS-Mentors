<%-- 
    Document   : menteeDashboard.jsp
    Location   : web/mentee/menteeDashboard.jsp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    // SECURITY LOCK: Only allow if session is Mentee
    if(session.getAttribute("menteeSession") == null) {
        response.sendRedirect("../login.jsp?role=mentee");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mentee Dashboard</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>
        <jsp:include page="../navbar.jsp" />

        <div class="container">
            <!-- Pull Name from Session -->
            <h1>Welcome, ${menteeSession.menteeFullname}</h1>
            <p style="color: #b2bec3;">System Overview</p>

            <div class="dashboard-grid">
                
                <!-- 1. PERSONAL DETAILS -->
                <div class="card">
                    <h3>🎓 Personal Details</h3>
                    <p>View your profile and academic status.</p>
                    <a href="${pageContext.request.contextPath}/MenteeServlet?action=viewProfile" class="btn-action">View Profile</a>
                </div>

                <!-- 2. PERFORMANCE -->
                <div class="card">
                    <h3>👥 Performance</h3>
                    <p>Displays GPA and status per semester.</p>
                    <a href="${pageContext.request.contextPath}/MenteeServlet?action=viewPerformance" class="btn-action">Check Results</a>
                </div>

                <!-- 3. MENTOR DETAILS -->
                <div class="card">
                    <h3>📊 Mentor Details</h3>
                    <p>View your assigned mentor info.</p>
                    <a href="${pageContext.request.contextPath}/MenteeServlet?action=viewMentor" class="btn-action">View Mentor</a>
                </div>
                
                <!-- 4. TIMETABLE -->
                <div class="card">
                    <h3>📅 Mentor Timetable</h3>
                    <p>Check mentor availability slots.</p>
                    <a href="${pageContext.request.contextPath}/MenteeServlet?action=viewTimetable" class="btn-action">Book Slot</a>
                </div>
            </div>
        </div>
    </body>
</html>