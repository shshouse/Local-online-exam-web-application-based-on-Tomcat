package com.example.blog.model;

import java.util.Date;

public class Question {
    private int id;
    private String teacherId;     // 出题人
    private String title;         // 题干
    private int type;             // 1: 单选；2: 多选；3: 填空；4: 大题
    private String options;       // JSON 或逗号分隔的选项列表（单选/多选用）
    private String answer;        // 答案（如 A、AB、"北京"、长文本等）
    private double score;         // 分值
    private Date createdAt;       // 创建时间

    // Getters and Setters
    public int getId() {return id;}

    public void setId(int id) {this.id = id;}

    public String getTeacherId() {return teacherId;}

    public void setTeacherId(String teacherId) {this.teacherId = teacherId;}

    public String getTitle() {return title;}

    public void setTitle(String title) {this.title = title;}

    public int getType() {return type;}

    public void setType(int type) {this.type = type;}

    public String getOptions() {return options;}

    public void setOptions(String options) {this.options = options;}

    public String getAnswer() {return answer;}

    public void setAnswer(String answer) {this.answer = answer;}

    public double getScore() {return score;}

    public void setScore(double score) {this.score = score;}

    public Date getCreatedAt() {return createdAt;}

    public void setCreatedAt(Date createdAt) {this.createdAt = createdAt;}
}
