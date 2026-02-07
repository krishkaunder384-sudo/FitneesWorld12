package com.gym_website.servlet;

import com.gym_website.config.RazorpayConfig;
import com.gym_website.dao.BookingDao;
import com.gym_website.entities.Message;
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

@WebServlet("/verify-payment")
public class VerifyPaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("currentUser");

        try {
            // ✅ validate keys before using
            RazorpayConfig.validateKeys();

            String bookingIdStr = request.getParameter("bookingId");
            int bookingId;

            try {
                bookingId = Integer.parseInt(bookingIdStr);
            } catch (Exception ex) {
                session.setAttribute("msg",
                        new Message("Invalid bookingId.", "error", "alert-danger"));
                response.sendRedirect(request.getContextPath() + "/my-bookings");
                return;
            }

            String razorpayPaymentId = trim(request.getParameter("razorpay_payment_id"));
            String razorpayOrderId = trim(request.getParameter("razorpay_order_id"));
            String razorpaySignature = trim(request.getParameter("razorpay_signature"));

            if (isBlank(razorpayPaymentId) || isBlank(razorpayOrderId) || isBlank(razorpaySignature)) {
                session.setAttribute("msg",
                        new Message("Payment verification failed (missing details).", "error", "alert-danger"));
                response.sendRedirect(request.getContextPath() + "/my-bookings");
                return;
            }

            BookingDao dao = new BookingDao(ConnectionProvider.getConnection());

            // ✅ IMPORTANT: confirm orderId matches orderId stored in booking (prevents spoofing)
            boolean orderOk = dao.isOrderIdValid(bookingId, currentUser.getId(), razorpayOrderId);
            if (!orderOk) {
                session.setAttribute("msg",
                        new Message("Payment failed: Order ID mismatch / invalid booking.", "error", "alert-danger"));
                response.sendRedirect(request.getContextPath() + "/my-bookings");
                return;
            }

            // ✅ Verify HMAC signature
            String payload = razorpayOrderId + "|" + razorpayPaymentId;
            String generatedSignature = hmacSha256(payload, RazorpayConfig.KEY_SECRET);

            // safer comparison
            boolean signatureMatch = MessageDigest.isEqual(
                    generatedSignature.getBytes(StandardCharsets.UTF_8),
                    razorpaySignature.getBytes(StandardCharsets.UTF_8)
            );

            if (!signatureMatch) {
                session.setAttribute("msg",
                        new Message("Payment verification failed (invalid signature).", "error", "alert-danger"));
                response.sendRedirect(request.getContextPath() + "/my-bookings");
                return;
            }

            // ✅ update DB (mark PAID)
            boolean ok = dao.markPaid(
                    bookingId,
                    currentUser.getId(),
                    razorpayPaymentId,
                    razorpayOrderId,
                    razorpaySignature
            );

            if (ok) {
                session.setAttribute("msg",
                        new Message("✅ Payment successful & verified!", "success", "alert-success"));
            } else {
                session.setAttribute("msg",
                        new Message("Payment verified but booking not updated (already paid / invalid booking).",
                                "error", "alert-danger"));
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msg",
                    new Message("Server error during payment verification: " + e.getMessage(),
                            "error", "alert-danger"));
        }

        response.sendRedirect(request.getContextPath() + "/my-bookings");
    }

    private String trim(String s) {
        return s == null ? null : s.trim();
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }

    // ✅ Razorpay signature = HEX(HmacSHA256(payload, secret))
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
