<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.gym_website.dao.TrainerDao" %>
<%@ page import="com.gym_website.entities.Trainer" %>
<%@ page import="com.gym_website.helper.ConnectionProvider" %>

<!DOCTYPE html>
<html>
<head>
    <title>Our Trainers | FitnessWorld</title>

    <!-- Bootstrap -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap"
          rel="stylesheet">

    <style>
        body {
            background: #0b0b0b;
            color: #e5e7eb;
            font-family: "Poppins", Arial, sans-serif;
            padding-top: 90px; /* ✅ FIX navbar overlap */
        }

        .trainer-hero {
            text-align: center;
            padding: 40px 15px 30px;
        }

        .trainer-hero h1 span {
            color: #ff2e2e;
        }

        .trainer-hero p {
            color: #9ca3af;
        }

        .trainer-container {
            max-width: 1100px;
            margin: 30px auto 80px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 26px;
            padding: 0 20px;
        }

        .trainer-card {
            background: rgba(20,20,20,0.95);
            border-radius: 18px;
            padding: 30px 22px;
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

        .trainer-role {
            font-size: 0.95rem;
            color: #d1d5db;
            margin-top: 4px;
        }

        .trainer-card {
            cursor: pointer;
        }


        .trainer-meta {
            font-size: 0.85rem;
            color: #9ca3af;
            margin-top: 6px;
        }

        .trainer-desc {
            margin-top: 12px;
            font-size: 0.8rem;
            color: #aaa;
            line-height: 1.4;
        }

        .no-data {
            grid-column: 1 / -1;
            text-align: center;
            color: #9ca3af;
            font-size: 1rem;
        }
    </style>
</head>

<body>

<!-- ✅ GLOBAL NAVBAR -->
<%@ include file="navbar.jsp" %>

<!-- HERO -->
<div class="trainer-hero">
    <h1>Meet Our <span>Expert Trainers</span></h1>
    <p>Certified professionals ready to guide your fitness journey</p>
</div>

<!-- TRAINER LIST -->
<div class="trainer-container">
<%
    TrainerDao tdao = new TrainerDao(ConnectionProvider.getConnection());
    List<Trainer> list = tdao.getAllTrainers();

    if (list == null || list.isEmpty()) {
%>
    <div class="no-data">
        Trainers will be added soon. Stay tuned!
    </div>
<%
    } else {
        for (Trainer t : list) {
            String image = t.getImage();
            if (image == null || image.trim().isEmpty()) {
                image = request.getContextPath() + "/assets/default-trainer.png";
            }
%>
  <a href="<%= request.getContextPath() %>/trainer-profile.jsp?id=<%= t.getId() %>"
     style="text-decoration:none; color:inherit;">
      <div class="trainer-card">

       <img src="<%= image %>" alt="Trainer">

       <div class="trainer-name"><%= t.getName() %></div>
       <div class="trainer-role"><%= t.getSpecialization() %></div>
       <div class="trainer-meta">Experience: <%= t.getExperience() %></div>
       <div class="trainer-desc">
           <%= t.getDescription() %>
       </div>

       <!-- ✅ BOOK SESSION BUTTON -->
       <a href="<%= request.getContextPath() %>/trainer-profile.jsp?id=<%= t.getId() %>"
          class="btn btn-danger mt-3"
          style="border-radius:30px; padding:10px 22px; font-weight:600;">
           View Profile / Book Session
       </a>
   </div>
<%
        }
    }
%>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
