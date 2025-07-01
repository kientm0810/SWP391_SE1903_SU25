package models;

public class JobTypeCount {
    private String jobType;
    private int count;

    public JobTypeCount(String jobType, int count) {
        this.jobType = jobType;
        this.count = count;
    }

    public JobTypeCount() {}

    public String getJobType() {
        return jobType;
    }

    public void setJobType(String jobType) {
        this.jobType = jobType;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
}