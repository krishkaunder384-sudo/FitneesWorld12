package com.gym_website.ForgotPassword.servlet;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ValidateOtp")
public class ValidateOtp extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher dispatcher;

        // ✅ Get session safely
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("otp") == null) {
            // session expired or otp missing
            request.setAttribute("error", "Session expired. Please request OTP again.");
            dispatcher = request.getRequestDispatcher("ForgotPassword_JSP/forgotPassword.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // ✅ Read OTP input safely
        String otpInput = request.getParameter("otp");

        if (otpInput == null || otpInput.trim().isEmpty()) {
            request.setAttribute("error", "Please enter OTP.");
            dispatcher = request.getRequestDispatcher("ForgotPassword_JSP/EnterOtp.jsp");
            dispatcher.forward(request, response);
            return;
        }

        int enteredOtp;
        try {
            enteredOtp = Integer.parseInt(otpInput.trim());
        } catch (Exception e) {
            request.setAttribute("error", "OTP must contain only numbers.");
            dispatcher = request.getRequestDispatcher("ForgotPassword_JSP/EnterOtp.jsp");
            dispatcher.forward(request, response);
            return;
        }

        int sessionOtp = (int) session.getAttribute("otp");
        String email = (String) session.getAttribute("email");

        // ✅ Compare OTP
        if (enteredOtp == sessionOtp) {

            session.removeAttribute("otp");


            // success → go to new password page
            request.setAttribute("email", email);
            request.setAttribute("message", "OTP verified successfully. Please set a new password.");

            dispatcher = request.getRequestDispatcher("ForgotPassword_JSP/newPassword.jsp");
            dispatcher.forward(request, response);

        } else {
            request.setAttribute("error", "Invalid OTP. Please try again.");
            dispatcher = request.getRequestDispatcher("ForgotPassword_JSP/EnterOtp.jsp");
            dispatcher.forward(request, response);
        }
    }

    // ✅ if someone hits URL in browser
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/ForgotPassword_JSP/forgotPassword.jsp");
    }
}
