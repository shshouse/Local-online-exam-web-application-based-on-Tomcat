<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.blog.dao.QuestionDao" %>
<%@ page import="com.example.blog.model.Question" %>
<%@ page import="com.example.blog.dao.StudentAnswerDao" %>
<%@ page import="com.example.blog.model.StudentAnswer" %>
<%@ page import="com.example.blog.model.Student" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>学生主页</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f6f8;
        }

        .container {
            display: flex;
            flex-direction: row;
            min-height: 100vh;
            justify-content: center;
            align-items: stretch;
            padding: 20px;
            gap: 20px;
        }

        /* 左侧竖向菜单 */
        .sidebar {
            flex: 0 0 220px;
            background-color: #007bff;
            color: white;
            padding: 20px 15px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
        }

        .sidebar h3 {
            text-align: center;
            font-size: 18px;
            margin-top: 0;
        }

        .tabs {
            list-style-type: none;
            padding: 0;
            margin-top: 20px;
            flex: 1;
        }

        .tabs li {
            padding: 12px;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.3s ease;
            margin-bottom: 10px;
        }

        .tabs li:hover,
        .tabs li.active {
            background-color: #0056b3;
        }

        /* 右侧内容区域 */
        .content {
            flex: 1;
            background-color: #ffffff;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            overflow-y: auto;
        }

        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
        }

        /* 按钮通用样式 */
        .btn {
            display: inline-block;
            padding: 8px 14px;
            font-size: 14px;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            color: white;
            border: none;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .btn.btn-primary {
            background-color: #007bff;
        }

        .btn.btn-primary:hover {
            background-color: #0056b3;
        }

        .btn.disabled {
            background-color: #cccccc;
            cursor: not-allowed;
        }

        /* 登出按钮 */
        .logout-container {
            margin-top: auto;
            padding: 20px;
        }

        .logout-button {
            display: block;
            width: 100%;
            padding: 12px;
            background-color: #dc3545;
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .logout-button:hover {
            background-color: #c82333;
        }

        /* 响应式布局 */
        @media (max-width: 768px) {
            .container {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
                order: -1;
            }
        }

        .question-card {
            background-color: #f9f9f9;
            border-left: 6px solid #007bff;
            padding: 15px 20px;
            margin-bottom: 20px;
            border-radius: 6px;
        }

        .question-card input[type="radio"],
        .question-card input[type="checkbox"] {
            margin-right: 10px;
        }

        .result-correct {
            color: green;
            font-weight: bold;
        }

        .result-wrong {
            color: red;
            font-weight: bold;
        }

        .correct-answer {
            color: #555;
            font-style: italic;
        }
    </style>
</head>
<body>

<div class="container">
    <!-- 左侧竖向选项卡 -->
    <div class="sidebar">
        <h3>个人中心</h3>
        <ul class="tabs">
            <li class="tab-link active" data-tab="quiz">在线做题</li>
            <li class="tab-link" data-tab="profile">个人信息</li>
        </ul>
        <div class="logout-container">
            <a href="${pageContext.request.contextPath}/student/logout" class="logout-button">退出登录</a>
        </div>
    </div>

    <!-- 右侧内容区 -->
    <div class="content">
        <!-- 在线做题 tab -->
        <div id="quiz" class="tab-content active">
            <h2>在线做题</h2>

            <form id="quizForm" action="${pageContext.request.contextPath}/student/submitAnswers" method="post">
                <%
                    QuestionDao questionDao = new QuestionDao();
                    StudentAnswerDao answerDao = new StudentAnswerDao();

                    Student student = (Student) session.getAttribute("student");
                    String studentId = student != null ? student.getStudentId() : null;

                    List<Question> questions = questionDao.getAllQuestions();
                    Map<Integer, StudentAnswer> userAnswers = new HashMap<>();

                    if (student != null && studentId != null) {
                        userAnswers = answerDao.getLatestAnswersByStudent(studentId);
                    }

                    if (questions != null && !questions.isEmpty()) {
                        for (Question q : questions) {
                            StudentAnswer sa = userAnswers.get(q.getId());
                            boolean answered = sa != null;
                            String correctClass = "";
                            String correctAnswerText = "";

                            // 强制重新判断是否答对
                            boolean isCorrect = false;

                            if (answered && q.getAnswer() != null && sa.getContent() != null) {
                                isCorrect = sa.getContent().trim().equalsIgnoreCase(q.getAnswer().trim());
                            }

                            correctClass = isCorrect ? "result-correct" : "result-wrong";
                            correctAnswerText = "正确答案：" + q.getAnswer();
                %>
                <div class="question-card <%= answered ? "answered" : "" %>">
                    <p><strong>Q<%= q.getId() %>:</strong> <%= q.getTitle() %></p>

                    <% if (!answered) { %>
                    <input type="hidden" name="question_id_<%= q.getId() %>" value="<%= q.getId() %>">
                    <% } %>

                    <%
                        int type = q.getType();
                        if (type == 1 || type == 2) {
                            String[] options = q.getOptions().split("\n");
                            for (String option : options) {
                                String value = option.trim();
                    %>
                    <label>
                        <input type="<%= type == 1 ? "radio" : "checkbox" %>"
                               name="answer_<%= q.getId() %>"
                               value="<%= value %>"
                            <%= answered ? "disabled" : "" %>
                            <%= answered && sa.getContent().contains(value) ? "checked" : "" %>>
                        <%= value %>
                    </label><br>
                    <%
                        }
                    } else if (type == 3) {
                    %>
                    <input type="text"
                           name="answer_<%= q.getId() %>"
                           placeholder="请输入你的答案"
                           size="60"
                        <%= answered ? "value=\"" + sa.getContent() + "\" disabled" : "" %>><br>
                    <%
                    } else if (type == 4) {
                    %>
                    <textarea name="answer_<%= q.getId() %>"
                              rows="4"
                              cols="80"
                            <%= answered ? "disabled" : "" %>><%= answered ? sa.getContent() : "" %></textarea><br>
                    <%
                        }
                    %>

                    <div class="question-result">
                        <% if (answered) { %>
                        <span class="<%= correctClass %>"><%= isCorrect ? "回答正确" : "回答错误" %></span>
                        <div class="correct-answer"><%= correctAnswerText %></div>
                        <% } %>
                    </div>
                </div>
                <hr>
                <%
                    }
                } else {
                %>
                <p>暂无题目。</p>
                <%
                    }
                %>
                <%
                    // 判断是否全部作答
                    boolean allAnswered = true;
                    for (Question q : questions) {
                        StudentAnswer sa = userAnswers.get(q.getId());
                        if (sa == null) {
                            allAnswered = false;
                            break;
                        }
                    }
                %>
                <button type="submit" class="btn btn-primary <%= allAnswered ? "disabled" : "" %>">提交答案</button>
            </form>
        </div>

        <!-- 个人信息 tab -->
        <div id="profile" class="tab-content">
            <h2>个人信息</h2>
            <%
                if (student != null) {
            %>
            <p><strong>学号：</strong><%= student.getStudentId() %></p>
            <p><strong>姓名：</strong><%= student.getUsername() %></p>
            <p><strong>注册时间：</strong><%= student.getCreatedAt() != null ? student.getCreatedAt().toLocaleString() : "未知" %></p>
            <%
            } else {
            %>
            <p>未找到学生信息，请重新登录。</p>
            <%
                }
            %>
        </div>
    </div>
</div>

<script>
    document.querySelectorAll('.tab-link').forEach(link => {
        link.addEventListener('click', function () {
            const tabId = this.getAttribute('data-tab');

            document.querySelectorAll('.tab-link').forEach(item => item.classList.remove('active'));
            document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));

            this.classList.add('active');
            document.getElementById(tabId).classList.add('active');
        });
    });
</script>

</body>
</html>
