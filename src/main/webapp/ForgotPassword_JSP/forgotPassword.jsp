<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String errorMsg = (String) request.getAttribute("error");
    String successMsg = (String) request.getAttribute("message");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Forgot Password | FitnessWorld</title>
</head>

<body>

<%@ include file="../header.jsp" %>
<%@ include file="../navbar.jsp" %>

<style>
    body {
        background: #0b0b0b;
        color: #e5e7eb;
        font-family: "Poppins", Arial, sans-serif;
        padding-top: 90px;
    }

    .fp-wrapper {
        max-width: 520px;
        margin: auto;
        padding: 0 15px;
    }

    .fp-card {
        background: rgba(18,18,18,0.92);
        backdrop-filter: blur(18px);
        border-radius: 20px;
        box-shadow: 0 30px 70px rgba(0,0,0,0.65);
        padding: 34px 30px;
    }

    .fp-title {
        text-align: center;
        font-weight: 800;
        font-size: 1.8rem;
        margin-bottom: 8px;
    }

    .fp-title span {
        color: #ff2e2e;
    }

    .fp-sub {
        text-align: center;
        color: #9ca3af;
        font-size: 0.95rem;
        margin-bottom: 24px;
    }

    .fp-steps {
        background: rgba(255,255,255,0.04);
        border: 1px solid rgba(255,255,255,0.07);
        border-radius: 14px;
        padding: 14px 16px;
        margin-bottom: 18px;
        color: #cbd5e1;
        font-size: 0.9rem;
    }

    .form-control {
        background: #111;
        border: 1px solid #333;
        color: #fff;
        height: 46px;
        border-radius: 12px;
    }

    .form-control:focus {
        border-color: #ff2e2e;
        box-shadow: none;
        background: #111;
        color: #fff;
    }

    .btn-send {
        width: 100%;
        height: 46px;
        border-radius: 30px;
        font-weight: 600;
        border: none;
        background: #ff2e2e;
        color: #fff;
        transition: 0.25s ease;
    }

    .btn-send:hover {
        background: #e60023;
        transform: translateY(-1px);
    }

    .btn-back {
        width: 100%;
        height: 46px;
        border-radius: 30px;
        font-weight: 600;
        margin-top: 12px;
        background: transparent;
        border: 1px solid #444;
        color: #ddd;
    }

    .btn-back:hover {
        border-color: #ff2e2e;
        color: #ff2e2e;
    }

    .alert {
        border-radius: 12px;
        font-size: 0.9rem;
        margin-bottom: 16px;
    }
</style>

<div class="fp-wrapper">
    <div class="fp-card">

        <div class="fp-title">
            Forgot <span>Password</span>
        </div>

        <div class="fp-sub">
            We’ll send an OTP to your registered email.
        </div>

        <!-- ✅ Show messages -->
        <% if (errorMsg != null) { %>
            <div class="alert alert-danger">
                <%= errorMsg %>
            </div>
        <% } %>

        <% if (successMsg != null) { %>
            <div class="alert alert-success">
                <%= successMsg %>
            </div>
        <% } %>

        <div class="fp-steps">
            <div><b>1)</b> Enter your email</div>
            <div><b>2)</b> Receive OTP</div>
            <div><b>3)</b> Reset password</div>
        </div>

        <form action="<%= request.getContextPath() %>/forgotPassword"
              method="post">

            <div class="form-group">
                <label style="font-size:0.85rem; color:#bbb;">
                    Registered Email
                </label>
                <input class="form-control"
                       type="email"
                       name="email"
                       placeholder="example@gmail.com"
                       required>
                <small class="text-muted">
                    OTP will be valid for 5 minutes.
                </small>
            </div>

            <button type="submit" class="btn-send">
                Send OTP
            </button>

            <a class="btn btn-back"
               href="<%= request.getContextPath() %>/login.jsp">
                Back to Login
            </a>

        </form>
    </div>
</div>

<%@ include file="../script.jsp" %>

</body>
</html>
