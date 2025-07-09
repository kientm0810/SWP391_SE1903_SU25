package models;
import java.time.LocalDateTime;

public class Interview {
    private int id;
    private int applicationId;
    private int interviewerId;
    private LocalDateTime time;
    private String location;
    private String round;
    private String status;
    private String result;
    private String note;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getApplicationId() { return applicationId; }
    public void setApplicationId(int applicationId) { this.applicationId = applicationId; }
    public int getInterviewerId() { return interviewerId; }
    public void setInterviewerId(int interviewerId) { this.interviewerId = interviewerId; }
    public LocalDateTime getTime() { return time; }
    public void setTime(LocalDateTime time) { this.time = time; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    public String getRound() { return round; }
    public void setRound(String round) { this.round = round; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getResult() { return result; }
    public void setResult(String result) { this.result = result; }
    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
} 