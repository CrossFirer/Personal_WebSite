<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    // 检查用户是否已登录，如果没有则重定向到登录页面
    if(session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    // 调试输出，检查document对象是否存在
    Object documentObj = request.getAttribute("document");

    // 输出URL参数信息，用于调试
    String uuidParam = request.getParameter("uuid");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${document ne null ? "编辑文件" : "起草文件"}</title>
    <style>
        body {
            font-family: 'Microsoft YaHei', sans-serif;
            background-color: #f8fafc;
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
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #1a202c;
        }
        input[type="text"], textarea, select {
            width: 100%;
            padding: 10px;
            border: 1px solid #cbd5e0;
            border-radius: 4px;
            font-size: 14px;
        }
        textarea {
            min-height: 200px;
            resize: vertical;
        }
        .readonly-field {
            background-color: #f7fafc;
            cursor: not-allowed;
        }
        .btn {
            background-color: #409eff;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background-color: #337ecc;
        }
        .btn-back {
            background-color: #909399;
            margin-right: 10px;
        }
        .btn-back:hover {
            background-color: #787a7d;
        }
        .form-row {
            display: flex;
            gap: 20px;
        }
        .form-col {
            flex: 1;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>${document ne null ? "编辑文章" : "起草文章"}</h2>
    <form id="documentForm" action="${pageContext.request.contextPath}/document/save" method="post">
        <input type="hidden" id="uuid" name="uuid" value="${document ne null ? document.uuid : ''}">
        <div class="form-row">
            <div class="form-col">
                <div class="form-group">
                    <label for="drafter">起草人:</label>
                    <input type="text" id="drafter" name="drafter" value="${sessionScope.user.username}" readonly class="readonly-field">
                </div>
            </div>
            <div class="form-col">
                <div class="form-group">
                    <label for="draftTime">起草时间:</label>
                    <c:choose>
                        <c:when test="${document ne null}">
                            <input type="text" id="draftTime" name="draftTime" 
                                   value="<fmt:formatDate value='${document.createTime}' pattern='yyyy-MM-dd HH:mm:ss'/>" 
                                   readonly class="readonly-field">
                        </c:when>
                        <c:otherwise>
                            <input type="text" id="draftTime" name="draftTime" 
                                   value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date()) %>" 
                                   readonly class="readonly-field">
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label for="title">标题:</label>
            <input type="text" id="title" name="title" value="${document ne null ? document.title : ''}" required>
        </div>

        <div class="form-row">
            <div class="form-col">
                <div class="form-group">
                    <label for="type">类型:</label>
                    <select id="type" name="type" required>
                        <option value="">请选择类型</option>
                        <option value="我的随笔" ${document ne null && document.type == '我的随笔' ? 'selected' : ''}>我的随笔</option>
                        <option value="我的图片" ${document ne null && document.type == '我的图片' ? 'selected' : ''}>我的图片</option>
                        <option value="我的收藏" ${document ne null && document.type == '我的收藏' ? 'selected' : ''}>我的收藏</option>
                        <option value="我的宝贝" ${document ne null && document.type == '我的宝贝' ? 'selected' : ''}>我的宝贝</option>
                    </select>
                </div>
            </div>
            <div class="form-col">
                <div class="form-group">
                    <label for="secondaryCategory">二级分类:</label>
                    <select id="secondaryCategory" name="secondaryCategory" required>
                        <option value="">请选择二级分类</option>
                        <option value="杂谈" ${document ne null && document.secondaryCategory == '杂谈' ? 'selected' : ''}>杂谈</option>
                        <option value="奇闻异事" ${document ne null && document.secondaryCategory == '奇闻异事' ? 'selected' : ''}>奇闻异事</option>
                        <option value="新闻" ${document ne null && document.secondaryCategory == '新闻' ? 'selected' : ''}>新闻</option>
                        <option value="焦点" ${document ne null && document.secondaryCategory == '焦点' ? 'selected' : ''}>焦点</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label for="tertiaryCategory">三级分类:</label>
            <select id="tertiaryCategory" name="tertiaryCategory" required>
                <option value="">请选择三级分类</option>
                <option value="新闻" ${document ne null && document.tertiaryCategory == '新闻' ? 'selected' : ''}>新闻</option>
                <option value="焦点" ${document ne null && document.tertiaryCategory == '焦点' ? 'selected' : ''}>焦点</option>
                <option value="评论" ${document ne null && document.tertiaryCategory == '评论' ? 'selected' : ''}>评论</option>
                <option value="分析" ${document ne null && document.tertiaryCategory == '分析' ? 'selected' : ''}>分析</option>
            </select>
        </div>

        <div class="form-group">
            <label for="content">内容:</label>
            <textarea id="content" name="content" placeholder="请输入内容..." required>${document ne null ? document.content : ''}</textarea>
        </div>

        <div class="form-group">
            <button type="submit" class="btn">${document ne null ? "更新" : "保存"}</button>
            <button type="button" class="btn btn-back" onclick="history.back()">返回</button>
        </div>
    </form>
</div>

<script>
    document.getElementById('documentForm').addEventListener('submit', function(e) {
        e.preventDefault();

        // 收集表单数据并转换为 URL 编码格式
        const formData = new FormData(this);
        const params = new URLSearchParams();
        for (const [key, value] of formData.entries()) {
            params.append(key, value);
        }

        fetch('${pageContext.request.contextPath}/document/save', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: params.toString()
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert(data.message);
                    window.location.href = '${pageContext.request.contextPath}/';
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('提交失败，请重试');
            });
    });

</script>
</body>
</html>