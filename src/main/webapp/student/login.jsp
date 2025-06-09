<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>学生登录</title>
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

        .login-container {
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            padding: 40px 30px;
            width: 100%;
            max-width: 400px;
        }

        .login-container h2 {
            text-align: center;
            color: #333;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 6px;
            color: #555;
        }

        .form-group input[type="text"],
        .form-group input[type="password"] {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        .form-group input:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }

        .login-button {
            width: 100%;
            background-color: #007bff;
            color: white;
            padding: 12px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .login-button:hover {
            background-color: #0056b3;
        }

        .footer {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
            color: #777;
        }

        .footer a {
            color: #007bff;
            text-decoration: none;
        }

        .footer a:hover {
            text-decoration: underline;
        }

        .error-message {
            background-color: #fff3cd;
            color: #856404;
            padding: 12px;
            border-left: 4px solid #ffc107;
            border-radius: 5px;
            font-size: 14px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            text-align: center;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2>学生登录</h2>

    <!-- 错误提示 -->
    <% String error = request.getParameter("error"); %>
    <% if (error != null) { %>
    <div class="error-message">
        <% switch (error) {
            case "1": out.print("密码错误，请重新输入。"); break;
            case "2": out.print("该学号不存在，请检查输入。"); break;
            default: out.print("登录失败，请重试。");
        } %>
    </div>
    <% } %>


    <form action="${pageContext.request.contextPath}/student/login" method="post">
        <div class="form-group">
            <label for="studentId">学号</label>
            <input type="text" id="studentId" name="studentId" placeholder="请输入学号" required />
        </div>
        <div class="form-group">
            <label for="password">密码</label>
            <input type="password" id="password" name="password" placeholder="请输入密码" required />
        </div>

        <button type="submit" class="login-button">登录</button>
    </form>

    <div class="footer">
        <p><a href="../index.jsp">返回主页</a></p>
    </div>
</div>
</body>
</html>
