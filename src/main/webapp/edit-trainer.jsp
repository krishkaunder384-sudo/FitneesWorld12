<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.gym_website.dao.TrainerDao" %>
<%@ page import="com.gym_website.entities.Trainer" %>
<%@ page import="com.gym_website.helper.ConnectionProvider" %>

<%
    // ===== ADMIN AUTH CHECK =====
    String adminName = (String) session.getAttribute("adminName");
    if (adminName == null) {
        response.sendRedirect(request.getContextPath() + "/AdminDashboardPage/adminLoginPage.jsp");
        return;
    }

    // ===== GET TRAINER =====
    String idStr = request.getParameter("id");
    Trainer trainer = null;

    try {
        int id = Integer.parseInt(idStr);
        TrainerDao dao = new TrainerDao(ConnectionProvider.getConnection());
        trainer = dao.getTrainerById(id);
    } catch (Exception e) {
        response.sendRedirect(request.getContextPath() + "/trainer.jsp");
        return;
    }

    if (trainer == null) {
        response.sendRedirect(request.getContextPath() + "/trainer.jsp");
        return;
    }
%>

<!-- ✅ HEADER -->
<%@ include file="header.jsp" %>

<!-- ✅ NAVBAR -->
<%@ include file="navbar.jsp" %>

<style>
body {
    background: #0b0b0b;
    color: #e5e7eb;
    font-family: "Poppins", Arial, sans-serif;
}

/* Wrapper */
.edit-wrapper {
    max-width: 640px;
    margin: 120px auto 80px;
    padding: 0 15px;
}

/* Card */
.edit-card {
    background: rgba(20,20,20,0.95);
    padding: 40px;
    border-radius: 20px;
    box-shadow: 0 30px 60px rgba(0,0,0,0.7);
}

/* Title */
.edit-card h2 {
    text-align: center;
    font-weight: 800;
    margin-bottom: 30px;
}

.edit-card h2 span {
    color: #ff2e2e;
}

/* Labels */
label {
    font-size: 0.85rem;
    color: #bbb;
    margin-top: 14px;
}

/* Inputs */
input, textarea {
    width: 100%;
    background: #111;
    border: 1px solid #333;
    color: #fff;
    padding: 10px;
    border-radius: 10px;
}

input:focus, textarea:focus {
    border-color: #ff2e2e;
    outline: none;
}

/* Button */
.btn-save {
    margin-top: 25px;
    width: 100%;
    padding: 12px;
    border-radius: 30px;
    border: none;
    background: #ff2e2e;
    color: #fff;
    font-weight: 600;
    transition: all 0.3s ease;
}

.btn-save:hover {
    background: #e60023;
    transform: translateY(-2px);
}
</style>

<div class="edit-wrapper">
    <div class="edit-card">

        <h2>Edit <span>Trainer</span></h2>

        <form action="<%= request.getContextPath() %>/EditTrainer"
              method="post">

            <input type="hidden" name="id" value="<%= trainer.getId() %>">

            <label>Name</label>
            <input type="text" name="name"
                   value="<%= trainer.getName() %>" required>

            <label>Specialization</label>
            <input type="text" name="specialization"
                   value="<%= trainer.getSpecialization() %>" required>

            <label>Experience</label>
            <input type="text" name="experience"
                   value="<%= trainer.getExperience() %>" required>

            <label>Image URL</label>
            <input type="text" name="image"
                   value="<%= trainer.getImage() %>">

            <label>Description</label>
            <textarea name="description" rows="3"><%= trainer.getDescription() %></textarea>

            <button type="submit" class="btn-save">
                Update Trainer
            </button>
        </form>

    </div>
</div>

<!-- ✅ SCRIPTS -->
<%@ include file="script.jsp" %>
