package com.gym_website.servlet;

import java.io.IOException;

import com.gym_website.entities.Message;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminloginservlet")
public class AdminLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        HttpSession session = req.getSession();
        String contextPath = req.getContextPath();

        // ✅ TEMP ADMIN LOGIN (replace with DB later)
        if ("admin".equals(username) && "admin123".equals(password)) {

            // 🔐 IMPORTANT: match filter key
            session.setAttribute("admin", true);

            resp.sendRedirect(contextPath + "/AdminDashboardPage/adminDashboard.jsp");
            return;
        }

        // ❌ Login failed
        session.setAttribute(
                "msg",
                new Message("Invalid admin credentials", "error", "alert alert-danger")
        );

        // ✅ redirect back to login page with admin tab open
        resp.sendRedirect(contextPath + "/login.jsp?type=admin");
    }
}
