package com.gym_website.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import com.gym_website.dao.BookingDao;
import com.gym_website.helper.ConnectionProvider;

@WebServlet("/UpdateBookingStatusServlet")
public class UpdateBookingStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int bookingId = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");

            BookingDao dao = new BookingDao(ConnectionProvider.getConnection());
            dao.updateBookingStatus(bookingId, status);

            response.sendRedirect("AdminDashboardPage/admin-bookings.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminDashboardPage/admin-bookings.jsp");
        }
    }
}
