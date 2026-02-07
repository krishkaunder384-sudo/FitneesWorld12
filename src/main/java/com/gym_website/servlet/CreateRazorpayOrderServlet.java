package com.gym_website.servlet;

import com.gym_website.config.RazorpayConfig;
import com.gym_website.dao.BookingDao;
import com.gym_website.entities.User;
import com.gym_website.helper.ConnectionProvider;

import com.razorpay.Order;
import com.razorpay.RazorpayClient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.json.JSONObject;

import java.io.IOException;

@WebServlet("/create-razorpay-order")
public class CreateRazorpayOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("currentUser") == null) {
            response.setStatus(401);
            response.getWriter().print(new JSONObject()
                    .put("success", false)
                    .put("message", "Login required")
                    .toString());
            return;
        }

        User currentUser = (User) session.getAttribute("currentUser");

        try {
            // ✅ validate Razorpay keys first
            RazorpayConfig.validateKeys();

            String bookingIdStr = request.getParameter("bookingId");

            if (bookingIdStr == null || bookingIdStr.trim().isEmpty()) {
                response.setStatus(400);
                response.getWriter().print(new JSONObject()
                        .put("success", false)
                        .put("message", "bookingId required")
                        .toString());
                return;
            }

            int bookingId;
            try {
                bookingId = Integer.parseInt(bookingIdStr.trim());
            } catch (NumberFormatException ex) {
                response.setStatus(400);
                response.getWriter().print(new JSONObject()
                        .put("success", false)
                        .put("message", "Invalid bookingId")
                        .toString());
                return;
            }

            // ✅ Amount in paise
            int amount = RazorpayConfig.BOOKING_AMOUNT_PAISE;

            RazorpayClient client = new RazorpayClient(
                    RazorpayConfig.KEY_ID,
                    RazorpayConfig.KEY_SECRET
            );

            JSONObject options = new JSONObject();
            options.put("amount", amount);
            options.put("currency", "INR");
            options.put("receipt", "booking_" + bookingId);
            options.put("payment_capture", 1);

            Order order = client.orders.create(options);
            String orderId = order.get("id");
            String currency = order.get("currency");
            int orderAmount = order.get("amount");

            // ✅ store orderId in DB
            BookingDao dao = new BookingDao(ConnectionProvider.getConnection());
            boolean saved = dao.saveOrderId(bookingId, currentUser.getId(), orderId);

            if (!saved) {
                response.setStatus(400);
                response.getWriter().print(new JSONObject()
                        .put("success", false)
                        .put("message", "Booking not valid / not owned by user")
                        .toString());
                return;
            }

            // ✅ controlled JSON response (frontend friendly)
            JSONObject res = new JSONObject();
            res.put("success", true);
            res.put("orderId", orderId);
            res.put("amount", orderAmount);
            res.put("currency", currency);
            res.put("bookingId", bookingId);
            res.put("userId", currentUser.getId());

            response.setStatus(200);
            response.getWriter().print(res.toString());

        } catch (Exception e) {
            e.printStackTrace();

            response.setStatus(500);
            response.getWriter().print(new JSONObject()
                    .put("success", false)
                    .put("message", "Order creation failed")
                    .put("error", e.getMessage())
                    .toString());
        }
    }
}
