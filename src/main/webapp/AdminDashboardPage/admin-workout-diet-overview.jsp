<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.gym_website.helper.ConnectionProvider" %>

<%
    // 🔐 Admin login check
    Boolean admin = (Boolean) session.getAttribute("admin");
    if (admin == null || !admin) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?type=admin");
        return;
    }

    List<Map<String,String>> workouts = new ArrayList<>();
    List<Map<String,String>> diets = new ArrayList<>();

    try (Connection con = ConnectionProvider.getConnection()) {

        if (con != null) {

            // ✅ Fetch workouts
            String workoutSql =
                    "SELECT wp.title, wp.level, wp.duration_weeks, t.name AS trainer_name " +
                    "FROM workout_plans wp " +
                    "JOIN trainers t ON wp.trainer_id = t.id " +
                    "ORDER BY wp.id DESC";

            try (PreparedStatement ps = con.prepareStatement(workoutSql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Map<String,String> w = new HashMap<>();
                    w.put("title", rs.getString("title"));
                    w.put("level", rs.getString("level"));
                    w.put("duration", String.valueOf(rs.getInt("duration_weeks")));
                    w.put("trainerName", rs.getString("trainer_name"));
                    workouts.add(w);
                }
            }

            // ✅ Fetch diets
            String dietSql =
                    "SELECT dp.title, dp.goal, dp.calories, t.name AS trainer_name " +
                    "FROM diet_plans dp " +
                    "JOIN trainers t ON dp.trainer_id = t.id " +
                    "ORDER BY dp.id DESC";

            try (PreparedStatement ps = con.prepareStatement(dietSql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Map<String,String> d = new HashMap<>();
                    d.put("title", rs.getString("title"));
                    d.put("goal", rs.getString("goal"));
                    d.put("calories", String.valueOf(rs.getInt("calories")));
                    d.put("trainerName", rs.getString("trainer_name"));
                    diets.add(d);
                }
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Workout & Diet Library | Admin</title>

    <!-- Bootstrap -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        body { background: #f4f6f9; font-family: "Poppins", Arial, sans-serif; }

        .page-container { margin-left: 270px; padding: 40px; }

        .page-header {
            background: #fff;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 20px 45px rgba(0,0,0,0.12);
            margin-bottom: 30px;
        }

        .page-header span { color: #ff2e2e; }

        .card-box {
            background: #fff;
            padding: 25px;
            border-radius: 20px;
            box-shadow: 0 20px 45px rgba(0,0,0,0.12);
        }

        th { background: #111; color: #fff; text-align: center; }
        td { text-align: center; vertical-align: middle; }

        .badge-level {
            background: #ff2e2e;
            color: #fff;
            padding: 6px 14px;
            border-radius: 999px;
        }

        .badge-goal {
            background: #22c55e;
            color: #fff;
            padding: 6px 14px;
            border-radius: 999px;
        }

        .empty {
            text-align: center;
            padding: 40px;
            color: #6b7280;
            font-weight: 600;
        }

        @media (max-width: 992px) {
            .page-container { margin-left: 0; padding: 25px; }
        }
    </style>
</head>

<body>

<%@ include file="adminSidebar.jsp" %>

<div class="page-container">

    <div class="page-header">
        <h2>Workout & Diet <span>Library</span></h2>
        <p class="text-muted mb-0">
            View all workout and diet plans created by trainers.
        </p>
    </div>

    <ul class="nav nav-pills mb-4">
        <li class="nav-item">
            <a class="nav-link active" data-toggle="pill" href="#workouts">
                🏋️ Workouts
            </a>
        </li>
        <li class="nav-item ml-2">
            <a class="nav-link" data-toggle="pill" href="#diets">
                🥗 Diet Plans
            </a>
        </li>
    </ul>

    <div class="tab-content">

        <div class="tab-pane fade show active" id="workouts">
            <div class="card-box">

                <% if (workouts.isEmpty()) { %>
                    <div class="empty">No workout plans found.</div>
                <% } else { %>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Title</th>
                                    <th>Level</th>
                                    <th>Duration</th>
                                    <th>Trainer</th>
                                </tr>
                            </thead>
                            <tbody>
                            <% for (Map<String,String> w : workouts) { %>
                                <tr>
                                    <td><%= w.get("title") %></td>
                                    <td><span class="badge-level"><%= w.get("level") %></span></td>
                                    <td><%= w.get("duration") %> weeks</td>
                                    <td><%= w.get("trainerName") %></td>
                                </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>
                <% } %>

            </div>
        </div>

        <div class="tab-pane fade" id="diets">
            <div class="card-box">

                <% if (diets.isEmpty()) { %>
                    <div class="empty">No diet plans found.</div>
                <% } else { %>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Title</th>
                                    <th>Goal</th>
                                    <th>Calories</th>
                                    <th>Trainer</th>
                                </tr>
                            </thead>
                            <tbody>
                            <% for (Map<String,String> d : diets) { %>
                                <tr>
                                    <td><%= d.get("title") %></td>
                                    <td><span class="badge-goal"><%= d.get("goal") %></span></td>
                                    <td><%= d.get("calories") %> kcal</td>
                                    <td><%= d.get("trainerName") %></td>
                                </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>
                <% } %>

            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
