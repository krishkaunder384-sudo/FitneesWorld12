package com.gym_website.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.gym_website.dao.BookingDao;
import com.gym_website.entities.Message;
import com.gym_website.entities.User;
import com.gym_website.helper.ConnectionProvider;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // 🔐 Login check
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));

            BookingDao dao =
                    new BookingDao(ConnectionProvider.getConnection());

            boolean success = dao.payBooking(bookingId, currentUser.getId());


            if (success) {
                session.setAttribute("msg",
                        new Message(
                                "Payment successful!",
                                "success",
                                "alert-success"
                        ));
            } else {
                session.setAttribute("msg",
                        new Message(
                                "Payment failed!",
                                "error",
                                "alert-danger"
                        ));
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msg",
                    new Message(
                            "Something went wrong!",
                            "error",
                            "alert-danger"
                    ));
        }

        // ✅ Redirect back to bookings
        response.sendRedirect(
                request.getContextPath() + "/my-bookings"
        );
    }
}
