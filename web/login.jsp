
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    if (request.getParameter("role") == null) {
        response.sendRedirect("Storyboard/index.html");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <style>
        body {
            margin: 0; padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1e2024 0%, #232526 100%);
            height: 100vh;
            display: flex; justify-content: center; align-items: center;
            color: white;
        }
        .login-card {
            background-color: #2d3436;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
            border: 1px solid #444;
            width: 100%; max-width: 350px;
            text-align: center;
        }
        h2 { margin-bottom: 20px; letter-spacing: 1px; }
        input {
            width: 100%; padding: 12px; margin: 10px 0;
            background-color: #1e2024; border: 1px solid #555;
            border-radius: 6px; color: white; box-sizing: border-box;
        }
        input:focus { outline: none; border-color: #3498db; }
        
        .btn-login {
            width: 100%; padding: 12px; margin-top: 15px;
            background-color: #27ae60; color: white;
            border: none; border-radius: 6px; font-weight: bold; cursor: pointer;
            transition: 0.3s;
        }
        .btn-login:hover { background-color: #2ecc71; box-shadow: 0 0 10px rgba(46, 204, 113, 0.4); }

        .links { margin-top: 15px; font-size: 13px; }
        .links a { color: #3498db; text-decoration: none; margin: 0 5px; cursor: pointer; }
        .links a:hover { text-decoration: underline; }
        
        .hidden { display: none; }
    </style>
    </head>
    <body>
        <div class="login-card">
        
        <form action="/IRSS-Mentors/LoginServlet" method="post">
            <input type="hidden" name="role" value="${param.role}">
            <input type="text" placeholder="Username" name="username" required>
            <input type="password" placeholder="Password" name="password" required>
            <input type="submit" value="Login">
        </form>
    
        <div class="links">
            <a href="#" onclick="alert('Reset password feature coming soon!')">Forgot Password?</a>
            <br><br>
            <c:if test="${param.role eq 'Mentee'}">
                <span id="signup-section">
                    New Student? <a href="Storyboard/register_mentee.html">Sign Up Here</a>
                </span>
            </c:if>
        </div>
        </div>
    </body>
</html>
