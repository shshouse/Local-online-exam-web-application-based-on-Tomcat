package com.example.blog.model;

import java.sql.Timestamp;

public class StudentAnswer {
    private int questionId;
    private String studentId;
    private String content;
    private double scoreAchieved;
    private boolean isCorrect;
    private Timestamp submittedAt;

    public int getQuestionId() { return questionId; }
    public void setQuestionId(int questionId) { this.questionId = questionId; }

    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public double getScoreAchieved() { return scoreAchieved; }
    public void setScoreAchieved(double scoreAchieved) { this.scoreAchieved = scoreAchieved; }

    public Timestamp getSubmittedAt() { return submittedAt; }
    public void setSubmittedAt(Timestamp submittedAt) { this.submittedAt = submittedAt; }

    public boolean isCorrect() { return isCorrect; }
    public void setIsCorrect(boolean isCorrect) { this.isCorrect = isCorrect; }
}
