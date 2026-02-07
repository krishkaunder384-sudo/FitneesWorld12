package com.gym_website.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TrainerPlanDao {

    private Connection con;

    public TrainerPlanDao(Connection con) {
        this.con = con;
    }

    // ===============================
    // Fetch all workout plans (Trainer Dashboard)
    // ===============================
    public List<Map<String, String>> getAllWorkouts() {

        List<Map<String, String>> list = new ArrayList<>();

        String sql =
                "SELECT id, title, level, duration_weeks " +
                        "FROM workout_plans " +
                        "ORDER BY created_at DESC";

        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, String> map = new HashMap<>();
                map.put("id", rs.getString("id"));
                map.put("title", rs.getString("title"));
                map.put("level", rs.getString("level"));
                map.put("duration", rs.getString("duration_weeks"));
                list.add(map);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ===============================
    // Assign workout to user (Trainer)
    // ===============================
    public boolean assignWorkout(int trainerId, int userId, int workoutId) {

        String sql =
                "INSERT INTO user_workout_plans " +
                        "(trainer_id, user_id, workout_id, assigned_at) " +
                        "VALUES (?, ?, ?, CURRENT_TIMESTAMP)";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, trainerId);
            ps.setInt(2, userId);
            ps.setInt(3, workoutId);

            return ps.executeUpdate() > 0;

        } catch (SQLIntegrityConstraintViolationException e) {
            System.out.println("Workout already assigned to this user.");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
