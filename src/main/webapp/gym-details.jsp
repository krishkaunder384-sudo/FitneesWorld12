<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.gym_website.entities.Gym" %>

<%
    Gym gym = (Gym) request.getAttribute("gym");
    if (gym == null) {
        response.sendRedirect(request.getContextPath() + "/error.jsp");
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
.gym-wrapper {
    padding: 110px 15px 80px;
}

/* Card */
.gym-card {
    max-width: 800px;
    margin: auto;
    background: rgba(20,20,20,0.95);
    border-radius: 22px;
    padding: 40px;
    box-shadow: 0 30px 60px rgba(0,0,0,0.7);
}

/* Title */
.gym-title {
    text-align: center;
    margin-bottom: 30px;
}

.gym-title h1 {
    font-weight: 800;
}

.gym-title span {
    color: #ff2e2e;
}

/* Info rows */
.gym-info {
    margin-top: 20px;
}

.info-row {
    padding: 14px 0;
    border-bottom: 1px solid #222;
}

.info-label {
    font-weight: 600;
    color: #aaa;
}

.info-value {
    color: #fff;
}

/* Back button */
.btn-back {
    margin-top: 35px;
    background: #ff2e2e;
    border: none;
    padding: 12px 36px;
    border-radius: 30px;
    font-weight: 600;
    color: #fff;
    transition: all 0.3s ease;
}

.btn-back:hover {
    background: #e60023;
    transform: translateY(-2px);
}
</style>

<div class="gym-wrapper">

    <div class="gym-card">

        <!-- TITLE -->
        <div class="gym-title">
            <h1>
                <span><%= gym.getGymName() %></span>
            </h1>
            <p class="text-muted">
                Gym Information & Contact Details
            </p>
        </div>

        <!-- INFO -->
        <div class="gym-info">

            <div class="info-row">
                <div class="info-label">📧 Email</div>
                <div class="info-value"><%= gym.getContactEmail() %></div>
            </div>

            <div class="info-row">
                <div class="info-label">📞 Phone</div>
                <div class="info-value"><%= gym.getContactPhone() %></div>
            </div>

            <div class="info-row">
                <div class="info-label">📍 Address</div>
                <div class="info-value"><%= gym.getAddress() %></div>
            </div>

            <div class="info-row">
                <div class="info-label">🌐 Social Media</div>
                <div class="info-value"><%= gym.getSocialMediaLinks() %></div>
            </div>

            <div class="info-row">
                <div class="info-label">⏰ Business Hours</div>
                <div class="info-value"><%= gym.getBusinessHours() %></div>
            </div>

        </div>

        <!-- BACK -->
        <div class="text-center">
            <a href="<%= request.getContextPath() %>/nearbygym/nearbygym.jsp"
               class="btn btn-back">
                Back to Nearby Gyms
            </a>
        </div>

    </div>
</div>

<!-- ✅ SCRIPTS -->
<%@ include file="script.jsp" %>

</body>
</html>
