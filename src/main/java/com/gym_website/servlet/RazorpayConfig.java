package com.gym_website.config;

public class RazorpayConfig {

    // Read from Environment Variables (safer than hardcoding)
    public static final String KEY_ID = System.getenv("RAZORPAY_KEY_ID");
    public static final String KEY_SECRET = System.getenv("RAZORPAY_KEY_SECRET");

    // fixed amount for booking
    public static final int BOOKING_AMOUNT_PAISE = 999 * 100; // ₹999

    public static void validateKeys() {
        if (KEY_ID == null || KEY_ID.isBlank() || KEY_SECRET == null || KEY_SECRET.isBlank()) {
            throw new RuntimeException(
                    "Razorpay keys not found. Please set environment variables " +
                            "RAZORPAY_KEY_ID and RAZORPAY_KEY_SECRET."
            );
        }
    }
}
