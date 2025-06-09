package com.example.blog.controller.teacher.question;

import com.example.blog.dao.QuestionDao;
import com.example.blog.model.Question;
import com.example.blog.model.Teacher;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/teacher/question/publish")
public class PublishQuestionServlet extends HttpServlet {

    private QuestionDao questionDao = new QuestionDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        Teacher teacher = (Teacher) request.getSession().getAttribute("teacher");
        if (teacher == null) {
            response.sendRedirect(request.getContextPath() + "/teacher/login.jsp");
            return;
        }

        String title = request.getParameter("title");
        int type = Integer.parseInt(request.getParameter("type"));
        String options = request.getParameter("options");
        String answer = request.getParameter("answer");
        double score = Double.parseDouble(request.getParameter("score"));

        Question question = new Question();
        question.setTeacherId(teacher.getTeacherId());
        question.setTitle(title);
        question.setType(type);
        question.setOptions(options);
        question.setAnswer(answer);
        question.setScore(score);

        boolean success = questionDao.addQuestion(question);

        if (success) {
            // ✅ 使用绝对路径跳转
            response.sendRedirect(request.getContextPath() + "/teacher/dashboard.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/teacher/question/add.jsp?error=1");
        }
    }
}
