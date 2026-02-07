package com.gym_website.dao;

import com.gym_website.entities.Category;
import com.gym_website.entities.Post;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDao {

    private Connection connection;

    public PostDao(Connection connection) {
        this.connection = connection;
    }

    // Get all categories
    public ArrayList<Category> getAllCategories() {
        ArrayList<Category> list = new ArrayList<>();
        try {
            String q = "SELECT * FROM categories";
            Statement st = this.connection.createStatement();
            ResultSet set = st.executeQuery(q);

            while (set.next()) {
                int cid = set.getInt("cid");
                String name = set.getString("name");
                String description = set.getString("description");
                Category c = new Category(cid, name, description);
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Save post
    public boolean savePost(Post p) {
        boolean f = false;
        try {
            String q = "INSERT INTO posts (gym_name, gym_photo, owner_name, owner_email, owner_address, owner_photo, about_gym, catId, userId) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = connection.prepareStatement(q);

            pstmt.setString(1, p.getGym_name());
            pstmt.setString(2, p.getGym_photo());
            pstmt.setString(3, p.getOwner_name());
            pstmt.setString(4, p.getOwner_email());
            pstmt.setString(5, p.getOwner_address());
            pstmt.setString(6, p.getOwner_photo());
            pstmt.setString(7, p.getAbout_gym());
            pstmt.setInt(8, p.getCatId());
            pstmt.setInt(9, p.getUserId());

            pstmt.executeUpdate();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    // Get all posts
    public List<Post> getAllPosts() {
        List<Post> list = new ArrayList<>();
        try {
            PreparedStatement p = connection.prepareStatement("SELECT * FROM posts ORDER BY pid DESC");
            ResultSet set = p.executeQuery();

            while (set.next()) {
                int pid = set.getInt("pid");
                String gymName = set.getString("gym_name");
                String gymPhoto = set.getString("gym_photo");
                String ownerName = set.getString("owner_name");
                String ownerEmail = set.getString("owner_email");
                String ownerAddress = set.getString("owner_address");
                String ownerPhoto = set.getString("owner_photo");
                String aboutGym = set.getString("about_gym");
                Timestamp pDate = set.getTimestamp("pDate");
                int catId = set.getInt("catId");
                int userId = set.getInt("userId");

                Post post = new Post(pid, gymName, gymPhoto, ownerName, ownerEmail, ownerAddress, ownerPhoto, aboutGym, pDate, catId, userId);
                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get posts by category ID
    public List<Post> getPostByCatId(int catId) {
        List<Post> list = new ArrayList<>();
        try {
            PreparedStatement p = connection.prepareStatement("SELECT * FROM posts WHERE catId=?");
            p.setInt(1, catId);
            ResultSet set = p.executeQuery();

            while (set.next()) {
                int pid = set.getInt("pid");
                String gymName = set.getString("gym_name");
                String gymPhoto = set.getString("gym_photo");
                String ownerName = set.getString("owner_name");
                String ownerEmail = set.getString("owner_email");
                String ownerAddress = set.getString("owner_address");
                String ownerPhoto = set.getString("owner_photo");
                String aboutGym = set.getString("about_gym");
                Timestamp pDate = set.getTimestamp("pDate");
                int userId = set.getInt("userId");

                Post post = new Post(pid, gymName, gymPhoto, ownerName, ownerEmail, ownerAddress, ownerPhoto, aboutGym, pDate, catId, userId);
                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get post by post ID
    public Post getPostByPostId(int postId) {
        Post post = null;
        try {
            PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM posts WHERE pid=?");
            pstmt.setInt(1, postId);
            ResultSet set = pstmt.executeQuery();

            if (set.next()) {
                int pid = set.getInt("pid");
                String gymName = set.getString("gym_name");
                String gymPhoto = set.getString("gym_photo");
                String ownerName = set.getString("owner_name");
                String ownerEmail = set.getString("owner_email");
                String ownerAddress = set.getString("owner_address");
                String ownerPhoto = set.getString("owner_photo");
                String aboutGym = set.getString("about_gym");
                Timestamp pDate = set.getTimestamp("pDate");
                int catId = set.getInt("catId");
                int userId = set.getInt("userId");

                post = new Post(pid, gymName, gymPhoto, ownerName, ownerEmail, ownerAddress, ownerPhoto, aboutGym, pDate, catId, userId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return post;
    }
}
