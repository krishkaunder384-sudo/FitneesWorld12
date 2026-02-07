package com.gym_website.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.gym_website.dao.BookingDao;
import com.gym_website.entities.User;
import com.gym_website.helper.ConnectionProvider;

@WebServlet("/my-bookings")
public class MyBookingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // 🔐 Login check
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 📦 Fetch bookings for this user
        BookingDao dao = new BookingDao(ConnectionProvider.getConnection());
        List<Map<String, String>> bookings =
                dao.getBookingsByUser(currentUser.getId());

        // 📤 Send to JSP
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("my-bookings.jsp")
                .forward(request, response);
    }
}
