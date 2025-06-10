<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.blog.model.Teacher" %>
<%@ page import="com.example.blog.model.Question" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.blog.dao.QuestionDao" %>
<%@ page import="com.example.blog.util.PermissionUtils" %>
<%@ page import="com.example.blog.dao.StudentDao" %>
<%@ page import="com.example.blog.model.Student" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>教师主页</title>
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

        /* 左侧菜单 */
        .sidebar {
            flex: 0 0 220px;
            background-color: #28a745;
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
            background-color: #218838;
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

        /* 表格样式 */
        .question-table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 10px;
        }

        .question-table th,
        .question-table td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ccc;
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

        /* 主按钮 */
        .btn.btn-primary {
            background-color: #007bff;
        }

        .btn.btn-primary:hover {
            background-color: #0056b3;
        }

        /* 成功按钮 */
        .btn.btn-success {
            background-color: #28a745;
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
    </style>

</head>
<body>

<div class="container">
    <!-- 左侧竖向选项卡 -->
    <div class="sidebar">
        <h3>教师中心</h3>
        <ul class="tabs">
            <li class="tab-link active" data-tab="questions">题目管理</li>
            <li class="tab-link" data-tab="students">学生名单</li>
            <li class="tab-link" data-tab="profile">个人信息</li>
        </ul>

        <!-- 退出按钮 -->
        <div class="logout-container">
            <a href="${pageContext.request.contextPath}/teacher/logout" class="logout-button">退出登录</a>
        </div>
    </div>

    <!-- 右侧内容区 -->
    <div class="content">
        <div id="questions" class="tab-content active">
            <h2>题目管理</h2>

            <!-- 筛选区域 -->
            <div style="margin-bottom: 15px;">
                <form method="get" action="" style="display: flex; gap: 10px; align-items: center;">
                    <label for="startDate">起始时间：</label>
                    <input type="date" id="startDate" name="startDate">

                    <label for="endDate">结束时间：</label>
                    <input type="date" id="endDate" name="endDate">

                    <button type="submit" class="btn btn-primary">筛选</button>
                </form>
            </div>

            <!-- 发布练习按钮 -->
            <div style="margin-bottom: 20px;">
                <a href="question/add.jsp" class="btn btn-success">+ 发布练习</a>
            </div>

            <!-- 题目列表表格 -->
            <table border="1" width="100%" class="question-table">
                <thead>
                <tr>
                    <th>编号</th>
                    <th>题目内容</th>
                    <th>类型</th>
                    <th>分值</th>
                    <th>发布时间</th>
                    <th>发布者</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <%
                    // 获取筛选参数
                    String startDate = request.getParameter("startDate");
                    String endDate = request.getParameter("endDate");

                    QuestionDao questionDao = new QuestionDao();
                    List<Question> questions;

                    if (startDate != null && !startDate.isEmpty() &&
                            endDate != null && !endDate.isEmpty()) {
                        questions = questionDao.getQuestionsByDateRange(startDate, endDate);
                    } else {
                        questions = questionDao.getAllQuestions();
                    }

                    Teacher currentTeacher = (Teacher) session.getAttribute("teacher");

                    if (questions != null && !questions.isEmpty()) {
                        for (Question q : questions) {
                %>
                <tr>
                    <td><%= q.getId() %></td>
                    <td><%= q.getTitle() %></td>
                    <td>
                        <%= q.getType() == 1 ? "单选题" :
                                q.getType() == 2 ? "多选题" :
                                        q.getType() == 3 ? "填空题" : "大题" %>
                    </td>
                    <td><%= q.getScore() %></td>
                    <td><%= q.getCreatedAt() %></td>
                    <td><%= q.getTeacherId() %></td> <!-- 显示发布者 ID -->
                    <td>
                        <% if (currentTeacher != null && PermissionUtils.isOwner(q, currentTeacher)) { %>
                        <a href="question/edit.jsp?id=<%= q.getId() %>">编辑</a> |
                        <a href="question/delete?questionId=<%= q.getId() %>" onclick="return confirm('确定删除？')">删除</a>
                        <% } else { %>
                        ——
                        <% } %>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="7" style="text-align:center;">暂无题目记录</td>
                </tr>
                <%
                    }
                %>
                </tbody>

            </table>
        </div>



        <div id="students" class="tab-content">
            <h2>学生名单</h2>

            <table border="1" width="100%" class="question-table">
                <thead>
                <tr>
                    <th>学号</th>
                    <th>姓名</th>
                    <th>注册时间</th>
                </tr>
                </thead>
                <tbody>
                <%
                    StudentDao studentDao = new StudentDao();
                    List<Student> students = studentDao.getAllStudents();

                    if (students != null && !students.isEmpty()) {
                        for (Student s : students) {
                %>
                <tr>
                    <td><%= s.getStudentId() %></td>
                    <td><%= s.getUsername() %></td>
                    <td><%= s.getCreatedAt() != null ? s.getCreatedAt().toLocaleString() : "" %></td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="5" style="text-align:center;">暂无学生记录</td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>


        <div id="profile" class="tab-content">
            <h2>个人信息</h2>
            <%
                Teacher teacher = (Teacher) session.getAttribute("teacher");
                if (teacher != null) {
            %>
            <p><strong>工号：</strong><%= teacher.getTeacherId() %></p>
            <p><strong>姓名：</strong><%= teacher.getUsername() %></p>
            <p><strong>注册时间：</strong>
                <%= teacher.getCreatedAt() != null ? teacher.getCreatedAt().toLocaleString() : "未知" %>
            </p>
            <%
            } else {
            %>
            <p>未找到教师信息，请重新登录。</p>
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

            // 移除所有 active 类
            document.querySelectorAll('.tab-link').forEach(item => item.classList.remove('active'));
            document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));

            // 添加 active 到当前选项卡和对应内容
            this.classList.add('active');
            document.getElementById(tabId).classList.add('active');
        });
    });
</script>

</body>
</html>
