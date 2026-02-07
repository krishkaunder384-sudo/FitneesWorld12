package com.gym_website.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.gym_website.entities.DietPlan;

public class DietPlanDao {

    private Connection con;

    public DietPlanDao(Connection con) {
        this.con = con;
    }

    // ================= ADD DIET PLAN (BY TRAINER) =================
    public boolean addDietPlan(DietPlan d) {

        String sql =
                "INSERT INTO diet_plans " +
                        "(title, description, goal, calories, trainer_id, diet_type, meals_per_day, protein_g, carbs_g, fats_g, water_liters, foods_to_avoid) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, d.getTitle());
            ps.setString(2, d.getDescription());
            ps.setString(3, d.getGoal());
            ps.setInt(4, d.getCalories());
            ps.setInt(5, d.getTrainerId());

            // ✅ NEW FIELDS
            ps.setString(6, d.getDietType());
            ps.setInt(7, d.getMealsPerDay());
            ps.setInt(8, d.getProteinG());
            ps.setInt(9, d.getCarbsG());
            ps.setInt(10, d.getFatsG());
            ps.setDouble(11, d.getWaterLiters());
            ps.setString(12, d.getFoodsToAvoid());

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ================= GET DIETS BY TRAINER =================
    public List<DietPlan> getDietsByTrainer(int trainerId) {

        List<DietPlan> list = new ArrayList<>();

        String sql =
                "SELECT * FROM diet_plans " +
                        "WHERE trainer_id=? " +
                        "ORDER BY created_at DESC";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, trainerId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    DietPlan d = new DietPlan();
                    d.setId(rs.getInt("id"));
                    d.setTitle(rs.getString("title"));
                    d.setDescription(rs.getString("description"));
                    d.setGoal(rs.getString("goal"));
                    d.setCalories(rs.getInt("calories"));
                    d.setTrainerId(rs.getInt("trainer_id"));

                    // ✅ NEW FIELDS
                    d.setDietType(rs.getString("diet_type"));
                    d.setMealsPerDay(rs.getInt("meals_per_day"));
                    d.setProteinG(rs.getInt("protein_g"));
                    d.setCarbsG(rs.getInt("carbs_g"));
                    d.setFatsG(rs.getInt("fats_g"));
                    d.setWaterLiters(rs.getDouble("water_liters"));
                    d.setFoodsToAvoid(rs.getString("foods_to_avoid"));

                    list.add(d);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
