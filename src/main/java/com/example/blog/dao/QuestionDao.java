package com.example.blog.dao;

import com.example.blog.model.Question;
import com.example.blog.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class QuestionDao {

    // 获取所有题目
    public List<Question> getAllQuestions() {
        String sql = "SELECT * FROM questions ORDER BY created_at DESC";
        return queryQuestions(sql);
    }

    // 按时间筛选题目
    public List<Question> getQuestionsByDateRange(String startDate, String endDate) {
        String sql = "SELECT * FROM questions WHERE created_at BETWEEN ? AND ?";
        return queryQuestionsWithParams(sql, startDate, endDate);
    }

    // 分页获取题目
    public List<Question> getQuestionsByPage(int pageNum, int pageSize) {
        String sql = "SELECT * FROM questions ORDER BY created_at DESC LIMIT ? OFFSET ?";
        int offset = (pageNum - 1) * pageSize;
        return queryQuestionsWithParams(sql, String.valueOf(pageSize), String.valueOf(offset));
    }

    // 添加题目
    public boolean addQuestion(Question question) {
        String sql = "INSERT INTO questions (teacher_id, title, type, options, answer, score) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, question.getTeacherId());
            stmt.setString(2, question.getTitle());
            stmt.setInt(3, question.getType());
            stmt.setString(4, question.getOptions());
            stmt.setString(5, question.getAnswer());
            stmt.setDouble(6, question.getScore());

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 根据ID获取题目
    public Question getQuestionById(int id) {
        String sql = "SELECT * FROM questions WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Question q = new Question();
                q.setId(rs.getInt("id"));
                q.setTeacherId(rs.getString("teacher_id"));
                q.setTitle(rs.getString("title"));
                q.setType(rs.getInt("type"));
                q.setOptions(rs.getString("options"));
                q.setAnswer(rs.getString("answer"));
                q.setScore(rs.getDouble("score"));
                q.setCreatedAt(rs.getTimestamp("created_at"));

                return q;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 更新题目
    public boolean updateQuestion(Question question) {
        String sql = "UPDATE questions SET title=?, type=?, options=?, answer=?, score=? WHERE id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, question.getTitle());
            stmt.setInt(2, question.getType());
            stmt.setString(3, question.getOptions());
            stmt.setString(4, question.getAnswer());
            stmt.setDouble(5, question.getScore());
            stmt.setInt(6, question.getId());

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 删除题目
    public boolean deleteQuestion(int id) {
        String sql = "DELETE FROM questions WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 内部方法：执行查询并返回 Question 列表
    private List<Question> queryQuestions(String sql) {
        List<Question> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Question q = new Question();
                q.setId(rs.getInt("id"));
                q.setTeacherId(rs.getString("teacher_id"));
                q.setTitle(rs.getString("title"));
                q.setType(rs.getInt("type"));
                q.setOptions(rs.getString("options"));
                q.setAnswer(rs.getString("answer"));
                q.setScore(rs.getDouble("score"));
                q.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(q);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 带参数的查询
    private List<Question> queryQuestionsWithParams(String sql, String limit, String offset) {
        List<Question> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, limit);
            stmt.setString(2, offset);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Question q = new Question();
                q.setId(rs.getInt("id"));
                q.setTeacherId(rs.getString("teacher_id"));
                q.setTitle(rs.getString("title"));
                q.setType(rs.getInt("type"));
                q.setOptions(rs.getString("options"));
                q.setAnswer(rs.getString("answer"));
                q.setScore(rs.getDouble("score"));
                q.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(q);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
