<%@page import="com.gym_website.dao.PostDao"%>
<%@page import="com.gym_website.entities.Post"%>
<%@page import="com.gym_website.helper.ConnectionProvider"%>
<%@page import="com.gym_website.entities.User"%>
<%@page errorPage="error.jsp"%>

<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int postId = Integer.parseInt(request.getParameter("post_id"));
    PostDao dao = new PostDao(ConnectionProvider.getConnection());
    Post p = dao.getPostByPostId(postId);
%>

<!DOCTYPE html>
<html>
<head>
    <title><%= p.getGym_name() %> | FitnessWorld</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <style>
        body {
            background: #0b0b0b;
            color: #e5e7eb;
            font-family: "Poppins", Arial, sans-serif;
            padding-top: 90px; /* ✅ navbar spacing */
        }

        .hero {
            background:
                linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)),
                url("<%= request.getContextPath() %>/post_pics/gymPhotos/<%= p.getGym_photo() %>")
                center/cover no-repeat;
            padding: 80px 20px;
            text-align: center;
        }

        .hero h1 span {
            color: #ff2e2e;
        }

        .section {
            max-width: 1100px;
            margin: 70px auto;
            padding: 0 20px;
        }

        .card-dark {
            background: rgba(20,20,20,0.95);
            padding: 30px;
            border-radius: 18px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.6);
            margin-bottom: 40px;
        }

        h2 {
            margin-bottom: 16px;
        }

        .owner img {
            width: 140px;
            height: 140px;
            border-radius: 50%;
            border: 3px solid #ff2e2e;
            object-fit: cover;
            margin-bottom: 15px;
        }

        footer {
            text-align: center;
            padding: 40px 20px;
            color: #9ca3af;
        }
    </style>
</head>

<body>

<!-- ✅ GLOBAL NAVBAR -->
<%@ include file="navbar.jsp" %>

<!-- HERO -->
<div class="hero">
    <h1>Welcome to <span><%= p.getGym_name() %></span></h1>
    <p>Your journey to fitness starts here</p>
</div>

<div class="section">

    <!-- ABOUT -->
    <div class="card-dark">
        <h2>About Us</h2>
        <p><%= p.getAbout_gym() %></p>
    </div>

    <!-- SERVICES -->
    <div class="card-dark">
        <h2>Our Services</h2>
        <ul>
            <li>Personal Training</li>
            <li>Group Classes</li>
            <li>Strength & Cardio Equipment</li>
            <li>Nutrition Guidance</li>
        </ul>
    </div>

    <!-- OWNER -->
    <div class="card-dark text-center owner">
        <img src="<%= request.getContextPath() %>/post_pics/ownerPhotos/<%= p.getOwner_photo() %>">
        <h4><%= p.getOwner_name() %></h4>
        <p>
            Dedicated to providing a professional fitness experience
            and helping members achieve real results.
        </p>
    </div>

</div>

<footer>
    © 2024 <%= p.getGym_name() %> • Powered by FitnessWorld
</footer>

</body>
</html>
