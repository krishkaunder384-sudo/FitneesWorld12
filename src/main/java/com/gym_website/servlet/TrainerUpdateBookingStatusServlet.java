package com.gym_website.servlet;

import com.gym_website.dao.BookingDao;
import com.gym_website.entities.Trainer;
import com.gym_website.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/trainer-update-booking")
public class TrainerUpdateBookingStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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

        try {
            int bookingId =
                    Integer.parseInt(request.getParameter("bookingId"));
            String status =
                    request.getParameter("status");

            if (!("APPROVED".equals(status) || "REJECTED".equals(status))) {
                session.setAttribute(
                        "msg",
                        "❌ Invalid status update!"
                );
                response.sendRedirect(
                        request.getContextPath() + "/trainer-bookings"
                );
                return;
            }

            BookingDao dao =
                    new BookingDao(ConnectionProvider.getConnection());

            boolean ok =
                    dao.updateBookingStatusByTrainer(
                            bookingId,
                            trainer.getId(),
                            status
                    );

            if (ok) {
                session.setAttribute(
                        "msg",
                        "✅ Booking updated successfully!"
                );
            } else {
                session.setAttribute(
                        "msg",
                        "❌ Booking update failed!"
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute(
                    "msg",
                    "❌ Server error while updating booking!"
            );
        }

        response.sendRedirect(
                request.getContextPath() + "/trainer-bookings"
        );
    }
}
