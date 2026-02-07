package com.gym_website.ForgotPassword.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.Random;

import com.gym_website.helper.ConnectionProvider;

import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/forgotPassword")
public class ForgotPassword extends HttpServlet {

    private static final long OTP_EXPIRY_MS = 5 * 60 * 1000; // 5 minutes

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        RequestDispatcher dispatcher;
        HttpSession session = request.getSession();

        if (email == null || email.trim().isEmpty()) {
            dispatcher = request.getRequestDispatcher("ForgotPassword_JSP/forgotPassword.jsp");
            request.setAttribute("error", "Email is required!");
            dispatcher.forward(request, response);
            return;
        }

        // ✅ check email exists in DB
        boolean emailExists = checkEmailExists(email);

        if (!emailExists) {
            dispatcher = request.getRequestDispatcher("ForgotPassword_JSP/forgotPassword.jsp");
            request.setAttribute("error", "This email is not registered. Please sign up.");
            dispatcher.forward(request, response);
            return;
        }

        // ✅ generate 6 digit OTP
        int otp = new Random().nextInt(900000) + 100000;

        try {
            sendOtpEmail(email, otp);

            // ✅ store OTP + expiry in session
            session.setAttribute("otp", otp);
            session.setAttribute("otpTime", System.currentTimeMillis());
            session.setAttribute("email", email);

            dispatcher = request.getRequestDispatcher("ForgotPassword_JSP/EnterOtp.jsp");
            request.setAttribute("message", "OTP has been sent to your email.");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();

            dispatcher = request.getRequestDispatcher("ForgotPassword_JSP/forgotPassword.jsp");
            request.setAttribute("error", "Failed to send OTP. Please try again later.");
            dispatcher.forward(request, response);
        }
    }

    // ✅ check email exists
    private boolean checkEmailExists(String email) {
        boolean exists = false;

        try (Connection connection = ConnectionProvider.getConnection();
             PreparedStatement ps = connection.prepareStatement("SELECT 1 FROM users WHERE email = ? LIMIT 1")) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                exists = rs.next();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return exists;
    }

    // ✅ send OTP email (Jakarta Mail)
    private void sendOtpEmail(String to, int otp) throws MessagingException {

        final String fromEmail = "YOUR_EMAIL@gmail.com";
        final String appPassword = "YOUR_APP_PASSWORD"; // Gmail App Password

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session mailSession = Session.getInstance(props, new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, appPassword);
            }
        });

        MimeMessage message = new MimeMessage(mailSession);
        message.setFrom(new InternetAddress(fromEmail));
        message.addRecipient(jakarta.mail.Message.RecipientType.TO, new InternetAddress(to));
        message.setSubject("OTP for Password Reset - FitnessWorld");

        message.setText(
                "Your OTP is: " + otp +
                        "\n\nThis OTP will expire in 5 minutes." +
                        "\n\nFitnessWorld Team"
        );

        Transport.send(message);
    }
}
