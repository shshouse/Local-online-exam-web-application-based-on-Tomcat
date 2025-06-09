package com.example.blog.dao;

import com.example.blog.model.Teacher;
import com.example.blog.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class TeacherDao {

    public Teacher findByTeacherId(String teacherId) {
        String sql = "SELECT * FROM teachers WHERE teacher_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, teacherId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Teacher teacher = new Teacher();
                teacher.setId(rs.getInt("id"));
                teacher.setUsername(rs.getString("username"));
                teacher.setPassword(rs.getString("password"));
                teacher.setTeacherId(rs.getString("teacher_id"));
                teacher.setDepartment(rs.getString("department"));
                teacher.setCreatedAt(rs.getTimestamp("created_at"));
                return teacher;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public boolean register(Teacher teacher) {
        String sql = "INSERT INTO teachers (username, password, teacher_id) VALUES (?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, teacher.getUsername());
            stmt.setString(2, teacher.getPassword());
            stmt.setString(3, teacher.getTeacherId());

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
