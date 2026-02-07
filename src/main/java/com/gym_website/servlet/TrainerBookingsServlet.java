package com.gym_website.servlet;

import com.gym_website.dao.BookingDao;
import com.gym_website.entities.Trainer;
import com.gym_website.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/trainer-bookings")
public class TrainerBookingsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // ===== ✅ STANDARD TRAINER AUTH CHECK =====
        if (session == null || session.getAttribute("currentTrainer") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp?type=trainer"
            );
            return;
        }

        Trainer trainer = (Trainer) session.getAttribute("currentTrainer");

        BookingDao dao =
                new BookingDao(ConnectionProvider.getConnection());

        // ✅ Bookings List
        List<Map<String, String>> bookings =
                dao.getBookingsByTrainer(trainer.getId());
        request.setAttribute("bookings", bookings);

        // ✅ Booking Stats
        int totalBookings = (bookings != null) ? bookings.size() : 0;
        int pendingBookings = 0;
        int approvedBookings = 0;
        int rejectedBookings = 0;

        if (bookings != null) {
            for (Map<String, String> b : bookings) {
                String status = b.get("status");

                if ("PENDING".equalsIgnoreCase(status)) pendingBookings++;
                else if ("APPROVED".equalsIgnoreCase(status)) approvedBookings++;
                else if ("REJECTED".equalsIgnoreCase(status)) rejectedBookings++;
            }
        }

        request.setAttribute("totalBookings", totalBookings);
        request.setAttribute("pendingBookings", pendingBookings);
        request.setAttribute("approvedBookings", approvedBookings);
        request.setAttribute("rejectedBookings", rejectedBookings);

        request.getRequestDispatcher(
                "trainer-bookings.jsp"
        ).forward(request, response);
    }
}
