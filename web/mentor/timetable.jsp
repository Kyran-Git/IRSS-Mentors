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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>
        <jsp:include page="../navbar.jsp" />

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
                        <button type="submit" class="btn btn-primary">Add Slot</button>
                    </div>
                </form>
            </div>

            <!-- VIEW SLOTS TABLE -->
            <h3>Current Slots</h3>
            <div class="card" style="padding: 0; overflow: hidden;">
                
                <div class ="table-wrapper">
                    <table>
                    <thead>
                        <tr>
                            <th>Day</th>
                            <th>Time</th>
                            <th>Booked By</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="slot" items="${slotList}">
                            <tr>
                                <td>${slot.availableDay}</td>
                                <td>${slot.availableTime}</td>
                                <td style="color: #3498db;">
                                    ${empty slot.menteeName ? "—" : slot.menteeName}
                                </td>
                                <td>
                                    <a href="MentorServlet?action=removeSlot&id=${slot.mentorTimeID}" class="btn btn-remove">Remove</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                </div>
            </div>
        </div>
    </body>
</html>