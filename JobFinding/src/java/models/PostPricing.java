// PostPricing.java
package models;

import java.sql.Timestamp;

public class PostPricing {

    private int id;
    private String positionName;
    private String positionCode;
    private double price;
    private int durationDays;
    private String description;
    private boolean isActive;
    private Timestamp createdAt;

    // Constructors
    public PostPricing() {
    }

    public PostPricing(String positionName, String positionCode, double price, int durationDays, String description, boolean isActive, Timestamp createdAt) {
        this.positionName = positionName;
        this.positionCode = positionCode;
        this.price = price;
        this.durationDays = durationDays;
        this.description = description;
        this.isActive = isActive;
        this.createdAt = createdAt;
    }

    public PostPricing(int id, String positionName, String positionCode, double price, int durationDays, String description, boolean isActive, Timestamp createdAt) {
        this.id = id;
        this.positionName = positionName;
        this.positionCode = positionCode;
        this.price = price;
        this.durationDays = durationDays;
        this.description = description;
        this.isActive = isActive;
        this.createdAt = createdAt;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public boolean isIsActive() {
        return isActive;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPositionName() {
        return positionName;
    }

    public void setPositionName(String positionName) {
        this.positionName = positionName;
    }

    public String getPositionCode() {
        return positionCode;
    }

    public void setPositionCode(String positionCode) {
        this.positionCode = positionCode;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getDurationDays() {
        return durationDays;
    }

    public void setDurationDays(int durationDays) {
        this.durationDays = durationDays;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
