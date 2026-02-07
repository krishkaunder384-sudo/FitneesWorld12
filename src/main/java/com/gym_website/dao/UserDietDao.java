package com.gym_website.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

public class UserDietDao {

    private Connection con;

    public UserDietDao(Connection con) {
        this.con = con;
    }

    // ✅ Assign Diet to User
    public boolean assignDiet(int userId, int dietId, int trainerId) {

        try {
            // prevent duplicate
            String checkSql =
                    "SELECT id FROM user_diet_plans WHERE user_id=? AND diet_id=?";

            try (PreparedStatement check = con.prepareStatement(checkSql)) {
                check.setInt(1, userId);
                check.setInt(2, dietId);

                ResultSet rs = check.executeQuery();
                if (rs.next()) return false;
            }

            // insert
            String insertSql =
                    "INSERT INTO user_diet_plans(user_id, diet_id, trainer_id) VALUES(?,?,?)";

            try (PreparedStatement ps = con.prepareStatement(insertSql)) {
                ps.setInt(1, userId);
                ps.setInt(2, dietId);
                ps.setInt(3, trainerId);

                return ps.executeUpdate() == 1;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ✅ Get User Diet History (FULL DATA)
    public List<Map<String, String>> getUserDiets(int userId) {

        List<Map<String, String>> list = new ArrayList<>();

        String sql =
                "SELECT " +
                        "dp.title, dp.goal, dp.calories, " +
                        "dp.diet_type, dp.meals_per_day, dp.protein_g, dp.carbs_g, dp.fats_g, dp.water_liters, dp.foods_to_avoid, " +
                        "udp.assigned_date, t.name AS trainerName " +
                        "FROM user_diet_plans udp " +
                        "JOIN diet_plans dp ON udp.diet_id = dp.id " +
                        "JOIN trainers t ON udp.trainer_id = t.id " +
                        "WHERE udp.user_id=? " +
                        "ORDER BY udp.assigned_date DESC";


        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, String> map = new HashMap<>();

                map.put("title", rs.getString("title"));
                map.put("goal", rs.getString("goal"));
                map.put("calories", rs.getString("calories"));

                // ✅ NEW FIELDS
                map.put("diet_type", rs.getString("diet_type"));
                map.put("meals_per_day", rs.getString("meals_per_day"));
                map.put("protein_g", rs.getString("protein_g"));
                map.put("carbs_g", rs.getString("carbs_g"));
                map.put("fats_g", rs.getString("fats_g"));
                map.put("water_liters", rs.getString("water_liters"));
                map.put("foods_to_avoid", rs.getString("foods_to_avoid"));

                map.put("trainerName", rs.getString("trainerName"));
                map.put("assigned_at", rs.getString("assigned_date"));



                list.add(map);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
