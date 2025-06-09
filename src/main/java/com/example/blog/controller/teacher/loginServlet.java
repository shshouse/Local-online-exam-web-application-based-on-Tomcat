package com.example.blog.controller.teacher;

import com.example.blog.dao.TeacherDao;
import com.example.blog.model.Teacher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/teacher/login")
public class loginServlet extends HttpServlet{
    private TeacherDao teacherDao = new TeacherDao();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String teacherId = request.getParameter("teacherId");
        String password = request.getParameter("password");

        Teacher teacher = teacherDao.findByTeacherId(teacherId);

        if (teacher == null) {
            response.sendRedirect("../teacher/login.jsp?error=2");
        } else if (!teacher.getPassword().equals(password)) {
            response.sendRedirect("../teacher/login.jsp?error=1");
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("teacher", teacher);
            response.sendRedirect("../teacher/dashboard.jsp");
        }
    }
}
