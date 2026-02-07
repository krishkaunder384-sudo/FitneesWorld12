<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.gym_website.entities.*" %>

<%
    // 🔐 Trainer authentication check
    Trainer trainer = (Trainer) session.getAttribute("currentTrainer");
    if (trainer == null) {
        response.sendRedirect("trainer-login.jsp");
        return;
    }

    List<User> users = (List<User>) request.getAttribute("users");
    List<WorkoutPlan> workouts = (List<WorkoutPlan>) request.getAttribute("workouts");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Assign Workout | FitnessWorld</title>

    <!-- Bootstrap -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <style>
        body {
            background: #0b0b0b;
            color: #e5e7eb;
            font-family: "Poppins", Arial, sans-serif;
        }

        /* Page wrapper */
        .page-wrapper {
            max-width: 720px;
            margin: 60px auto;
            padding: 0 15px;
        }

        /* Card */
        .assign-card {
            background: rgba(20,20,20,0.95);
            border-radius: 18px;
            padding: 32px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.6);
        }

        .assign-card h4 {
            text-align: center;
            margin-bottom: 28px;
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
            border-radius: 10px;
        }

        select:focus {
            background: #111;
            border-color: #ff2e2e;
            color: #fff;
            box-shadow: none;
        }

        .btn-assign {
            background: #ff2e2e;
            border: none;
            border-radius: 30px;
            height: 46px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-assign:hover {
            background: #e60023;
            transform: translateY(-1px);
        }
    </style>
</head>

<body>

<div class="page-wrapper">

    <div class="assign-card">

        <h4>🏋️ Assign Workout Plan</h4>

        <form action="AssignWorkoutServlet" method="post">

            <!-- USER SELECT -->
            <div class="form-group">
                <label>Select User</label>
                <select name="userId" class="form-control" required>
                    <option value="">-- Select User --</option>
                    <% if (users != null) {
                        for (User u : users) { %>
                            <option value="<%= u.getId() %>">
                                <%= u.getName() %> ( <%= u.getEmail() %> )
                            </option>
                    <%  }
                    } %>
                </select>
            </div>

            <!-- WORKOUT SELECT -->
            <div class="form-group">
                <label>Select Workout Plan</label>
                <select name="workoutId" class="form-control" required>
                    <option value="">-- Select Workout --</option>
                    <% if (workouts != null) {
                        for (WorkoutPlan w : workouts) { %>
                            <option value="<%= w.getId() %>">
                                <%= w.getTitle() %> – <%= w.getLevel() %>
                            </option>
                    <%  }
                    } %>
                </select>
            </div>

            <!-- SUBMIT -->
            <button type="submit"
                    class="btn btn-assign btn-block mt-4">
                Assign Workout
            </button>

        </form>

    </div>

</div>

</body>
</html>
