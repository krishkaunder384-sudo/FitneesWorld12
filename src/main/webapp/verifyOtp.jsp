<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Verify OTP | FitnessWorld</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
</head>
<body style="background:#0b0b0b;color:white;font-family:Poppins;">

<div class="container mt-5" style="max-width:500px;">
    <h3 class="text-center mb-4">Verify OTP</h3>

    <%
        String error = request.getParameter("error");
        if(error != null){
    %>
        <div class="alert alert-danger"><%= error %></div>
    <% } %>

    <form action="<%=request.getContextPath()%>/verify-otp" method="post">
        <div class="form-group">
            <label>Enter OTP</label>
            <input type="text" name="otp" class="form-control" maxlength="6" required>
        </div>

        <button class="btn btn-danger btn-block">Verify & Create Account</button>
    </form>
</div>

</body>
</html>
