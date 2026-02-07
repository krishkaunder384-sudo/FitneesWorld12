package com.gym_website.servlet;

import com.gym_website.config.RazorpayConfig;
import com.gym_website.dao.UserMembershipDao;
import com.gym_website.entities.User;
import com.gym_website.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.json.JSONObject;

@WebServlet("/verify-membership-payment")
public class VerifyMembershipPaymentServlet extends HttpServlet {

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

        try {
            RazorpayConfig.validateKeys();

            int userMembershipId = Integer.parseInt(request.getParameter("userMembershipId"));

            String razorpayPaymentId = trim(request.getParameter("razorpay_payment_id"));
            String razorpayOrderId = trim(request.getParameter("razorpay_order_id"));
            String razorpaySignature = trim(request.getParameter("razorpay_signature"));

            if (isBlank(razorpayPaymentId) || isBlank(razorpayOrderId) || isBlank(razorpaySignature)) {
                response.setStatus(400);
                res.put("success", false);
                res.put("message", "Missing payment details");
                response.getWriter().print(res.toString());
                return;
            }

            UserMembershipDao dao = new UserMembershipDao(ConnectionProvider.getConnection());

            boolean orderOk = dao.isMembershipOrderValid(userMembershipId, currentUser.getId(), razorpayOrderId);
            if (!orderOk) {
                response.setStatus(400);
                res.put("success", false);
                res.put("message", "Invalid order / membership mismatch");
                response.getWriter().print(res.toString());
                return;
            }

            // ✅ signature verify
            String payload = razorpayOrderId + "|" + razorpayPaymentId;
            String generatedSignature = hmacSha256(payload, RazorpayConfig.KEY_SECRET);

            boolean signatureMatch = MessageDigest.isEqual(
                    generatedSignature.getBytes(StandardCharsets.UTF_8),
                    razorpaySignature.getBytes(StandardCharsets.UTF_8)
            );

            if (!signatureMatch) {
                response.setStatus(400);
                res.put("success", false);
                res.put("message", "Invalid signature");
                response.getWriter().print(res.toString());
                return;
            }

            // ✅ expire old memberships before activating new one
            dao.expireAllActiveMemberships(currentUser.getId());

            boolean ok = dao.markMembershipPaid(
                    userMembershipId,
                    currentUser.getId(),
                    razorpayPaymentId,
                    razorpayOrderId,
                    razorpaySignature
            );

            if (ok) {
                response.setStatus(200);
                res.put("success", true);
                res.put("message", "✅ Membership Activated Successfully!");
                res.put("userMembershipId", userMembershipId);
            } else {
                response.setStatus(500);
                res.put("success", false);
                res.put("message", "Payment verified but membership not updated");
            }

            response.getWriter().print(res.toString());

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(500);
            res.put("success", false);
            res.put("message", "Server error while verifying payment");
            res.put("error", e.toString());
            response.getWriter().print(res.toString());
        }
    }

    private String trim(String s) { return s == null ? null : s.trim(); }
    private boolean isBlank(String s) { return s == null || s.trim().isEmpty(); }

    private String hmacSha256(String data, String secret) throws Exception {
        Mac sha256Hmac = Mac.getInstance("HmacSHA256");
        SecretKeySpec secretKey = new SecretKeySpec(secret.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
        sha256Hmac.init(secretKey);

        byte[] hash = sha256Hmac.doFinal(data.getBytes(StandardCharsets.UTF_8));

        StringBuilder sb = new StringBuilder();
        for (byte b : hash) sb.append(String.format("%02x", b));
        return sb.toString();
    }
}
