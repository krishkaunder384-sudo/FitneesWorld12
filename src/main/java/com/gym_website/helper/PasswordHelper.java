package com.gym_website.helper;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordHelper {

    // ✅ Hash password while saving in DB
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(10));
    }

    // ✅ Verify password at login
    public static boolean verifyPassword(String plainPassword, String storedPassword) {

        if (plainPassword == null || storedPassword == null) {
            return false;
        }

        storedPassword = storedPassword.trim();

        if (storedPassword.isEmpty()) {
            return false;
        }

        // ✅ If password is bcrypt hash
        if (storedPassword.startsWith("$2a$") ||
                storedPassword.startsWith("$2b$") ||
                storedPassword.startsWith("$2y$") ||
                storedPassword.startsWith("$2$")) {

            return BCrypt.checkpw(plainPassword, storedPassword);
        }

        // ✅ fallback: old passwords stored as plain text
        return plainPassword.equals(storedPassword);
    }
}
