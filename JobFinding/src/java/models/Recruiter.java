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
public class Recruiter {
    private int id;
    private String username, password, email, full_name, phone;
    private Date date_of_birth;
    private String gender, address, profile_picture, company_name,
            company_description, logo, website, company_address,
            company_size, industry, tax_code;
    private double loyalty_score;
    private String verification_status;
    private Date created_at;
    private Date updated_at;
    private boolean is_active;

    public Recruiter(int id, String username, String password, String email, String full_name, String phone, Date date_of_birth, String gender, String address, String profile_picture, String company_name, String company_description, String logo, String website, String company_address, String company_size, String industry, String tax_code, double loyalty_score, String verification_status, Date created_at, Date updated_at, boolean is_active) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.full_name = full_name;
        this.phone = phone;
        this.date_of_birth = date_of_birth;
        this.gender = gender;
        this.address = address;
        this.profile_picture = profile_picture;
        this.company_name = company_name;
        this.company_description = company_description;
        this.logo = logo;
        this.website = website;
        this.company_address = company_address;
        this.company_size = company_size;
        this.industry = industry;
        this.tax_code = tax_code;
        this.loyalty_score = loyalty_score;
        this.verification_status = verification_status;
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

    public void setDate_of_birth(Date date_of_birth) {
        this.date_of_birth = date_of_birth;
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

    public void setCompany_name(String company_name) {
        this.company_name = company_name;
    }

    public void setCompany_description(String company_description) {
        this.company_description = company_description;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public void setCompany_address(String company_address) {
        this.company_address = company_address;
    }

    public void setCompany_size(String company_size) {
        this.company_size = company_size;
    }

    public void setIndustry(String industry) {
        this.industry = industry;
    }

    public void setTax_code(String tax_code) {
        this.tax_code = tax_code;
    }

    public void setLoyalty_score(double loyalty_score) {
        this.loyalty_score = loyalty_score;
    }

    public void setVerification_status(String verification_status) {
        this.verification_status = verification_status;
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

    public Date getDate_of_birth() {
        return date_of_birth;
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

    public String getCompany_name() {
        return company_name;
    }

    public String getCompany_description() {
        return company_description;
    }

    public String getLogo() {
        return logo;
    }

    public String getWebsite() {
        return website;
    }

    public String getCompany_address() {
        return company_address;
    }

    public String getCompany_size() {
        return company_size;
    }

    public String getIndustry() {
        return industry;
    }

    public String getTax_code() {
        return tax_code;
    }

    public double getLoyalty_score() {
        return loyalty_score;
    }

    public String getVerification_status() {
        return verification_status;
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
