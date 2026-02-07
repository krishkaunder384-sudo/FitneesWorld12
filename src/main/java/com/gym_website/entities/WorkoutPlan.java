package com.gym_website.entities;

public class WorkoutPlan {

    private int id;
    private String title;
    private String description;
    private String level;
    private int durationWeeks;
    private int trainerId;
    private String trainerName; // for admin display

    // ✅ NEW FIELDS
    private String goal;
    private int daysPerWeek;
    private String equipment;
    private String splitType;
    private String videoLink;
    private String notes;

    // ===== Getters & Setters =====

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getLevel() { return level; }
    public void setLevel(String level) { this.level = level; }

    public int getDurationWeeks() { return durationWeeks; }
    public void setDurationWeeks(int durationWeeks) { this.durationWeeks = durationWeeks; }

    public int getTrainerId() { return trainerId; }
    public void setTrainerId(int trainerId) { this.trainerId = trainerId; }

    public String getTrainerName() { return trainerName; }
    public void setTrainerName(String trainerName) { this.trainerName = trainerName; }

    // ✅ NEW GETTERS/SETTERS

    public String getGoal() { return goal; }
    public void setGoal(String goal) { this.goal = goal; }

    public int getDaysPerWeek() { return daysPerWeek; }
    public void setDaysPerWeek(int daysPerWeek) { this.daysPerWeek = daysPerWeek; }

    public String getEquipment() { return equipment; }
    public void setEquipment(String equipment) { this.equipment = equipment; }

    public String getSplitType() { return splitType; }
    public void setSplitType(String splitType) { this.splitType = splitType; }

    public String getVideoLink() { return videoLink; }
    public void setVideoLink(String videoLink) { this.videoLink = videoLink; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
}
