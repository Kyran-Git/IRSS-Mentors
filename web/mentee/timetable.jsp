<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Mentor Timetable</title>
    <style>
        body { margin: 0; font-family: 'Segoe UI', sans-serif; background-color: #1e2024; color: white; }
        .navbar { background-color: #2d3436; padding: 15px 30px; border-bottom: 3px solid #3498db; }
        .container { padding: 40px; max-width: 900px; margin: 0 auto; }
        table { width: 100%; border-collapse: collapse; background: #2d3436; border-radius: 8px; overflow: hidden; }
        th { background: #3498db; padding: 15px; text-align: left; }
        td { padding: 15px; border-bottom: 1px solid #444; }
        .btn-select { background: #27ae60; color: white; padding: 8px 15px; text-decoration: none; border-radius: 4px; font-size: 14px; border: none; cursor: pointer; }
        .btn-select:hover { background: #2ecc71; }
        .btn-booked { background: #7f8c8d; color: white; padding: 8px 15px; border-radius: 4px; font-size: 14px; border: none; cursor: default; }
        .no-slots { text-align: center; padding: 40px; color: #b2bec3; }
    </style>
</head>
<body>
    <div class="navbar">
        <h2>📅 Mentor Availability</h2>
    </div>

    <div class="container">
        <h3>Available Slots</h3>
        <p>Please select a convenient time for your mentoring session.</p>

        <table>
            <thead>
                <tr>
                    <th>Day</th>
                    <th>Time</th>
                    <th>Action</th> <!-- Only 3 columns for Mentee -->
                </tr>
            </thead>
            <tbody>
                <c:forEach var="slot" items="${slotList}">
                    <tr>
                        <td>${slot.availableDay}</td>
                        <td>${slot.availableTime}</td>
                        <td>
                            <c:choose>
                                <%-- If the slot is already booked --%>
                                <c:when test="${not empty slot.bookedByID}">
                                    <button class="btn-booked">Booked</button>
                                </c:when>
                                <%-- If the slot is available --%>
                                <c:otherwise>
                                    <a href="MenteeServlet?action=bookSlot&slotID=${slot.mentorTimeID}" 
                                       class="btn-select" 
                                       onclick="return confirm('Confirm booking for ${slot.availableDay} at ${slot.availableTime}?')">
                                       Select Slot
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty slotList}">
                    <tr>
                        <td colspan="3" class="no-slots">Your mentor has not posted any availability yet.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
        
        <br>
        <a href="MenteeServlet?action=dashboard" style="color: #3498db; text-decoration: none;">← Back to Dashboard</a>
    </div>
</body>
</html>