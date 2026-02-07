package com.gym_website.dao;

import java.sql.*;
import java.util.*;
import com.gym_website.entities.Membership;

public class MembershipDao {

    private Connection con;

    public MembershipDao(Connection con) {
        this.con = con;
    }

    public void expireOldMemberships() {

        String sql = "UPDATE user_memberships " +
                "SET status = 'EXPIRED' " +
                "WHERE end_date < CURDATE() " +
                "AND status = 'ACTIVE'";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public List<Membership> getAllActivePlans() {

        List<Membership> list = new ArrayList<>();

        String sql = "SELECT * FROM membership_plans WHERE is_active = TRUE";

        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new Membership(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getInt("duration_days"),
                        rs.getDouble("price"),
                        rs.getString("description")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public Membership getPlanById(int planId) {

        String sql = "SELECT * FROM membership_plans WHERE id=? AND is_active=TRUE";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, planId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Membership(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getInt("duration_days"),
                        rs.getDouble("price"),
                        rs.getString("description")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

}
