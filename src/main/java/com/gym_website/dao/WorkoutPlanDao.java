package com.gym_website.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.gym_website.entities.WorkoutPlan;

public class WorkoutPlanDao {

    private Connection con;

    public WorkoutPlanDao(Connection con) {
        this.con = con;
    }

    // ================= ADD WORKOUT (BY TRAINER) =================
    public boolean addWorkoutPlan(WorkoutPlan w) {

        String sql =
                "INSERT INTO workout_plans " +
                        "(title, description, level, duration_weeks, trainer_id, goal, days_per_week, equipment, split_type, video_link, notes) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, w.getTitle());
            ps.setString(2, w.getDescription());
            ps.setString(3, w.getLevel());
            ps.setInt(4, w.getDurationWeeks());
            ps.setInt(5, w.getTrainerId());

            // ✅ NEW FIELDS
            ps.setString(6, w.getGoal());
            ps.setInt(7, w.getDaysPerWeek());
            ps.setString(8, w.getEquipment());
            ps.setString(9, w.getSplitType());
            ps.setString(10, w.getVideoLink());
            ps.setString(11, w.getNotes());

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ================= GET WORKOUTS BY TRAINER =================
    public List<WorkoutPlan> getWorkoutsByTrainer(int trainerId) {

        List<WorkoutPlan> list = new ArrayList<>();

        String sql =
                "SELECT * FROM workout_plans " +
                        "WHERE trainer_id = ? " +
                        "ORDER BY created_at DESC";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, trainerId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    WorkoutPlan w = new WorkoutPlan();
                    w.setId(rs.getInt("id"));
                    w.setTitle(rs.getString("title"));
                    w.setDescription(rs.getString("description"));
                    w.setLevel(rs.getString("level"));
                    w.setDurationWeeks(rs.getInt("duration_weeks"));
                    w.setTrainerId(rs.getInt("trainer_id"));

                    // ✅ NEW FIELDS
                    w.setGoal(rs.getString("goal"));
                    w.setDaysPerWeek(rs.getInt("days_per_week"));
                    w.setEquipment(rs.getString("equipment"));
                    w.setSplitType(rs.getString("split_type"));
                    w.setVideoLink(rs.getString("video_link"));
                    w.setNotes(rs.getString("notes"));

                    list.add(w);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
