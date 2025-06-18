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
public class Banner {
    private int id;
    private int admin_id;
    private String title;
    private String image_url;
    private String redirect_url;
    private int position;
    private boolean is_active;
    private Date created_at;

    public Banner() {
    }

    public Banner(int admin_id, String title, String image_url, String redirect_url, int position, boolean is_active) {
        this.admin_id = admin_id;
        this.title = title;
        this.image_url = image_url;
        this.redirect_url = redirect_url;
        this.position = position;
        this.is_active = is_active;
    }

    public Banner(int admin_id, String title, String image_url, String redirect_url, int position, boolean is_active, Date created_at) {
        this.admin_id = admin_id;
        this.title = title;
        this.image_url = image_url;
        this.redirect_url = redirect_url;
        this.position = position;
        this.is_active = is_active;
        this.created_at = created_at;
    }

    public Banner(int id, int admin_id, String title, String image_url, String redirect_url, int position, boolean is_active, Date created_at) {
        this.id = id;
        this.admin_id = admin_id;
        this.title = title;
        this.image_url = image_url;
        this.redirect_url = redirect_url;
        this.position = position;
        this.is_active = is_active;
        this.created_at = created_at;
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

    public void setImage_url(String image_url) {
        this.image_url = image_url;
    }

    public void setRedirect_url(String redirect_url) {
        this.redirect_url = redirect_url;
    }

    public void setPosition(int position) {
        this.position = position;
    }

    public void setIs_active(boolean is_active) {
        this.is_active = is_active;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
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

    public String getImage_url() {
        return image_url;
    }

    public String getRedirect_url() {
        return redirect_url;
    }

    public int getPosition() {
        return position;
    }

    public boolean isIs_active() {
        return is_active;
    }

    public Date getCreated_at() {
        return created_at;
    }
    
    
}
