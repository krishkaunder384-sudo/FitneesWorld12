package com.gym_website.servlet;

import com.gym_website.helper.MailHelper;
import com.gym_website.helper.OtpHelper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/send-otp")
public class SendOtpServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Read form
        String name = request.getParameter("user_name");
        String email = request.getParameter("user_email");
        String mobile = request.getParameter("user_mobile");
        String address = request.getParameter("address");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String password = request.getParameter("user_password");
        String confirmPassword = request.getParameter("confirm_password");
        String check = request.getParameter("check");

        // Basic validation
        if (check == null) {
            response.sendRedirect(request.getContextPath() + "/signup.jsp?error=Please+accept+Terms");
            return;
        }

        if (email == null || email.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/signup.jsp?error=Email+required");
            return;
        }

        if (password == null || password.length() < 6) {
            response.sendRedirect(request.getContextPath() + "/signup.jsp?error=Password+must+be+atleast+6+chars");
            return;
        }

        if (confirmPassword == null || !password.equals(confirmPassword)) {
            response.sendRedirect(request.getContextPath() + "/signup.jsp?error=Passwords+do+not+match");
            return;
        }

        // ✅ Store user details in session temporarily
        session.setAttribute("pending_name", name);
        session.setAttribute("pending_email", email);
        session.setAttribute("pending_mobile", mobile);
        session.setAttribute("pending_address", address);
        session.setAttribute("pending_dob", dob);
        session.setAttribute("pending_gender", gender);
        session.setAttribute("pending_password", password);

        // ✅ Generate OTP
        String otp = OtpHelper.generateOtp();
        session.setAttribute("signup_otp", otp);
        session.setAttribute("otp_time", System.currentTimeMillis());

        // ✅ Send OTP mail (HTML)
        String subject = "FitnessWorld OTP Verification";
        String html =
                "<div style='font-family:Arial;padding:20px'>" +
                        "<h2 style='color:#ff2e2e'>FitnessWorld OTP</h2>" +
                        "<p>Your OTP for signup is:</p>" +
                        "<h1 style='letter-spacing:4px'>" + otp + "</h1>" +
                        "<p>This OTP is valid for 5 minutes.</p>" +
                        "</div>";

        boolean sent = MailHelper.sendEmail(email, subject, html);

        if (!sent) {
            response.sendRedirect(request.getContextPath() + "/signup.jsp?error=Unable+to+send+OTP");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/verifyOtp.jsp");
    }
}
