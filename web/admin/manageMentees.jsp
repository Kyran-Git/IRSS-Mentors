<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("adminSession") == null) {
        response.sendRedirect("../login.jsp?role=admin");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Mentees</title>
    <style>
        body { margin: 0; font-family: 'Segoe UI', sans-serif; background-color: #1e2024; color: #ecf0f1; }
        .navbar { background-color: #2c3e50; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; border-bottom: 3px solid #e74c3c; }
        .btn-logout { padding: 8px 15px; background-color: #c0392b; color: white; text-decoration: none; border-radius: 4px; }
        .container { padding: 30px; max-width: 1200px; margin: 0 auto; }
        table { width: 100%; border-collapse: collapse; background-color: #2d3436; margin-top: 20px; border-radius: 8px; overflow: hidden; }
        th { background-color: #e74c3c; color: white; padding: 12px; text-align: left; }
        td { padding: 12px; border-bottom: 1px solid #444; }
        .btn-submit { background-color: #27ae60; color: white; padding: 8px 15px; border: none; cursor: pointer; border-radius: 4px; font-weight: bold; }
        .status-assigned { color: #2ecc71; font-weight: bold; }
        .status-unassigned { color: #f1c40f; font-style: italic; }
        select { padding: 8px; background: #3d4648; border: 1px solid #555; color: white; border-radius: 4px; }
    </style>
</head>
<body>
    <div class="navbar">
        <h2>⚙️ Admin Portal</h2>
        <div>
            <a href="admin/adminDashboard.jsp" style="color: white; text-decoration: none; margin-right: 15px;">Back</a>
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn-logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <h3>🎓 Mentee Management & Assignment</h3>
        
        <div style="display: flex; gap: 10px; margin-bottom: 20px; align-items: center;">
            <form action="ListMenteeServlet" method="GET">
                <input type="text" name="searchName" placeholder="Search mentee name..." value="${param.searchName}" 
                       style="width: 250px; padding: 8px; background: #3d4648; border: 1px solid #555; color: white; border-radius: 4px;">
                <button type="submit" class="btn-submit">Search</button>
            </form>

            <form action="ListMenteeServlet" method="GET">
                <select name="filterMentorID" onchange="this.form.submit()">
                    <option value="">-- Filter by Mentor --</option>
                    <c:forEach var="mentor" items="${mentorList}">
                        <option value="${mentor.mentorID}" ${param.filterMentorID == mentor.mentorID ? 'selected' : ''}>
                            ${mentor.mentorFullname}
                        </option>
                    </c:forEach>
                </select>
            </form>

            <form action="ListMenteeServlet" method="GET">
                <input type="hidden" name="sortBy" value="${empty nextSort ? 'fullname' : nextSort}">
                <button type="submit" class="btn-submit" style="background-color: #f39c12;">
                    Sort by: 
                    <c:choose>
                        <c:when test="${nextSort == 'programme'}">Programme</c:when>
                        <c:when test="${nextSort == 'status'}">Assignment Status</c:when>
                        <c:otherwise>Name</c:otherwise>
                    </c:choose>
                </button>
            </form>

            <a href="ListMenteeServlet" style="color: #b2bec3; text-decoration: none; font-size: 14px; margin-left: 10px;">Reset View</a>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Student ID</th>
                    <th>Full Name</th>
                    <th>Programme</th>
                    <th>Current Mentor</th>
                    <th style="width: 300px;">Assign Mentor</th>
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
                            <form action="ListMenteeServlet" method="POST" style="display: flex; gap: 5px;">
                                <input type="hidden" name="menteeID" value="${mentee.menteeID}">
                                <select name="mentorID" style="width: 100%;">
                                    <option value="">-- No Mentor --</option>
                                    <c:forEach var="mentor" items="${mentorList}">
                                        <option value="${mentor.mentorID}" ${mentor.mentorID == mentee.mentorID ? 'selected' : ''}>
                                            ${mentor.mentorFullname}
                                        </option>
                                    </c:forEach>
                                </select>
                                <button type="submit" class="btn-submit">Assign</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>