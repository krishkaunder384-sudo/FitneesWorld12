package com.gym_website.helper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionProvider {

    private static Connection connection;

    public static Connection getConnection() {

        try {
            if (connection == null || connection.isClosed()) {

                // Load MySQL driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Get Railway environment variables
                String host = System.getenv("DB_HOST");
                String port = System.getenv("DB_PORT");
                String db   = System.getenv("DB_NAME");
                String user = System.getenv("DB_USER");
                String pass = System.getenv("DB_PASSWORD");

                String url = "jdbc:mysql://" + host + ":" + port + "/" + db +
                        "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

                connection = DriverManager.getConnection(url, user, pass);

                System.out.println("✅ Database Connected Successfully");
            }

        } catch (Exception e) {
            System.out.println("❌ Database Connection Failed");
            e.printStackTrace();
        }

        return connection;
    }
}
