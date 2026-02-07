package com.gym_website.dao;

import com.gym_website.entities.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {

    private final Connection connection;

    public UserDao(Connection connection) {
        this.connection = connection;
    }

    // ✅ Save User
    public boolean saveUser(User user) {

        String query = "INSERT INTO users(name, email, mobile, password, address, dob, gender) VALUES(?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement pstmt = this.connection.prepareStatement(query)) {

            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getMobile());
            pstmt.setString(4, user.getPassword());
            pstmt.setString(5, user.getAddress());
            pstmt.setString(6, user.getDob());
            pstmt.setString(7, user.getGender());

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public User getUserByEmailOrPhone(String identifier) {
        User user = null;

        try {
            String query = "SELECT * FROM users WHERE email=? OR mobile=?";
            PreparedStatement ps = this.connection.prepareStatement(query);

            ps.setString(1, identifier);
            ps.setString(2, identifier);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setMobile(rs.getString("mobile"));
                user.setPassword(rs.getString("password"));
                user.setAddress(rs.getString("address"));
                user.setDob(rs.getString("dob"));
                user.setGender(rs.getString("gender"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }


    // ✅ get user by id
    public User getUserByUserId(int userId) {

        String query = "SELECT * FROM users WHERE id=?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapUser(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // ✅ check email exists
    public boolean emailExists(String email) {

        String query = "SELECT COUNT(*) FROM users WHERE email=?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // ✅ update user
    public boolean updateUser(User user) {

        String query = "UPDATE users SET name=?, email=?, mobile=?, password=?, address=?, dob=?, gender=? WHERE id=?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getMobile());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getDob());
            ps.setString(7, user.getGender());
            ps.setInt(8, user.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ mapper (IMPORTANT FIX: throws SQLException only)
    private User mapUser(ResultSet rs) throws SQLException {

        User user = new User();

        user.setId(rs.getInt("id"));
        user.setName(rs.getString("name"));
        user.setEmail(rs.getString("email"));
        user.setMobile(rs.getString("mobile"));
        user.setPassword(rs.getString("password"));
        user.setAddress(rs.getString("address"));
        user.setDob(rs.getString("dob"));
        user.setGender(rs.getString("gender"));
        user.setRegister_date(rs.getTimestamp("created_at"));

        return user;
    }
}
