package com.example.blog.dao;

import com.example.blog.model.Student;
import com.example.blog.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDao {
    public Student findByStudentId(String studentId) {
        String sql = "SELECT * FROM students WHERE student_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, studentId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Student student = new Student();
                student.setId(rs.getInt("id"));
                student.setUsername(rs.getString("username"));
                student.setPassword(rs.getString("password"));
                student.setStudentId(rs.getString("student_id"));
                student.setCourse(rs.getString("course"));
                student.setCreatedAt(rs.getTimestamp("created_at"));
                return student;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public boolean register(Student student) {
        String sql = "INSERT INTO students (username, password, student_id) VALUES (?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, student.getUsername());
            stmt.setString(2, student.getPassword()); // 应该先加密
            stmt.setString(3, student.getStudentId());

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students";
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Student student = new Student();
                student.setStudentId(rs.getString("student_id"));
                student.setUsername(rs.getString("username"));
                student.setCreatedAt(rs.getTimestamp("created_at"));
                students.add(student);
            }
            System.out.println("✅ 查询到 " + students.size() + " 条学生记录");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

}
