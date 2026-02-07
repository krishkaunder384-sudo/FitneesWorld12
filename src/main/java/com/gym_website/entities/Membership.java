package com.gym_website.entities;

public class Membership {

    private int id;
    private String name;
    private int durationDays;
    private double price;
    private String description;

    public Membership(int id, String name, int durationDays, double price, String description) {
        this.id = id;
        this.name = name;
        this.durationDays = durationDays;
        this.price = price;
        this.description = description;
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public int getDurationDays() { return durationDays; }
    public double getPrice() { return price; }
    public String getDescription() { return description; }
}
