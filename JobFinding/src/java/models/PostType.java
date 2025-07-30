package models;

import java.sql.Timestamp;

/**
 * Model cho bảng PostType - phân loại các loại bài đăng
 */
public class PostType {
    private int id;
    private String typeCode;
    private String typeName;
    private String description;
    private String category;
    private int priorityLevel;
    private boolean isActive;
    private String iconClass;
    private String colorCode;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public PostType() {
    }

    public PostType(int id, String typeCode, String typeName, String description, 
                   String category, int priorityLevel, boolean isActive, 
                   String iconClass, String colorCode) {
        this.id = id;
        this.typeCode = typeCode;
        this.typeName = typeName;
        this.description = description;
        this.category = category;
        this.priorityLevel = priorityLevel;
        this.isActive = isActive;
        this.iconClass = iconClass;
        this.colorCode = colorCode;
    }

    public PostType(int id, String typeCode, String typeName, String description, 
                   String category, int priorityLevel, boolean isActive, 
                   String iconClass, String colorCode, Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.typeCode = typeCode;
        this.typeName = typeName;
        this.description = description;
        this.category = category;
        this.priorityLevel = priorityLevel;
        this.isActive = isActive;
        this.iconClass = iconClass;
        this.colorCode = colorCode;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters
    public int getId() {
        return id;
    }

    public String getTypeCode() {
        return typeCode;
    }

    public String getTypeName() {
        return typeName;
    }

    public String getDescription() {
        return description;
    }

    public String getCategory() {
        return category;
    }

    public int getPriorityLevel() {
        return priorityLevel;
    }

    public boolean isActive() {
        return isActive;
    }

    public String getIconClass() {
        return iconClass;
    }

    public String getColorCode() {
        return colorCode;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public void setPriorityLevel(int priorityLevel) {
        this.priorityLevel = priorityLevel;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public void setIconClass(String iconClass) {
        this.iconClass = iconClass;
    }

    public void setColorCode(String colorCode) {
        this.colorCode = colorCode;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "PostType{" +
                "id=" + id +
                ", typeCode='" + typeCode + '\'' +
                ", typeName='" + typeName + '\'' +
                ", category='" + category + '\'' +
                ", priorityLevel=" + priorityLevel +
                ", isActive=" + isActive +
                '}';
    }
} 