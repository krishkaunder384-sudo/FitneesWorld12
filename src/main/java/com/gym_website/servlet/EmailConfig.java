package com.gym_website.config;

public class EmailConfig {

    public static final String EMAIL_USER = System.getenv("GYM_EMAIL_USER");
    public static final String EMAIL_PASS = System.getenv("GYM_EMAIL_PASS");

    public static void validate() {
        if (EMAIL_USER == null || EMAIL_USER.isBlank() ||
                EMAIL_PASS == null || EMAIL_PASS.isBlank()) {

            throw new RuntimeException("Email credentials missing. Set GYM_EMAIL_USER and GYM_EMAIL_PASS in Env Variables.");
        }
    }
}
