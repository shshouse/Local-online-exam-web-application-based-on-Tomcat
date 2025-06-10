<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.example.blog.model.Question" %>
<%@ page import="com.example.blog.dao.QuestionDao" %>

<%
  String idStr = request.getParameter("id");
  if (idStr == null || idStr.isEmpty()) {
    response.sendRedirect("list.jsp");
    return;
  }

  int questionId;
  try {
    questionId = Integer.parseInt(idStr);
  } catch (NumberFormatException e) {
    response.sendRedirect("list.jsp");
    return;
  }

  QuestionDao questionDao = new QuestionDao();
  Question question = questionDao.getQuestionById(questionId);

  if (question == null) {
    response.sendRedirect("list.jsp");
    return;
  }
%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>编辑题目 - 教师端</title>
  <style>
    * {
      box-sizing: border-box;
    }

    body {
      font-family: "Microsoft YaHei", "Segoe UI", sans-serif;
      background-color: #f4f6f8;
      margin: 0;
      padding: 20px;
    }

    .container {
      max-width: 800px;
      margin: 0 auto;
      background-color: #ffffff;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    h2 {
      color: #007bff;
      text-align: center;
      margin-bottom: 20px;
    }

    form {
      display: flex;
      flex-direction: column;
    }

    label {
      font-weight: bold;
      margin-top: 15px;
      margin-bottom: 5px;
      color: #333;
    }

    select,
    textarea,
    input[type="text"],
    input[type="number"] {
      width: 100%;
      padding: 10px 12px;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 14px;
      resize: vertical;
      transition: border-color 0.3s ease;
    }

    select:focus,
    textarea:focus,
    input[type="text"]:focus,
    input[type="number"]:focus {
      border-color: #007bff;
      outline: none;
      box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.2);
    }

    textarea {
      height: 100px;
    }

    .btn-container {
      display: flex;
      justify-content: center;
      margin-top: 25px;
    }

    .btn {
      padding: 10px 20px;
      background-color: #007bff;
      color: white;
      border: none;
      border-radius: 6px;
      font-size: 16px;
      font-weight: bold;
      cursor: pointer;
      transition: background-color 0.3s ease, transform 0.2s ease;
    }

    .btn:hover {
      background-color: #0056b3;
      transform: translateY(-2px);
    }

    .btn:active {
      transform: translateY(0);
    }

    .form-group {
      flex: 1;
    }

    @media (max-width: 600px) {
      .container {
        padding: 20px;
      }

      .btn {
        width: 100%;
      }
    }
  </style>

</head>
<body>

<h2>编辑题目</h2>

<form action="${pageContext.request.contextPath}/teacher/question/update" method="post">
  <input type="hidden" name="id" value="<%= question.getId() %>">

  <label for="typeSelect">题目类型：</label>
  <select id="typeSelect" name="type">
    <option value="1" <%= question.getType() == 1 ? "selected" : "" %>>单选题</option>
    <option value="2" <%= question.getType() == 2 ? "selected" : "" %>>多选题</option>
    <option value="3" <%= question.getType() == 3 ? "selected" : "" %>>填空题</option>
    <option value="4" <%= question.getType() == 4 ? "selected" : "" %>>大题</option>
  </select>

  <label for="title">题目内容：</label>
  <textarea id="title" name="title" rows="5" required><%= question.getTitle() %></textarea>

  <div id="optionsDiv" style="display: <%= (question.getType() == 1 || question.getType() == 2) ? "block" : "none" %>;">
    <label for="options">选项（每行一个）：</label>
    <textarea id="options" name="options" rows="6"><%= question.getOptions() != null ? question.getOptions() : "" %></textarea>
  </div>

  <label for="answer">正确答案：</label>
  <input type="text" id="answer" name="answer" value="<%= question.getAnswer() %>" size="60" required />

  <label for="score">分值：</label>
  <input type="number" id="score" name="score" step="0.5" min="0" max="100" value="<%= question.getScore() %>" />

  <button type="submit" class="btn">保存修改</button>
</form>

<script>
  document.getElementById("typeSelect").addEventListener("change", function () {
    const optionsDiv = document.getElementById("optionsDiv");
    const selectedType = parseInt(this.value);

    if (selectedType === 1 || selectedType === 2) {
      optionsDiv.style.display = "block";
    } else {
      optionsDiv.style.display = "none";
    }
  });
</script>

</body>
</html>