package com.gym_website.servlet;

import com.gym_website.dao.BookingDao;
import com.gym_website.entities.User;
import com.gym_website.helper.ConnectionProvider;
import com.razorpay.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import org.json.JSONObject;

@WebServlet("/create-order")
public class CreateOrderServlet extends HttpServlet {

    private static final String KEY_ID = "YOUR_KEY_ID";
    private static final String KEY_SECRET = "YOUR_KEY_SECRET";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("currentUser");

        if (user == null) {
            response.sendError(401, "Login required");
            return;
        }

        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));

            // ✅ amount in paisa
            int amount = 999 * 100;

            RazorpayClient razorpay = new RazorpayClient(KEY_ID, KEY_SECRET);

            JSONObject orderRequest = new JSONObject();
            orderRequest.put("amount", amount);
            orderRequest.put("currency", "INR");
            orderRequest.put("receipt", "booking_" + bookingId);

            Order order = razorpay.orders.create(orderRequest);

            String orderId = order.get("id");

            BookingDao dao = new BookingDao(ConnectionProvider.getConnection());
            dao.saveOrderId(bookingId, user.getId(), orderId);

            response.setContentType("application/json");
            response.getWriter().write(order.toString());

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Error creating order");
        }
    }
}
