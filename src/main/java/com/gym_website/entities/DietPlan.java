package com.gym_website.entities;

public class DietPlan {

    private int id;
    private String title;
    private String description;
    private String goal;
    private int calories;


    private String dietType;
    private int mealsPerDay;
    private int proteinG;
    private int carbsG;
    private int fatsG;
    private double waterLiters;
    private String foodsToAvoid;

    // trainer id
    private int trainerId;

    public DietPlan() {}

    // ===== Getters & Setters =====
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getGoal() { return goal; }
    public void setGoal(String goal) { this.goal = goal; }

    public int getCalories() { return calories; }
    public void setCalories(int calories) { this.calories = calories; }

    public String getDietType() { return dietType; }
    public void setDietType(String dietType) { this.dietType = dietType; }

    public int getMealsPerDay() { return mealsPerDay; }
    public void setMealsPerDay(int mealsPerDay) { this.mealsPerDay = mealsPerDay; }

    public int getProteinG() { return proteinG; }
    public void setProteinG(int proteinG) { this.proteinG = proteinG; }

    public int getCarbsG() { return carbsG; }
    public void setCarbsG(int carbsG) { this.carbsG = carbsG; }

    public int getFatsG() { return fatsG; }
    public void setFatsG(int fatsG) { this.fatsG = fatsG; }

    public double getWaterLiters() { return waterLiters; }
    public void setWaterLiters(double waterLiters) { this.waterLiters = waterLiters; }

    public String getFoodsToAvoid() { return foodsToAvoid; }
    public void setFoodsToAvoid(String foodsToAvoid) { this.foodsToAvoid = foodsToAvoid; }

    public int getTrainerId() { return trainerId; }
    public void setTrainerId(int trainerId) { this.trainerId = trainerId; }
}
