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
        <style>
            /* CONSISTENT DARK THEME */
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
            input[type="text"], input[type="number"] { 
                padding: 10px; background: #3d4648; border: 1px solid #555; color: white; border-radius: 4px; 
            }
            .inline-input { background: #1e2024 !important; border: 1px solid #555; color: #00d1b2 !important; padding: 5px !important; text-align: center; }
            
            .btn-submit { background-color: #27ae60; color: white; padding: 10px 20px; border: none; cursor: pointer; border-radius: 4px; font-weight: bold; }
            .btn-update { background-color: #f39c12; } /* Orange for sort button */
            .btn-cancel { background-color: #7f8c8d; text-decoration: none; padding: 10px 20px; color: white; border-radius: 4px; display:inline-block; text-align:center; font-size: 14px;}

            /* Alerts */
            .alert { padding: 15px; margin-bottom: 20px; border-radius: 4px; text-align: center; font-weight: bold; }
            .alert-success { background-color: rgba(39, 174, 96, 0.2); border: 1px solid #27ae60; color: #2ecc71; }
            .alert-error { background-color: rgba(231, 76, 60, 0.2); border: 1px solid #e74c3c; color: #ff7675; }
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
                    <button type="submit" class="btn-submit" style="padding: 8px 15px;">Search</button>
                </form>

                <%-- Dynamic Sorting Button (Simplified: Name <-> Programme) --%>
                <form action="AdminServlet" method="GET">
                    <input type="hidden" name="sortBy" value="${empty nextSort ? 'fullname' : nextSort}">
                    <button type="submit" class="btn-submit btn-update" style="padding: 8px 15px;">
                        Sort by: 
                        <c:choose>
                            <c:when test="${nextSort == 'programme'}">Programme</c:when>
                            <c:otherwise>Name</c:otherwise>
                        </c:choose>
                    </button>
                </form>

                <a href="AdminServlet" class="btn-cancel" style="padding: 8px 15px;">Reset</a>
            </div>

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
                                    
                                    <button type="submit" class="btn-submit" style="margin-top: 14px; padding: 8px 15px;">Add Record</button>
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