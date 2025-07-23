// HomepageComponentContent.java
package models;

import java.util.Date;

public class HomepageComponentContent { 
    private int id;
    private int typeId;
    private int position;
    private String name;
    private String title;
    private String content;
    private String iconClass;
    private String status;
    private Date createdAt;
    private Date updatedAt;
    private String typeName; // From JOIN with type table

    // Constructors
    public HomepageComponentContent() {}

    public HomepageComponentContent(int typeId, int position, String name, String title, String content) {
        this.typeId = typeId;
        this.position = position;
        this.name = name;
        this.title = title;
        this.content = content;
        this.status = "active";
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getTypeId() { return typeId; }
    public void setTypeId(int typeId) { this.typeId = typeId; }

    public int getPosition() { return position; }
    public void setPosition(int position) { this.position = position; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getIconClass() { return iconClass; }
    public void setIconClass(String iconClass) { this.iconClass = iconClass; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }

    public String getTypeName() { return typeName; }
    public void setTypeName(String typeName) { this.typeName = typeName; }
}