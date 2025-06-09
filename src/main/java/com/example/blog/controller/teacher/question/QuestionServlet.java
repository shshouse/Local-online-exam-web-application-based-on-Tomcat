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
import java.util.List;

@WebServlet("/teacher/question/list")
public class QuestionServlet extends HttpServlet {

    private QuestionDao questionDao = new QuestionDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Teacher teacher = (Teacher) request.getSession().getAttribute("teacher");
        if (teacher == null) {
            response.sendRedirect(request.getContextPath() + "/teacher/login.jsp");
            return;
        }

        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        List<Question> questions;

        if (startDate != null && !startDate.isEmpty() &&
                endDate != null && !endDate.isEmpty()) {
            questions = questionDao.getQuestionsByDateRange(startDate, endDate);
        } else {
            questions = questionDao.getAllQuestions();
        }

        request.setAttribute("questions", questions);

        request.getRequestDispatcher("/teacher/dashboard.jsp").forward(request, response);
    }
}
