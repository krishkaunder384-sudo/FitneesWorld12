package com.gym_website.helper;

public class PasswordConvertTool {
    public static void main(String[] args) {

        // Example: hash a password "12345"
        String plain = "newpassword123";
        String hashed = PasswordHelper.hashPassword(plain);

        System.out.println("Plain: " + plain);
        System.out.println("Hashed: " + hashed);
    }
}
