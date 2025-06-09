<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>用户注册</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body {
      font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      margin: 0;
      padding: 0;
      background: linear-gradient(135deg, #f2f2f2, #dcdcdc);
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .container {
      background-color: #ffffff;
      border-radius: 10px;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
      padding: 40px 30px;
      width: 100%;
      max-width: 500px;
    }

    .container h2 {
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
    .form-group input[type="password"],
    .form-group select {
      width: 100%;
      padding: 10px;
      border-radius: 5px;
      border: 1px solid #ccc;
      font-size: 14px;
    }

    .form-group input:focus,
    .form-group select:focus {
      border-color: #007bff;
      outline: none;
      box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
    }

    .submit-button {
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

    .submit-button:hover {
      background-color: #0056b3;
    }

    .error-message {
      color: red;
      font-size: 14px;
      text-align: center;
      margin-bottom: 15px;
    }
  </style>
</head>
<body>

<div class="container">
  <h2>用户注册</h2>

  <% String error = request.getParameter("error"); %>
  <% if (error != null && error.equals("1")) { %>
  <div class="error-message">注册失败，学号/工号已经注册过。</div>
  <% } %>

  <form action="${pageContext.request.contextPath}/register" method="post">
    <div class="form-group">
      <label for="studentName">姓名</label>
      <input type="text" id="studentName" name="username" placeholder="请输入您的姓名" required />
    </div>

    <div class="form-group">
      <label for="studentId">学号/工号</label>
      <input type="text" id="studentId" name="id" placeholder="请输入学号/工号" required />
    </div>

    <div class="form-group">
      <label for="password">密码</label>
      <input type="password" id="password" name="password" placeholder="请输入密码" required />
    </div>

    <div class="form-group">
      <label for="confirmPassword">确认密码</label>
      <input type="password" id="confirmPassword" name="confirmPassword" placeholder="请再次输入密码" required />
    </div>

    <div class="form-group">
      <label for="identity">身份</label>
      <select id="identity" name="identity">
        <option value="student">学生</option>
        <option value="teacher">教师</option>
      </select>
    </div>

    <button type="submit" class="submit-button">注册</button>
    <p style="text-align: center; margin-top: 15px;">
      已有账户？<a href="index.jsp">立即登录</a>
    </p>
  </form>
</div>

<script>
  document.querySelector("form").addEventListener("submit", function(e) {
    const password = document.getElementById("password").value;
    const confirmPassword = document.getElementById("confirmPassword").value;

    if (password !== confirmPassword) {
      e.preventDefault();
      alert("两次输入的密码不一致！");
    }
  });
</script>

</body>
</html>
