package com.gym_website.helper;

import java.util.Random;

public class OtpHelper {
    public static String generateOtp() {
        return String.valueOf(100000 + new Random().nextInt(900000)); // 6-digit OTP
    }
}
