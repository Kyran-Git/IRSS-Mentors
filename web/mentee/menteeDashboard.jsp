<%-- 
    Document   : menteeDashboard
    Created on : Dec 14, 2025, 3:11:24 AM
    Author     : nikla
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // SECURITY LOCK: Only allow if session is Mentee
    if(session.getAttribute("menteeSession") == null) {
        response.sendRedirect("../login.jsp?role=mentee"); // Kick them out
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
