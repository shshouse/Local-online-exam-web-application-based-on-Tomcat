package com.example.blog.controller.teacher.question;

import com.example.blog.dao.QuestionDao;
import com.example.blog.model.Question;
import com.example.blog.model.Teacher;
import com.example.blog.util.PermissionUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/teacher/question/update")
public class UpdateQuestionServlet extends HttpServlet {

    private QuestionDao questionDao = new QuestionDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 获取当前登录的教师信息
        Teacher teacher = (Teacher) request.getSession().getAttribute("teacher");
        if (teacher == null) {
            response.sendRedirect(request.getContextPath() + "/teacher/login.jsp");
            return;
        }

        // 获取题目 ID
        int questionId = Integer.parseInt(request.getParameter("id"));
        Question question = questionDao.getQuestionById(questionId);

        // 检查题目是否存在
        if (question == null) {
            response.sendRedirect("../dashboard.jsp?error=1"); // 题目不存在
            return;
        }

        // 🔐 使用权限工具类检查是否有权限修改
        if (!PermissionUtils.isOwner(question, teacher)) {
            response.sendRedirect("../dashboard.jsp?error=3"); // 无权限
            return;
        }

        // 获取表单数据
        String title = request.getParameter("title");
        int type = Integer.parseInt(request.getParameter("type"));
        String options = request.getParameter("options");
        String answer = request.getParameter("answer");
        double score = Double.parseDouble(request.getParameter("score"));

        // 设置更新内容
        question.setTitle(title);
        question.setType(type);
        question.setOptions(options);
        question.setAnswer(answer);
        question.setScore(score);

        // 更新数据库
        boolean success = questionDao.updateQuestion(question);

        if (success) {
            response.sendRedirect("../dashboard.jsp");
        } else {
            response.sendRedirect("edit.jsp?id=" + questionId + "&error=1");
        }
    }
}
