<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String message = (String) request.getAttribute("message");
    String error   = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Enter OTP | FitnessWorld</title>
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

    .otp-wrapper {
        max-width: 480px;
        margin: auto;
        padding: 0 15px;
    }

    .otp-card {
        background: rgba(18,18,18,0.92);
        backdrop-filter: blur(18px);
        border-radius: 20px;
        box-shadow: 0 30px 70px rgba(0,0,0,0.65);
        padding: 34px 30px;
        text-align: center;
    }

    .otp-title {
        font-size: 1.7rem;
        font-weight: 800;
        margin-bottom: 8px;
    }

    .otp-sub {
        color: #9ca3af;
        font-size: 0.95rem;
        margin-bottom: 22px;
    }

    .otp-icon {
        font-size: 3rem;
        margin-bottom: 14px;
        color: #ff2e2e;
    }

    .form-control {
        background: #111;
        border: 1px solid #333;
        color: #fff;
        height: 50px;
        border-radius: 14px;
        text-align: center;
        font-size: 1.1rem;
        letter-spacing: 3px;
        font-weight: 700;
    }

    .form-control:focus {
        border-color: #ff2e2e;
        box-shadow: none;
        background: #111;
        color: #fff;
    }

    .btn-verify {
        width: 100%;
        height: 46px;
        border-radius: 30px;
        font-weight: 600;
        border: none;
        background: #ff2e2e;
        color: #fff;
        transition: 0.25s ease;
        margin-top: 16px;
    }

    .btn-verify:hover {
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
        display: inline-flex;
        align-items: center;
        justify-content: center;
        text-decoration: none;
    }

    .btn-back:hover {
        border-color: #ff2e2e;
        color: #ff2e2e;
        text-decoration: none;
    }

    .alert {
        border-radius: 12px;
        font-size: 0.9rem;
        margin-bottom: 16px;
        text-align: left;
    }
</style>

<div class="otp-wrapper">
    <div class="otp-card">

        <div class="otp-icon">🔐</div>

        <div class="otp-title">Enter OTP</div>
        <div class="otp-sub">
            We sent an OTP to your email.
        </div>

        <!-- ✅ Messages -->
        <% if (message != null) { %>
            <div class="alert alert-success"><%= message %></div>
        <% } %>

        <% if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
        <% } %>

        <form action="<%= request.getContextPath() %>/ValidateOtp"
              method="post"
              autocomplete="off">

            <div class="form-group">
                <input id="otp"
                       name="otp"
                       placeholder="______"
                       class="form-control"
                       type="text"
                       maxlength="6"
                       inputmode="numeric"
                       pattern="[0-9]*"
                       required>

                <small class="text-muted">
                    Enter OTP exactly as received.
                </small>
            </div>

            <button type="submit" class="btn-verify">
                Verify OTP
            </button>

            <a class="btn-back"
               href="<%= request.getContextPath() %>/ForgotPassword_JSP/forgotPassword.jsp">
                Resend / Change Email
            </a>

        </form>

    </div>
</div>

<%@ include file="../script.jsp" %>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const otp = document.getElementById("otp");
        if (otp) {
            otp.focus();

            // allow only numbers
            otp.addEventListener("input", function () {
                this.value = this.value.replace(/[^0-9]/g, "");
            });
        }
    });
</script>

</body>
</html>
