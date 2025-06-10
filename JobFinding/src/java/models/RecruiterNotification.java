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
public class RecruiterNotification {
    private int id;
    private int recruiter_id;
    private String type;
    private String title;
    private String content;
    private boolean is_read;
    private Date created_at;

    public RecruiterNotification() {
    }

    public RecruiterNotification(int recruiter_id, String type, String title, String content, boolean is_read) {
        this.recruiter_id = recruiter_id;
        this.type = type;
        this.title = title;
        this.content = content;
        this.is_read = is_read;
    }

    public RecruiterNotification(int id, int recruiter_id, String type, String title, String content, boolean is_read, Date created_at) {
        this.id = id;
        this.recruiter_id = recruiter_id;
        this.type = type;
        this.title = title;
        this.content = content;
        this.is_read = is_read;
        this.created_at = created_at;
    }

    public RecruiterNotification(int recruiter_id, String type, String title, String content, boolean is_read, Date created_at) {
        this.recruiter_id = recruiter_id;
        this.type = type;
        this.title = title;
        this.content = content;
        this.is_read = is_read;
        this.created_at = created_at;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setRecruiter_id(int recruiter_id) {
        this.recruiter_id = recruiter_id;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setIs_read(boolean is_read) {
        this.is_read = is_read;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

    public int getId() {
        return id;
    }

    public int getRecruiter_id() {
        return recruiter_id;
    }

    public String getType() {
        return type;
    }

    public String getTitle() {
        return title;
    }

    public String getContent() {
        return content;
    }

    public boolean isIs_read() {
        return is_read;
    }

    public Date getCreated_at() {
        return created_at;
    }
    
    
}
