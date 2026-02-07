<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isErrorPage="true" %>

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
.error-wrapper {
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 120px 15px 60px;
}

/* Card */
.error-card {
    max-width: 520px;
    background: rgba(20,20,20,0.95);
    padding: 45px;
    border-radius: 22px;
    text-align: center;
    box-shadow: 0 30px 60px rgba(0,0,0,0.7);
}

/* Icon */
.error-icon {
    font-size: 4rem;
    color: #ff2e2e;
    margin-bottom: 20px;
}

/* Title */
.error-card h2 {
    font-weight: 800;
    margin-bottom: 12px;
}

/* Text */
.error-card p {
    color: #bbb;
    margin-bottom: 20px;
}

/* Exception (dev only) */
.error-details {
    font-size: 0.8rem;
    color: #777;
    background: #111;
    padding: 10px;
    border-radius: 10px;
    margin-bottom: 25px;
    overflow-x: auto;
}

/* Button */
.btn-home {
    background: #ff2e2e;
    border: none;
    padding: 12px 34px;
    border-radius: 30px;
    font-weight: 600;
    color: #fff;
    transition: all 0.3s ease;
}

.btn-home:hover {
    background: #e60023;
    transform: translateY(-2px);
}
</style>

<div class="error-wrapper">
    <div class="error-card">

        <div class="error-icon">⚠️</div>

        <h2>Something went wrong</h2>
        <p>
            Don’t worry — our team is already working on it.
            Please try again or return to the homepage.
        </p>

        <% if (exception != null) { %>
            <div class="error-details">
                <%= exception.toString() %>
            </div>
        <% } %>

        <a href="<%= request.getContextPath() %>/index.jsp"
           class="btn btn-home">
            Go to Home
        </a>

    </div>
</div>

<!-- ✅ SCRIPTS -->
<%@ include file="script.jsp" %>
