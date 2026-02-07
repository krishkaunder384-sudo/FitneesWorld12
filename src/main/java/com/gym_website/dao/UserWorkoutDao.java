package com.gym_website.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

public class UserWorkoutDao {

    private Connection con;

    public UserWorkoutDao(Connection con) {
        this.con = con;
    }

    // ✅ Assign workout to user
    public boolean assignWorkoutToUser(int userId, int workoutId, int trainerId) {

        try {
            // prevent duplicate
            String checkSql =
                    "SELECT id FROM user_workout_assignments WHERE user_id=? AND workout_id=?";

            try (PreparedStatement check = con.prepareStatement(checkSql)) {
                check.setInt(1, userId);
                check.setInt(2, workoutId);

                ResultSet rs = check.executeQuery();
                if (rs.next()) return false;
            }

            // insert
            String insertSql =
                    "INSERT INTO user_workout_assignments(user_id, workout_id, trainer_id) VALUES(?,?,?)";

            try (PreparedStatement ps = con.prepareStatement(insertSql)) {
                ps.setInt(1, userId);
                ps.setInt(2, workoutId);
                ps.setInt(3, trainerId);
                return ps.executeUpdate() == 1;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ✅ Workout History for a User (FULL DATA)
    public List<Map<String, String>> getUserWorkouts(int userId) {

        List<Map<String, String>> list = new ArrayList<>();

        String sql =
                "SELECT " +
                        "wp.title, wp.level, wp.duration_weeks, " +
                        "wp.goal, wp.days_per_week, wp.equipment, wp.split_type, wp.video_link, wp.notes, " +
                        "uwa.assigned_at, t.name AS trainerName " +
                        "FROM user_workout_assignments uwa " +
                        "JOIN workout_plans wp ON uwa.workout_id = wp.id " +
                        "JOIN trainers t ON uwa.trainer_id = t.id " +
                        "WHERE uwa.user_id=? " +
                        "ORDER BY uwa.assigned_at DESC";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, String> map = new HashMap<>();

                map.put("title", rs.getString("title"));
                map.put("level", rs.getString("level"));
                map.put("duration_weeks", rs.getString("duration_weeks"));

                // ✅ NEW FIELDS
                map.put("goal", rs.getString("goal"));
                map.put("days_per_week", rs.getString("days_per_week"));
                map.put("equipment", rs.getString("equipment"));
                map.put("split_type", rs.getString("split_type"));
                map.put("video_link", rs.getString("video_link"));
                map.put("notes", rs.getString("notes"));

                map.put("trainerName", rs.getString("trainerName"));
                map.put("assigned_at", rs.getString("assigned_at"));

                list.add(map);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
