<%-- 
    Document   : manageMentors
    Created on : Dec 14, 2025, 3:10:06 AM
    Author     : nikla
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Mentor Page</title>
        <style>
            /* Shared Dark Theme */
            body {
                margin: 0; font-family: 'Segoe UI', sans-serif;
                background-color: #1e2024; color: white;
            }

            /* Navbar */
            .navbar {
                background-color: #2d3436; padding: 15px 30px;
                display: flex; justify-content: space-between; align-items: center;
                border-bottom: 1px solid #444;
            }
            .navbar h2 { margin: 0; color: #e74c3c; /* Red for Admin */ }
            .btn-logout {
                padding: 8px 15px; background-color: #c0392b; color: white;
                text-decoration: none; border-radius: 5px; font-size: 14px;
            }

            /* Main Content Grid */
            .container { padding: 40px; max-width: 1200px; margin: 0 auto; }
            .dashboard-grid {
                display: grid;
                gap: 20px; margin-top: 20px;
            }

            /* Action Cards */
            .card {
                background-color: #2d3436; padding: 25px; border-radius: 10px;
                text-align: center; border: 1px solid #444; transition: 0.3s;
            }
            .card:hover { transform: translateY(-5px); border-color: #e74c3c; }
            .card h3 { margin-top: 0; }
            .card p { color: #b2bec3; font-size: 14px; }

            .btn-action {
                display: inline-block; margin-top: 15px; padding: 10px 20px;
                background-color: #444; color: white; text-decoration: none;
                border-radius: 5px; transition: 0.3s;
            }
            .btn-action:hover { background-color: #e74c3c; }
        </style>
    </head>
    <body>
        <div class="navbar">
            <h2>⚙️ Admin Portal</h2>
            <a href="index.jsp" class="btn-logout">Logout</a>
        </div>

        <div class="container">
            <h1>Manage Mentors</h1>
            <p style="color: #b2bec3;">System Overview</p>

            <div class="dashboard-grid">
                <div class="card">
                    <h3>👥 Create Mentor</h3>
                    <p>Register new mentor</p>
                    <form action="/IRSS-Mentors/CreateMentorServlet" method="post">
                        <table>
                            <tr>
                                <td>Username:</td>
                                <td><input type="text" name="mentorUsername"></td>
                            </tr>
                            <tr>
                                <td>Password:</td>
                                <td><input type="text" name="mentorPassword"></td>
                            </tr>
                            <tr>
                                <td>Full Name:</td>
                                <td><input type="text" name="mentorFullname"></td>
                            </tr>
                            <tr>
                                <td>Email:</td>
                                <td><input type="text" name="mentorEmail"></td>
                            </tr>
                            <tr>
                                <td>Phone Number:</td>
                                <td><input type="text" name="mentorPhone"></td>
                            </tr>
                            <tr>
                                <td>Faculty:</td>
                                <td><input type="text" name="mentorFaculty"></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td><input type="submit" value="Register" class="btn-action"></td>
                            </tr> 
                        </table>
                    </form>
                </div>

                <div class="card">
                    <h3>👥 Mentors List</h3>
                    <p>View all profile mentors</p>
                    <a href="<c:url value='/ListMentorServlet' />" class="btn-action">View List</a>
                    <c:if test="${not empty mentorList}">
                        <table border="1">
                            <tr>
                                <th>Username</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Faculty</th>
                            </tr>

                            <c:forEach var="mentor" items="${mentorList}">
                                <tr>
                                    <td>${mentor.username}</td>
                                    <td>${mentor.fullname}</td>
                                    <td>${mentor.email}</td>
                                    <td>${mentor.phone}</td>
                                    <td>${mentor.faculty}</td>  
                                </tr>
                            </c:forEach>
                        </table>
                    </c:if>
                </div>

                <div class="card">
                    <h3>👥 Edit Mentor</h3>
                    <p>Update profile mentor</p>
                    <c:choose>
                        <c:when test="${empty selectedMentor}">
                            <form action="EditMentorServlet" method="get">
                                <table>
                                    <tr>
                                        <td>Username:</td>
                                        <td><input type="text" name="username" placeholder="Enter username..." required></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td><input type="submit" value="Find Mentor" class="btn-action"></td>
                                    </tr>
                                </table>
                            </form>
                        </c:when>

                        <c:otherwise>
                            <form action="EditMentorServlet" method="post">
                                <table>
                                    <tr>
                                        <td>Username:</td>
                                        <td><input type="text" name="mentorUsername" value="${selectedMentor.username}" readonly></td>
                                    </tr>
                                    <tr>
                                        <td>Password:</td>
                                        <td><input type="text" name="mentorPassword" value="${selectedMentor.password}"></td>
                                    </tr>
                                    <tr>
                                        <td>Full Name:</td>
                                        <td><input type="text" name="mentorFullname" value="${selectedMentor.fullname}"></td>
                                    </tr>
                                    <tr>
                                        <td>Email:</td>
                                        <td><input type="text" name="mentorEmail" value="${selectedMentor.email}"></td>
                                    </tr>
                                    <tr>
                                        <td>Phone Number:</td>
                                        <td><input type="text" name="mentorPhone" value="${selectedMentor.phone}"></td>
                                    </tr>
                                    <tr>
                                        <td>Faculty:</td>
                                        <td><input type="text" name="mentorFaculty" value="${selectedMentor.faculty}"></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>
                                            <input type="submit" value="Update Data" class="btn-action">
                                            <a href="ListMentorServlet" class="btn-action">Cancel</a>
                                        </td>
                                    </tr> 
                                </table>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </body>
</html>
