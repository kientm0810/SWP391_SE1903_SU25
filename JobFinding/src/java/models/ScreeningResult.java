package models;

import java.sql.Timestamp;

public class ScreeningResult {

    private int id;
    private int recruitmentProcessId;
    private String screeningType; // automated, manual
    private String result; // pass, fail, shortlist
    private int score;
    private String feedback;
    private String reviewerName;
    private Timestamp reviewedAt;
    private String criteria; // JSON string for criteria details

    // Constructor
    public ScreeningResult() {
    }

    public ScreeningResult(int id, int recruitmentProcessId, String screeningType, String result,
            int score, String feedback, String reviewerName, Timestamp reviewedAt, String criteria) {
        this.id = id;
        this.recruitmentProcessId = recruitmentProcessId;
        this.screeningType = screeningType;
        this.result = result;
        this.score = score;
        this.feedback = feedback;
        this.reviewerName = reviewerName;
        this.reviewedAt = reviewedAt;
        this.criteria = criteria;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getRecruitmentProcessId() {
        return recruitmentProcessId;
    }

    public void setRecruitmentProcessId(int recruitmentProcessId) {
        this.recruitmentProcessId = recruitmentProcessId;
    }

    public String getScreeningType() {
        return screeningType;
    }

    public void setScreeningType(String screeningType) {
        this.screeningType = screeningType;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public String getReviewerName() {
        return reviewerName;
    }

    public void setReviewerName(String reviewerName) {
        this.reviewerName = reviewerName;
    }

    public Timestamp getReviewedAt() {
        return reviewedAt;
    }

    public void setReviewedAt(Timestamp reviewedAt) {
        this.reviewedAt = reviewedAt;
    }

    public String getCriteria() {
        return criteria;
    }

    public void setCriteria(String criteria) {
        this.criteria = criteria;
    }
}
