<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Mentor Details</title>
        <style>
            /* Keep your existing styles */
            body { margin: 0; font-family: 'Segoe UI', sans-serif; background-color: #1e2024; color: white; }
            .navbar { background-color: #2d3436; padding: 15px 30px; border-bottom: 3px solid #3498db; }
            .container { padding: 40px; max-width: 600px; margin: 0 auto; }
            .detail-card { background-color: #2d3436; padding: 30px; border-radius: 10px; border: 1px solid #444; }
            .info-group { margin-bottom: 20px; border-bottom: 1px solid #444; padding-bottom: 10px; }
            .label { color: #3498db; font-weight: bold; font-size: 14px; text-transform: uppercase; }
            .value { font-size: 18px; margin-top: 5px; }
            .btn-back { display: inline-block; margin-top: 20px; padding: 10px 20px; background-color: #444; color: white; text-decoration: none; border-radius: 5px; transition: 0.3s; }
            .btn-back:hover { background-color: #3498db; }
        </style>
    </head>
    <body>
        <div class="navbar">
            <h2>👤 Mentor Information</h2>
        </div>

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