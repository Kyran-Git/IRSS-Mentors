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
    // FAILSAFE: Load list if accessed directly or if attributes are missing
    if(request.getAttribute("menteeList") == null) {
        com.irssmentors.dao.AdminDAO tempDao = new com.irssmentors.dao.AdminDAO();
        request.setAttribute("menteeList", tempDao.getMenteeList());
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Manage Mentee Performance</title>
    <style>
        /* CONSISTENT DARK THEME - Matches Manage Mentor & Manage Mentees */
        body { margin: 0; font-family: 'Segoe UI', sans-serif; background-color: #1e2024; color: #ecf0f1; }
        
        .navbar { 
            background-color: #2c3e50; padding: 15px 30px; 
            display: flex; justify-content: space-between; align-items: center; 
            border-bottom: 3px solid #e74c3c; 
        }
        .navbar h2 { margin: 0; color: #ecf0f1; }
        .btn-logout { 
            padding: 8px 15px; background-color: #c0392b; color: white; 
            text-decoration: none; border-radius: 4px; font-size: 14px; 
        }
        
        .container { padding: 30px; max-width: 1200px; margin: 0 auto; }

        /* Table Section */
        table { width: 100%; border-collapse: collapse; background-color: #2d3436; border-radius: 8px; overflow: hidden; margin-top: 20px; }
        th { background-color: #e74c3c; color: white; padding: 15px; text-align: left; }
        td { padding: 12px; border-bottom: 1px solid #444; vertical-align: middle; }
        tr:hover { background-color: #3d4648; }

        /* Input and Button Styling */
        .cgpa-input { 
            width: 75px; padding: 8px; border-radius: 4px; border: 1px solid #555; 
            background: #1e2024; color: white; text-align: center;
        }
        .btn-submit { 
            background-color: #27ae60; color: white; border: none; 
            padding: 8px 15px; cursor: pointer; border-radius: 4px; 
            font-weight: bold; transition: 0.3s;
        }
        .btn-submit:hover { background-color: #219150; }
        
        .btn-sort { background-color: #f39c12; color: white; padding: 8px 15px; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; }

        /* Performance Badges */
        .badge { padding: 6px 12px; border-radius: 20px; font-size: 11px; font-weight: bold; display: inline-block; text-transform: uppercase; }
        .excellent { background-color: #27ae60; color: white; }
        .average { background-color: #f39c12; color: white; }
        .warning { background-color: #e74c3c; color: white; }

        /* Message Boxes */
        .msg-box { padding: 12px; margin-bottom: 20px; border-radius: 5px; text-align: center; font-weight: bold; }
        .success { background-color: #27ae60; color: white; }
        .error { background-color: #c0392b; color: white; }
        
        .search-input {
            width: 250px; padding: 8px; background: #3d4648; border: 1px solid #555; color: white; border-radius: 4px;
        }
    </style>
</head>
<body>

    <div class="navbar">
        <h2>📈 Mentee Performance Management</h2>
        <div style="display: flex; gap: 15px; align-items: center;">
            <a href="admin/adminDashboard.jsp" style="color: white; text-decoration: none;">Back</a>
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn-logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <c:if test="${not empty message}">
            <div class="msg-box success">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="msg-box error">${error}</div>
        </c:if>

        <h3>📋 Mentee Academic Overview</h3>
        <p style="color: #b2bec3; margin-bottom: 20px;">Monitor and update student CGPA and academic standings.</p>

        <div style="display: flex; gap: 10px; margin-bottom: 20px; align-items: center;">
            
            <form action="${pageContext.request.contextPath}/AdminServlet" method="GET" style="display: flex; gap: 5px;">
                <input type="text" name="searchName" placeholder="Search mentee name..." value="${param.searchName}" class="search-input">
                <button type="submit" class="btn-submit">Search</button>
            </form>

            <form action="${pageContext.request.contextPath}/AdminServlet" method="GET">
                <input type="hidden" name="sortBy" value="${empty nextSort ? 'fullname' : nextSort}">
                <button type="submit" class="btn-sort">
                    Sort by: 
                    <c:choose>
                        <c:when test="${nextSort == 'cgpa'}">Current Performance</c:when>
                        <c:otherwise>Student Name</c:otherwise>
                    </c:choose>
                </button>
            </form>

            <a href="${pageContext.request.contextPath}/AdminServlet" 
               style="color: #b2bec3; text-decoration: none; font-size: 14px; margin-left: 10px;">Reset View</a>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Student ID</th>
                    <th>Full Name</th>
                    <th>Update CGPA</th>
                    <th>Current Status</th>
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
                                
                                <form action="AdminServlet" method="POST">
                                    <input type="hidden" name="action" value="updatePerformance">
                                    <input type="hidden" name="menteeID" value="${mentee.menteeID}">
                                    
                                    <td>
                                        <input type="number" name="cgpa" step="0.01" min="0" max="4" 
                                               class="cgpa-input" value="${mentee.menteeCGPA}">
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${mentee.menteeCGPA >= 3.5}">
                                                <span class="badge excellent">Excellent</span>
                                            </c:when>
                                            <c:when test="${mentee.menteeCGPA >= 2.0}">
                                                <span class="badge average">Satisfactory</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge warning">At Risk</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="text-align: center;">
                                        <button type="submit" class="btn-submit" 
                                                onclick="return confirm('Confirm CGPA update for ${mentee.menteeFullname}?');">
                                            Update
                                        </button>
                                    </td>
                                </form>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="5" style="text-align: center; padding: 30px; color: #b2bec3;">
                                No students found. <a href="AdminServlet" style="color: #3498db;">Refresh List</a>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        <br><br>
    </div>
</body>
</html>