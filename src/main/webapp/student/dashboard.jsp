<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

        .sidebar {
            flex: 0 0 200px;
            background-color: #007bff;
            color: white;
            padding: 20px 15px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
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

        /* 响应式布局：当屏幕小于 768px 时变为上下结构 */
        @media (max-width: 768px) {
            .container {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
                order: -1;
            }
        }
        .logout-container {
            margin-top: auto;
            padding: 20px;
        }

        .logout-button {
            display: block;
            width: 100%;
            padding: 12px;
            background-color: #28a745;
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .logout-button:hover {
            background-color: #218838;
        }

    </style>
</head>
<body>

<div class="container">
    <!-- 左侧竖向选项卡 -->
    <div class="sidebar">
        <h3>个人中心</h3>
        <ul class="tabs">
            <li class="tab-link active" data-tab="course">选课信息</li>
            <li class="tab-link" data-tab="grades">成绩查询</li>
            <li class="tab-link" data-tab="profile">个人信息</li>
        </ul>
        <div class="logout-container">
            <a href="${pageContext.request.contextPath}/student/logout" class="logout-button">退出登录</a>
        </div>
    </div>

    <div class="content">
        <div id="course" class="tab-content active">
            <h2>选课信息</h2>
            <p>这里是你的选课信息，请选择课程或查看已选课程。</p>
            <a href="selectCourse.jsp">进入选课系统</a>
        </div>

        <div id="grades" class="tab-content">
            <h2>成绩查询</h2>
            <p>目前暂无成绩记录，请等待教师录入。</p>
        </div>

        <div id="profile" class="tab-content">
            <h2>个人信息</h2>
            <%@ page import="com.example.blog.model.Student" %>
            <%
                Student student = (Student) session.getAttribute("student");
                if (student != null) {
            %>
            <p><strong>学号：</strong><%= student.getStudentId() %></p>
            <p><strong>姓名：</strong><%= student.getUsername() %></p>
            <p><strong>专业：</strong><%= student.getCourse() %></p>
            <p><strong>注册时间：</strong>
                <%
                    if (student != null && student.getCreatedAt() != null) {
                        out.print(student.getCreatedAt().toLocaleString());
                    } else {
                        out.print("暂无注册时间");
                    }
                %>
            </p>
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
