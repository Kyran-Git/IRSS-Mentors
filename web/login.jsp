<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    // 1. Get role from URL
    String role = request.getParameter("role");
    
    // 2. Safety Check & Default
    if (role == null || role.trim().isEmpty()) {
        role = "mentee"; // Default to mentee if missing
    }
    
    // 3. Normalize to lowercase to prevent Case Sensitivity issues
    role = role.toLowerCase();
    
    // 4. Pass this normalized variable to the JSTL tags
    pageContext.setAttribute("currentRole", role);
    
    // 5. Capitalize for display title (e.g., "mentee" -> "Mentee")
    String displayRole = role.substring(0, 1).toUpperCase() + role.substring(1);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= displayRole %> Login</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link rel="stylesheet" href="css/style.css">
        <style>
            body {
                justify-content: center;
                align-items: center;
                height: 100vh;
                background-image: radial-gradient(circle at center, #1f2937 0%, #0f1115 100%);
            }
            .login-card {
                width: 100%;
                max-width: 400px;
                padding: 2.5rem;
                border-top: 5px solid; /* Dynamic color applied via class below */
                background: var(--bg-card);
                border-radius: var(--radius);
                box-shadow: var(--shadow-lg);
            }
            /* Dynamic Border Colors */
            .border-admin { border-color: var(--accent); }
            .border-mentor { border-color: #f39c12; }
            .border-mentee { border-color: var(--primary); }
            
            .links { 
                margin-top: 20px; 
                font-size: 0.9rem; 
                color: var(--text-muted); 
            }
            .links a { color: var(--primary); text-decoration: none; transition: 0.2s; }
            .links a:hover { text-decoration: underline; color: white; }
        </style>
    </head>
    <body>
        <div class="login-card border-${currentRole}">
            
            <div style="text-align: center; margin-bottom: 2rem;">
                <h2 style="font-size: 1.8rem; font-weight: 700;"><%= displayRole %> Login</h2>
                <p style="color: var(--text-muted);">Welcome back</p>
            </div>
            
            <!-- Error Message -->
            <c:if test="${not empty errMessage}">
                <div class="alert alert-error" style="font-size: 0.9rem; padding: 10px;">
                    ${errMessage}
                </div>
            </c:if>

            <form action="LoginServlet" method="POST">
                <input type="hidden" name="role" value="${currentRole}">
                
                <label>Username</label>
                <input type="text" name="username" placeholder="Enter username" required>
                
                <label>Password</label>
                <input type="password" name="password" placeholder="Enter password" required>

                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 10px; padding: 12px;">Login</button>
            </form>

            <div class="links" style="text-align: center;">
                <a href="index.jsp">Switch Role</a>
                <span style="margin: 0 5px; color: #444;">|</span>
                <a href="#" onclick="alert('Please contact the administrator to reset your password.')">Forgot Password?</a>
                
                <c:if test="${currentRole eq 'mentee'}">
                    <div style="margin-top: 20px; padding-top: 15px; border-top: 1px solid #333;">
                        New Student? <a href="registerMentee.jsp" style="font-weight: 600;">Sign Up Here</a>
                    </div>
                </c:if>
            </div>
        </div>
    </body>
</html>