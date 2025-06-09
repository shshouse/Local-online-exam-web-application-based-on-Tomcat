package com.example.blog.model;

import java.util.Date;

public class StudentAnswer {
    private int id;
    private int questionId;
    private String studentId;
    private String content;          // 学生提交的答案
    private boolean isCorrect;     // 是否正确（仅限客观题）
    private double scoreAchieved;  // 得分
    private Date submittedAt;

    // Getters and Setters
    public int getId() {return id;}

    public void setId(int id) {this.id = id;}

    public int getQuestionId() {return questionId;}

    public void setQuestionId(int questionId) {this.questionId = questionId;}

    public String getStudentId() {return studentId;}

    public void setStudentId(String studentId) {this.studentId = studentId;}

    public boolean isCorrect() {return isCorrect;}

    public void setCorrect(boolean isCorrect) {this.isCorrect = isCorrect;}

    public double getScoreAchieved() {return scoreAchieved;}

    public void setScoreAchieved(double scoreAchieved) {this.scoreAchieved = scoreAchieved;}

    public Date getSubmittedAt() {return submittedAt;}

    public void setSubmittedAt(Date submittedAt) {this.submittedAt = submittedAt;}
}
