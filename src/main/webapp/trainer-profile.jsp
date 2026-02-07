<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.gym_website.dao.TrainerDao" %>
<%@ page import="com.gym_website.entities.Trainer" %>
<%@ page import="com.gym_website.entities.User" %>
<%@ page import="com.gym_website.entities.Message" %>
<%@ page import="com.gym_website.helper.ConnectionProvider" %>

<%
    String idStr = request.getParameter("id");
    if (idStr == null) {
        response.sendRedirect("public-trainers.jsp");
        return;
    }

    int trainerId = Integer.parseInt(idStr);
    TrainerDao dao = new TrainerDao(ConnectionProvider.getConnection());
    Trainer t = dao.getTrainerById(trainerId);

    if (t == null) {
        response.sendRedirect("public-trainers.jsp");
        return;
    }

    User currentUser = (User) session.getAttribute("currentUser");

    // ✅ Read msg from session (for booking status)
    Message msg = (Message) session.getAttribute("msg");
    if (msg != null) {
        session.removeAttribute("msg");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title><%= t.getName() %> | FitnessWorld Trainer</title>

    <!-- Bootstrap -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap"
          rel="stylesheet">

    <style>
        body {
            background: #0b0b0b;
            color: #e5e7eb;
            font-family: "Poppins", Arial, sans-serif;
            padding-top: 90px;
        }

        .profile-card {
            max-width: 900px;
            margin: auto;
            background: rgba(20,20,20,0.95);
            border-radius: 24px;
            padding: 45px;
            box-shadow: 0 30px 60px rgba(0,0,0,0.7);
            text-align: center;
        }

        .profile-card img {
            width: 160px;
            height: 160px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #ff2e2e;
        }

        .trainer-name {
            margin-top: 18px;
            font-size: 2rem;
            font-weight: 800;
        }

        .trainer-role {
            color: #ff2e2e;
            margin-top: 6px;
            font-weight: 600;
        }

        .trainer-meta {
            margin-top: 10px;
            color: #aaa;
            font-size: 0.95rem;
        }

        .trainer-desc {
            margin-top: 18px;
            color: #ccc;
            line-height: 1.7;
        }

        /* ✅ Message box */
        .fw-alert {
            max-width: 900px;
            margin: 0 auto 20px;
        }

        /* BOOKING */
        .booking-box {
            margin-top: 35px;
            padding: 30px;
            background: rgba(15,15,15,0.9);
            border-radius: 18px;
            box-shadow: inset 0 0 0 1px #222;
        }

        label {
            font-size: 0.85rem;
            color: #bbb;
            font-weight: 500;
            margin-top: 12px;
            display: block;
            text-align: left;
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border-radius: 10px;
            border: 1px solid #333;
            background: #111;
            color: #fff;
        }

        input:focus, select:focus {
            border-color: #ff2e2e;
            outline: none;
        }

        .btn-book {
            margin-top: 18px;
            background: #ff2e2e;
            border: none;
            padding: 10px 28px;
            border-radius: 30px;
            font-weight: 600;
            color: #fff;
            width: 100%;
        }

        .btn-book:hover {
            background: #e60023;
        }

        .btn-login {
            background: #f59e0b;
            border-radius: 30px;
            padding: 10px 26px;
            color: #000;
            font-weight: 600;
            display: inline-block;
            margin-top: 15px;
            text-decoration: none;
        }

        .btn-back {
            display: inline-block;
            margin-top: 30px;
            color: #aaa;
            text-decoration: none;
            font-size: 0.9rem;
        }

        .btn-back:hover {
            color: #ff2e2e;
            text-decoration: underline;
        }
    </style>
</head>

<body>

<jsp:include page="navbar.jsp"/>

<!-- ✅ SHOW MESSAGE -->
<% if (msg != null) { %>
    <div class="fw-alert">
        <div class="alert <%= msg.getCssClass() %> alert-dismissible fade show text-center" role="alert">
            <%= msg.getContent() %>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </div>
<% } %>

<div class="profile-card">

    <img src="<%= t.getImage() %>" alt="Trainer">

    <div class="trainer-name"><%= t.getName() %></div>
    <div class="trainer-role"><%= t.getSpecialization() %></div>
    <div class="trainer-meta">Experience: <%= t.getExperience() %></div>

    <div class="trainer-desc">
        <%= t.getDescription() %>
    </div>

    <div class="booking-box">

        <% if (currentUser != null) { %>

        <form action="<%= request.getContextPath() %>/BookSessionServlet" method="post">

            <input type="hidden" name="trainerId" value="<%= trainerId %>">

            <label>Select Date</label>
            <input type="date" name="sessionDate" required>

            <label>Select Time</label>
            <select name="sessionTime" required>
                <option value="">-- Select Time --</option>
                <option value="06:00 AM">06:00 AM</option>
                <option value="07:00 AM">07:00 AM</option>
                <option value="08:00 AM">08:00 AM</option>
                <option value="05:00 PM">05:00 PM</option>
                <option value="06:00 PM">06:00 PM</option>
                <option value="07:00 PM">07:00 PM</option>
            </select>

            <button type="submit" class="btn-book">
                Confirm Booking
            </button>
        </form>

        <% } else { %>

            <a href="<%= request.getContextPath() %>/login.jsp"
               class="btn-login">
                Login to Book Session
            </a>

        <% } %>

    </div>

    <a href="<%= request.getContextPath() %>/public-trainers.jsp"
       class="btn-back">
        ← Back to Trainers
    </a>

</div>

<!-- ✅ Bootstrap JS (required for alert close button) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
