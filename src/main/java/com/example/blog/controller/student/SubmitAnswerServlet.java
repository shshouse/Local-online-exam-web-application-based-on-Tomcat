package com.example.blog.controller.student;

import com.example.blog.dao.QuestionDao;
import com.example.blog.dao.StudentAnswerDao;
import com.example.blog.model.Question;
import com.example.blog.model.Student;
import com.example.blog.model.StudentAnswer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Enumeration;

@WebServlet("/student/submitAnswers")
public class SubmitAnswerServlet extends HttpServlet {

    private StudentAnswerDao studentAnswerDao = new StudentAnswerDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String studentId = ((Student) request.getSession().getAttribute("student")).getStudentId();
        QuestionDao questionDao = new QuestionDao();
        StudentAnswerDao answerDao = new StudentAnswerDao();

        Enumeration<String> parameterNames = request.getParameterNames();
        while (parameterNames.hasMoreElements()) {
            String paramName = parameterNames.nextElement();
            if (paramName.startsWith("answer_")) {
                String questionIdStr = paramName.split("_")[1];
                int questionId = Integer.parseInt(questionIdStr);
                String answerContent = request.getParameter(paramName);

                // 获取标准答案
                Question question = questionDao.getQuestionById(questionId);
                if (question == null) continue;

                // 判断是否正确
                boolean isCorrect = false;
                if (question.getType() == 1 || question.getType() == 2) {
                    // 单选/多选题：判断是否完全匹配
                    isCorrect = answerContent != null && answerContent.equals(question.getAnswer());
                } else {
                    //todo
                    // 填空题/大题：暂时标记为 false，可扩展人工评分
                    isCorrect = false;
                }

                // 创建答题记录
                StudentAnswer sa = new StudentAnswer();
                sa.setQuestionId(questionId);
                sa.setStudentId(studentId);
                sa.setContent(answerContent);
                sa.setIsCorrect(isCorrect); // 设置是否正确

                // 保存或更新答题记录
                answerDao.saveAnswer(sa);
            }
        }

        // 跳转回学生主页
        response.sendRedirect(request.getContextPath() + "/student/dashboard.jsp?tab=quiz&success=1");
    }
}
