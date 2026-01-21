<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // SECURITY LOCK: Only allow if session is Admin
    if(session.getAttribute("adminSession") == null) {
        response.sendRedirect("../login.jsp?role=admin"); 
        return;
    }
%>
<%
    // FAILSAFE: Load list if accessed directly
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
    <style>
        /* CONSISTENT DARK THEME - MATCHING MANAGE MENTEE */
        body { margin: 0; font-family: 'Segoe UI', sans-serif; background-color: #1e2024; color: #ecf0f1; }
        .navbar { background-color: #2c3e50; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; border-bottom: 3px solid #e74c3c; }
        .navbar h2 { margin: 0; color: #ecf0f1; }
        .btn-logout { padding: 8px 15px; background-color: #c0392b; color: white; text-decoration: none; border-radius: 4px; font-size: 14px; }
        .container { padding: 30px; max-width: 1200px; margin: 0 auto; }

        /* Table Styling */
        table { width: 100%; border-collapse: collapse; background-color: #2d3436; border-radius: 8px; overflow: hidden; margin-top: 20px; }
        th { background-color: #e74c3c; color: white; padding: 12px; text-align: left; }
        td { padding: 12px; border-bottom: 1px solid #444; vertical-align: middle; }
        tr:hover { background-color: #3d4648; }

        /* Controls Styling */
        .search-input, .cgpa-input { 
            padding: 10px; background: #3d4648; border: 1px solid #555; color: white; border-radius: 4px; 
        }
        .cgpa-input { width: 75px; text-align: center; background: #1e2024; }
        
        .btn-submit { background-color: #27ae60; color: white; padding: 10px 20px; border: none; cursor: pointer; border-radius: 4px; font-weight: bold; }
        .btn-sort { background-color: #f39c12; color: white; padding: 8px 15px; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; }
        .btn-cancel { background-color: #7f8c8d; text-decoration: none; padding: 8px 15px; color: white; border-radius: 4px; display:inline-block; text-align:center; font-size: 14px;}

        /* Performance Badges */
        .badge { padding: 6px 12px; border-radius: 20px; font-size: 11px; font-weight: bold; display: inline-block; text-transform: uppercase; }
        .excellent { background-color: #27ae60; color: white; }
        .average { background-color: #f39c12; color: white; }
        .warning { background-color: #e74c3c; color: white; }

        /* Message Boxes */
        .msg-box { padding: 12px; margin-bottom: 20px; border-radius: 5px; text-align: center; font-weight: bold; }
        .success { background-color: #27ae60; color: white; }
        .error { background-color: #c0392b; color: white; }
    </style>
</head>
<body>

    <div class="navbar">
        <h2>⚙️ Admin Portal</h2>
        <div style="display: flex; gap: 15px; align-items: center;">
            <a href="admin/adminDashboard.jsp" style="color: white; text-decoration: none;">Back</a>
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn-logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <c:if test="${not empty message}"><div class="msg-box success">${message}</div></c:if>
        <c:if test="${not empty error}"><div class="msg-box error">${error}</div></c:if>

        <h3>📈 Mentee Academic Overview</h3>
        <p style="color: #b2bec3; margin-bottom: 20px;">Monitor and update student CGPA and academic standings.</p>
        
        <div style="display: flex; gap: 10px; margin-bottom: 20px; align-items: center;">
            <form action="${pageContext.request.contextPath}/AdminServlet" method="GET" style="display: flex; gap: 5px;">
                <input type="text" name="searchName" placeholder="Search mentee name..." value="${param.searchName}" class="search-input" style="width: 250px;">
                <button type="submit" class="btn-submit" style="padding: 8px 15px;">Search</button>
            </form>

            <form action="${pageContext.request.contextPath}/AdminServlet" method="GET">
                <input type="hidden" name="sortBy" value="${empty nextSort ? 'fullname' : nextSort}">
                <button type="submit" class="btn-sort">
                    Sort by: 
                    <c:choose>
                        <c:when test="${nextSort == 'cgpa'}">Performance</c:when>
                        <c:when test="${nextSort == 'programme'}">Programme</c:when>
                        <c:otherwise>Name</c:otherwise>
                    </c:choose>
                </button>
            </form>

            <a href="${pageContext.request.contextPath}/AdminServlet" class="btn-cancel">Reset</a>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Student ID</th>
                    <th>Full Name</th>
                    <th>Programme</th>
                    <th>Update CGPA</th>
                    <th>Status</th>
                    <th style="text-align: center;">Action</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty menteeList}">
                        <c:forEach var="mentee" items="${menteeList}">
                            <tr>
                                <td>${mentee.menteeID}</td>
                                <td>${mentee.menteeFullname}</td>
                                <td style="color: #bdc3c7;">${mentee.menteeProgramme}</td>
                                
                                <form action="AdminServlet" method="POST">
                                    <input type="hidden" name="action" value="updatePerformance">
                                    <input type="hidden" name="menteeID" value="${mentee.menteeID}">
                                    <td>
                                        <input type="number" name="cgpa" step="0.01" min="0" max="4" 
                                               class="cgpa-input" value="${mentee.menteeCGPA}">
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${mentee.menteeCGPA >= 3.5}"><span class="badge excellent">Excellent</span></c:when>
                                            <c:when test="${mentee.menteeCGPA >= 2.0}"><span class="badge average">Satisfactory</span></c:when>
                                            <c:otherwise><span class="badge warning">At Risk</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="text-align: center;">
                                        <button type="submit" class="btn-submit" style="padding: 8px 15px;"
                                                onclick="return confirm('Update performance for ${mentee.menteeFullname}?');">Update</button>
                                    </td>
                                </form>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="6" style="text-align: center; padding: 30px; color: #b2bec3;">
                                No students found. <a href="AdminServlet" style="color: #e74c3c;">Refresh List</a>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</body>
</html>