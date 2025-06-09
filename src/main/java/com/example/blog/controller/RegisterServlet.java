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
        String identity = request.getParameter("identity");


        if (identity.equals("student")) {
            Student student = new Student();
            student.setUsername(username);
            student.setPassword(password); // 实际应使用 BCrypt 加密
            student.setStudentId(id);
            student.setCourse("无"); // 可选字段留空

            boolean success = studentDao.register(student);
            if (success) {
                response.sendRedirect("student/login.jsp");
            } else {
                response.sendRedirect("signup.jsp?error=1");
            }

        } else if (identity.equals("teacher")) {
            Teacher teacher = new Teacher();
            teacher.setUsername(username);
            teacher.setPassword(password);
            teacher.setTeacherId(id);
            teacher.setDepartment("");

            boolean success = teacherDao.register(teacher);
            if (success) {
                response.sendRedirect("teacher/login.jsp");
            } else {
                response.sendRedirect("signup.jsp?error=1");
            }
        }
    }
}
