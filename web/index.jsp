<%-- 
    Document   : index
    Description: Main Landing Page - Role Selection
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome - Student Mentorship System</title>
        
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        
        <style>
            body {
                justify-content: center;
                align-items: center;
                height: 100vh;
                background-image: radial-gradient(circle at top, #1f2937 0%, #0f1115 80%);
                overflow: hidden;
            }

            .welcome-card {
                background: var(--bg-card);
                border: var(--glass-border);
                border-radius: 20px;
                padding: 3rem;
                text-align: center;
                box-shadow: 0 20px 40px rgba(0,0,0,0.4);
                max-width: 800px;
                width: 90%;
                animation: fadeIn 0.8s ease-out;
            }

            .welcome-header h1 {
                font-size: 2.5rem;
                margin-bottom: 0.5rem;
                background: linear-gradient(to right, #fff, #94a3b8);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }
            
            .welcome-header p {
                color: var(--text-muted);
                font-size: 1.1rem;
                margin-bottom: 3rem;
            }

            /* Role Selection Grid */
            .role-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
            }

            .role-option {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 2rem 1.5rem;
                background: var(--bg-input);
                border: 1px solid #333;
                border-radius: 12px;
                text-decoration: none;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            /* Icons */
            .role-option i {
                font-size: 2.5rem;
                margin-bottom: 1rem;
                transition: transform 0.3s;
            }

            .role-option span {
                color: var(--text-main);
                font-weight: 600;
                font-size: 1.1rem;
            }

            /* Hover Effects & Specific Colors */
            .role-option:hover {
                transform: translateY(-5px);
                border-color: rgba(255,255,255,0.1);
            }

            /* Admin Style */
            .role-admin:hover {
                background: linear-gradient(145deg, rgba(239, 68, 68, 0.1), transparent);
                border-color: var(--accent);
            }
            .role-admin i { color: var(--accent); }

            /* Mentor Style */
            .role-mentor:hover {
                background: linear-gradient(145deg, rgba(245, 158, 11, 0.1), transparent);
                border-color: #f59e0b;
            }
            .role-mentor i { color: #f59e0b; }

            /* Mentee Style */
            .role-mentee:hover {
                background: linear-gradient(145deg, rgba(59, 130, 246, 0.1), transparent);
                border-color: var(--primary);
            }
            .role-mentee i { color: var(--primary); }

            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(20px); }
                to { opacity: 1; transform: translateY(0); }
            }
        </style>
    </head>
    <body>
        
        <div class="welcome-card">
            <div class="welcome-header">
                <h1>IRSS Mentorship Portal</h1>
                <p>Select your role to access the dashboard</p>
            </div>

            <div class="role-grid">
                <!-- Admin Button -->
                <a href="login.jsp?role=admin" class="role-option role-admin">
                    <i class="fas fa-user-shield"></i>
                    <span>Admin</span>
                </a>

                <!-- Mentor Button -->
                <a href="login.jsp?role=mentor" class="role-option role-mentor">
                    <i class="fas fa-chalkboard-user"></i>
                    <span>Mentor</span>
                </a>

                <!-- Mentee Button -->
                <a href="login.jsp?role=mentee" class="role-option role-mentee">
                    <i class="fas fa-user-graduate"></i>
                    <span>Student</span>
                </a>
            </div>
            
            <div style="margin-top: 2.5rem; font-size: 0.9rem; color: #555;">
                &copy; 2026 Student Mentorship System
            </div>
        </div>

    </body>
</html>