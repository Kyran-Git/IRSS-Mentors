<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if(session.getAttribute("menteeSession") == null) {
        response.sendRedirect("../login.jsp?role=mentee");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>My Profile</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>
        <jsp:include page="../navbar.jsp" />

        <div class="container">
            <div class="card">
                <h3 style="margin-top:0; border-bottom: 1px solid #3498db; padding-bottom: 10px;">Student Information</h3>
                
                <div class ="table-wrapper">
                    <table>
                    <tr>
                        <td>Student ID</td>
                        <td>${menteeSession.menteeID}</td>
                    </tr>
                    <tr>
                        <td>Full Name</td>
                        <td>${menteeSession.menteeFullname}</td>
                    </tr>
                    <tr>
                        <td>Programme</td>
                        <td>${menteeSession.menteeProgramme}</td>
                    </tr>
                    <tr>
                        <td>Semester</td>
                        <td>${menteeSession.menteeSemester}</td>
                    </tr>
                    <tr>
                        <td>Email</td>
                        <td>${menteeSession.menteeEmail}</td>
                    </tr>
                    <tr>
                        <td>Phone</td>
                        <td>${menteeSession.menteePhone}</td>
                    </tr>
                    <tr>
                        <td>Assigned Mentor ID</td>
                        <td>${menteeSession.mentorID}</td>
                    </tr>
                </table>
                </div>
            </div>
        </div>
    </body>
</html>