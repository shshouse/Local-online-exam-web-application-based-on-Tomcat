package com.example.blog.controller.student;

import com.example.blog.dao.StudentDao;
import com.example.blog.model.Student;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@WebServlet("/student/login")
public class loginServlet extends HttpServlet {

    private StudentDao studentDao = new StudentDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String studentId = request.getParameter("studentId");
        String password = request.getParameter("password");

        Student student = studentDao.findByStudentId(studentId);

        if (student == null) {
            // 账号不存在
            response.sendRedirect("../student/login.jsp?error=2");
        } else if (!student.getPassword().equals(md5Encrypt(password))) {
            // 密码错误
            response.sendRedirect("../student/login.jsp?error=1");
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("student", student);
            response.sendRedirect("../student/dashboard.jsp");
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
