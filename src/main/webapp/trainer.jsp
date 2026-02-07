<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.gym_website.entities.Trainer" %>
<%@ page import="com.gym_website.dao.TrainerDao" %>
<%@ page import="com.gym_website.helper.ConnectionProvider" %>

<%
    String adminName = (String) session.getAttribute("adminName");
    if (adminName == null) {
        response.sendRedirect(request.getContextPath() + "/AdminDashboardPage/adminLoginPage.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Trainer Manager | FitnessWorld</title>

    <!-- Bootstrap -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            font-family: "Poppins", Arial, sans-serif;
            background: #0b0b0b;
            color: #e5e7eb;
            margin: 0;
            padding-top: 40px; /* ✅ SAFE ADMIN SPACING */
        }

        /* PAGE TITLE */
        .page-hero {
            text-align: center;
            padding: 30px 15px 30px;
        }

        .page-hero h2 span {
            color: #ff2e2e;
        }

        /* ALERT */
        .alert-msg {
            background: #16a34a;
            color: #fff;
            padding: 10px 18px;
            width: fit-content;
            margin: 20px auto;
            border-radius: 10px;
        }

        /* FORM */
        .trainer-form {
            max-width: 620px;
            margin: 30px auto 50px;
            background: rgba(20,20,20,0.9);
            padding: 28px;
            border-radius: 18px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.6);
        }

        .trainer-form h4 {
            margin-bottom: 20px;
        }

        .trainer-form label {
            font-size: 0.85rem;
            margin-top: 12px;
            color: #bbb;
        }

        .trainer-form input,
        .trainer-form textarea {
            width: 100%;
            background: #111;
            border: 1px solid #333;
            color: #fff;
            padding: 10px;
            border-radius: 10px;
        }

        .trainer-form button {
            margin-top: 20px;
            background: #ff2e2e;
            border: none;
            padding: 10px 26px;
            border-radius: 30px;
            font-weight: 600;
            color: #fff;
        }

        /* TRAINER GRID */
        .trainer-container {
            max-width: 1200px;
            margin: 30px auto 70px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 28px;
            padding: 0 20px;
        }

        .trainer-card {
            background: rgba(20,20,20,0.95);
            border-radius: 18px;
            padding: 26px;
            text-align: center;
            box-shadow: 0 20px 40px rgba(0,0,0,0.6);
            transition: transform 0.35s ease;
        }

        .trainer-card:hover {
            transform: translateY(-10px);
        }

        .trainer-card img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #ff2e2e;
        }

        .trainer-name {
            margin-top: 14px;
            font-size: 1.25rem;
            font-weight: 700;
        }

        .trainer-card small {
            display: block;
            margin-top: 8px;
            color: #aaa;
        }
    </style>
</head>

<body>

<%
    String msg = (String) session.getAttribute("msg");
    if (msg != null) {
%>
<div class="alert-msg"><%= msg %></div>
<%
        session.removeAttribute("msg");
    }
%>

<div class="page-hero">
    <h2>Trainer <span>Management</span></h2>
    <p class="text-muted">Add, edit and manage trainers</p>
</div>

<!-- ADD TRAINER -->
<form action="<%= request.getContextPath() %>/AddTrainer"
      method="post"
      class="trainer-form">

    <h4>Add Trainer</h4>

    <label>Name</label>
    <input type="text" name="name" required>

    <label>Specialization</label>
    <input type="text" name="specialization" required>

    <label>Experience</label>
    <input type="text" name="experience" required>

    <label>Image URL</label>
    <input type="text" name="image">

    <label>Description</label>
    <textarea name="description" rows="3"></textarea>

    <label class="mt-3">
        <input type="checkbox" required> I agree to terms
    </label>

    <button type="submit">Save Trainer</button>
</form>

<!-- TRAINER LIST -->
<div class="trainer-container">
<%
    TrainerDao tdao = new TrainerDao(ConnectionProvider.getConnection());
    List<Trainer> list = tdao.getAllTrainers();

    if (list == null || list.isEmpty()) {
%>
    <p style="grid-column:1/-1; text-align:center;">No trainers added yet.</p>
<%
    } else {
        for (Trainer t : list) {
%>
    <div class="trainer-card">
        <img src="<%= t.getImage() %>" alt="Trainer">
        <div class="trainer-name"><%= t.getName() %></div>
        <div class="text-muted"><%= t.getSpecialization() %></div>
        <div class="text-muted"><%= t.getExperience() %></div>
        <small><%= t.getDescription() %></small>

        <div class="mt-3">
            <a href="<%= request.getContextPath() %>/edit-trainer.jsp?id=<%= t.getId() %>"
               class="btn btn-sm btn-outline-light">Edit</a>

            <form action="<%= request.getContextPath() %>/DeleteTrainer"
                  method="post" style="display:inline;">
                <input type="hidden" name="id" value="<%= t.getId() %>">
                <button class="btn btn-sm btn-danger"
                        onclick="return confirm('Delete this trainer?');">
                    Delete
                </button>
            </form>
        </div>
    </div>
<%
        }
    }
%>
</div>

</body>
</html>
