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
    <title>Add Diet Plan | FitnessWorld</title>

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

        h3 span { color: #ff2e2e; }

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

        .btn-red:hover { background: #e60023; }

        .btn-back { border-radius: 30px; }
    </style>
</head>

<body>

<div class="container container-box">

    <h3 class="mb-2">➕ Add Diet Plan</h3>
    <p style="color:#aaa;">Trainer: <span><%= trainer.getName() %></span></p>

    <% String msg = (String) session.getAttribute("msg"); %>
    <% if (msg != null) { %>
    <div class="alert alert-info text-center" style="border-radius:12px;">
        <%= msg %>
    </div>
    <% session.removeAttribute("msg"); } %>

    <form action="<%= request.getContextPath() %>/add-diet-plan" method="post">

        <div class="form-group">
            <label>Diet Title</label>
            <input type="text" name="title" class="form-control" required>
        </div>

        <div class="form-group">
            <label>Description</label>
            <textarea name="description" rows="4" class="form-control" required></textarea>
        </div>

        <div class="form-group">
            <label>Goal</label>
            <input type="text" name="goal" class="form-control" required>
        </div>

        <div class="form-group">
            <label>Calories</label>
            <input type="number" name="calories" class="form-control" min="50" max="10000" required>
        </div>

        <!-- ✅ NEW FIELD -->
        <div class="form-group">
            <label>Diet Type</label>
            <select name="dietType" class="form-control" required>
                <option value="">-- Select Type --</option>
                <option value="Veg">Veg</option>
                <option value="Non-Veg">Non-Veg</option>
                <option value="Vegan">Vegan</option>
                <option value="Keto">Keto</option>
                <option value="Balanced">Balanced</option>
            </select>
        </div>

        <!-- ✅ NEW FIELD -->
        <div class="form-group">
            <label>Meals Per Day</label>
            <input type="number" name="mealsPerDay" class="form-control" min="1" max="8" required>
        </div>

        <!-- ✅ MACROS -->
        <div class="form-row">

            <div class="form-group col-md-4">
                <label>Protein (g)</label>
                <input type="number" name="proteinG" class="form-control" min="0" max="500" required>
            </div>

            <div class="form-group col-md-4">
                <label>Carbs (g)</label>
                <input type="number" name="carbsG" class="form-control" min="0" max="800" required>
            </div>

            <div class="form-group col-md-4">
                <label>Fats (g)</label>
                <input type="number" name="fatsG" class="form-control" min="0" max="300" required>
            </div>

        </div>

        <!-- ✅ NEW FIELD -->
        <div class="form-group">
            <label>Water Intake (Liters/day)</label>
            <input type="number" step="0.1" name="waterLiters" class="form-control" min="0.5" max="10" required>
        </div>

        <!-- ✅ NEW FIELD -->
        <div class="form-group">
            <label>Foods to Avoid (optional)</label>
            <textarea name="foodsToAvoid" rows="3" class="form-control"
                      placeholder="Sugar, fast food, cold drinks..."></textarea>
        </div>

        <button type="submit" class="btn btn-red btn-block">
            Save Diet Plan
        </button>

        <a href="<%= request.getContextPath() %>/trainer-dashboard"
           class="btn btn-outline-light btn-block btn-back mt-3">
            ← Back to Dashboard
        </a>
    </form>

</div>

</body>
</html>
