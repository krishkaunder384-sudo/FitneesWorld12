package com.gym_website.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;

public class UserMembershipDao {

    private Connection con;

    public UserMembershipDao(Connection con) {
        this.con = con;
    }

    // ================= GET ACTIVE MEMBERSHIP =================
    public ResultSet getActiveMembership(int userId) throws Exception {

        String sql =
                "SELECT um.*, mp.duration_days " +
                        "FROM user_memberships um " +
                        "JOIN membership_plans mp ON um.plan_id = mp.id " +
                        "WHERE um.user_id = ? AND um.status = 'ACTIVE' " +
                        "ORDER BY um.end_date DESC " +
                        "LIMIT 1";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, userId);
        return ps.executeQuery();
    }

    // ================= EXPIRE ALL OLD MEMBERSHIPS =================
    public void expireOldMemberships() {

        String sql =
                "UPDATE user_memberships " +
                        "SET status = 'EXPIRED' " +
                        "WHERE end_date < CURDATE() " +
                        "AND status = 'ACTIVE'";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ================= EXPIRE SINGLE MEMBERSHIP =================
    public void expireMembership(int membershipId) throws Exception {

        String sql =
                "UPDATE user_memberships SET status='EXPIRED' WHERE id=?";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, membershipId);
        ps.executeUpdate();
    }

    // ================= GET LATEST MEMBERSHIP =================
    public ResultSet getLatestMembership(int userId) throws Exception {

        String sql =
                "SELECT um.*, mp.name AS plan_name, mp.price " +
                        "FROM user_memberships um " +
                        "JOIN membership_plans mp ON um.plan_id = mp.id " +
                        "WHERE um.user_id = ? " +
                        "ORDER BY um.id DESC " +     // ✅ FIXED: latest created row
                        "LIMIT 1";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, userId);
        return ps.executeQuery();
    }

    // ================= ADD NEW MEMBERSHIP =================
    public boolean addMembership(int userId, int planId,
                                 LocalDate start, LocalDate end) {

        String sql =
                "INSERT INTO user_memberships " +
                        "(user_id, plan_id, start_date, end_date) " +
                        "VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, planId);
            ps.setDate(3, Date.valueOf(start));
            ps.setDate(4, Date.valueOf(end));

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ================= ADMIN: GET ALL USER MEMBERSHIPS =================
    public ResultSet getAllUserMemberships() throws Exception {

        String sql =
                "SELECT " +
                        "u.id AS user_id, " +
                        "u.name AS user_name, " +
                        "u.email, " +
                        "mp.name AS plan_name, " +
                        "um.start_date, " +
                        "um.end_date, " +
                        "um.status " +
                        "FROM user_memberships um " +
                        "JOIN users u ON um.user_id = u.id " +
                        "JOIN membership_plans mp ON um.plan_id = mp.id " +
                        "ORDER BY um.end_date DESC";

        PreparedStatement ps = con.prepareStatement(sql);
        return ps.executeQuery();
    }

    public int createPendingMembership(int userId, int planId, LocalDate start, LocalDate end) {

        String sql =
                "INSERT INTO user_memberships(user_id, plan_id, start_date, end_date, status, payment_status) " +
                        "VALUES (?, ?, ?, ?, 'PENDING', 'UNPAID')";

        try (PreparedStatement ps = con.prepareStatement(sql, java.sql.Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, userId);
            ps.setInt(2, planId);
            ps.setDate(3, Date.valueOf(start));
            ps.setDate(4, Date.valueOf(end));

            int rows = ps.executeUpdate();
            if (rows == 1) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }


    // ✅ save order id
    public boolean saveMembershipOrderId(int membershipId, int userId, String orderId) {

        String sql =
                "UPDATE user_memberships " +
                        "SET razorpay_order_id=? " +
                        "WHERE id=? AND user_id=? AND payment_status='UNPAID'";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, orderId);
            ps.setInt(2, membershipId);
            ps.setInt(3, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ verify order belongs to membership
    public boolean isMembershipOrderValid(int membershipId, int userId, String orderId) {

        String sql =
                "SELECT id FROM user_memberships " +
                        "WHERE id=? AND user_id=? AND razorpay_order_id=?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, membershipId);
            ps.setInt(2, userId);
            ps.setString(3, orderId);

            ResultSet rs = ps.executeQuery();
            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ mark paid + ACTIVE
    public boolean markMembershipPaid(int membershipId, int userId,
                                      String paymentId, String orderId, String signature) {

        String sql =
                "UPDATE user_memberships SET " +
                        "payment_status='PAID', payment_time=CURRENT_TIMESTAMP, " +
                        "status='ACTIVE', " +
                        "razorpay_payment_id=?, razorpay_order_id=?, razorpay_signature=? " +
                        "WHERE id=? AND user_id=? AND payment_status='UNPAID'";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, paymentId);
            ps.setString(2, orderId);
            ps.setString(3, signature);
            ps.setInt(4, membershipId);
            ps.setInt(5, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ expire old memberships for same user before activating new one
    public void expireAllActiveMemberships(int userId) {
        String sql =
                "UPDATE user_memberships SET status='EXPIRED' " +
                        "WHERE user_id=? AND status='ACTIVE'";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
