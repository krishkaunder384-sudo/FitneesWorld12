package com.gym_website.helper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionProvider {

    private static final String URL =
            "jdbc:mysql://localhost:3306/gym_website?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

    private static final String USER = "gymuser";   // ✅ change to new DB user
    private static final String PASSWORD = "gym123"; // ✅ change to new DB password

    private static Connection connection;

    public static Connection getConnection() {

        try {
            if (connection == null || connection.isClosed()) {

                // Load driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Create fresh connection
                connection = DriverManager.getConnection(URL, USER, PASSWORD);

                System.out.println("✅ Database Connected Successfully");
            }

        } catch (ClassNotFoundException e) {
            System.out.println("❌ MySQL Driver Not Found");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("❌ Database Connection Failed");
            e.printStackTrace();
        }

        return connection;
    }
}
