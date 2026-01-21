<%-- 
    Document   : performance
    Created on : Dec 14, 2025, 3:11:34 AM
    Author     : nikla
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    // Security check
    if(session.getAttribute("menteeSession") == null) {
        response.sendRedirect("../login.jsp?role=mentee");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Performance</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #1e2024; color: white; padding: 20px; }
        .container { max-width: 800px; margin: 0 auto; }
        
        /* Table Styling */
        table { width: 100%; border-collapse: collapse; margin-top: 20px; background-color: #2d3436; border-radius: 8px; overflow: hidden; }
        th { background-color: #3498db; color: white; padding: 12px; text-align: left; }
        td { padding: 12px; border-bottom: 1px solid #444; }
        tr:hover { background-color: #3d4648; }
        
        .btn-back { display: inline-block; padding: 10px 15px; background: #7f8c8d; color: white; text-decoration: none; border-radius: 5px; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Academic Performance History</h2>
        <a href="${pageContext.request.contextPath}/MenteeServlet?action=dashboard" class="btn-back">← Back to Dashboard</a>
        
        <table>
            <thead>
                <tr>
                    <th>Perf ID</th>
                    <th>Semester</th>
                    <th>GPA</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty performanceList}">
                        <c:forEach var="p" items="${performanceList}">
                            <tr>
                                <!-- Updated to match new MenteePerformance.java -->
                                <td>${p.perfID}</td>
                                <td>Semester ${p.semester}</td>
                                <td>${p.gpa}</td>
                                <td>
                                    <!-- Conditional Coloring -->
                                    <span style="color: ${p.status eq 'Pass' ? '#2ecc71' : '#e74c3c'}; font-weight: bold;">
                                        ${p.status}
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr><td colspan="4" style="text-align:center; padding: 20px;">No performance records found.</td></tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</body>
</html>