package com.gym_website.admin.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DashboardDAOImpl implements DashboardDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/`gym`";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "password";

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/gym","root","admin");
    }

    @Override
    public List<Double> getEarnings() {
        List<Double> earnings = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT amount FROM Earnings")) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                earnings.add(rs.getDouble("amount"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return earnings;
    }

    @Override
    public int getMonthlyBookings() {
        int count = 0;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM Bookings WHERE MONTH(date) = MONTH(CURDATE())")) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    @Override
    public int getPendingPayments() {
        int count = 0;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM Payments WHERE status = 'Pending'")) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    @Override
    public int getCustomersEngaged() {
        int count = 0;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM Customers WHERE engaged = true")) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
}
