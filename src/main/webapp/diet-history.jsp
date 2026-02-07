<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.gym_website.entities.User" %>

<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Map<String, String>> diets =
            (List<Map<String, String>>) request.getAttribute("diets");

    if (diets == null) diets = new ArrayList<>();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Diet History | FitnessWorld</title>

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
    </style>
</head>

<body>

<jsp:include page="navbar.jsp"/>

<div class="container-box">

    <div class="card-box">

        <h2>🥗 Diet History</h2>

        <% if (diets.isEmpty()) { %>
            <div class="text-center text-muted">
                No diet plans assigned yet.
            </div>
        <% } else { %>

            <div class="table-responsive">
                <table class="table table-dark table-bordered text-center">
                    <thead>
                    <tr>
                        <th>Diet Title</th>
                        <th>Goal</th>
                        <th>Calories</th>
                        <th>Type</th>
                        <th>Meals/Day</th>
                        <th>Protein (g)</th>
                        <th>Carbs (g)</th>
                        <th>Fats (g)</th>
                        <th>Water (L)</th>
                        <th>Trainer</th>
                        <th>Assigned At</th>
                    </tr>
                    </thead>

                    <tbody>
                    <% for (Map<String, String> d : diets) { %>
                        <tr>
                            <td><%= d.get("title") %></td>
                            <td><%= d.get("goal") %></td>
                            <td><%= d.get("calories") %></td>
                            <td><%= d.get("diet_type") %></td>
                            <td><%= d.get("meals_per_day") %></td>
                            <td><%= d.get("protein_g") %></td>
                            <td><%= d.get("carbs_g") %></td>
                            <td><%= d.get("fats_g") %></td>
                            <td><%= d.get("water_liters") %></td>
                            <td><%= d.get("trainerName") %></td>
                            <td><%= d.get("assigned_at") %></td>
                        </tr>

                        <%
                            String avoid = d.get("foods_to_avoid");
                            if (avoid != null && !avoid.trim().isEmpty()) {
                        %>
                        <tr>
                            <td colspan="11" class="text-left">
                                <span class="small-muted"><b>Foods to Avoid:</b> <%= avoid %></span>
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
