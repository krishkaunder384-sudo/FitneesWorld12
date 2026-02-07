package com.gym_website.servlet;

import com.gym_website.dao.BookingDao;
import com.gym_website.entities.User;
import com.gym_website.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/cancel-booking")
public class CancelBookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("currentUser");

        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));

            BookingDao dao = new BookingDao(ConnectionProvider.getConnection());
            boolean ok = dao.cancelBooking(bookingId, user.getId());

            if (ok) {
                session.setAttribute("msg", "✅ Booking cancelled successfully.");
            } else {
                session.setAttribute("msg", "❌ Booking cannot be cancelled (only PENDING can be cancelled).");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msg", "❌ Server error while cancelling booking.");
        }

        response.sendRedirect(request.getContextPath() + "/my-bookings");
    }
}
