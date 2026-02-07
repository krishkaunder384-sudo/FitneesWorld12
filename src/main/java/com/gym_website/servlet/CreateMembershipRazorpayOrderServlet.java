package com.gym_website.servlet;

import com.gym_website.config.RazorpayConfig;
import com.gym_website.dao.UserMembershipDao;
import com.gym_website.entities.User;
import com.gym_website.helper.ConnectionProvider;

import com.razorpay.Order;
import com.razorpay.RazorpayClient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.json.JSONObject;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/create-membership-order")
public class CreateMembershipRazorpayOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JSONObject res = new JSONObject();

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.setStatus(401);
            res.put("success", false);
            res.put("message", "Login required");
            response.getWriter().print(res.toString());
            return;
        }

        User currentUser = (User) session.getAttribute("currentUser");

        String membershipIdStr = request.getParameter("userMembershipId");

        if (membershipIdStr == null || membershipIdStr.trim().isEmpty()) {
            response.setStatus(400);
            res.put("success", false);
            res.put("message", "userMembershipId required");
            response.getWriter().print(res.toString());
            return;
        }

        int userMembershipId;
        try {
            userMembershipId = Integer.parseInt(membershipIdStr.trim());
        } catch (Exception ex) {
            response.setStatus(400);
            res.put("success", false);
            res.put("message", "Invalid userMembershipId");
            response.getWriter().print(res.toString());
            return;
        }

        try (Connection con = ConnectionProvider.getConnection()) {

            // ✅ validate Razorpay keys
            RazorpayConfig.validateKeys();

            // ✅ Fetch membership price securely
            double price = 0;

            String sql =
                    "SELECT mp.price " +
                            "FROM user_memberships um " +
                            "JOIN membership_plans mp ON um.plan_id = mp.id " +
                            "WHERE um.id=? AND um.user_id=? " +
                            "AND um.status='PENDING' AND um.payment_status='UNPAID'";

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, userMembershipId);
                ps.setInt(2, currentUser.getId());

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        price = rs.getDouble("price");
                    } else {
                        response.setStatus(400);
                        res.put("success", false);
                        res.put("message", "Membership not valid / already paid / not pending");
                        response.getWriter().print(res.toString());
                        return;
                    }
                }
            }

            int amountPaise = (int) Math.round(price * 100);
            if (amountPaise <= 0) {
                response.setStatus(400);
                res.put("success", false);
                res.put("message", "Invalid membership price");
                response.getWriter().print(res.toString());
                return;
            }

            // ✅ create Razorpay order
            RazorpayClient client = new RazorpayClient(
                    RazorpayConfig.KEY_ID,
                    RazorpayConfig.KEY_SECRET
            );

            JSONObject options = new JSONObject();
            options.put("amount", amountPaise);
            options.put("currency", "INR");
            options.put("receipt", "membership_" + userMembershipId);
            options.put("payment_capture", 1);

            Order order = client.orders.create(options);

            String orderId = order.get("id");
            int orderAmount = order.get("amount");
            String currency = order.get("currency");

            // ✅ Save order_id into DB using same connection
            UserMembershipDao dao = new UserMembershipDao(con);
            boolean saved = dao.saveMembershipOrderId(userMembershipId, currentUser.getId(), orderId);

            if (!saved) {
                response.setStatus(400);
                res.put("success", false);
                res.put("message", "Could not save Razorpay order (membership not valid / already paid)");
                response.getWriter().print(res.toString());
                return;
            }

            // ✅ Success response
            res.put("success", true);
            res.put("orderId", orderId);
            res.put("amount", orderAmount);
            res.put("currency", currency);
            res.put("key", RazorpayConfig.KEY_ID);

            res.put("userMembershipId", userMembershipId);
            res.put("price", price);

            response.setStatus(200);
            response.getWriter().print(res.toString());

        } catch (Exception e) {
            e.printStackTrace();

            response.setStatus(500);
            res.put("success", false);
            res.put("message", "Server error while creating membership order");
            res.put("error", e.getMessage()); // ✅ this will help you debug frontend popup
            response.getWriter().print(res.toString());
        }
    }
}
