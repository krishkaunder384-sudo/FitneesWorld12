package com.gym_website.entities;

import java.sql.Timestamp;

public class Post {

    private int pid;
    private String gym_name;
    private String gym_photo;
    private String owner_name;
    private String owner_email;
    private String owner_address;
    private String owner_photo;
    private String about_gym;
    private Timestamp pDate;
    private int catId;
    private int userId;

    // Constructor
    public Post(int pid, String gym_name, String gym_photo, String owner_name, String owner_email, String owner_address, String owner_photo, String about_gym, Timestamp pDate, int catId, int userId) {
        this.pid = pid;
        this.gym_name = gym_name;
        this.gym_photo = gym_photo;
        this.owner_name = owner_name;
        this.owner_email = owner_email;
        this.owner_address = owner_address;
        this.owner_photo = owner_photo;
        this.about_gym = about_gym;
        this.pDate = pDate;
        this.catId = catId;
        this.userId = userId;
    }

    // Getters and Setters
    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public String getGym_name() {
        return gym_name;
    }

    public void setGym_name(String gym_name) {
        this.gym_name = gym_name;
    }

    public String getGym_photo() {
        return gym_photo;
    }

    public void setGym_photo(String gym_photo) {
        this.gym_photo = gym_photo;
    }

    public String getOwner_name() {
        return owner_name;
    }

    public void setOwner_name(String owner_name) {
        this.owner_name = owner_name;
    }

    public String getOwner_email() {
        return owner_email;
    }

    public void setOwner_email(String owner_email) {
        this.owner_email = owner_email;
    }

    public String getOwner_address() {
        return owner_address;
    }

    public void setOwner_address(String owner_address) {
        this.owner_address = owner_address;
    }

    public String getOwner_photo() {
        return owner_photo;
    }

    public void setOwner_photo(String owner_photo) {
        this.owner_photo = owner_photo;
    }

    public String getAbout_gym() {
        return about_gym;
    }

    public void setAbout_gym(String about_gym) {
        this.about_gym = about_gym;
    }

    public Timestamp getpDate() {
        return pDate;
    }

    public void setpDate(Timestamp pDate) {
        this.pDate = pDate;
    }

    public int getCatId() {
        return catId;
    }

    public void setCatId(int catId) {
        this.catId = catId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}
