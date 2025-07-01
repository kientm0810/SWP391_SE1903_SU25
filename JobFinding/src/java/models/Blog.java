/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;
import java.sql.Date;

/**
 *
 * @author andin
 */
public class Blog {
    private int id;
    private int admin_id;
    private String title;
    private String description;
    private String thumbnail;
    private String status;
    private Date created_at;
    private Date updated_at;

    public Blog() {
    }

    public Blog(int id, int admin_id, String title, String description, String thumbnail, String status) {
        this.id = id;
        this.admin_id = admin_id;
        this.title = title;
        this.description = description;
        this.thumbnail = thumbnail;
        this.status = status;
    }
    
    public Blog(int id, int admin_id, String title, String description, String thumbnail, String status, Date created_at, Date updated_at) {
        this.id = id;
        this.admin_id = admin_id;
        this.title = title;
        this.description = description;
        this.thumbnail = thumbnail;
        this.status = status;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public Blog(int admin_id, String title, String description, String thumbnail, String status, Date created_at, Date updated_at) {
        this.admin_id = admin_id;
        this.title = title;
        this.description = description;
        this.thumbnail = thumbnail;
        this.status = status;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public Blog(int admin_id, String title, String description, String thumbnail, String status) {
        this.admin_id = admin_id;
        this.title = title;
        this.description = description;
        this.thumbnail = thumbnail;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public int getAdmin_id() {
        return admin_id;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public String getStatus() {
        return status;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public Date getUpdated_at() {
        return updated_at;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setAdmin_id(int admin_id) {
        this.admin_id = admin_id;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

    public void setUpdated_at(Date updated_at) {
        this.updated_at = updated_at;
    }
}
