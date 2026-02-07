<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.gym_website.entities.User" %>
<%@ page import="java.util.*" %>

<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>

<%!
    public String safe(java.util.Map<String,String> m, String key) {
        if (m == null) return "";
        String v = m.get(key);
        return (v == null) ? "" : v;
    }
%>


<%
    List<Map<String,String>> workouts =
            (List<Map<String,String>>) request.getAttribute("workouts");

    List<Map<String,String>> diets =
            (List<Map<String,String>>) request.getAttribute("diets");

    Map<String,String> latestWorkout = null;
    Map<String,String> latestDiet = null;

    if (workouts != null && !workouts.isEmpty()) latestWorkout = workouts.get(0);
    if (diets != null && !diets.isEmpty()) latestDiet = diets.get(0);


%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Dashboard | FitnessWorld</title>

    <!-- Bootstrap -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>

    <style>
        body {
            background: #0b0b0b;
            color: #e5e7eb;
            font-family: "Poppins", Arial, sans-serif;
            padding-top: 90px;
        }

        .dashboard-container {
            max-width: 1100px;
            margin: auto;
            padding: 0 20px 80px;
        }

        /* HERO */
        .dashboard-hero {
            background: linear-gradient(135deg, #111, #000);
            padding: 35px;
            border-radius: 22px;
            box-shadow: 0 30px 60px rgba(0,0,0,0.65);
            margin-bottom: 40px;
        }

        .dashboard-hero span {
            color: #ff2e2e;
        }

        .dashboard-hero p {
            color: #bbb;
            margin-top: 8px;
        }

        /* SECTION */
        .section-title {
            margin: 30px 0 14px;
            font-weight: 600;
        }

        .dashboard-card {
            background: rgba(20,20,20,0.95);
            border-radius: 18px;
            padding: 22px;
            margin-bottom: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.6);
            color: #ccc;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
            margin-bottom: 12px;
        }

        .status-pending {
            background: #f59e0b;
            color: #000;
        }

        .status-active {
            background: #22c55e;
            color: #000;
        }

        /* BIG PLAN CARD */
        .plan-big {
            border: 1px solid rgba(255,255,255,0.06);
            background: rgba(20,20,20,0.95);
            border-radius: 18px;
            padding: 24px;
            box-shadow: 0 20px 45px rgba(0,0,0,0.65);
        }

        .plan-big-title {
            font-size: 1.3rem;
            font-weight: 800;
            color: #fff;
            margin-bottom: 10px;
        }

        .plan-meta {
            color: #a1a1aa;
            font-size: 0.92rem;
            margin-bottom: 6px;
        }

        .fw-btn-outline {
            border: 1px solid #ff2e2e;
            background: transparent;
            color: #ff2e2e;
            padding: 9px 16px;
            border-radius: 999px;
            font-weight: 700;
            font-size: 0.88rem;
            text-decoration: none;
            transition: 0.25s ease;
        }

        .fw-btn-outline:hover {
            background: #ff2e2e;
            color: #fff;
            text-decoration: none;
        }

        /* QUICK ACTIONS */
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 24px;
            margin-top: 20px;
        }

        .action-card {
            background: rgba(20,20,20,0.95);
            padding: 30px 20px;
            border-radius: 20px;
            text-align: center;
            box-shadow: 0 25px 45px rgba(0,0,0,0.65);
            transition: transform 0.3s ease;
        }

        .action-card:hover {
            transform: translateY(-10px);
        }

        .action-icon {
            font-size: 2.5rem;
            margin-bottom: 14px;
            color: #ff2e2e;
        }

        .action-card a {
            color: #ff2e2e;
            font-weight: 600;
            text-decoration: none;
        }

        .action-card a:hover {
            text-decoration: underline;
        }

        /* NEW: Pills for extra info */
        .pill-wrap {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin: 14px 0 12px;
        }
        .pill {
            border: 1px solid rgba(255,255,255,0.08);
            background: rgba(0,0,0,0.35);
            padding: 7px 12px;
            border-radius: 999px;
            font-size: 0.82rem;
            color: #cbd5e1;
        }
        .pill b { color: #fff; }
        .video-link {
            color: #ff2e2e;
            font-weight: 700;
            text-decoration: none;
        }
        .video-link:hover { text-decoration: underline; }
        .note-box {
            margin-top: 10px;
            padding: 12px 14px;
            border-radius: 14px;
            border: 1px solid rgba(255,255,255,0.06);
            background: rgba(0,0,0,0.35);
            color: #cbd5e1;
            font-size: 0.9rem;
        }
    </style>
</head>

<body>

<jsp:include page="navbar.jsp"/>

<div class="dashboard-container">

    <!-- HERO -->
    <div class="dashboard-hero">
        <h2>
            Welcome back,
            <span><%= currentUser.getName() %></span>
        </h2>
        <p>
            Track your workouts, diet plans and fitness journey in one place.
        </p>
    </div>

    <!-- WORKOUT -->
    <h4 class="section-title">
        <i class="fa-solid fa-dumbbell"></i> Workout Plan
    </h4>

    <%
        if (latestWorkout == null) {
    %>
        <div class="dashboard-card">
            <span class="status-badge status-pending">Pending</span>
            <p class="mb-0">
                No workout assigned yet. Your trainer will assign one soon.
            </p>
        </div>
    <%
        } else {
            String videoLink = safe(latestWorkout, "video_link");
            String notes = safe(latestWorkout, "notes");
    %>
        <div class="plan-big">
            <span class="status-badge status-active">Active</span>

            <div class="plan-big-title">
                <%= latestWorkout.get("title") %>
            </div>

            <div class="plan-meta">Level: <b><%= safe(latestWorkout,"level") %></b></div>
            <div class="plan-meta">Duration: <b><%= safe(latestWorkout,"duration_weeks") %></b> weeks</div>
            <div class="plan-meta">Trainer: <b><%= safe(latestWorkout,"trainerName") %></b></div>
            <div class="plan-meta">Assigned At: <b><%= safe(latestWorkout,"assigned_at") %></b></div>

            <!-- ✅ NEW EXTRA INFO -->
            <div class="pill-wrap">
                <div class="pill">Goal: <b><%= safe(latestWorkout,"goal") %></b></div>
                <div class="pill">Days/Week: <b><%= safe(latestWorkout,"days_per_week") %></b></div>
                <div class="pill">Equipment: <b><%= safe(latestWorkout,"equipment") %></b></div>
                <div class="pill">Split: <b><%= safe(latestWorkout,"split_type") %></b></div>
            </div>

            <% if (videoLink != null && !videoLink.trim().isEmpty()) { %>
                <div class="plan-meta">
                    Video:
                    <a class="video-link" href="<%= videoLink %>" target="_blank">
                        Watch
                    </a>
                </div>
            <% } %>

            <% if (notes != null && !notes.trim().isEmpty()) { %>
                <div class="note-box">
                    <b>Notes:</b> <%= notes %>
                </div>
            <% } %>

            <div class="mt-3">
                <a class="fw-btn-outline"
                   href="<%= request.getContextPath() %>/workout-history">
                    View Workout History
                </a>
            </div>
        </div>
    <%
        }
    %>

    <!-- DIET -->
    <h4 class="section-title">
        <i class="fa-solid fa-apple-whole"></i> Diet Plan
    </h4>

    <%
        if (latestDiet == null) {
    %>
        <div class="dashboard-card">
            <span class="status-badge status-pending">Pending</span>
            <p class="mb-0">
                No diet plan assigned yet.
            </p>
        </div>
    <%
        } else {
            String avoid = safe(latestDiet, "foods_to_avoid");
    %>
        <div class="plan-big">
            <span class="status-badge status-active">Active</span>

            <div class="plan-big-title">
                <%= safe(latestDiet,"title") %>
            </div>

            <div class="plan-meta">Goal: <b><%= safe(latestDiet,"goal") %></b></div>
            <div class="plan-meta">Calories: <b><%= safe(latestDiet,"calories") %></b></div>
            <div class="plan-meta">Trainer: <b><%= safe(latestDiet,"trainerName") %></b></div>
            <div class="plan-meta">Assigned Date: <b><%= safe(latestDiet,"assigned_at") %></b></div>

            <!-- ✅ NEW EXTRA INFO -->
            <div class="pill-wrap">
                <div class="pill">Type: <b><%= safe(latestDiet,"diet_type") %></b></div>
                <div class="pill">Meals/Day: <b><%= safe(latestDiet,"meals_per_day") %></b></div>
                <div class="pill">Protein: <b><%= safe(latestDiet,"protein_g") %>g</b></div>
                <div class="pill">Carbs: <b><%= safe(latestDiet,"carbs_g") %>g</b></div>
                <div class="pill">Fats: <b><%= safe(latestDiet,"fats_g") %>g</b></div>
                <div class="pill">Water: <b><%= safe(latestDiet,"water_liters") %> L</b></div>
            </div>

            <% if (avoid != null && !avoid.trim().isEmpty()) { %>
                <div class="note-box">
                    <b>Foods to Avoid:</b> <%= avoid %>
                </div>
            <% } %>

            <div class="mt-3">
                <a class="fw-btn-outline"
                   href="<%= request.getContextPath() %>/diet-history">
                    View Diet History
                </a>
            </div>
        </div>
    <%
        }
    %>

    <!-- QUICK ACTIONS -->
    <h4 class="section-title">
        <i class="fa-solid fa-bolt"></i> Quick Actions
    </h4>

    <div class="quick-actions">

        <div class="action-card">
            <div class="action-icon">
                <i class="fa-solid fa-ticket"></i>
            </div>
            <a href="<%= request.getContextPath() %>/my-membership">
                View Membership
            </a>
        </div>

        <div class="action-card">
            <div class="action-icon">
                <i class="fa-solid fa-calendar-days"></i>
            </div>
            <a href="<%= request.getContextPath() %>/my-bookings">
                Trainer Sessions
            </a>
        </div>

        <div class="action-card">
            <div class="action-icon">
                <i class="fa-solid fa-user"></i>
            </div>
            <a href="<%= request.getContextPath() %>/profile.jsp">
                Update Profile
            </a>
        </div>

    </div>

</div>

</body>
</html>
