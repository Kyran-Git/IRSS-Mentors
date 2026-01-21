<%-- 
    Document   : adminDashboard
    Created on : Dec 14, 2025, 3:09:54 AM
    Author     : nikla
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // SECURITY LOCK: Only allow if session is Admin
    if(session.getAttribute("adminSession") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?role=admin");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Dashboard</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>
        <jsp:include page="../navbar.jsp" />

        <div class="container">
            <h1>Welcome, Admin</h1>
            <p style="color: #b2bec3;">System Overview</p>

            <div class="dashboard-grid">
                <div class="card">
                    <h3>👥 Manage Mentors</h3>
                    <p>Register new mentors or update profiles.</p>
                    <a href="${pageContext.request.contextPath}/ListMentorServlet" class="btn-action">View Mentors</a>
                </div>

                <div class="card">
                    <h3>🎓 Manage Mentees</h3>
                    <p>View student list and assign mentors.</p>
                    <a href="${pageContext.request.contextPath}/ListMenteeServlet" class="btn-action">Assign Students</a>
                </div>

                <div class="card">
                    <h3>📊 Performance Reports</h3>
                    <p>Review overall CGPA statistics.</p>
                    <a href="${pageContext.request.contextPath}/AdminServlet" class="btn-action">View Reports</a>   
                </div>
            </div>
        </div>
    </body>
</html>
