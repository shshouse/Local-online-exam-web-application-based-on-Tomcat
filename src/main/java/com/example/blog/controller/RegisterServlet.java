package com.example.blog.controller;

import com.example.blog.dao.StudentDao;
import com.example.blog.dao.TeacherDao;
import com.example.blog.model.Student;
import com.example.blog.model.Teacher;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private StudentDao studentDao = new StudentDao();
    private TeacherDao teacherDao = new TeacherDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String id = request.getParameter("id");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String identity = request.getParameter("identity");

        // 验证必填字段
        if (username == null || username.trim().isEmpty() ||
            id == null || id.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            response.sendRedirect("signup.jsp?error=3");
            return;
        }

        // 验证密码一致性
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("signup.jsp?error=2");
            return;
        }

        // 验证密码格式(至少8位)
        if (password.length() < 8) {
            response.sendRedirect("signup.jsp?error=4");
            return;
        }

        if (identity.equals("student")) {
            // 检查学号是否已存在
            if (studentDao.findByStudentId(id) != null) {
                response.sendRedirect("signup.jsp?error=1");
                return;
            }

            Student student = new Student();
            student.setUsername(username);
            student.setPassword(md5Encrypt(password)); // 使用MD5加密密码
            student.setStudentId(id);
            student.setCourse("无");

            boolean success = studentDao.register(student);
            if (success) {
                response.sendRedirect("student/login.jsp");
            } else {
                response.sendRedirect("signup.jsp?error=0");
            }
        } else if (identity.equals("teacher")) {
            // 检查工号是否已存在
            if (teacherDao.findByTeacherId(id) != null) {
                response.sendRedirect("signup.jsp?error=1");
                return;
            }

            Teacher teacher = new Teacher();
            teacher.setUsername(username);
            teacher.setPassword(md5Encrypt(password)); // 使用MD5加密密码
            teacher.setTeacherId(id);

            boolean success = teacherDao.register(teacher);
            if (success) {
                response.sendRedirect("teacher/login.jsp");
            } else {
                response.sendRedirect("signup.jsp?error=0");
            }
        }
    }

    private String md5Encrypt(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(input.getBytes());
            byte[] bytes = md.digest();
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
}
