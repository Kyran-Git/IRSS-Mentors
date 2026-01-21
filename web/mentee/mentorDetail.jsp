<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Mentor Details</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>
        <jsp:include page="../navbar.jsp" />

        <div class="container">
            <div class="detail-card">
                <!-- 1. FULL NAME -->
                <div class="info-group">
                    <div class="label">Mentor Name</div>
                    <div class="value">${mentor.mentorFullname}</div>
                </div>
                
                <!-- 2. EMAIL -->
                <div class="info-group">
                    <div class="label">Email Address</div>
                    <div class="value">${mentor.mentorEmail}</div>
                </div>

                <!-- 3. PHONE -->
                <div class="info-group">
                    <div class="label">Phone Number</div>
                    <div class="value">${mentor.mentorPhone}</div>
                </div>
                
                <!-- 4. FACULTY -->
                <div class="info-group">
                    <div class="label">Faculty</div>
                    <div class="value">${mentor.mentorFaculty}</div>
                </div>

                <a href="${pageContext.request.contextPath}/MenteeServlet?action=dashboard" class="btn-back">← Back to Dashboard</a>
            </div>
        </div>
    </body>
</html>