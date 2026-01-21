<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Mentor Timetable</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="../navbar.jsp" />

    <div class="container">
        <h3>Available Slots</h3>
        <p>Please select a convenient time for your mentoring session.</p>

        
        <div class ="table-wrapper">
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
        </div>
        
        
        <br>
        <a href="MenteeServlet?action=dashboard" style="color: #3498db; text-decoration: none;">← Back to Dashboard</a>
    </div>
</body>
</html>