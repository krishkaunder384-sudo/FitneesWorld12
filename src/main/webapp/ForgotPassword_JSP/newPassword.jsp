<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // ✅ Email should come from session (best) or request attribute (fallback)
    String email = (String) session.getAttribute("email");

    if (email == null) {
        email = (String) request.getAttribute("email");
    }

    // if someone opens page directly -> redirect
    if (email == null) {
        response.sendRedirect(request.getContextPath() + "/ForgotPassword_JSP/forgotPassword.jsp");
        return;
    }

    String message = (String) request.getAttribute("message");
    String error   = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password | FitnessWorld</title>

    <!-- Bootstrap -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap"
          rel="stylesheet">

    <style>
        body {
            min-height: 100vh;
            margin: 0;
            background: linear-gradient(rgba(0,0,0,0.78), rgba(0,0,0,0.78)),
                url("<%= request.getContextPath() %>/assets/images/auth-bg.jpg")
                center/cover no-repeat;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: "Poppins", Arial, sans-serif;
            padding: 40px 15px;
        }

        .reset-card {
            width: 100%;
            max-width: 460px;
            background: rgba(18,18,18,0.92);
            backdrop-filter: blur(18px);
            border-radius: 18px;
            padding: 34px 30px;
            box-shadow: 0 30px 60px rgba(0,0,0,0.65);
            color: #fff;
        }

        .brand {
            text-align: center;
            font-size: 1.8rem;
            font-weight: 800;
            letter-spacing: 1px;
            margin-bottom: 5px;
        }

        .brand span {
            color: #ff2e2e;
        }

        .sub {
            text-align: center;
            color: #aaa;
            font-size: 0.9rem;
            margin-bottom: 20px;
        }

        label {
            font-size: 0.85rem;
            color: #bbb;
            font-weight: 600;
        }

        .form-control {
            height: 46px;
            border-radius: 12px;
            background: #111;
            border: 1px solid #333;
            color: #fff;
        }

        .form-control:focus {
            border-color: #ff2e2e;
            background: #111;
            color: #fff;
            box-shadow: none;
        }

        .input-group-text {
            background: #111;
            border: 1px solid #333;
            color: #bbb;
            cursor: pointer;
            border-radius: 12px;
        }

        .btn-reset {
            height: 46px;
            border-radius: 30px;
            border: none;
            background: #ff2e2e;
            font-weight: 700;
            color: #fff;
            transition: all 0.25s ease;
        }

        .btn-reset:hover {
            background: #e60023;
            transform: translateY(-1px);
        }

        .small-help {
            font-size: 0.8rem;
            color: #aaa;
            margin-top: 8px;
        }

        .msg {
            padding: 10px 14px;
            border-radius: 12px;
            font-size: 0.9rem;
            margin-bottom: 14px;
        }

        .msg-success {
            background: rgba(34,197,94,0.15);
            border: 1px solid rgba(34,197,94,0.35);
            color: #b6f7c9;
        }

        .msg-error {
            background: rgba(239,68,68,0.15);
            border: 1px solid rgba(239,68,68,0.35);
            color: #ffd1d1;
        }

        .footer-links {
            text-align: center;
            margin-top: 18px;
            font-size: 0.9rem;
            color: #aaa;
        }

        .footer-links a {
            color: #ff2e2e;
            text-decoration: none;
            font-weight: 600;
        }

        .footer-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

<div class="reset-card">

    <div class="brand"><span>Fitness</span>World</div>
    <div class="sub">Create your new password securely</div>

    <% if (message != null) { %>
        <div class="msg msg-success"><%= message %></div>
    <% } %>

    <% if (error != null) { %>
        <div class="msg msg-error"><%= error %></div>
    <% } %>

    <form action="<%= request.getContextPath() %>/newPassword"
          method="post"
          onsubmit="return validatePassword()">

        <!-- ✅ keep hidden email as backup -->
        <input type="hidden" name="email" value="<%= email %>">

        <div class="form-group">
            <label>New Password</label>
            <div class="input-group">
                <input type="password"
                       name="password"
                       id="password"
                       class="form-control"
                       placeholder="Enter new password"
                       required>
                <div class="input-group-append">
                    <span class="input-group-text" onclick="togglePassword('password', 'eye1')">
                        <i id="eye1" class="fa fa-eye"></i>
                    </span>
                </div>
            </div>
            <div class="small-help">
                Must contain at least 5 characters, 1 uppercase and 1 special symbol.
            </div>
        </div>

        <div class="form-group">
            <label>Confirm New Password</label>
            <div class="input-group">
                <input type="password"
                       name="confPassword"
                       id="confPassword"
                       class="form-control"
                       placeholder="Confirm password"
                       required>
                <div class="input-group-append">
                    <span class="input-group-text" onclick="togglePassword('confPassword', 'eye2')">
                        <i id="eye2" class="fa fa-eye"></i>
                    </span>
                </div>
            </div>
        </div>

        <button type="submit" class="btn btn-reset btn-block">
            Reset Password
        </button>
    </form>

    <div class="footer-links">
        Back to <a href="<%= request.getContextPath() %>/login.jsp">Login</a>
    </div>

</div>

<script>
    function validatePassword() {
        const password = document.getElementById("password").value.trim();
        const confPassword = document.getElementById("confPassword").value.trim();

        if (password !== confPassword) {
            alert("Passwords do not match!");
            return false;
        }

        // at least 5 chars, 1 uppercase, 1 special
        const passwordRegex = /^(?=.*[A-Z])(?=.*[^A-Za-z0-9]).{5,}$/;

        if (!passwordRegex.test(password)) {
            alert("Password must be at least 5 characters long, contain 1 uppercase letter, and 1 special symbol.");
            return false;
        }

        return true;
    }

    function togglePassword(inputId, eyeId) {
        const input = document.getElementById(inputId);
        const eye = document.getElementById(eyeId);

        if (input.type === "password") {
            input.type = "text";
            eye.className = "fa fa-eye-slash";
        } else {
            input.type = "password";
            eye.className = "fa fa-eye";
        }
    }
</script>

</body>
</html>
