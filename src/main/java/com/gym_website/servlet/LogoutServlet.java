package com.gym_website.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/logoutservlet")
public class LogoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Get session safely
        HttpSession session = request.getSession(false);

        if (session != null) {
            // remove user + invalidate session completely
            session.removeAttribute("currentUser");
            session.invalidate();
        }

        // ✅ Redirect to login
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}
