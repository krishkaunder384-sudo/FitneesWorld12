package com.gym_website.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.gym_website.entities.Gym;

public class GymDao {

    private Connection con;

    public GymDao(Connection con) {
        this.con = con;
    }

    // ===============================
    // Get gym details by ID
    // ===============================
    public Gym getGymById(int id) {

        Gym gym = null;

        String sql =
                "SELECT gymName, contactEmail, contactPhone, " +
                        "address, socialMediaLinks, businessHours " +
                        "FROM gyms " +
                        "WHERE id = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                gym = new Gym();
                gym.setGymName(rs.getString("gymName"));
                gym.setContactEmail(rs.getString("contactEmail"));
                gym.setContactPhone(rs.getString("contactPhone"));
                gym.setAddress(rs.getString("address"));
                gym.setSocialMediaLinks(rs.getString("socialMediaLinks"));
                gym.setBusinessHours(rs.getString("businessHours"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return gym;
    }
}
