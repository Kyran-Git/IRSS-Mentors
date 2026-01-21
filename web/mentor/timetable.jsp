<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    if(session.getAttribute("mentorSession") == null) {
        response.sendRedirect("../login.jsp?role=mentor");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Timetable</title>
        <style>
            body { margin: 0; font-family: 'Segoe UI', sans-serif; background-color: #1e2024; color: white; }
            .navbar { background-color: #2d3436; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; border-bottom: 3px solid #3498db; }
            .navbar h2 { margin: 0; color: #3498db; }
            .btn-back { padding: 8px 15px; background-color: #7f8c8d; color: white; text-decoration: none; border-radius: 5px; font-size: 14px; }
            .container { padding: 40px; max-width: 800px; margin: 0 auto; }
            .card { background-color: #2d3436; padding: 25px; border-radius: 10px; border: 1px solid #444; margin-bottom: 20px; }
            table { width: 100%; border-collapse: collapse; margin-top: 10px; }
            th { background-color: #3498db; color: white; padding: 10px; text-align: left; }
            td { padding: 10px; border-bottom: 1px solid #444; }
            input, select { padding: 10px; background: #1e2024; border: 1px solid #555; color: white; border-radius: 4px; width: 200px; }
            .btn-add { background: #27ae60; border: none; padding: 10px 20px; color: white; border-radius: 4px; cursor: pointer; }
            .btn-remove { background-color: #c0392b; color: white; text-decoration: none; padding: 5px 10px; border-radius: 4px; font-size: 12px; }
        </style>
    </head>
    <body>
        <div class="navbar">
            <h2>📅 Manage Timetable</h2>
            <a href="${pageContext.request.contextPath}/MentorServlet?action=dashboard" class="btn-back">← Back to Dashboard</a>
        </div>

        <div class="container">
            
            <!-- ADD SLOT FORM -->
            <div class="card">
                <h3>Add New Availability</h3>
                <form action="${pageContext.request.contextPath}/MentorServlet" method="POST" style="display: flex; gap: 10px; align-items: center;">
                    <input type="hidden" name="action" value="addSlot">
                    
                    <div>
                        <label>Day:</label><br>
                        <select name="availableDay" required>
                            <option>Monday</option>
                            <option>Tuesday</option>
                            <option>Wednesday</option>
                            <option>Thursday</option>
                            <option>Friday</option>
                        </select>
                    </div>
                    
                    <div>
                        <label>Time Range:</label><br>
                        <input type="text" name="availableTime" placeholder="e.g. 10:00 AM - 12:00 PM" required>
                    </div>
                    
                    <div style="margin-top: 18px;">
                        <button type="submit" class="btn-add">Add Slot</button>
                    </div>
                </form>
            </div>

            <!-- VIEW SLOTS TABLE -->
            <h3>Current Slots</h3>
            <div class="card" style="padding: 0; overflow: hidden;">
                <table>
                    <thead>
                        <tr>
                            <th>Day</th>
                            <th>Time</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty timetableList}">
                                <c:forEach var="slot" items="${timetableList}">
                                    <tr>
                                        <td>${slot.availableDay}</td>
                                        <td>${slot.availableTime}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/MentorServlet?action=removeSlot&id=${slot.mentorTimeID}" 
                                               class="btn-remove" onclick="return confirm('Delete this slot?');">Remove</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="3" style="text-align: center; padding: 20px; color: #b2bec3;">No availability slots found.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>