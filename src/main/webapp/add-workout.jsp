<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.gym_website.entities.Trainer" %>

<%
    Trainer trainer = (Trainer) session.getAttribute("currentTrainer");
    if (trainer == null) {
        response.sendRedirect("trainer-login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Add Workout Plan | FitnessWorld</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <style>
        body {
            background: #0b0b0b;
            color: #fff;
            font-family: "Poppins", Arial, sans-serif;
        }

        .container-box {
            max-width: 720px;
            margin: 70px auto;
            background: rgba(20,20,20,0.95);
            padding: 35px;
            border-radius: 22px;
            box-shadow: 0 25px 60px rgba(0,0,0,0.6);
        }

        h3 span {
            color: #ff2e2e;
        }

        input, textarea, select {
            background: #111 !important;
            color: #fff !important;
            border: 1px solid #333 !important;
            border-radius: 12px !important;
        }

        input:focus, textarea:focus, select:focus {
            border-color: #ff2e2e !important;
            box-shadow: none !important;
        }

        .btn-red {
            background: #ff2e2e;
            border: none;
            border-radius: 30px;
            height: 46px;
            font-weight: 700;
        }

        .btn-red:hover {
            background: #e60023;
        }

        .btn-back {
            border-radius: 30px;
        }
    </style>
</head>

<body>

<div class="container container-box">

    <h3 class="mb-2">➕ Add Workout Plan</h3>
    <p style="color:#aaa;">Trainer: <span><%= trainer.getName() %></span></p>

    <% String msg = (String) session.getAttribute("msg"); %>
    <% if (msg != null) { %>
    <div class="alert alert-info text-center" style="border-radius:12px;">
        <%= msg %>
    </div>
    <% session.removeAttribute("msg"); } %>

    <form action="<%= request.getContextPath() %>/add-workout-plan" method="post">

        <div class="form-group">
            <label>Workout Title</label>
            <input type="text" name="title" class="form-control" required>
        </div>

        <div class="form-group">
            <label>Description</label>
            <textarea name="description" rows="4" class="form-control" required></textarea>
        </div>

        <div class="form-group">
            <label>Level</label>
            <select name="level" class="form-control" required>
                <option value="">-- Select Level --</option>
                <option value="Beginner">Beginner</option>
                <option value="Intermediate">Intermediate</option>
                <option value="Advanced">Advanced</option>
            </select>
        </div>

        <!-- ✅ NEW FIELD -->
        <div class="form-group">
            <label>Goal</label>
            <select name="goal" class="form-control" required>
                <option value="">-- Select Goal --</option>
                <option value="Fat Loss">Fat Loss</option>
                <option value="Muscle Gain">Muscle Gain</option>
                <option value="Strength">Strength</option>
                <option value="Endurance">Endurance</option>
            </select>
        </div>

        <!-- ✅ NEW FIELD -->
        <div class="form-group">
            <label>Days Per Week</label>
            <input type="number" name="daysPerWeek" class="form-control" min="1" max="7" required>
        </div>

        <!-- ✅ NEW FIELD -->
        <div class="form-group">
            <label>Equipment Required</label>
            <select name="equipment" class="form-control" required>
                <option value="">-- Select Equipment --</option>
                <option value="Bodyweight Only">Bodyweight Only</option>
                <option value="Dumbbells">Dumbbells</option>
                <option value="Resistance Bands">Resistance Bands</option>
                <option value="Gym Machines">Gym Machines</option>
                <option value="Full Gym">Full Gym</option>
            </select>
        </div>

        <!-- ✅ NEW FIELD -->
        <div class="form-group">
            <label>Workout Split Type</label>
            <select name="splitType" class="form-control" required>
                <option value="">-- Select Split --</option>
                <option value="Full Body">Full Body</option>
                <option value="Upper Lower">Upper Lower</option>
                <option value="Push Pull Legs">Push Pull Legs</option>
                <option value="Bro Split">Bro Split</option>
            </select>
        </div>

        <div class="form-group">
            <label>Duration (weeks)</label>
            <input type="number" name="durationWeeks" class="form-control" min="1" max="52" required>
        </div>

        <!-- ✅ NEW FIELD -->
        <div class="form-group">
            <label>Video Link (optional)</label>
            <input type="url" name="videoLink" class="form-control" placeholder="https://youtube.com/...">
        </div>

        <!-- ✅ NEW FIELD -->
        <div class="form-group">
            <label>Notes / Instructions (optional)</label>
            <textarea name="notes" rows="3" class="form-control"
                      placeholder="Explain warm-up, rest time, cardio, etc."></textarea>
        </div>

        <button type="submit" class="btn btn-red btn-block">
            Save Workout Plan
        </button>

        <a href="<%= request.getContextPath() %>/trainer-dashboard"
           class="btn btn-outline-light btn-block btn-back mt-3">
            ← Back to Dashboard
        </a>
    </form>

</div>

</body>
</html>
