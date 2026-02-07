package com.gym_website.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;

import com.gym_website.dao.BookingDao;
import com.gym_website.entities.Message;
import com.gym_website.entities.User;
import com.gym_website.helper.ConnectionProvider;

@WebServlet("/BookSessionServlet")
public class BookSessionServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // 🔐 Login check
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String trainerIdStr = request.getParameter("trainerId");
        String sessionDate = request.getParameter("sessionDate");
        String sessionTime = request.getParameter("sessionTime");

        try {
            // ✅ Basic validation
            if (trainerIdStr == null || sessionDate == null || sessionTime == null
                    || trainerIdStr.trim().isEmpty()
                    || sessionDate.trim().isEmpty()
                    || sessionTime.trim().isEmpty()) {

                session.setAttribute("msg",
                        new Message("All booking fields are required.",
                                "error",
                                "alert-danger"));

                response.sendRedirect(request.getContextPath() + "/public-trainers.jsp");
                return;
            }

            int trainerId = Integer.parseInt(trainerIdStr.trim());
            int userId = currentUser.getId();

            // ✅ Date validation (no past bookings)
            LocalDate chosenDate = LocalDate.parse(sessionDate.trim());
            if (chosenDate.isBefore(LocalDate.now())) {
                session.setAttribute("msg",
                        new Message("You cannot book a session in the past. Please choose a valid date.",
                                "error",
                                "alert-danger"));

                response.sendRedirect(request.getContextPath() + "/trainer-profile.jsp?id=" + trainerId);
                return;
            }

            BookingDao dao = new BookingDao(ConnectionProvider.getConnection());

            // ✅ 1) prevent duplicate booking by same user
            if (dao.isBookingAlreadyExists(userId, trainerId, sessionDate, sessionTime)) {
                session.setAttribute("msg",
                        new Message("You already booked this trainer at the same time slot.",
                                "error",
                                "alert-danger"));

                response.sendRedirect(request.getContextPath() + "/trainer-profile.jsp?id=" + trainerId);
                return;
            }

            // ✅ 2) prevent double-booking trainer slot by any user
            if (dao.isTrainerSlotTaken(trainerId, sessionDate, sessionTime)) {
                session.setAttribute("msg",
                        new Message("This time slot is already booked. Please choose another slot.",
                                "error",
                                "alert-danger"));

                response.sendRedirect(request.getContextPath() + "/trainer-profile.jsp?id=" + trainerId);
                return;
            }

            // ✅ 3) Save booking
            boolean success = dao.addBooking(userId, trainerId, sessionDate, sessionTime);

            if (success) {
                session.setAttribute("msg",
                        new Message("Session booked successfully! Pending admin approval.",
                                "success",
                                "alert-success"));
            } else {
                session.setAttribute("msg",
                        new Message("Booking failed. Please try again.",
                                "error",
                                "alert-danger"));
            }

            response.sendRedirect(request.getContextPath() + "/trainer-profile.jsp?id=" + trainerId);

        } catch (Exception e) {
            e.printStackTrace();

            session.setAttribute("msg",
                    new Message("Something went wrong while booking.",
                            "error",
                            "alert-danger"));

            // fallback redirect
            if (trainerIdStr != null && !trainerIdStr.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/trainer-profile.jsp?id=" + trainerIdStr.trim());
            } else {
                response.sendRedirect(request.getContextPath() + "/public-trainers.jsp");
            }
        }
    }
}
