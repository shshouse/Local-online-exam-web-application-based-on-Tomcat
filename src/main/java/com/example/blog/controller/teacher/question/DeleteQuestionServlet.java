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

@WebServlet("/teacher/question/delete")
public class DeleteQuestionServlet extends HttpServlet {

    private QuestionDao questionDao = new QuestionDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 获取 questionId 参数
        String questionIdStr = request.getParameter("questionId");
        if (questionIdStr == null || questionIdStr.isEmpty()) {
            response.sendRedirect("list.jsp");
            return;
        }

        int questionId = Integer.parseInt(questionIdStr);
        Question question = questionDao.getQuestionById(questionId);

        // 检查题目是否存在
        if (question == null) {
            response.sendRedirect("list.jsp");
            return;
        }

        // 获取当前教师
        Teacher teacher = (Teacher) request.getSession().getAttribute("teacher");
        if (teacher == null) {
            response.sendRedirect(request.getContextPath() + "/teacher/login.jsp");
            return;
        }

        // 🔐 使用权限工具类检查是否有权限删除
        if (!PermissionUtils.isOwner(question, teacher)) {
            response.sendRedirect("list.jsp?error=3"); // 无权限
            return;
        }

        // 删除题目
        boolean success = questionDao.deleteQuestion(questionId);

        // 跳转回列表页
        response.sendRedirect("list.jsp");
    }
}
