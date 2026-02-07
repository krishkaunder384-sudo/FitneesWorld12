<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Create Account | FitnessWorld</title>

<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>
    body {
        min-height: 100vh;
        background:
            linear-gradient(rgba(0,0,0,0.78), rgba(0,0,0,0.78)),
            url("<%= request.getContextPath() %>/assets/images/auth-bg.jpg")
            center/cover no-repeat;
        font-family: "Poppins", sans-serif;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .signup-card {
        width: 100%;
        max-width: 650px;
        background: rgba(18,18,18,0.92);
        border-radius: 20px;
        box-shadow: 0 35px 70px rgba(0,0,0,0.65);
        color: #fff;
    }

    .signup-header {
        text-align: center;
        padding: 34px;
        border-bottom: 1px solid #333;
    }

    .signup-header h3 span {
        color: #ff2e2e;
    }

    .signup-body {
        padding: 34px;
    }

    label {
        color: #bbb;
        font-size: 0.85rem;
        font-weight: 500;
    }

    .form-control {
        background: #111;
        border: 1px solid #333;
        color: #fff;
        height: 46px;
    }

    .form-control:focus {
        border-color: #ff2e2e;
        box-shadow: none;
        background: #111;
    }

    .btn-primary {
        background: #ff2e2e;
        border: none;
        height: 48px;
        border-radius: 30px;
        font-weight: 600;
    }

    .btn-primary:hover {
        background: #e60023;
    }
</style>
</head>

<body>

<div class="signup-card">

    <div class="signup-header">
        <h3><span>Fitness</span>World</h3>
        <p class="small text-muted">Create your account & start training today</p>
    </div>

    <div class="signup-body">
        <form action="<%=request.getContextPath()%>/send-otp" method="post">


            <div class="form-group">
                <label>Full Name</label>
                <input type="text" class="form-control" name="user_name" required>
            </div>

            <div class="form-group">
                <label>Email</label>
                <input type="email" class="form-control" name="user_email" required>
            </div>

            <div class="form-group">
                <label>Mobile Number</label>
                <input type="tel" class="form-control" name="user_mobile" required>
            </div>

            <div class="form-group">
                <label>Address</label>
                <input type="text" class="form-control" name="address" required>
            </div>

            <!-- ✅ Password -->
            <div class="form-group">
                <label>Password</label>
                <input type="password" class="form-control" name="user_password" required>
            </div>

            <!-- ✅ Confirm Password (IMPORTANT) -->
            <div class="form-group">
                <label>Confirm Password</label>
                <input type="password" class="form-control" name="confirm_password" required>
            </div>

            <div class="form-group">
                <label>Date of Birth</label>
                <input type="date" class="form-control" name="dob"
                       max="<%= java.time.LocalDate.now().minusYears(16) %>" required>
            </div>

            <div class="form-group">
                <label>Gender</label><br>
                <input type="radio" name="gender" value="Male" required> Male
                <input type="radio" name="gender" value="Female" class="ml-3" required> Female
            </div>

            <!-- ✅ checkbox name must be check -->
            <div class="form-check mb-3">
                <input type="checkbox" class="form-check-input" name="check" value="yes" required>
                <label class="form-check-label small">
                    I agree to the Terms & Privacy Policy
                </label>
            </div>

            <button type="submit" class="btn btn-primary btn-block">
                Create Account
            </button>

            <div class="text-center mt-3">
                <a href="login.jsp" class="text-light">
                    Already have an account? Login
                </a>
            </div>

        </form>
    </div>
</div>

</body>
</html>
