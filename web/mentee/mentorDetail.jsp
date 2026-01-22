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
    <title>My Mentor Details</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="../navbar.jsp" />

    <div class="container" style="max-width: 800px;">
        <div class="page-header">
            <h1><i class="fas fa-chalkboard-teacher"></i> Assigned Mentor</h1>
            <p>Contact details for your academic supervisor.</p>
        </div>

        <div class="card">
            <c:choose>
                <c:when test="${not empty assignedMentor}">
                    <div class="table-wrapper">
                        <table>
                            <tbody>
                                <tr>
                                    <th style="width: 30%;">Full Name</th>
                                    <td><b>${assignedMentor.mentorFullname}</b></td>
                                </tr>
                                <tr>
                                    <th>Faculty</th>
                                    <td>${assignedMentor.mentorFaculty}</td>
                                </tr>
                                <tr>
                                    <th>Email Address</th>
                                    <td>
                                        <a href="mailto:${assignedMentor.mentorEmail}" style="color: var(--primary);">
                                            ${assignedMentor.mentorEmail}
                                        </a>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Phone Number</th>
                                    <td>${assignedMentor.mentorPhone}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 2rem;">
                        <i class="fas fa-user-clock" style="font-size: 3rem; color: var(--text-muted); margin-bottom: 1rem;"></i>
                        <h3>No Mentor Assigned Yet</h3>
                        <p style="color: var(--text-muted);">Please contact the administrator or wait for assignment.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <br>
        <a href="${pageContext.request.contextPath}/MenteeServlet?action=dashboard" class="btn btn-outline">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>
</body>
</html>