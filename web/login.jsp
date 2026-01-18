<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    // 1. Get role from URL
    String role = request.getParameter("role");
    
    // 2. Safety Check: If no role is selected, send them back to the main page
    if (role == null || role.trim().isEmpty()) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    // 3. Capitalize for display (e.g., "admin" -> "Admin")
    String displayRole = role.substring(0, 1).toUpperCase() + role.substring(1);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= displayRole %> Login</title>
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
            h2 { margin-bottom: 20px; letter-spacing: 1px; color: #ecf0f1; }
            
            /* Dynamic Border Colors based on Role */
            .border-admin { border-top: 5px solid #e74c3c; }
            .border-mentor { border-top: 5px solid #f39c12; }
            .border-mentee { border-top: 5px solid #3498db; }

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
            
            .error-msg { color: #e74c3c; background: rgba(231, 76, 60, 0.1); padding: 10px; border-radius: 4px; margin-bottom: 15px; }
        </style>
    </head>
    <body>
        <!-- Dynamic class adds a colored border based on role -->
        <div class="login-card border-<%= role %>">
            
            <h2><%= displayRole %> Login</h2>
            
            <% if(request.getAttribute("errMessage") != null) { %>
                <div class="error-msg"><%= request.getAttribute("errMessage") %></div>
            <% } %>

            <form action="LoginServlet" method="POST">
                <input type="hidden" name="role" value="<%= role %>">
                
                <input type="text" name="username" placeholder="Username" required>
                <input type="password" name="password" placeholder="Password" required>

                <button type="submit" class="btn-login">Login</button>
            </form>

            <div class="links">
                <a href="index.jsp">Switch Role</a> |
                <a href="#" onclick="alert('Contact Admin to reset password.')">Forgot Password?</a>
                
                <c:if test="${param.role eq 'mentee'}">
                    <br><br>
                    <span>New Student? <a href="Storyboard/register_mentee.html">Sign Up Here</a></span>
                </c:if>
            </div>
        </div>
    </body>
</html>