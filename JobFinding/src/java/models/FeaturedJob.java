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
public class FeaturedJob {
    private int id;
    private int post_id;
    private int promotion_id;
    private Date start_date;
    private Date end_date;
    private int transaction_id;

    public FeaturedJob() {
    }

    public FeaturedJob(int id, int post_id, int promotion_id, Date start_date, Date end_date, int transaction_id) {
        this.id = id;
        this.post_id = post_id;
        this.promotion_id = promotion_id;
        this.start_date = start_date;
        this.end_date = end_date;
        this.transaction_id = transaction_id;
    }

    public FeaturedJob(int post_id, int promotion_id, Date start_date, Date end_date, int transaction_id) {
        this.post_id = post_id;
        this.promotion_id = promotion_id;
        this.start_date = start_date;
        this.end_date = end_date;
        this.transaction_id = transaction_id;
    }

    public FeaturedJob(int post_id, int promotion_id, int transaction_id) {
        this.post_id = post_id;
        this.promotion_id = promotion_id;
        this.transaction_id = transaction_id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setPost_id(int post_id) {
        this.post_id = post_id;
    }

    public void setPromotion_id(int promotion_id) {
        this.promotion_id = promotion_id;
    }

    public void setStart_date(Date start_date) {
        this.start_date = start_date;
    }

    public void setEnd_date(Date end_date) {
        this.end_date = end_date;
    }

    public void setTransaction_id(int transaction_id) {
        this.transaction_id = transaction_id;
    }

    public int getId() {
        return id;
    }

    public int getPost_id() {
        return post_id;
    }

    public int getPromotion_id() {
        return promotion_id;
    }

    public Date getStart_date() {
        return start_date;
    }

    public Date getEnd_date() {
        return end_date;
    }

    public int getTransaction_id() {
        return transaction_id;
    }
    
    
    
}
