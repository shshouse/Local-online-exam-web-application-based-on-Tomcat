package com.example.blog.dao;

import com.example.blog.model.StudentAnswer;
import com.example.blog.util.DBUtil;

import java.sql.*;
import java.util.*;

public class StudentAnswerDao {

    public List<StudentAnswer> getAnswersByStudentAndQuestion(String studentId, int questionId) {
        List<StudentAnswer> answers = new ArrayList<>();
        String sql = "SELECT * FROM student_answers WHERE student_id = ? AND question_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, studentId);
            stmt.setInt(2, questionId);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                StudentAnswer sa = new StudentAnswer();
                sa.setQuestionId(rs.getInt("question_id"));
                sa.setStudentId(rs.getString("student_id"));
                sa.setContent(rs.getString("content"));
                sa.setSubmittedAt(rs.getTimestamp("submitted_at"));
                answers.add(sa);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return answers;
    }
//todo 保存待完善
public boolean saveAnswer(StudentAnswer answer) {
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        conn = DBUtil.getConnection();

        // 1. 先检查是否已经存在该学生的答题记录
        String checkSql = "SELECT * FROM student_answers WHERE student_id = ? AND question_id = ?";
        stmt = conn.prepareStatement(checkSql);
        stmt.setString(1, answer.getStudentId());
        stmt.setInt(2, answer.getQuestionId());

        rs = stmt.executeQuery();

        if (rs.next()) {
            // 2. 如果已存在，执行更新操作
            String updateSql = "UPDATE student_answers SET content = ?, submitted_at = NOW(), is_correct = ? WHERE student_id = ? AND question_id = ?";
            stmt = conn.prepareStatement(updateSql);
            stmt.setString(1, answer.getContent());
            stmt.setBoolean(2, answer.isCorrect()); // 是否正确
            stmt.setString(3, answer.getStudentId());
            stmt.setInt(4, answer.getQuestionId());

            return stmt.executeUpdate() > 0;

        } else {
            // 3. 如果不存在，执行插入操作
            String insertSql = "INSERT INTO student_answers (question_id, student_id, content, is_correct) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(insertSql);
            stmt.setInt(1, answer.getQuestionId());
            stmt.setString(2, answer.getStudentId());
            stmt.setString(3, answer.getContent());
            stmt.setBoolean(4, answer.isCorrect());

            return stmt.executeUpdate() > 0;
        }

    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    } finally {
        DBUtil.close(rs, stmt, conn);
    }
}


    public Map<Integer, StudentAnswer> getLatestAnswersByStudent(String studentId) {
        Map<Integer, StudentAnswer> answers = new HashMap<>();
        String sql = "SELECT * FROM student_answers WHERE student_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, studentId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                StudentAnswer sa = new StudentAnswer();
                sa.setQuestionId(rs.getInt("question_id"));
                sa.setStudentId(rs.getString("student_id"));
                sa.setContent(rs.getString("content"));
                sa.setIsCorrect(rs.getBoolean("is_correct")); // 设置是否正确
                sa.setSubmittedAt(rs.getTimestamp("submitted_at"));

                answers.put(sa.getQuestionId(), sa);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return answers;
    }

}
