package controllers;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import daos.RecruitmentProcessDAO;
import daos.ApplicationDAO;
import daos.ScreeningResultDAO;
import daos.SkillsTestDAO;
import models.RecruitmentProcess;
import models.Application;
import models.ScreeningResult;
import models.SkillsTest;

@WebServlet(name="RecruitmentController", urlPatterns={"/recruitment/*"})
public class RecruitmentController extends HttpServlet {
    
    private RecruitmentProcessDAO recruitmentDAO;
    private ApplicationDAO applicationDAO;
    private ScreeningResultDAO screeningDAO;
    private SkillsTestDAO skillsTestDAO;
    
    @Override
    public void init() throws ServletException {
        recruitmentDAO = new RecruitmentProcessDAO();
        applicationDAO = new ApplicationDAO();
        screeningDAO = new ScreeningResultDAO();
        skillsTestDAO = new SkillsTestDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // Dashboard view
                showDashboard(request, response);
            } else if (pathInfo.equals("/dashboard")) {
                showDashboard(request, response);
            } else if (pathInfo.equals("/screening")) {
                showScreeningPage(request, response);
            } else if (pathInfo.equals("/phone-interview")) {
                showPhoneInterviewPage(request, response);
            } else if (pathInfo.equals("/skills-test")) {
                showSkillsTestPage(request, response);
            } else if (pathInfo.equals("/final-interview")) {
                showFinalInterviewPage(request, response);
            } else if (pathInfo.equals("/decision")) {
                showDecisionPage(request, response);
            } else if (pathInfo.equals("/offer")) {
                showOfferPage(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Don't call sendError after forward, just log the error
            if (!response.isCommitted()) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo.equals("/start-process")) {
                startRecruitmentProcess(request, response);
            } else if (pathInfo.equals("/update-stage")) {
                updateStage(request, response);
            } else if (pathInfo.equals("/screening-result")) {
                saveScreeningResult(request, response);
            } else if (pathInfo.equals("/schedule-interview")) {
                scheduleInterview(request, response);
            } else if (pathInfo.equals("/schedule-test")) {
                scheduleSkillsTest(request, response);
            } else if (pathInfo.equals("/final-decision")) {
                makeFinalDecision(request, response);
            } else if (pathInfo.equals("/send-offer")) {
                sendJobOffer(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Don't call sendError after redirect, just log the error
            if (!response.isCommitted()) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        }
    }
    
    private void showDashboard(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, Exception {
        // Get recruitment processes by status
        List<RecruitmentProcess> inProgress = recruitmentDAO.getByStatus("in_progress");
        List<RecruitmentProcess> completed = recruitmentDAO.getByStatus("completed");
        List<RecruitmentProcess> rejected = recruitmentDAO.getByStatus("rejected");
        List<RecruitmentProcess> hired = recruitmentDAO.getByStatus("hired");
        
        request.setAttribute("inProgress", inProgress);
        request.setAttribute("completed", completed);
        request.setAttribute("rejected", rejected);
        request.setAttribute("hired", hired);
        
        request.getRequestDispatcher("/recruitment_dashboard.jsp").forward(request, response);
    }
    
    private void showScreeningPage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, Exception {
        String stage = "initial_screening";
        List<RecruitmentProcess> processes = recruitmentDAO.getByStage(stage);
        request.setAttribute("processes", processes);
        request.setAttribute("currentStage", stage);
        request.getRequestDispatcher("/recruitment_screening.jsp").forward(request, response);
    }
    
    private void showPhoneInterviewPage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, Exception {
        String stage = "phone_interview";
        List<RecruitmentProcess> processes = recruitmentDAO.getByStage(stage);
        request.setAttribute("processes", processes);
        request.setAttribute("currentStage", stage);
        request.getRequestDispatcher("/recruitment_phone_interview.jsp").forward(request, response);
    }
    
    private void showSkillsTestPage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, Exception {
        String stage = "skills_test";
        List<RecruitmentProcess> processes = recruitmentDAO.getByStage(stage);
        request.setAttribute("processes", processes);
        request.setAttribute("currentStage", stage);
        request.getRequestDispatcher("/recruitment_skills_test.jsp").forward(request, response);
    }
    
    private void showFinalInterviewPage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, Exception {
        String stage = "final_interview";
        List<RecruitmentProcess> processes = recruitmentDAO.getByStage(stage);
        request.setAttribute("processes", processes);
        request.setAttribute("currentStage", stage);
        request.getRequestDispatcher("/recruitment_final_interview.jsp").forward(request, response);
    }
    
    private void showDecisionPage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, Exception {
        String stage = "decision";
        List<RecruitmentProcess> processes = recruitmentDAO.getByStage(stage);
        request.setAttribute("processes", processes);
        request.setAttribute("currentStage", stage);
        request.getRequestDispatcher("/recruitment_decision.jsp").forward(request, response);
    }
    
    private void showOfferPage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, Exception {
        String stage = "offer";
        List<RecruitmentProcess> processes = recruitmentDAO.getByStage(stage);
        request.setAttribute("processes", processes);
        request.setAttribute("currentStage", stage);
        request.getRequestDispatcher("/recruitment_offer.jsp").forward(request, response);
    }
    
    private void startRecruitmentProcess(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        int applicationId = Integer.parseInt(request.getParameter("applicationId"));
        int hrId = Integer.parseInt(request.getParameter("hrId"));
        int recruiterId = Integer.parseInt(request.getParameter("recruiterId"));
        
        RecruitmentProcess process = new RecruitmentProcess();
        process.setApplicationId(applicationId);
        process.setCurrentStage("initial_screening");
        process.setStatus("in_progress");
        process.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        process.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
        process.setAssignedHrId(hrId);
        process.setAssignedRecruiterId(recruiterId);
        process.setNotes("Quy trình tuyển dụng được khởi tạo");
        
        recruitmentDAO.insert(process);
        
        response.sendRedirect(request.getContextPath() + "/recruitment/screening");
    }
    
    private void updateStage(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        int processId = Integer.parseInt(request.getParameter("processId"));
        String newStage = request.getParameter("newStage");
        String notes = request.getParameter("notes");
        
        recruitmentDAO.updateStage(processId, newStage, notes);
        
        response.sendRedirect(request.getContextPath() + "/recruitment/dashboard");
    }
    
    private void saveScreeningResult(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        int processId = Integer.parseInt(request.getParameter("processId"));
        String screeningType = request.getParameter("screeningType");
        String result = request.getParameter("result");
        int score = Integer.parseInt(request.getParameter("score"));
        String feedback = request.getParameter("feedback");
        String reviewerName = request.getParameter("reviewerName");
        
        ScreeningResult screeningResult = new ScreeningResult();
        screeningResult.setRecruitmentProcessId(processId);
        screeningResult.setScreeningType(screeningType);
        screeningResult.setResult(result);
        screeningResult.setScore(score);
        screeningResult.setFeedback(feedback);
        screeningResult.setReviewerName(reviewerName);
        screeningResult.setReviewedAt(new Timestamp(System.currentTimeMillis()));
        
        screeningDAO.insert(screeningResult);
        
        // Update process stage based on result
        String nextStage = result.equals("pass") ? "phone_interview" : "rejected";
        recruitmentDAO.updateStage(processId, nextStage, "Screening completed: " + result);
        
        response.sendRedirect(request.getContextPath() + "/recruitment/screening");
    }
    
    private void scheduleInterview(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        int processId = Integer.parseInt(request.getParameter("processId"));
        String interviewType = request.getParameter("interviewType");
        String scheduledDate = request.getParameter("scheduledDate");
        String interviewer = request.getParameter("interviewer");
        String location = request.getParameter("location");
        
        // Create interview record
        // This would typically create an interview record in the Interviews table
        
        // Update process stage
        String nextStage = interviewType.equals("phone") ? "phone_interview" : "final_interview";
        recruitmentDAO.updateStage(processId, nextStage, "Interview scheduled for " + scheduledDate);
        
        response.sendRedirect(request.getContextPath() + "/recruitment/dashboard");
    }
    
    private void scheduleSkillsTest(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        int processId = Integer.parseInt(request.getParameter("processId"));
        String testType = request.getParameter("testType");
        String testName = request.getParameter("testName");
        String testUrl = request.getParameter("testUrl");
        String deadline = request.getParameter("deadline");
        
        SkillsTest test = new SkillsTest();
        test.setRecruitmentProcessId(processId);
        test.setTestType(testType);
        test.setTestName(testName);
        test.setTestUrl(testUrl);
        test.setScheduledAt(new Timestamp(System.currentTimeMillis()));
        test.setDeadline(Timestamp.valueOf(deadline));
        test.setStatus("scheduled");
        
        skillsTestDAO.insert(test);
        
        // Update process stage
        recruitmentDAO.updateStage(processId, "skills_test", "Skills test scheduled: " + testName);
        
        response.sendRedirect(request.getContextPath() + "/recruitment/skills-test");
    }
    
    private void makeFinalDecision(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        int processId = Integer.parseInt(request.getParameter("processId"));
        String decision = request.getParameter("decision");
        String feedback = request.getParameter("feedback");
        
        String nextStage = decision.equals("hire") ? "offer" : "rejected";
        String status = decision.equals("hire") ? "completed" : "rejected";
        
        recruitmentDAO.updateStage(processId, nextStage, "Final decision: " + decision + " - " + feedback);
        recruitmentDAO.updateStatus(processId, status, feedback);
        
        response.sendRedirect(request.getContextPath() + "/recruitment/decision");
    }
    
    private void sendJobOffer(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        int processId = Integer.parseInt(request.getParameter("processId"));
        String salary = request.getParameter("salary");
        String startDate = request.getParameter("startDate");
        String offerDetails = request.getParameter("offerDetails");
        
        // Update process stage and status
        recruitmentDAO.updateStage(processId, "offer", "Job offer sent - Salary: " + salary + ", Start: " + startDate);
        recruitmentDAO.updateStatus(processId, "hired", offerDetails);
        
        response.sendRedirect(request.getContextPath() + "/recruitment/offer");
    }
} 