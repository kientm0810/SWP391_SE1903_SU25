package models;

import java.sql.Timestamp;

/**
 * Model cho bảng BlogType - phân loại các loại blog
 */
public class BlogType {
    private int id;
    private String typeCode;
    private String typeName;
    private String description;
    private String category;
    private String targetAudience;
    private String contentFormat;
    private boolean isActive;
    private String iconClass;
    private String colorCode;
    private String seoKeywords;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public BlogType() {
    }

    public BlogType(int id, String typeCode, String typeName, String description, 
                   String category, String targetAudience, String contentFormat, 
                   boolean isActive, String iconClass, String colorCode, String seoKeywords) {
        this.id = id;
        this.typeCode = typeCode;
        this.typeName = typeName;
        this.description = description;
        this.category = category;
        this.targetAudience = targetAudience;
        this.contentFormat = contentFormat;
        this.isActive = isActive;
        this.iconClass = iconClass;
        this.colorCode = colorCode;
        this.seoKeywords = seoKeywords;
    }

    public BlogType(int id, String typeCode, String typeName, String description, 
                   String category, String targetAudience, String contentFormat, 
                   boolean isActive, String iconClass, String colorCode, String seoKeywords,
                   Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.typeCode = typeCode;
        this.typeName = typeName;
        this.description = description;
        this.category = category;
        this.targetAudience = targetAudience;
        this.contentFormat = contentFormat;
        this.isActive = isActive;
        this.iconClass = iconClass;
        this.colorCode = colorCode;
        this.seoKeywords = seoKeywords;
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

    public String getTargetAudience() {
        return targetAudience;
    }

    public String getContentFormat() {
        return contentFormat;
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

    public String getSeoKeywords() {
        return seoKeywords;
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

    public void setTargetAudience(String targetAudience) {
        this.targetAudience = targetAudience;
    }

    public void setContentFormat(String contentFormat) {
        this.contentFormat = contentFormat;
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

    public void setSeoKeywords(String seoKeywords) {
        this.seoKeywords = seoKeywords;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "BlogType{" +
                "id=" + id +
                ", typeCode='" + typeCode + '\'' +
                ", typeName='" + typeName + '\'' +
                ", category='" + category + '\'' +
                ", targetAudience='" + targetAudience + '\'' +
                ", contentFormat='" + contentFormat + '\'' +
                ", isActive=" + isActive +
                '}';
    }
} 