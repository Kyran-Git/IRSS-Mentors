<%-- 
    Document   : timetable
    Created on : Dec 14, 2025, 3:11:15 AM
    Author     : nikla
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.irssmentors.model.MentorTimetable"%>
<%
    if(session.getAttribute("mentorSession") == null) { response.sendRedirect("../login.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head><title>Manage Timetable</title></head>
<body>
    <h2>Manage Availability</h2>
    <a href="../MentorServlet?action=dashboard">Back to Dashboard</a>
    <hr>
    
    <!-- Add Slot Form -->
    <form action="../MentorServlet" method="POST">
        <input type="hidden" name="action" value="addSlot">
        Day: 
        <select name="day">
            <option>Monday</option><option>Tuesday</option><option>Wednesday</option>
            <option>Thursday</option><option>Friday</option>
        </select>
        Time: <input type="text" name="time" placeholder="e.g. 10am-12pm" required>
        <button type="submit">Add</button>
    </form>
    <br>
    
    <!-- View Slots -->
    <table border="1" cellpadding="5">
        <tr><th>Day</th><th>Time</th><th>Action</th></tr>
        <%
            List<MentorTimetable> slots = (List<MentorTimetable>) request.getAttribute("timetable");
            if (slots != null) {
                for (MentorTimetable s : slots) {
        %>
        <tr>
            <td><%= s.getAvailableDay() %></td>
            <td><%= s.getAvailableTime() %></td>
            <td><a href="../MentorServlet?action=removeSlot&id=<%= s.getMentorTimeID() %>">Remove</a></td>
        </tr>
        <%      }
            } %>
    </table>
</body>
</html>
