package com.gym_website.servlet;

import com.gym_website.dao.UserDao;
import com.gym_website.entities.User;
import com.gym_website.helper.ConnectionProvider;
import com.gym_website.helper.MailHelper;
import com.gym_website.helper.PasswordHelper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/verify-otp")
public class VerifyOtpServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/signup.jsp");
            return;
        }

        String enteredOtp = request.getParameter("otp");
        String sessionOtp = (String) session.getAttribute("signup_otp");

        Long otpTime = (Long) session.getAttribute("otp_time");

        if (otpTime == null || (System.currentTimeMillis() - otpTime) > (5 * 60 * 1000)) {
            response.sendRedirect(request.getContextPath() + "/verifyOtp.jsp?error=OTP+Expired");
            return;
        }

        if (sessionOtp == null || enteredOtp == null || !enteredOtp.trim().equals(sessionOtp)) {
            response.sendRedirect(request.getContextPath() + "/verifyOtp.jsp?error=Invalid+OTP");
            return;
        }

        // ✅ fetch pending data
        String name = (String) session.getAttribute("pending_name");
        String email = (String) session.getAttribute("pending_email");
        String mobile = (String) session.getAttribute("pending_mobile");
        String address = (String) session.getAttribute("pending_address");
        String dob = (String) session.getAttribute("pending_dob");
        String gender = (String) session.getAttribute("pending_gender");
        String password = (String) session.getAttribute("pending_password");

        // ✅ hash password
        String hashedPassword = PasswordHelper.hashPassword(password);

        User user = new User(name, email, mobile, hashedPassword, address, dob, gender);

        try {
            UserDao dao = new UserDao(ConnectionProvider.getConnection());
            boolean saved = dao.saveUser(user);

            if (!saved) {
                response.sendRedirect(request.getContextPath() + "/signup.jsp?error=Registration+failed");
                return;
            }

            // ✅ Welcome mail (HTML)
            String subject = "Welcome to FitnessWorld ✅";
            String html =
                    "<div style='font-family:Arial;padding:20px'>" +
                            "<h2 style='color:#ff2e2e'>Welcome " + name + " 💪</h2>" +
                            "<p>Your FitnessWorld account is verified and created successfully.</p>" +
                            "<p>You can now login and explore workouts, diet and memberships.</p>" +
                            "<br><b>FitnessWorld Team</b>" +
                            "</div>";

            MailHelper.sendEmail(email, subject, html);

            // ✅ clear OTP session
            session.removeAttribute("signup_otp");
            session.removeAttribute("otp_time");
            session.removeAttribute("pending_password");

            response.sendRedirect(request.getContextPath() + "/login.jsp?success=Account+created+successfully");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/signup.jsp?error=Server+Error");
        }
    }
}
