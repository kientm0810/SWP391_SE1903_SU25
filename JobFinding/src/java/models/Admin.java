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
public class Admin {
    private int id;
    private String username, password, email, full_name, phone;
    private Date te_of_birth;
    private String gender, address, profile_picture;
    private Date created_at, updated_at;
    private boolean is_active;

    public Admin(int id, String username, String password, String email, String full_name, String phone, Date te_of_birth, String gender, String address, String profile_picture, Date created_at, Date updated_at, boolean is_active) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.full_name = full_name;
        this.phone = phone;
        this.te_of_birth = te_of_birth;
        this.gender = gender;
        this.address = address;
        this.profile_picture = profile_picture;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.is_active = is_active;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setFull_name(String full_name) {
        this.full_name = full_name;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setTe_of_birth(Date te_of_birth) {
        this.te_of_birth = te_of_birth;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setProfile_picture(String profile_picture) {
        this.profile_picture = profile_picture;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

    public void setUpdated_at(Date updated_at) {
        this.updated_at = updated_at;
    }

    public void setIs_active(boolean is_active) {
        this.is_active = is_active;
    }

    public int getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getEmail() {
        return email;
    }

    public String getFull_name() {
        return full_name;
    }

    public String getPhone() {
        return phone;
    }

    public Date getTe_of_birth() {
        return te_of_birth;
    }

    public String getGender() {
        return gender;
    }

    public String getAddress() {
        return address;
    }

    public String getProfile_picture() {
        return profile_picture;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public Date getUpdated_at() {
        return updated_at;
    }

    public boolean isIs_active() {
        return is_active;
    }
    
    
}
