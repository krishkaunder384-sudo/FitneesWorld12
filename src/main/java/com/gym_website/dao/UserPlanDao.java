package com.gym_website.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

public class UserPlanDao {

    private Connection con;

    public UserPlanDao(Connection con) {
        this.con = con;
    }

    // ===============================
    // Get latest assigned workout for user
    // ===============================
    public Map<String, String> getUserWorkout(int userId) {

        Map<String, String> workout = null;

        String sql =
                "SELECT wp.title, wp.description, wp.level, wp.duration_weeks, uwp.assigned_at " +
                        "FROM user_workout_plans uwp " +
                        "JOIN workout_plans wp ON uwp.workout_id = wp.id " +
                        "WHERE uwp.user_id = ? " +
                        "ORDER BY uwp.assigned_at DESC " +
                        "LIMIT 1";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                workout = new HashMap<>();
                workout.put("title", rs.getString("title"));
                workout.put("description", rs.getString("description"));
                workout.put("level", rs.getString("level"));
                workout.put("duration", rs.getString("duration_weeks"));
                workout.put("assignedAt", rs.getString("assigned_at"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return workout;
    }
}
