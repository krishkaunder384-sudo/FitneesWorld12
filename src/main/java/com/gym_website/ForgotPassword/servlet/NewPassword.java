package com.gym_website.ForgotPassword.servlet;

import com.gym_website.entities.Message;
import com.gym_website.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/newPassword")
public class NewPassword extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        String newPassword = request.getParameter("password");
        String confPassword = request.getParameter("confPassword");

        // ✅ email can come from hidden field OR session
        String email = request.getParameter("email");
        if (email == null || email.trim().isEmpty()) {
            email = (String) session.getAttribute("email");
        }

        // ✅ basic validation
        if (email == null || email.trim().isEmpty()) {
            session.setAttribute("msg",
                    new Message("Session expired. Please try Forgot Password again.",
                            "error", "alert-danger"));
            response.sendRedirect(request.getContextPath() + "/ForgotPassword_JSP/forgotPassword.jsp");
            return;
        }

        if (newPassword == null || confPassword == null || !newPassword.equals(confPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            request.setAttribute("email", email);
            request.getRequestDispatcher("ForgotPassword_JSP/newPassword.jsp")
                    .forward(request, response);
            return;
        }

        // ✅ password strength validation
        if (!(newPassword.length() >= 5
                && newPassword.matches(".*[A-Z].*")
                && newPassword.matches(".*[^a-zA-Z0-9].*"))) {

            request.setAttribute("error",
                    "Password must be at least 5 characters, contain 1 uppercase and 1 special symbol.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("ForgotPassword_JSP/newPassword.jsp")
                    .forward(request, response);
            return;
        }

        // ✅ update in DB
        try (Connection connection = ConnectionProvider.getConnection()) {

            PreparedStatement pst =
                    connection.prepareStatement("UPDATE users SET password = ? WHERE email = ?");

            pst.setString(1, newPassword);
            pst.setString(2, email);

            int rowCount = pst.executeUpdate();

            if (rowCount > 0) {

                // ✅ clear OTP session after success
                session.removeAttribute("otp");
                session.removeAttribute("email");

                session.setAttribute("msg",
                        new Message("Password reset successful. Please login!",
                                "success", "alert-success"));

                response.sendRedirect(request.getContextPath() + "/login.jsp");

            } else {
                session.setAttribute("msg",
                        new Message("Password reset failed! Account not found.",
                                "error", "alert-danger"));
                response.sendRedirect(request.getContextPath() + "/ForgotPassword_JSP/forgotPassword.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msg",
                    new Message("Server error while resetting password.",
                            "error", "alert-danger"));
            response.sendRedirect(request.getContextPath() + "/ForgotPassword_JSP/forgotPassword.jsp");
        }
    }
}
