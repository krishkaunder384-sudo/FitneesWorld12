<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.gym_website.entities.User" %>

<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Map<String, String>> workouts =
            (List<Map<String, String>>) request.getAttribute("workouts");

    if (workouts == null) workouts = new ArrayList<>();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Workout History | FitnessWorld</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <style>
        body{
            background:#0b0b0b;
            color:#e5e7eb;
            font-family:Poppins, Arial, sans-serif;
            padding-top:90px;
        }
        .container-box{
            max-width:1200px;
            margin:auto;
            padding:0 20px 70px;
        }
        .card-box{
            background:rgba(20,20,20,0.95);
            border-radius:20px;
            padding:30px;
            box-shadow:0 25px 50px rgba(0,0,0,0.6);
        }
        h2{
            font-weight:800;
            text-align:center;
            margin-bottom:25px;
        }
        table{
            color:white;
        }
        thead{
            background:#ff2e2e;
            color:white;
        }
        .back-btn{
            margin-top:20px;
            text-align:center;
        }
        .small-muted{
            font-size: 0.85rem;
            color:#9ca3af;
        }
        a.video-link{
            color:#ff2e2e;
            font-weight:700;
            text-decoration:none;
        }
        a.video-link:hover{ text-decoration:underline; }
    </style>
</head>

<body>

<jsp:include page="navbar.jsp"/>

<div class="container-box">

    <div class="card-box">

        <h2>🏋️ Workout History</h2>

        <% if (workouts.isEmpty()) { %>
            <div class="text-center text-muted">
                No workout plans assigned yet.
            </div>
        <% } else { %>

            <div class="table-responsive">
                <table class="table table-dark table-bordered text-center">
                    <thead>
                    <tr>
                        <th>Workout Title</th>
                        <th>Level</th>
                        <th>Goal</th>
                        <th>Days/Week</th>
                        <th>Equipment</th>
                        <th>Split</th>
                        <th>Duration</th>
                        <th>Trainer</th>
                        <th>Assigned At</th>
                        <th>Video</th>
                    </tr>
                    </thead>

                    <tbody>
                    <% for (Map<String, String> w : workouts) { %>
                        <tr>
                            <td><%= w.get("title") %></td>
                            <td><%= w.get("level") %></td>
                            <td><%= w.get("goal") %></td>
                            <td><%= w.get("days_per_week") %></td>
                            <td><%= w.get("equipment") %></td>
                            <td><%= w.get("split_type") %></td>
                            <td><%= w.get("duration_weeks") %> w</td>
                            <td><%= w.get("trainerName") %></td>
                            <td><%= w.get("assigned_at") %></td>
                            <td>
                                <%
                                    String v = w.get("video_link");
                                    if (v != null && !v.trim().isEmpty()) {
                                %>
                                    <a class="video-link" href="<%= v %>" target="_blank">Watch</a>
                                <%
                                    } else {
                                %>
                                    <span class="small-muted">—</span>
                                <%
                                    }
                                %>
                            </td>
                        </tr>

                        <%
                            String notes = w.get("notes");
                            if (notes != null && !notes.trim().isEmpty()) {
                        %>
                        <tr>
                            <td colspan="10" class="text-left">
                                <span class="small-muted"><b>Notes:</b> <%= notes %></span>
                            </td>
                        </tr>
                        <% } %>

                    <% } %>
                    </tbody>

                </table>
            </div>

        <% } %>

        <div class="back-btn">
            <a href="<%= request.getContextPath() %>/user-dashboard"
               class="btn btn-outline-light">
                ← Back to Dashboard
            </a>
        </div>

    </div>

</div>

</body>
</html>
