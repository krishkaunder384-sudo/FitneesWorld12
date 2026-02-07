package com.gym_website.helper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionProvider {

    private static final String URL =
            String host = System.getenv("DB_HOST");
String port = System.getenv("DB_PORT");
String db   = System.getenv("DB_NAME");
String user = System.getenv("DB_USER");
String pass = System.getenv("DB_PASSWORD");

String url = "jdbc:mysql://" + host + ":" + port + "/" + db +
             "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

Connection con = DriverManager.getConnection(url, user, pass);

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
