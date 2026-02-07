package com.gym_website.dao;

import com.gym_website.entities.Trainer;
import com.gym_website.entities.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TrainerDao {

    private Connection con;

    public TrainerDao(Connection con) {
        this.con = con;
    }

    // ================= TRAINER LOGIN =================
    public Trainer login(String email, String password) {

        String sql = "SELECT * FROM trainers WHERE email=? AND password=?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Trainer t = new Trainer();
                t.setId(rs.getInt("id"));
                t.setName(rs.getString("name"));
                t.setSpecialization(rs.getString("specialization"));
                t.setExperience(rs.getString("experience"));
                t.setImage(rs.getString("image"));
                t.setDescription(rs.getString("description"));
                return t;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ================= ADD TRAINER =================
    public boolean addTrainer(Trainer t) {

        String sql =
                "INSERT INTO trainers (name, specialization, experience, image, description) " +
                        "VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, t.getName());
            ps.setString(2, t.getSpecialization());
            ps.setString(3, t.getExperience());
            ps.setString(4, t.getImage());
            ps.setString(5, t.getDescription());

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ================= GET ALL TRAINERS =================
    public List<Trainer> getAllTrainers() {

        List<Trainer> list = new ArrayList<>();
        String sql = "SELECT * FROM trainers ORDER BY id DESC";

        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Trainer t = new Trainer();
                t.setId(rs.getInt("id"));
                t.setName(rs.getString("name"));
                t.setSpecialization(rs.getString("specialization"));
                t.setExperience(rs.getString("experience"));
                t.setImage(rs.getString("image"));
                t.setDescription(rs.getString("description"));
                list.add(t);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ================= GET TRAINER BY ID =================
    public Trainer getTrainerById(int id) {

        String sql = "SELECT * FROM trainers WHERE id=?";
        Trainer t = null;

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                t = new Trainer();
                t.setId(rs.getInt("id"));
                t.setName(rs.getString("name"));
                t.setSpecialization(rs.getString("specialization"));
                t.setExperience(rs.getString("experience"));
                t.setImage(rs.getString("image"));
                t.setDescription(rs.getString("description"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return t;
    }

    // ================= UPDATE TRAINER =================
    public boolean updateTrainer(Trainer t) {

        String sql =
                "UPDATE trainers SET name=?, specialization=?, experience=?, image=?, description=? " +
                        "WHERE id=?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, t.getName());
            ps.setString(2, t.getSpecialization());
            ps.setString(3, t.getExperience());
            ps.setString(4, t.getImage());
            ps.setString(5, t.getDescription());
            ps.setInt(6, t.getId());

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ================= DELETE TRAINER =================
    public boolean deleteTrainer(int id) {

        String sql = "DELETE FROM trainers WHERE id=?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ================= USERS ASSIGNED TO TRAINER =================
    public List<User> getUsersAssignedToTrainer(int trainerId) {

        List<User> list = new ArrayList<>();

        String sql =
                "SELECT DISTINCT u.id, u.name, u.email " +
                        "FROM users u " +
                        "JOIN user_workout_plans uwp ON uwp.user_id = u.id " +
                        "WHERE uwp.trainer_id = ?";

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
}
