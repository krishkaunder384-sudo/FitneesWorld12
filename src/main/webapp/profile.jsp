<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.gym_website.entities.User" %>
<%@ page import="com.gym_website.entities.Message" %>

<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard | FitnessWorld</title>

    <!-- Bootstrap -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <style>
        body {
            background: #0b0b0b;
            color: #e5e7eb;
            font-family: "Poppins", Arial, sans-serif;
        }

        .dashboard-container {
            max-width: 1200px;
            margin: auto;
            padding-top: 40px;
        }
    </style>
</head>

<body>

<!-- ✅ GLOBAL NAVBAR -->
<%@ include file="navbar.jsp" %>

<!-- ✅ SAFE SPACING -->
<div class="dashboard-container">

    <!-- FLASH MESSAGE -->
    <%
        Message m = (Message) session.getAttribute("msg");
        if (m != null) {
    %>
        <div class="alert <%= m.getCssClass() %> text-center">
            <%= m.getContent() %>
        </div>
    <%
            session.removeAttribute("msg");
        }
    %>

    <!-- MAIN BODY -->
    <%@ include file="/Profile(Nav_Bar , Main_Page , Proile_Model , Post_Model)/Profile_Main_Body.jsp" %>

</div>

<!-- PROFILE MODAL (UNCHANGED) -->
<jsp:include page="profile-modal.jsp" />

<!-- ADD POST MODAL -->
<jsp:include page="add-post-modal.jsp" />

<%@ include file="script.jsp" %>

</body>
</html>
