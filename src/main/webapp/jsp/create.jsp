<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <meta charset="UTF-8">
    <title>起草文件</title>
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
    <h2>起草文件</h2>
    <form id="documentForm" action="${pageContext.request.contextPath}/document/save" method="post">
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
                    <input type="text" id="draftTime" name="draftTime" value="<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date())%>" readonly class="readonly-field">
                </div>
            </div>
        </div>

        <div class="form-group">
            <label for="title">标题:</label>
            <input type="text" id="title" name="title" required>
        </div>

        <div class="form-row">
            <div class="form-col">
                <div class="form-group">
                    <label for="type">类型:</label>
                    <select id="type" name="type" required>
                        <option value="">请选择类型</option>
                        <option value="我的随笔">我的随笔</option>
                        <option value="我的图片">我的图片</option>
                        <option value="我的收藏">我的收藏</option>
                        <option value="我的宝贝">我的宝贝</option>
                    </select>
                </div>
            </div>
            <div class="form-col">
                <div class="form-group">
                    <label for="secondaryCategory">二级分类:</label>
                    <select id="secondaryCategory" name="secondaryCategory" required>
                        <option value="">请选择二级分类</option>
                        <option value="杂谈">杂谈</option>
                        <option value="奇闻异事">奇闻异事</option>
                        <option value="新闻">新闻</option>
                        <option value="焦点">焦点</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label for="tertiaryCategory">三级分类:</label>
            <select id="tertiaryCategory" name="tertiaryCategory" required>
                <option value="">请选择三级分类</option>
                <option value="新闻">新闻</option>
                <option value="焦点">焦点</option>
                <option value="评论">评论</option>
                <option value="分析">分析</option>
            </select>
        </div>

        <div class="form-group">
            <label for="content">内容:</label>
            <textarea id="content" name="content" placeholder="请输入内容..." required></textarea>
        </div>

        <div class="form-group">
            <button type="submit" class="btn">保存</button>
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
