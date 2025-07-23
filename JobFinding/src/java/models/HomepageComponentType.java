// HomepageComponentType.java
package models;

import java.util.Date;

public class HomepageComponentType {
    private int id;
    private String typeName;
    private String description;
    private Date createdAt;
    private Date updatedAt;

    // Constructors
    public HomepageComponentType() {}

    public HomepageComponentType(String typeName, String description) {
        this.typeName = typeName;
        this.description = description;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTypeName() { return typeName; }
    public void setTypeName(String typeName) { this.typeName = typeName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
}