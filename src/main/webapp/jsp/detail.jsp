<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    // 检查用户是否已登录
    if(session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>${document.title}</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Microsoft YaHei', sans-serif;
            background-color: #f8fafc;
            color: #1a202c;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .document-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 15px;
            color: #1a202c;
        }

        .document-meta {
            color: #666;
            font-size: 14px;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #e2e8f0;
        }

        .document-content {
            line-height: 1.6;
            color: #1a202c;
            white-space: pre-wrap;
        }

        .back-btn {
            background-color: #909399;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 20px;
        }

        .back-btn:hover {
            background-color: #787a7d;
        }
    </style>
</head>
<body>
<div class="container">
    <h2 class="document-title">${document.title}</h2>
    <div class="document-meta">
        ${document.type} ${document.secondaryCategory} ${document.tertiaryCategory} · ${document.drafter} ·
        <fmt:formatDate value="${document.createTime}" pattern="yyyy-MM-dd HH:mm:ss" />
    </div>
    <div class="document-content">${document.content}</div>
    <button class="back-btn" onclick="history.back()">返回</button>
</div>
</body>
</html>
