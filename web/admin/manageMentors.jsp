<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // FAILSAFE: If accessed directly, load the list automatically
    if(request.getAttribute("mentorList") == null) {
        com.irssmentors.dao.AdminDAO tempDao = new com.irssmentors.dao.AdminDAO();
        request.setAttribute("mentorList", tempDao.getMentorList());
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Mentor Page</title>
        <style>
            /* Dark Theme Styling */
            body { margin: 0; font-family: 'Segoe UI', sans-serif; background-color: #1e2024; color: #ecf0f1; }
            .navbar { background-color: #2c3e50; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; border-bottom: 3px solid #e74c3c; }
            .navbar h2 { margin: 0; color: #ecf0f1; }
            .btn-logout { padding: 8px 15px; background-color: #c0392b; color: white; text-decoration: none; border-radius: 4px; font-size: 14px; }
            .container { padding: 30px; max-width: 1200px; margin: 0 auto; }
            
            /* Form Section */
            .form-card { background-color: #2d3436; padding: 25px; border-radius: 8px; margin-bottom: 30px; border: 1px solid #444; }
            .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
            input[type="text"], input[type="email"], input[type="password"] {
                width: 95%; padding: 10px; background: #3d4648; border: 1px solid #555; color: white; border-radius: 4px;
            }
            .btn-submit { background-color: #27ae60; color: white; padding: 10px 20px; border: none; cursor: pointer; border-radius: 4px; font-weight: bold; }
            .btn-update { background-color: #f39c12; }
            .btn-cancel { background-color: #7f8c8d; text-decoration: none; padding: 10px 20px; color: white; border-radius: 4px; display:inline-block; text-align:center;}

            /* Table Section */
            table { width: 100%; border-collapse: collapse; background-color: #2d3436; border-radius: 8px; overflow: hidden; }
            th { background-color: #e74c3c; color: white; padding: 12px; text-align: left; }
            td { padding: 12px; border-bottom: 1px solid #444; }
            tr:hover { background-color: #3d4648; }
            
            /* Action Links */
            .action-link { text-decoration: none; padding: 5px 10px; border-radius: 3px; font-size: 12px; margin-right: 5px; }
            .edit-link { background-color: #3498db; color: white; }
            .del-link { background-color: #c0392b; color: white; }
            
            .msg-box { padding: 10px; margin-bottom: 20px; border-radius: 5px; text-align: center; }
            .error { background-color: #c0392b; color: white; }
            .success { background-color: #27ae60; color: white; }
        </style>
    </head>
    <body>
        <div class="navbar">
            <h2>⚙️ Admin Portal</h2>
            <!-- Link Logout to Servlet if possible, otherwise index.jsp -->
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn-logout">Logout</a>
        </div>

        <div class="container">
            <!-- Error/Success Messages -->
            <c:if test="${not empty errMessage}">
                <div class="msg-box error">${errMessage}</div>
            </c:if>

            <!-- 1. UNIFIED FORM (Handles both Create and Edit) -->
            <div class="form-card">
                <c:choose>
                    <c:when test="${not empty selectedMentor}">
                        <h3>✏️ Edit Mentor: ${selectedMentor.mentorFullname}</h3>
                        <form action="${pageContext.request.contextPath}/EditMentorServlet" method="POST">
                            <!-- Hidden ID for Update -->
                            <input type="hidden" name="mentorID" value="${selectedMentor.mentorID}">
                            
                            <div class="form-grid">
                                <div><label>Username</label><br><input type="text" name="mentorUsername" value="${selectedMentor.mentorUsername}" required></div>
                                <div><label>Password</label><br><input type="text" name="mentorPassword" value="${selectedMentor.mentorPassword}" required></div>
                                <div><label>Full Name</label><br><input type="text" name="mentorFullname" value="${selectedMentor.mentorFullname}" required></div>
                                <div><label>Email</label><br><input type="email" name="mentorEmail" value="${selectedMentor.mentorEmail}" required></div>
                                <div><label>Phone</label><br><input type="text" name="mentorPhone" value="${selectedMentor.mentorPhone}" required></div>
                                <div><label>Faculty</label><br><input type="text" name="mentorFaculty" value="${selectedMentor.mentorFaculty}" required></div>
                            </div>
                            <br>
                            <button type="submit" class="btn-submit btn-update">Update Mentor</button>
                            <!-- FIX 1: Point Cancel to ListServlet to reset view -->
                            <a href="${pageContext.request.contextPath}/ListMentorServlet" class="btn-cancel">Cancel</a>
                        </form>
                    </c:when>
                    
                    <c:otherwise>
                        <h3>➕ Register New Mentor</h3>
                        <form action="${pageContext.request.contextPath}/CreateMentorServlet" method="POST">
                            <div class="form-grid">
                                <div><label>Mentor ID</label><br><input type="text" name="mentorID" placeholder="e.g. M001" required></div>
                                <div><label>Username</label><br><input type="text" name="mentorUsername" placeholder="Login Username" required></div>
                                <div><label>Password</label><br><input type="password" name="mentorPassword" placeholder="Login Password" required></div>
                                <div><label>Full Name</label><br><input type="text" name="mentorFullname" placeholder="Full Name" required></div>
                                <div><label>Email</label><br><input type="email" name="mentorEmail" placeholder="Email Address" required></div>
                                <div><label>Phone</label><br><input type="text" name="mentorPhone" placeholder="Phone Number" required></div>
                                <div><label>Faculty</label><br><input type="text" name="mentorFaculty" placeholder="Faculty Name" required></div>
                            </div>
                            <br>
                            <button type="submit" class="btn-submit">Register Mentor</button>
                        </form>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 2. MENTOR LIST TABLE -->
            <h3>📋 Registered Mentors</h3>
            
            <div style="display: flex; gap: 10px; margin-bottom: 10px;">
                <!-- Search Bar -->
                <form action="${pageContext.request.contextPath}/ListMentorServlet" method="GET" style="display: flex; gap: 5px;">
                    <input type="text" name="searchName" placeholder="Search by name..." value="${param.searchName}" style="width: 250px;">
                    <button type="submit" class="btn-submit" style="padding: 8px 15px;">Search</button>
                </form>

                <!-- FIX 2: Sort Button (Toggles between Name/Faculty based on Servlet logic) -->
                <form action="${pageContext.request.contextPath}/ListMentorServlet" method="GET">
                    <input type="hidden" name="sortBy" value="${empty nextSort ? 'fullname' : nextSort}">
                    <button type="submit" class="btn-submit btn-update" style="padding: 8px 15px;">
                        Sort by ${empty nextSort || nextSort == 'fullname' ? 'Name' : 'Faculty'}
                    </button>
                </form>

                <a href="${pageContext.request.contextPath}/ListMentorServlet" class="btn-cancel" style="padding: 8px 15px;">Reset</a>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Full Name</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Faculty</th>
                        <th style="text-align: center;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty mentorList}">
                            <c:forEach var="mentor" items="${mentorList}">
                                <tr>
                                    <td>${mentor.mentorID}</td>
                                    <td>${mentor.mentorFullname}</td>
                                    <td>${mentor.mentorUsername}</td>
                                    <td>${mentor.mentorEmail}</td>
                                    <td>${mentor.mentorPhone}</td>
                                    <td>${mentor.mentorFaculty}</td>
                                    <td style="text-align: center;">
                                        <!-- Edit Link: Triggers doGet in EditMentorServlet -->
                                        <a href="${pageContext.request.contextPath}/EditMentorServlet?id=${mentor.mentorID}" class="action-link edit-link">Edit</a>
                                        
                                        <!-- Delete Link: Triggers Delete action -->
                                        <a href="${pageContext.request.contextPath}/EditMentorServlet?action=delete&id=${mentor.mentorID}" 
                                           class="action-link del-link" 
                                           onclick="return confirm('Permanently delete ${mentor.mentorFullname}?');">Delete</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="7" style="text-align: center; padding: 20px;">
                                    No mentors found. <a href="${pageContext.request.contextPath}/ListMentorServlet" style="color: #3498db;">Refresh List</a>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
            <br><br>
        </div>
    </body>
</html>