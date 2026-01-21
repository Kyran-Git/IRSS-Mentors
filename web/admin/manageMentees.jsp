<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // SECURITY LOCK
    if(session.getAttribute("adminSession") == null) {
        response.sendRedirect("../login.jsp?role=admin");
        return;
    }
%>
<%
    // FAILSAFE: Load lists if accessed directly
    if(request.getAttribute("menteeList") == null) {
        com.irssmentors.dao.AdminDAO tempDao = new com.irssmentors.dao.AdminDAO();
        request.setAttribute("menteeList", tempDao.getMenteeList());
        request.setAttribute("mentorList", tempDao.getMentorList());
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Mentees</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>
        <jsp:include page="../navbar.jsp" />

        <div class="container">
            <h3>🎓 Mentee Management & Assignment</h3>
            <p style="color: #b2bec3; margin-bottom: 20px;">Assign students to their respective faculty mentors.</p>
            
            <div style="display: flex; gap: 10px; margin-bottom: 20px; align-items: center;">
                
                <form action="${pageContext.request.contextPath}/ListMenteeServlet" method="GET" style="display: flex; gap: 5px;">
                    <input type="text" name="searchName" placeholder="Search mentee name..." value="${param.searchName}" style="width: 250px;">
                    <button type="submit" class="btn btn-primary" style="padding: 8px 15px;">Search</button>
                </form>

                <form action="${pageContext.request.contextPath}/ListMenteeServlet" method="GET">
                    <select name="filterMentorID" onchange="this.form.submit()" style="padding: 8px;">
                        <option value="">-- Filter by Mentor --</option>
                        <c:forEach var="mentor" items="${mentorList}">
                            <option value="${mentor.mentorID}" ${param.filterMentorID == mentor.mentorID ? 'selected' : ''}>
                                ${mentor.mentorFullname}
                            </option>
                        </c:forEach>
                    </select>
                </form>

                <form action="${pageContext.request.contextPath}/ListMenteeServlet" method="GET">
                    <input type="hidden" name="sortBy" value="${empty nextSort ? 'fullname' : nextSort}">
                    <button type="submit" class="btn btn-primary" style="padding: 8px 15px;">
                        Sort by: 
                        <c:choose>
                            <c:when test="${nextSort == 'programme'}">Programme</c:when>
                            <c:when test="${nextSort == 'status'}">Assignment Status</c:when>
                            <c:otherwise>Name</c:otherwise>
                        </c:choose>
                    </button>
                </form>

                <a href="${pageContext.request.contextPath}/ListMenteeServlet" class="btn btn-outline" style="padding: 8px 15px;">Reset</a>
            </div>

            <div class ="table-wrapper">
                <table>
                <thead>
                    <tr>
                        <th>Student ID</th>
                        <th>Full Name</th>
                        <th>Programme</th>
                        <th>Current Mentor</th>
                        <th style="width: 320px;">Assign Mentor</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="mentee" items="${menteeList}">
                        <tr>
                            <td>${mentee.menteeID}</td>
                            <td>${mentee.menteeFullname}</td>
                            <td>${mentee.menteeProgramme}</td>
                            <td>
                                <c:set var="mName" value="" />
                                <c:forEach var="m" items="${mentorList}">
                                    <c:if test="${m.mentorID == mentee.mentorID}">
                                        <c:set var="mName" value="${m.mentorFullname}" />
                                    </c:if>
                                </c:forEach>
                                
                                <c:choose>
                                    <c:when test="${not empty mName}">
                                        <span class="status-assigned">${mName}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-unassigned">Not Assigned</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <form action="${pageContext.request.contextPath}/ListMenteeServlet" method="POST" style="display: flex; gap: 5px;">
                                    <input type="hidden" name="menteeID" value="${mentee.menteeID}">
                                    <select name="mentorID" style="width: 200px; padding: 5px;">
                                        <option value="">-- No Mentor --</option>
                                        <c:forEach var="mentor" items="${mentorList}">
                                            <option value="${mentor.mentorID}" ${mentor.mentorID == mentee.mentorID ? 'selected' : ''}>
                                                ${mentor.mentorFullname}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <button type="submit" class="btn btn-primary" style="padding: 5px 15px;">Assign</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            </div>
        </div>
    </body>
</html>