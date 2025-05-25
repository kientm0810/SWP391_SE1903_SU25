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
public class JobSeeker {
    private int id;
    private String username, password, email, full_name, phone;
    private Date date_of_birth;
    private String gender, address, profile_picture, cv_file, skills;
    private int experience_years;
    private String education, desired_job_title;
    private double desired_salary;
    private String job_category, preferred_location, career_level, work_type,
            profile_summary, portfolio_url, languages;
    private Date created_at;
    private Date updated_at;
    private boolean is_active;

    public JobSeeker() {
    }

    public JobSeeker(int id, String username, String password, String email, String full_name, String phone, Date date_of_birth, String gender, String address, String profile_picture, String cv_file, String skills, int experience_years, String education, String desired_job_title, double desired_salary, String job_category, String preferred_location, String career_level, String work_type, String profile_summary, String portfolio_url, String languages, Date created_at, Date updated_at, boolean is_active) {
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
        this.cv_file = cv_file;
        this.skills = skills;
        this.experience_years = experience_years;
        this.education = education;
        this.desired_job_title = desired_job_title;
        this.desired_salary = desired_salary;
        this.job_category = job_category;
        this.preferred_location = preferred_location;
        this.career_level = career_level;
        this.work_type = work_type;
        this.profile_summary = profile_summary;
        this.portfolio_url = portfolio_url;
        this.languages = languages;
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

    public void setCv_file(String cv_file) {
        this.cv_file = cv_file;
    }

    public void setSkills(String skills) {
        this.skills = skills;
    }

    public void setExperience_years(int experience_years) {
        this.experience_years = experience_years;
    }

    public void setEducation(String education) {
        this.education = education;
    }

    public void setDesired_job_title(String desired_job_title) {
        this.desired_job_title = desired_job_title;
    }

    public void setDesired_salary(double desired_salary) {
        this.desired_salary = desired_salary;
    }

    public void setJob_category(String job_category) {
        this.job_category = job_category;
    }

    public void setPreferred_location(String preferred_location) {
        this.preferred_location = preferred_location;
    }

    public void setCareer_level(String career_level) {
        this.career_level = career_level;
    }

    public void setWork_type(String work_type) {
        this.work_type = work_type;
    }

    public void setProfile_summary(String profile_summary) {
        this.profile_summary = profile_summary;
    }

    public void setPortfolio_url(String portfolio_url) {
        this.portfolio_url = portfolio_url;
    }

    public void setLanguages(String languages) {
        this.languages = languages;
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

    public String getCv_file() {
        return cv_file;
    }

    public String getSkills() {
        return skills;
    }

    public int getExperience_years() {
        return experience_years;
    }

    public String getEducation() {
        return education;
    }

    public String getDesired_job_title() {
        return desired_job_title;
    }

    public double getDesired_salary() {
        return desired_salary;
    }

    public String getJob_category() {
        return job_category;
    }

    public String getPreferred_location() {
        return preferred_location;
    }

    public String getCareer_level() {
        return career_level;
    }

    public String getWork_type() {
        return work_type;
    }

    public String getProfile_summary() {
        return profile_summary;
    }

    public String getPortfolio_url() {
        return portfolio_url;
    }

    public String getLanguages() {
        return languages;
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
