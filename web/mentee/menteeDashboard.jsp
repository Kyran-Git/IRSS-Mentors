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
        <style>
            /* Shared Dark Theme */
            body { margin: 0; font-family: 'Segoe UI', sans-serif; background-color: #1e2024; color: white; }
            .navbar { background-color: #2d3436; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; border-bottom: 3px solid #3498db; }
            .navbar h2 { margin: 0; color: #3498db; }
            .btn-logout { padding: 8px 15px; background-color: #2980b9; color: white; text-decoration: none; border-radius: 5px; font-size: 14px; }
            .container { padding: 40px; max-width: 1200px; margin: 0 auto; }
            .dashboard-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-top: 20px; }
            .card { background-color: #2d3436; padding: 25px; border-radius: 10px; text-align: center; border: 1px solid #444; transition: 0.3s; }
            .card:hover { transform: translateY(-5px); border-color: #3498db; }
            .card h3 { margin-top: 0; }
            .card p { color: #b2bec3; font-size: 14px; }
            .btn-action { display: inline-block; margin-top: 15px; padding: 10px 20px; background-color: #444; color: white; text-decoration: none; border-radius: 5px; transition: 0.3s; }
            .btn-action:hover { background-color: #3498db; }
        </style>
    </head>
    <body>
        <div class="navbar">
            <h2>👤 Mentee Portal</h2>
            <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn-logout">Logout</a>
        </div>

        <div class="container">
            <!-- Pull Name from Session -->
            <h1>Welcome, ${menteeSession.menteeFullname}</h1>
            <p style="color: #b2bec3;">System Overview</p>

            <div class="dashboard-grid">
                
                <!-- 1. PERSONAL DETAILS -->
                <div class="card">
                    <h3>🎓 Personal Details</h3>
                    <p>View your profile and academic status.</p>
                    <!-- Link to Servlet Action -->
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