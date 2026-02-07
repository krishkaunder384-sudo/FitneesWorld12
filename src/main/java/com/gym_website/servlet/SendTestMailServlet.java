package com.gym_website.servlet;

import com.gym_website.helper.MailHelper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/send-test-mail")
public class SendTestMailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain");

        String to = request.getParameter("to");

        if (to == null || to.trim().isEmpty()) {
            response.getWriter().println("❌ Please provide ?to=yourmail@gmail.com");
            return;
        }

        boolean sent = MailHelper.sendEmail(
                to.trim(),
                "FitnessWorld - Test Mail ✅",
                "Hello! This is a test mail from FitnessWorld project."
        );

        if (sent) {
            response.getWriter().println("✅ Email sent successfully to: " + to);
        } else {
            response.getWriter().println("❌ Email sending failed. Check server console logs.");
        }
    }
}
