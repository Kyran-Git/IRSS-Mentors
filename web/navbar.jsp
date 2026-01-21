<%-- 
    Document   : navbar
    Created on : Jan 22, 2026, 4:46:17 AM
    Author     : Ron
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<nav class="navbar">
    <a href="#" class="brand">
        <c:choose>
            <c:when test="${not empty adminSession}"><i class="fas fa-shield-alt"></i> Admin Portal</c:when>
            <c:when test="${not empty mentorSession}"><i class="fas fa-chalkboard-user"></i> Mentor Portal</c:when>
            <c:when test="${not empty menteeSession}"><i class="fas fa-user-graduate"></i> Student Portal</c:when>
            <c:otherwise><i class="fas fa-layer-group"></i> IRSS Mentors</c:otherwise>
        </c:choose>
    </a>

    <div class="nav-links">
        <c:if test="${not empty adminSession}">
            <a href="${pageContext.request.contextPath}/admin/adminDashboard.jsp" class="nav-item">Dashboard</a>
            <a href="${pageContext.request.contextPath}/ListMentorServlet" class="nav-item">Mentors</a>
        </c:if>

        <c:if test="${not empty mentorSession}">
            <a href="${pageContext.request.contextPath}/MentorServlet?action=dashboard" class="nav-item">Dashboard</a>
            <a href="${pageContext.request.contextPath}/MentorServlet?action=viewTimetable" class="nav-item">Timetable</a>
        </c:if>

        <c:if test="${not empty menteeSession}">
            <a href="${pageContext.request.contextPath}/MenteeServlet?action=dashboard" class="nav-item">Dashboard</a>
            <a href="${pageContext.request.contextPath}/MenteeServlet?action=viewProfile" class="nav-item">Profile</a>
        </c:if>

        <c:choose>
            <c:when test="${not empty adminSession || not empty mentorSession || not empty menteeSession}">
                <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn-logout">
                    <i class="fas fa-power-off"></i> Logout
                </a>
            </c:when>
            <c:otherwise>
                <a href="index.jsp" class="nav-item">Login</a>
            </c:otherwise>
        </c:choose>
    </div>
</nav>