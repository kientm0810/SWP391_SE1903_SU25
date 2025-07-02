/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Timestamp;

/**
 *
 * @author andin
 */
public class PromotionProgram {
    private int id;
    private String name;
    private double cost;
    private int durationDays;
    private String description;
    private boolean isActive;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private int adminId;
    private String positionType;
    private int quantity;

    public PromotionProgram() {
    }

    public PromotionProgram(int id, String name, double cost, int durationDays, String description, 
                           boolean isActive, Timestamp createdAt, Timestamp updatedAt, 
                           int adminId, String positionType, int quantity) {
        this.id = id;
        this.name = name;
        this.cost = cost;
        this.durationDays = durationDays;
        this.description = description;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.adminId = adminId;
        this.positionType = positionType;
        this.quantity = quantity;
    }

    public PromotionProgram(String name, double cost, int durationDays, String description, 
                           boolean isActive, int adminId, String positionType, int quantity) {
        this.name = name;
        this.cost = cost;
        this.durationDays = durationDays;
        this.description = description;
        this.isActive = isActive;
        this.adminId = adminId;
        this.positionType = positionType;
        this.quantity = quantity;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getCost() {
        return cost;
    }

    public void setCost(double cost) {
        this.cost = cost;
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

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public int getAdminId() {
        return adminId;
    }

    public void setAdminId(int adminId) {
        this.adminId = adminId;
    }

    public String getPositionType() {
        return positionType;
    }

    public void setPositionType(String positionType) {
        this.positionType = positionType;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    // Helper methods
    public String getFormattedCost() {
        return String.format("%,.0f VNĐ", cost);
    }
    
    public String getPositionTypeDisplay() {
        switch (positionType.toLowerCase()) {
            case "normal":
                return "Thường";
            case "featured":
                return "Nổi bật";
            case "premium":
                return "Premium";
            default:
                return positionType;
        }
    }
    
    public String getBadgeClass() {
        switch (positionType.toLowerCase()) {
            case "normal":
                return "badge-secondary";
            case "featured":
                return "badge-warning";
            case "premium":
                return "badge-success";
            default:
                return "badge-primary";
        }
    }
}