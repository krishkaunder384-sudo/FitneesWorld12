<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.gym_website.entities.User" %>
<%@ page import="com.gym_website.entities.Trainer" %>
<%@ page import="com.gym_website.dao.TrainerDao" %>
<%@ page import="com.gym_website.helper.ConnectionProvider" %>

<%
    // 🔐 Login check
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    // 🎯 Trainer ID check
    String trainerIdStr = request.getParameter("trainerId");
    if (trainerIdStr == null) {
        response.sendRedirect(request.getContextPath() + "/public-trainers.jsp");
        return;
    }

    int trainerId;
    try {
        trainerId = Integer.parseInt(trainerIdStr);
    } catch (Exception e) {
        response.sendRedirect(request.getContextPath() + "/public-trainers.jsp");
        return;
    }

    TrainerDao tdao = new TrainerDao(ConnectionProvider.getConnection());
    Trainer trainer = tdao.getTrainerById(trainerId);

    if (trainer == null) {
        response.sendRedirect(request.getContextPath() + "/public-trainers.jsp");
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
    font-family: "Poppins", Arial, sans-serif;
}

/* Wrapper */
.booking-wrapper {
    max-width: 520px;
    margin: 110px auto 80px;
    padding: 0 15px;
}

/* Card */
.booking-card {
    background: rgba(20,20,20,0.95);
    padding: 32px;
    border-radius: 18px;
    box-shadow: 0 25px 50px rgba(0,0,0,0.7);
    color: #e5e7eb;
}

/* Title */
.booking-card h2 {
    text-align: center;
    margin-bottom: 22px;
    font-weight: 700;
}

.booking-card h2 span {
    color: #ff2e2e;
}

/* Labels */
.booking-card label {
    font-size: 0.85rem;
    margin-top: 14px;
    color: #bbb;
}

/* Inputs */
.booking-card input,
.booking-card select {
    width: 100%;
    background: #111;
    border: 1px solid #333;
    color: #fff;
    padding: 10px;
    border-radius: 10px;
    margin-top: 6px;
}

.booking-card input:focus,
.booking-card select:focus {
    border-color: #ff2e2e;
    outline: none;
}

/* Button */
.btn-book {
    margin-top: 24px;
    width: 100%;
    padding: 11px;
    border-radius: 30px;
    border: none;
    background: #ff2e2e;
    color: #fff;
    font-weight: 600;
    transition: all 0.3s ease;
}

.btn-book:hover {
    background: #e60023;
    transform: translateY(-2px);
}
</style>

<div class="booking-wrapper">
    <div class="booking-card">

        <h2>
            Book <span>Session</span>
        </h2>

        <form action="<%= request.getContextPath() %>/BookSessionServlet"
              method="post">

            <input type="hidden" name="trainerId" value="<%= trainer.getId() %>">

            <label>Trainer</label>
            <input type="text" value="<%= trainer.getName() %>" readonly>

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

    </div>
</div>

<!-- ✅ SCRIPTS -->
<%@ include file="script.jsp" %>
