package com.gym_website.dao;

import com.gym_website.entities.User;

import java.sql.*;
import java.util.*;

public class BookingDao {

    private Connection con;

    public BookingDao(Connection con) {
        this.con = con;
    }

    // ===============================
    // ✅ 0️⃣ Check Duplicate Booking (same user + same slot)
    // ===============================
    public boolean isBookingAlreadyExists(int userId, int trainerId, String sessionDate, String sessionTime) {

        String sql =
                "SELECT id FROM bookings " +
                        "WHERE user_id=? AND trainer_id=? AND session_date=? AND session_time=? " +
                        "AND status != 'CANCELLED'";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, trainerId);
            ps.setString(3, sessionDate);
            ps.setString(4, sessionTime);

            ResultSet rs = ps.executeQuery();
            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ===============================
    // ✅ NEW: Check if trainer slot already booked (any user)
    // ===============================
    public boolean isTrainerSlotTaken(int trainerId, String sessionDate, String sessionTime) {

        String sql =
                "SELECT id FROM bookings " +
                        "WHERE trainer_id=? AND session_date=? AND session_time=? " +
                        "AND status IN ('PENDING', 'APPROVED')";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, trainerId);
            ps.setString(2, sessionDate);
            ps.setString(3, sessionTime);

            ResultSet rs = ps.executeQuery();
            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Get saved order id for booking (secure verification)
    public String getOrderId(int bookingId, int userId) {

        String sql = "SELECT razorpay_order_id FROM bookings WHERE id=? AND user_id=?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.setInt(2, userId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("razorpay_order_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ===============================
    // 1️⃣ Insert booking
    // ===============================
    public boolean addBooking(int userId, int trainerId, String sessionDate, String sessionTime) {

        String sql =
                "INSERT INTO bookings (user_id, trainer_id, session_date, session_time) " +
                        "VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, trainerId);
            ps.setString(3, sessionDate);
            ps.setString(4, sessionTime);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ===============================
    // ✅ Pay booking (User) - secure
    // ===============================
    public boolean payBooking(int bookingId, int userId) {

        String sql =
                "UPDATE bookings " +
                        "SET payment_status='PAID', payment_time=CURRENT_TIMESTAMP " +
                        "WHERE id=? AND user_id=? AND status='APPROVED' AND payment_status='UNPAID'";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ===============================
    // 2️⃣ User bookings
    // ===============================
    public List<Map<String, String>> getBookingsByUser(int userId) {

        List<Map<String, String>> list = new ArrayList<>();

        String sql =
                "SELECT b.id, t.name AS trainerName, " +
                        "b.session_date, b.session_time, " +
                        "b.status, b.payment_status " +
                        "FROM bookings b " +
                        "JOIN trainers t ON b.trainer_id = t.id " +
                        "WHERE b.user_id = ? " +
                        "ORDER BY b.created_at DESC";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, String> map = new HashMap<>();
                map.put("id", rs.getString("id"));
                map.put("trainerName", rs.getString("trainerName"));
                map.put("date", rs.getString("session_date"));
                map.put("time", rs.getString("session_time"));
                map.put("status", rs.getString("status"));
                map.put("payment_status", rs.getString("payment_status"));
                list.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ===============================
    // 3️⃣ Cancel booking (USER)
    // ===============================
    public boolean cancelBooking(int bookingId, int userId) {

        String sql =
                "UPDATE bookings " +
                        "SET status='CANCELLED' " +
                        "WHERE id=? AND user_id=? AND status='PENDING'";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ===============================
    // 5️⃣ Admin: all bookings
    // ===============================
    public List<Map<String, String>> getAllBookings() {

        List<Map<String, String>> list = new ArrayList<>();

        String sql =
                "SELECT b.id, u.name AS userName, t.name AS trainerName, " +
                        "b.session_date, b.session_time, b.status " +
                        "FROM bookings b " +
                        "JOIN users u ON b.user_id = u.id " +
                        "JOIN trainers t ON b.trainer_id = t.id " +
                        "ORDER BY b.created_at DESC";

        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, String> map = new HashMap<>();
                map.put("id", rs.getString("id"));
                map.put("userName", rs.getString("userName"));
                map.put("trainerName", rs.getString("trainerName"));
                map.put("date", rs.getString("session_date"));
                map.put("time", rs.getString("session_time"));
                map.put("status", rs.getString("status"));
                list.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ===============================
    // 6️⃣ Admin: update booking status
    // ===============================
    public boolean updateBookingStatus(int bookingId, String status) {

        String sql = "UPDATE bookings SET status=? WHERE id=?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ===============================
    // 8️⃣ Trainer: get bookings assigned to trainer
    // ===============================
    public List<Map<String, String>> getBookingsByTrainer(int trainerId) {

        List<Map<String, String>> list = new ArrayList<>();

        String sql =
                "SELECT b.id, u.name AS userName, u.email AS userEmail, " +
                        "b.session_date, b.session_time, b.status, b.payment_status " +
                        "FROM bookings b " +
                        "JOIN users u ON b.user_id = u.id " +
                        "WHERE b.trainer_id = ? " +
                        "ORDER BY b.created_at DESC";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, trainerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, String> map = new HashMap<>();
                map.put("id", rs.getString("id"));
                map.put("userName", rs.getString("userName"));
                map.put("userEmail", rs.getString("userEmail"));
                map.put("date", rs.getString("session_date"));
                map.put("time", rs.getString("session_time"));
                map.put("status", rs.getString("status"));
                map.put("payment_status", rs.getString("payment_status"));
                list.add(map);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ===============================
    // 9️⃣ Trainer: update booking status (only own trainer booking)
    // ===============================
    public boolean updateBookingStatusByTrainer(int bookingId, int trainerId, String status) {

        String sql =
                "UPDATE bookings SET status=? WHERE id=? AND trainer_id=?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            ps.setInt(3, trainerId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ===============================
    // ✅ 10️⃣ Trainer Booking Stats
    // ===============================
    public int getTotalBookingsByTrainer(int trainerId) {

        String sql = "SELECT COUNT(*) FROM bookings WHERE trainer_id=?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, trainerId);
            ResultSet rs = ps.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getBookingCountByTrainerAndStatus(int trainerId, String status) {

        String sql = "SELECT COUNT(*) FROM bookings WHERE trainer_id=? AND status=?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, trainerId);
            ps.setString(2, status);
            ResultSet rs = ps.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ✅ store razorpay order id (only for approved unpaid booking)
    public boolean saveOrderId(int bookingId, int userId, String orderId) {

        String sql =
                "UPDATE bookings " +
                        "SET razorpay_order_id=? " +
                        "WHERE id=? AND user_id=? AND status='APPROVED' AND payment_status='UNPAID'";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, orderId);
            ps.setInt(2, bookingId);
            ps.setInt(3, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ mark paid only after verification
    public boolean markPaid(int bookingId, int userId, String paymentId, String orderId, String signature) {

        String sql =
                "UPDATE bookings SET payment_status='PAID', payment_time=CURRENT_TIMESTAMP, " +
                        "razorpay_payment_id=?, razorpay_order_id=?, razorpay_signature=? " +
                        "WHERE id=? AND user_id=? AND status='APPROVED' AND payment_status='UNPAID'";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, paymentId);
            ps.setString(2, orderId);
            ps.setString(3, signature);
            ps.setInt(4, bookingId);
            ps.setInt(5, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Check if orderId belongs to this booking + user
    public boolean isOrderIdValid(int bookingId, int userId, String orderId) {

        String sql =
                "SELECT id FROM bookings " +
                        "WHERE id=? AND user_id=? AND razorpay_order_id=?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.setInt(2, userId);
            ps.setString(3, orderId);

            ResultSet rs = ps.executeQuery();
            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Users dropdown list for Trainer Dashboard
    public List<User> getUsersForTrainer(int trainerId) {

        List<User> list = new ArrayList<>();

        String sql =
                "SELECT DISTINCT u.id, u.name, u.email " +
                        "FROM bookings b " +
                        "JOIN users u ON b.user_id = u.id " +
                        "WHERE b.trainer_id=? AND b.status IN ('PENDING','APPROVED') " +
                        "ORDER BY u.name ASC";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, trainerId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                User u = new User();
                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));

                list.add(u);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ===============================
    // 7️⃣ Global Stats
    // ===============================
    public int getTotalBookings() {

        try (PreparedStatement ps =
                     con.prepareStatement("SELECT COUNT(*) FROM bookings");
             ResultSet rs = ps.executeQuery()) {

            return rs.next() ? rs.getInt(1) : 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getBookingCountByStatus(String status) {

        try (PreparedStatement ps =
                     con.prepareStatement("SELECT COUNT(*) FROM bookings WHERE status=?")) {

            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
