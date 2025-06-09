<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>选课系统 - 首页</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #74ebd5, #ACB6E5);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .home-container {
            text-align: center;
            max-width: 500px;
            width: 90%;
        }

        .card {
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            padding: 30px 20px;
            margin-bottom: 20px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
        }

        .card h3 {
            margin: 0;
            font-size: 20px;
            color: #333;
        }

        .card p {
            color: #666;
            font-size: 14px;
            margin-top: 8px;
        }

        .footer {
            margin-top: 30px;
            font-size: 14px;
            color: #555;
        }

        .footer a {
            color: #007bff;
            text-decoration: none;
        }

        .footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="home-container">
    <h2 style="color: white; margin-bottom: 40px;"> miku 在线做题系统</h2>

    <a href="student/login.jsp" style="text-decoration: none;">
        <div class="card">
            <h3>我是学生</h3>
            <p>点击进入学生登录页面</p>
        </div>
    </a>

    <a href="teacher/login.jsp" style="text-decoration: none;">
        <div class="card">
            <h3>我是教师</h3>
            <p>点击进入教师登录页面</p>
        </div>
    </a>

    <div class="footer">
        <p>没有账户？<a href="signup.jsp">立即注册</a></p>
    </div>
</div>
</body>
</html>
