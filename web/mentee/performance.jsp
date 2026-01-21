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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="../navbar.jsp" />
    <div class="container">
        <h2>Academic Performance History</h2>
        <a href="${pageContext.request.contextPath}/MenteeServlet?action=dashboard" class="btn-back">← Back to Dashboard</a>
        
        <div class ="table-wrapper">
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
    </div>
</body>
</html>