<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.gym_website.entities.*" %>

<%
    Trainer trainer = (Trainer) session.getAttribute("currentTrainer");
    if (trainer == null) {
        response.sendRedirect("trainer-login.jsp");
        return;
    }

    List<User> users = (List<User>) request.getAttribute("users");
    List<WorkoutPlan> workouts = (List<WorkoutPlan>) request.getAttribute("workouts");
    List<DietPlan> diets = (List<DietPlan>) request.getAttribute("diets");

    // ✅ Booking Stats (coming from servlet)
    Integer totalBookings = (Integer) request.getAttribute("totalBookings");
    Integer pendingBookings = (Integer) request.getAttribute("pendingBookings");
    Integer approvedBookings = (Integer) request.getAttribute("approvedBookings");
    Integer cancelledBookings = (Integer) request.getAttribute("cancelledBookings");

    if (totalBookings == null) totalBookings = 0;
    if (pendingBookings == null) pendingBookings = 0;
    if (approvedBookings == null) approvedBookings = 0;
    if (cancelledBookings == null) cancelledBookings = 0;
%>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
response.setHeader("Pragma", "no-cache"); // HTTP 1.0
response.setDateHeader("Expires", 0); // Proxies
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Trainer Dashboard | FitnessWorld</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <style>
        body {
            background: #0b0b0b;
            color: #e5e7eb;
            font-family: "Poppins", Arial, sans-serif;
        }

        .dashboard-container {
            max-width: 1150px;
            margin: 60px auto;
            padding: 0 15px;
        }

        /* HERO */
        .trainer-hero {
            background: linear-gradient(135deg, #000, #1c1c1c);
            padding: 42px;
            border-radius: 22px;
            margin-bottom: 40px;
            box-shadow: 0 30px 60px rgba(0,0,0,0.6);
        }

        .trainer-hero span {
            color: #ff2e2e;
        }

        /* STATS */
        .stat-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 24px;
            margin-bottom: 25px;
        }

        .stat-card {
            background: rgba(20,20,20,0.95);
            padding: 26px;
            border-radius: 18px;
            text-align: center;
            box-shadow: 0 20px 40px rgba(0,0,0,0.6);
        }

        .stat-card h3 {
            font-weight: 800;
            color: #ff2e2e;
            margin-bottom: 6px;
        }

        .stat-card p {
            color: #aaa;
            font-size: 0.85rem;
        }

        /* ACTION CARDS */
        .dash-card {
            background: rgba(20,20,20,0.95);
            border-radius: 22px;
            padding: 30px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.6);
            height: 100%;
        }

        label {
            color: #bbb;
            font-size: 0.85rem;
            font-weight: 500;
        }

        select {
            background: #111;
            border: 1px solid #333;
            color: #fff;
            height: 46px;
            border-radius: 12px;
        }

        select:focus {
            background: #111;
            border-color: #ff2e2e;
            color: #fff;
            box-shadow: none;
        }

        .btn-primary,
        .btn-success {
            background: #ff2e2e;
            border: none;
            border-radius: 30px;
            height: 46px;
            font-weight: 600;
        }

        .btn-primary:hover,
        .btn-success:hover {
            background: #e60023;
        }

        .logout-btn {
            margin-top: 50px;
        }

        /* Booking badges */
        .booking-mini-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
            gap: 16px;
            margin: 20px 0;
        }

        .mini-box {
            background: #111;
            border: 1px solid #2a2a2a;
            border-radius: 16px;
            padding: 16px;
            text-align: center;
        }

        .mini-box h4 {
            margin: 0;
            font-weight: 800;
            color: #fff;
        }

        .mini-box p {
            margin: 6px 0 0;
            color: #9ca3af;
            font-size: 0.85rem;
        }

        .mini-red h4 { color: #ff2e2e; }
        .mini-yellow h4 { color: #facc15; }
        .mini-green h4 { color: #22c55e; }
        .mini-gray h4 { color: #94a3b8; }

        /* ✅ Quick buttons */
        .quick-actions {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            justify-content: center;
            margin-bottom: 35px;
        }

        .quick-actions a {
            padding: 12px 22px;
            border-radius: 30px;
            font-weight: 700;
            font-size: 0.95rem;
            text-decoration: none;
            display: inline-block;
            transition: 0.25s;
        }

        .btn-add-workout {
            background: #ff2e2e;
            color: white;
        }

        .btn-add-workout:hover {
            background: #e60023;
            color: white;
        }

        .btn-add-diet {
            background: #111;
            border: 1px solid #ff2e2e;
            color: #ff2e2e;
        }

        .btn-add-diet:hover {
            background: #ff2e2e;
            color: #fff;
        }
    </style>
</head>

<body>

<div class="dashboard-container">

    <!-- HERO -->
    <div class="trainer-hero">
        <h2>
            Welcome, <span><%= trainer.getName() %></span> 💪
        </h2>
        <p class="mb-0">
            Assign workouts & diet plans to help members reach their goals.
        </p>
    </div>

    <% String msg = (String) session.getAttribute("msg"); %>
    <% if (msg != null) { %>
        <div class="alert alert-info text-center" style="border-radius:12px;">
            <%= msg %>
        </div>
    <% session.removeAttribute("msg"); } %>

    <!-- STATS -->
    <div class="stat-grid">
        <div class="stat-card">
            <h3><%= users != null ? users.size() : 0 %></h3>
            <p>Assigned Members</p>
        </div>

        <div class="stat-card">
            <h3><%= workouts != null ? workouts.size() : 0 %></h3>
            <p>Workout Plans</p>
        </div>

        <div class="stat-card">
            <h3><%= diets != null ? diets.size() : 0 %></h3>
            <p>Diet Plans</p>
        </div>

        <div class="stat-card">
            <h3><%= totalBookings %></h3>
            <p>Total Bookings</p>
        </div>
    </div>

    <!-- ✅ QUICK ACTIONS (OPTION 1) -->
    <div class="quick-actions">
        <a class="btn-add-workout" href="<%= request.getContextPath() %>/add-workout.jsp">
            ➕ Add Workout Plan
        </a>

        <a class="btn-add-diet" href="<%= request.getContextPath() %>/add-diet.jsp">
            ➕ Add Diet Plan
        </a>
    </div>

    <!-- ACTIONS -->
    <div class="row">

        <!-- ASSIGN WORKOUT -->
        <div class="col-md-6 mb-4">
            <div class="dash-card">
                <h5 class="mb-4">🏋️ Assign Workout Plan</h5>

                <form action="assign-workout" method="post">

                    <label>Select Member</label>
                    <select name="userId" class="form-control mb-3" required>
                        <option value="">-- Choose Member --</option>
                        <% if (users != null) {
                            for (User u : users) { %>
                                <option value="<%= u.getId() %>"><%= u.getName() %></option>
                        <%  }
                        } %>
                    </select>

                    <label>Select Workout</label>
                    <select name="workoutId" class="form-control mb-4" required>
                        <option value="">-- Choose Workout --</option>
                        <% if (workouts != null) {
                            for (WorkoutPlan w : workouts) { %>
                                <option value="<%= w.getId() %>">
                                    <%= w.getTitle() %> • <%= w.getLevel() %>
                                </option>
                        <%  }
                        } %>
                    </select>

                    <button class="btn btn-primary btn-block">
                        Assign Workout
                    </button>
                </form>
            </div>
        </div>

        <!-- ASSIGN DIET -->
        <div class="col-md-6 mb-4">
            <div class="dash-card">
                <h5 class="mb-4">🥗 Assign Diet Plan</h5>

                <form action="assign-diet" method="post">

                    <label>Select Member</label>
                    <select name="userId" class="form-control mb-3" required>
                        <option value="">-- Choose Member --</option>
                        <% if (users != null) {
                            for (User u : users) { %>
                                <option value="<%= u.getId() %>"><%= u.getName() %></option>
                        <%  }
                        } %>
                    </select>

                    <label>Select Diet</label>
                    <select name="dietId" class="form-control mb-4" required>
                        <option value="">-- Choose Diet --</option>
                        <% if (diets != null) {
                            for (DietPlan d : diets) { %>
                                <option value="<%= d.getId() %>">
                                    <%= d.getTitle() %> • <%= d.getGoal() %>
                                </option>
                        <%  }
                        } %>
                    </select>

                    <button class="btn btn-success btn-block">
                        Assign Diet
                    </button>
                </form>
            </div>
        </div>
    </div>

    <!-- ✅ BOOKINGS SECTION -->
    <div class="row mt-2">
        <div class="col-md-12 mb-4">
            <div class="dash-card text-center">

                <h5 class="mb-2">📅 Trainer Session Bookings</h5>
                <p style="color:#aaa; font-size:0.9rem;">
                    View your session bookings and booking statuses.
                </p>

                <div class="booking-mini-grid">
                    <div class="mini-box mini-yellow">
                        <h4><%= pendingBookings %></h4>
                        <p>Pending</p>
                    </div>

                    <div class="mini-box mini-green">
                        <h4><%= approvedBookings %></h4>
                        <p>Approved</p>
                    </div>

                    <div class="mini-box mini-red">
                        <h4><%= cancelledBookings %></h4>
                        <p>Cancelled</p>
                    </div>

                    <div class="mini-box mini-gray">
                        <h4><%= totalBookings %></h4>
                        <p>Total</p>
                    </div>
                </div>

                <a href="<%= request.getContextPath() %>/trainer-bookings"
                   class="btn btn-outline-light btn-sm mt-2"
                   style="border-radius:30px; padding:10px 22px;">
                    View Bookings
                </a>

            </div>
        </div>
    </div>

    <!-- LOGOUT -->
    <div class="text-center logout-btn">
        <a href="trainer-logout" class="btn btn-outline-danger btn-sm">
            Logout
        </a>
    </div>

</div>

</body>
</html>
