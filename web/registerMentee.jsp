<%-- 
    Document   : registerMentee
    Created on : Jan 22, 2026, 5:42:32 AM
    Author     : Ron
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Registration</title>
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <jsp:include page="navbar.jsp" />

        <div class="container" style="max-width: 600px;">
            <div class="page-header" style="text-align: center;">
                <h1>Student Registration</h1>
                <p>Create your account to join the mentorship program.</p>
            </div>

            <!-- Error Message Box -->
            <c:if test="${not empty errMessage}">
                <div class="alert alert-error">${errMessage}</div>
            </c:if>

            <div class="card">
                <form action="RegisterMenteeServlet" method="POST">
                    
                    <label>Student ID (Matric No)</label>
                    <input type="text" name="menteeID" placeholder="e.g. S12345" required>

                    <label>Full Name</label>
                    <input type="text" name="menteeFullname" placeholder="John Doe" required>

                    <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 10px;">
                        <div>
                            <label>Programme</label>
                            <input type="text" name="menteeProgramme" placeholder="Computer Science" required>
                        </div>
                        <div>
                            <label>Semester</label>
                            <select name="menteeSemester">
                                <option value="1">1</option><option value="2">2</option>
                                <option value="3">3</option><option value="4">4</option>
                                <option value="5">5</option><option value="6">6</option>
                            </select>
                        </div>
                    </div>

                    <label>Email Address</label>
                    <input type="email" name="menteeEmail" placeholder="student@university.edu" required>

                    <label>Phone Number</label>
                    <input type="text" name="menteePhone" placeholder="012-3456789" required>

                    <hr style="border: 0; border-top: 1px solid #333; margin: 20px 0;">

                    <label>Username</label>
                    <input type="text" name="menteeUsername" required>

                    <label>Password</label>
                    <input type="password" name="menteePassword" required>

                    <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 10px;">Register Account</button>
                </form>
                
                <div style="text-align: center; margin-top: 20px; font-size: 0.9rem;">
                    Already have an account? <a href="login.jsp?role=mentee" style="color: var(--primary);">Login here</a>
                </div>
            </div>
        </div>
    </body>
</html>