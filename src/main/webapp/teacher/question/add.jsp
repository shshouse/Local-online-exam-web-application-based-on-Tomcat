<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>发布新题目 - 教师端</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #f6d365, #fda085);
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 20px;
    }

    .form-container {
      background-color: #ffffff;
      border-radius: 12px;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
      padding: 30px 25px;
      width: 100%;
      max-width: 600px;
    }

    .form-container h2 {
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

    .form-group select,
    .form-group input[type="number"],
    .form-group input[type="text"],
    .form-group textarea {
      width: 100%;
      padding: 10px;
      border-radius: 5px;
      border: 1px solid #ccc;
      font-size: 14px;
      resize: vertical;
    }

    .form-group input:focus,
    .form-group select:focus,
    .form-group textarea:focus {
      border-color: #007bff;
      outline: none;
      box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
    }

    .btn {
      display: inline-block;
      width: 100%;
      padding: 12px;
      font-size: 16px;
      font-weight: bold;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s ease;
      color: white;
      text-align: center;
      text-decoration: none;
    }

    .btn-primary {
      background-color: #007bff;
    }

    .btn-primary:hover {
      background-color: #0056b3;
    }

    .btn-success {
      background-color: #28a745;
    }

    .btn-success:hover {
      background-color: #218838;
    }

    .footer {
      margin-top: 20px;
      text-align: center;
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

<div class="form-container">
  <h2>发布新题目</h2>

  <form action="${pageContext.request.contextPath}/teacher/question/publish" method="post">
    <div class="form-group">
      <label for="typeSelect">题目类型：</label>
      <select id="typeSelect" name="type" class="form-control">
        <option value="1">单选题</option>
        <option value="2">多选题</option>
        <option value="3">填空题</option>
        <option value="4">大题</option>
      </select>
    </div>

    <div class="form-group">
      <label for="title">题目内容：</label>
      <textarea id="title" name="title" rows="5" required></textarea>
    </div>

    <div class="form-group" id="optionsDiv" style="display: none;">
      <label for="options">选项（每行一个）：</label>
      <textarea id="options" name="options" rows="6"></textarea>
    </div>

    <div class="form-group">
      <label for="answer">正确答案：</label>
      <input type="text" id="answer" name="answer" placeholder="如：A / AB / 北京 / 自由作答..." required />
    </div>

    <div class="form-group">
      <label for="score">分值：</label>
      <input type="number" id="score" name="score" step="0.5" min="0" max="100" value="5.0" />
    </div>

    <button type="submit" class="btn btn-primary">发布题目</button>
  </form>

  <div class="footer">
    <p><a href="../dashboard.jsp">返回题目列表</a></p>
  </div>
</div>

<script>
  document.getElementById("typeSelect").addEventListener("change", function () {
    const optionsDiv = document.getElementById("optionsDiv");
    const selectedType = this.value;

    if (selectedType === "1" || selectedType === "2") {
      optionsDiv.style.display = "block";
    } else {
      optionsDiv.style.display = "none";
    }
  });
</script>

</body>
</html>
