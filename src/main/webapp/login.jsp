<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.gym_website.entities.Message" %>

<%
    Message m = (Message) session.getAttribute("msg");
    String type = request.getParameter("type");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Login | FitnessWorld</title>

<!-- Bootstrap -->
<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<!-- Font Awesome -->
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
    body {
        min-height: 100vh;
        background: linear-gradient(rgba(0,0,0,0.75), rgba(0,0,0,0.75)),
            url("<%= request.getContextPath() %>/assets/images/auth-bg.jpg")
            center/cover no-repeat;
        display: flex;
        align-items: center;
        justify-content: center;
        font-family: "Poppins", sans-serif;
    }

    .auth-card {
        width: 100%;
        max-width: 420px;
        padding: 40px 35px;
        border-radius: 18px;
        min-height: 540px;
        background: rgba(18,18,18,0.9);
        backdrop-filter: blur(18px);
        box-shadow: 0 30px 60px rgba(0,0,0,0.65);
        animation: fadeUp 0.8s ease;
        color: #fff;
        position: relative;
    }

    @keyframes fadeUp {
        from { opacity: 0; transform: translateY(40px); }
        to   { opacity: 1; transform: translateY(0); }
    }

    .auth-brand {
        text-align: center;
        font-size: 1.8rem;
        font-weight: 800;
        margin-bottom: 6px;
    }

    .auth-brand span { color: #ff2e2e; }

    .auth-sub {
        text-align: center;
        color: #aaa;
        font-size: 0.9rem;
        margin-bottom: 22px;
    }

    .auth-toggle {
        display: flex;
        margin-bottom: 22px;
        border-radius: 30px;
        overflow: hidden;
        border: 1px solid #444;
    }

    .auth-toggle button {
        flex: 1;
        border: none;
        padding: 12px;
        background: transparent;
        color: #bbb;
        font-weight: 600;
        transition: all 0.35s ease;
    }

    .auth-toggle button.active {
        background: #ff2e2e;
        color: #fff;
    }

    .auth-form {
        transition: opacity 0.35s ease, transform 0.35s ease;
    }

    .auth-form.hidden {
        opacity: 0;
        transform: translateY(10px);
        pointer-events: none;
        position: absolute;
        width: 100%;
    }

    .form-control {
        background: #111;
        border: 1px solid #333;
        color: #fff;
        height: 46px;
        border-radius: 10px;
    }

    .form-control:focus {
        border-color: #ff2e2e;
        box-shadow: none;
    }

    .input-group-text {
        background: #111;
        border: 1px solid #333;
        color: #bbb;
        cursor: pointer;
    }

    .btn-auth {
        background: #ff2e2e;
        border: none;
        height: 46px;
        font-weight: 600;
        border-radius: 30px;
    }

    .forgot-link {
        text-align: right;
        margin-bottom: 15px;
        font-size: 0.88rem;
    }

    .forgot-link a {
        color: #ff2e2e;
        font-weight: 600;
        text-decoration: none;
    }

    .login-alert {
        border-radius: 12px;
        font-size: 0.9rem;
    }
</style>
</head>

<body>

<div class="auth-card">

    <% if (m != null) { %>
        <div class="alert <%= m.getCssClass() %> login-alert">
            <%= m.getContent() %>
        </div>
        <% session.removeAttribute("msg"); %>
    <% } %>

    <div class="auth-brand"><span>Fitness</span>World</div>
    <div class="auth-sub">Login to continue your fitness journey</div>

    <!-- TOGGLE -->
    <div class="auth-toggle">
        <button type="button" id="userBtn" class="active" onclick="showUser()">User</button>
        <button type="button" id="trainerBtn" onclick="showTrainer()">Trainer</button>
        <button type="button" id="adminBtn" onclick="showAdmin()">Admin</button>
    </div>

    <!-- USER LOGIN -->
    <form id="userLoginForm" class="auth-form"
          action="<%= request.getContextPath() %>/loginservlet" method="post">

        <div class="form-group">
            <input type="text" name="loginIdentifier" class="form-control"
                   placeholder="Email or Phone" required>
        </div>

        <div class="form-group input-group">
            <input type="password" name="password" id="userPassword"
                   class="form-control" placeholder="Password" required>
            <div class="input-group-append">
                <span class="input-group-text" onclick="togglePassword('userPassword', this)">
                    <i class="fa fa-eye"></i>
                </span>
            </div>
        </div>

        <div class="forgot-link">
            <a href="<%= request.getContextPath() %>/ForgotPassword_JSP/forgotPassword.jsp">
                Forgot Password?
            </a>
        </div>

        <button type="submit" class="btn btn-auth btn-block">Login as User</button>
    </form>

    <!-- TRAINER LOGIN -->
    <form id="trainerLoginForm" class="auth-form hidden"
          action="<%= request.getContextPath() %>/trainerloginservlet" method="post">

        <div class="form-group">
            <input type="text" name="loginIdentifier" class="form-control"
                   placeholder="Trainer Email or Phone" required>
        </div>

        <div class="form-group input-group">
            <input type="password" name="password" id="trainerPassword"
                   class="form-control" placeholder="Password" required>
            <div class="input-group-append">
                <span class="input-group-text" onclick="togglePassword('trainerPassword', this)">
                    <i class="fa fa-eye"></i>
                </span>
            </div>
        </div>

        <button type="submit" class="btn btn-auth btn-block">Login as Trainer</button>
    </form>

    <!-- ADMIN LOGIN -->
    <form id="adminLoginForm" class="auth-form hidden"
          action="<%= request.getContextPath() %>/adminloginservlet" method="post">

        <div class="form-group">
            <input type="text" name="username" class="form-control"
                   placeholder="Admin Username" required>
        </div>

        <div class="form-group input-group">
            <input type="password" name="password" id="adminPassword"
                   class="form-control" placeholder="Password" required>
            <div class="input-group-append">
                <span class="input-group-text" onclick="togglePassword('adminPassword', this)">
                    <i class="fa fa-eye"></i>
                </span>
            </div>
        </div>

        <button type="submit" class="btn btn-auth btn-block">Login as Admin</button>
    </form>

</div>

<script>
    const userForm = document.getElementById("userLoginForm");
    const trainerForm = document.getElementById("trainerLoginForm");
    const adminForm = document.getElementById("adminLoginForm");

    const userBtn = document.getElementById("userBtn");
    const trainerBtn = document.getElementById("trainerBtn");
    const adminBtn = document.getElementById("adminBtn");

    function reset() {
        userForm.classList.add("hidden");
        trainerForm.classList.add("hidden");
        adminForm.classList.add("hidden");

        userBtn.classList.remove("active");
        trainerBtn.classList.remove("active");
        adminBtn.classList.remove("active");
    }

    function showUser() {
        reset();
        userForm.classList.remove("hidden");
        userBtn.classList.add("active");
    }

    function showTrainer() {
        reset();
        trainerForm.classList.remove("hidden");
        trainerBtn.classList.add("active");
    }

    function showAdmin() {
        reset();
        adminForm.classList.remove("hidden");
        adminBtn.classList.add("active");
    }

    window.onload = function () {
        const type = "<%= type != null ? type : "" %>";
        if (type === "trainer") showTrainer();
        else if (type === "admin") showAdmin();
        else showUser();
    };

    function togglePassword(id, el) {
        const input = document.getElementById(id);
        const icon = el.querySelector("i");
        if (input.type === "password") {
            input.type = "text";
            icon.classList.replace("fa-eye", "fa-eye-slash");
        } else {
            input.type = "password";
            icon.classList.replace("fa-eye-slash", "fa-eye");
        }
    }
</script>

</body>
</html>
