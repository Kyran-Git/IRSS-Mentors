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
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Performance</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>
        <jsp:include page="../navbar.jsp" />

        <div class="container">
            <h3>📈 Mentee Performance Management</h3>
            <p style="color: #b2bec3; margin-bottom: 20px;">Record and update academic results for students.</p>
            
            <%-- Status Messages --%>
            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <div style="display: flex; gap: 10px; margin-bottom: 20px; align-items: center;">
                
                <%-- Search Form --%>
                <form action="AdminServlet" method="GET" style="display: flex; gap: 5px;">
                    <input type="text" name="searchName" placeholder="Search mentee name..." value="${param.searchName}" style="width: 250px;">
                    <button type="submit" class="btn btn-primary" style="padding: 8px 15px;">Search</button>
                </form>

                <%-- Dynamic Sorting Button (Simplified: Name <-> Programme) --%>
                <form action="AdminServlet" method="GET">
                    <input type="hidden" name="sortBy" value="${empty nextSort ? 'fullname' : nextSort}">
                    <button type="submit" class="btn btn-primary" style="padding: 8px 15px;">
                        Sort by: 
                        <c:choose>
                            <c:when test="${nextSort == 'programme'}">Programme</c:when>
                            <c:otherwise>Name</c:otherwise>
                        </c:choose>
                    </button>
                </form>

                <a href="AdminServlet" class="btn btn-outline" style="padding: 8px 15px;">Reset</a>
            </div>

            <div class = "table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>Student ID</th>
                        <th>Full Name</th>
                        <th>Programme</th>
                        <th style="text-align: center; width: 400px;">Insert New Semester GPA</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="mentee" items="${menteeList}">
                        <tr>
                            <td>${mentee.menteeID}</td>
                            <td style="font-weight: 500;">${mentee.menteeFullname}</td>
                            <td style="font-size: 13px; color: #bdc3c7;">${mentee.menteeProgramme}</td>
                            <td style="background-color: rgba(255,255,255,0.02);">
                                <form action="AdminServlet" method="POST" style="display: flex; gap: 10px; justify-content: center; align-items: center;">
                                    <input type="hidden" name="action" value="insertGPA">
                                    <input type="hidden" name="menteeID" value="${mentee.menteeID}">
                                    
                                    <div style="display: flex; flex-direction: column; align-items: center;">
                                        <label style="font-size: 10px; color: #888; margin-bottom: 4px;">SEM</label>
                                        <input type="number" name="semester" class="inline-input" style="width: 50px;" min="1" max="10" required>
                                    </div>
                                    
                                    <div style="display: flex; flex-direction: column; align-items: center;">
                                        <label style="font-size: 10px; color: #888; margin-bottom: 4px;">GPA</label>
                                        <input type="number" step="0.01" name="gpa" class="inline-input" style="width: 70px;" min="0" max="4" required>
                                    </div>
                                    
                                    <button type="submit" class="btn btn-primary" style="margin-top: 14px; padding: 8px 15px;">Add Record</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty menteeList}">
                        <tr>
                            <td colspan="4" style="text-align: center; padding: 40px; color: #7f8c8d;">No mentees found.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </body>
</html>