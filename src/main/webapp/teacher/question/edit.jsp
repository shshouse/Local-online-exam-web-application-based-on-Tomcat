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
    body {
      font-family: "Segoe UI", sans-serif;
      padding: 20px;
      background-color: #f4f6f8;
    }
    label {
      font-weight: bold;
      display: block;
      margin-top: 10px;
    }
    input[type="number"], select, textarea {
      width: 100%;
      padding: 8px;
      margin-top: 5px;
      border-radius: 4px;
      border: 1px solid #ccc;
    }
    .btn {
      margin-top: 15px;
      padding: 10px 15px;
      background-color: #007bff;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
    .btn:hover {
      background-color: #0056b3;
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