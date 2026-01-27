<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <title>野猪佩奇</title>
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
        }

        /* 左侧导航栏 */
        .sidebar {
            width: 13%;
            height: 100vh;
            background-color: #001529;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 99;
            border-right: 1px solid #e2e8f0;
            box-shadow: 0 2px 8px #409eff;
        }

        .sidebar-header {
            padding: 20px 15px;
            text-align: center;
            font-weight: bold;
            font-size: 18px;
            color: #1a202c;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }



        {
            list-style: none;
            padding: 0;
        }

        .sidebar-menu li {
            margin: 0;
        }

        .sidebar-menu a {
            display: flex;
            align-items: center;
            padding: 14px 20px;
            color: #4a5568;
            text-decoration: none;
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
            gap: 10px; /* 增加图标与文字间距 */
        }

        .sidebar-menu a:hover,
        .sidebar-menu a.active {
            background-color: #409eff;
            color: white;
            border-left-color: #409eff;
        }

        /* 固定头部 - 调整右侧内容布局 */
        .fixed-header {
            position: fixed;
            top: 0;
            left: 208px;
            right: 20px;
            background-color: white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            padding: 15px 20px;
            z-index: 100;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #e2e8f0;
            border-radius: 0 0 6px 6px;
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 15px; /* 增加间距 */
        }

        .header-left h2 {
            font-size: 18px;
            margin: 0;
            color: #1a202c;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 14px;
        }

        .avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background-color: #667eea;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 14px;
        }

        .weather-info {
            color: #666;
            font-size: 14px;
            margin: 0;
        }

        .music-player {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            color: #666;
            font-size: 14px;
        }

        /* 主内容区 */
        .main-content {
            margin-top: 32px;
            margin-left: 187px;
            padding: 20px;
            display: flex;
            gap: 20px;
        }

        /* 右侧面板 - 固定位置 */
        .right-panel {
            width: 300px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            padding: 15px;
            position: fixed;
            top: 70px; /* 起始位置，避开固定头部 */
            right: 20px;
            z-index: 98;
            height: calc(100vh - 70px); /* 占满剩余高度 */
            overflow-y: auto; /* 启用滚动条 */
        }

        .section-title {
            font-weight: 600;
            color: #1a202c;
            margin-bottom: 12px;
            font-size: 16px;
        }

        .quick-access-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 12px;
            margin-bottom: 20px;
        }

        .quick-item-card {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 12px;
            border-radius: 6px;
            background: #f8fafc;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
        }

        .quick-item-card:hover {
            background: #edf2f7;
        }

        .quick-item-icon {
            width: 24px;
            height: 24px;
            margin-bottom: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            color: #4a5568;
        }

        .quick-item-text {
            font-size: 12px;
            color: #4a5568;
            line-height: 1.4;
        }

        .notifications {
            margin-top: 20px;
        }

        .notification-item {
            display: flex;
            gap: 12px;
            padding: 12px 0;
            border-bottom: 1px solid #e2e8f0;
        }

        .notification-item:last-child {
            border-bottom: none;
        }

        .notification-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background-color: #cbd5e1;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            color: #475569;
            flex-shrink: 0;
        }

        .notification-content {
            flex: 1;
        }

        .notification-title {
            font-weight: 600;
            color: #1a202c;
            margin-bottom: 4px;
        }

        .notification-date {
            font-size: 12px;
            color: #718096;
        }

        /* 内容区域 - 卡片列表 */
        .project-cards {
            display: flex;
            flex-direction: column;
            gap: 10px;
            width: 1000px;
            margin-top: 20px;
        }

        .card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            padding: 16px;
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-3px);
        }

        .card-title {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 8px;
            color: #1a202c;
        }

        .card-desc {
            color: #666;
            font-size: 14px;
            margin-bottom: 6px;
        }

        .card-date {
            color: #999;
            font-size: 12px;
        }

        /* 分页样式 */
        .pagination {
            display: flex;
            justify-content: center;
            gap: 8px;
            margin-top: 20px;
            padding: 10px 0;
        }

        .pagination-btn {
            padding: 6px 12px;
            border: 1px solid #d1d5da;
            background-color: white;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .pagination-btn:hover {
            background-color: #f3f4f6;
        }

        .pagination-btn.active {
            background-color: #3b82f6;
            color: white;
            border-color: #3b82f6;
        }

        .pagination-btn.disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

    </style>
</head>
<body>

<script>
    // 为"起草文件"项添加点击事件
    document.addEventListener('DOMContentLoaded', function() {
        const quickItems = document.querySelectorAll('.quick-item-card');

        quickItems.forEach(item => {
            const icon = item.querySelector('.quick-item-icon').textContent;
            if (icon === '📡') { // 起草文件的图标
                item.addEventListener('click', function() {
                    window.location.href = '${pageContext.request.contextPath}/jsp/create.jsp';
                });
            }
        });
    });
</script>


<!-- 左侧导航栏 -->
<div class="sidebar">
    <div class="sidebar-header" style="color: white">
        <span>🐶</span>
        <div>天地不仁，<p/>以万物为小狗！</div>
    </div>
    <ul class="sidebar-menu">
        <li><a href="#" class="active"><span>🏠</span>首页</a></li>
        <li><a href="#"><span>📝</span>我的随笔</a></li>
        <li><a href="#"><span>🖼️</span>我的图片</a></li>
        <li><a href="#"><span>⭐</span>我的收藏</a></li>
        <li><a href="#"><span>💎</span>我的宝贝</a></li>
        <li><a href="#"><span>💬</span>留言板</a></li>
        <li><a href="#"><span>📧</span>联系我?</a></li>
    </ul>
</div>

<!-- 固定头部 -->
<div class="fixed-header">
    <div class="header-left">
        <div class="user-info">
            <div class="avatar">Y</div>
            <span>你好 野猪佩奇 祝你开心每一天!</span>
        </div>
    </div>

    <div class="header-right">
        <div class="music-player">
            <span>🎵</span>
            <span>背景音乐</span>
        </div>
        <div class="weather-info">今日晴，20°C - 32°C!</div>
    </div>
</div>

<!-- 主内容区 -->
<div class="main-content">
    <!-- 项目卡片 -->
    <div class="project-cards">
        <c:forEach items="${documents}" var="document">
            <div class="card" onclick="viewDocument('${document.uuid}')">
                <div class="card-title">${document.title}</div>
                <div class="card-desc" title="${document.content}">${fn:substring(document.content, 0, Math.min(document.content.length(), 100))}${document.content.length() > 100 ? '...' : ''}</div>
                <div class="card-date">
                        ${document.type} ${document.secondaryCategory} ${document.tertiaryCategory} · ${document.drafter} ·
                    <fmt:formatDate value="${document.createTime}" pattern="yyyy-MM-dd HH:mm:ss" />
                </div>
            </div>
        </c:forEach>

        <!-- 分页组件 -->
        <div class="pagination">
            <c:choose>
                <c:when test="${currentPage <= 1}">
                    <button class="pagination-btn disabled">上一页</button>
                </c:when>
                <c:otherwise>
                    <button class="pagination-btn" onclick="changePage(${currentPage - 1})">上一页</button>
                </c:otherwise>
            </c:choose>

            <c:forEach begin="1" end="${totalPages}" var="i">
                <c:choose>
                    <c:when test="${i == currentPage}">
                        <button class="pagination-btn active">${i}</button>
                    </c:when>
                    <c:otherwise>
                        <button class="pagination-btn" onclick="changePage(${i})">${i}</button>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:choose>
                <c:when test="${currentPage >= totalPages}">
                    <button class="pagination-btn disabled">下一页</button>
                </c:when>
                <c:otherwise>
                    <button class="pagination-btn" onclick="changePage(${currentPage + 1})">下一页</button>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script>
    function viewDocument(uuid) {
        window.location.href = '${pageContext.request.contextPath}/document/detail?uuid=' + uuid;
    }

    function changePage(page) {
        window.location.href = '?page=' + page;
    }
</script>

    <!-- 右侧面板 -->
    <div class="right-panel">
        <div class="section-title">快捷入口</div>
        <div class="quick-access-grid">
            <div class="quick-item-card">
                <div class="quick-item-icon">🏠</div>
                <div class="quick-item-text">我的github</div>
            </div>
            <div class="quick-item-card">
                <div class="quick-item-icon">🛒</div>
                <div class="quick-item-text">商城中心</div>
            </div>
            <div class="quick-item-card">
                <div class="quick-item-icon">🤖</div>
                <div class="quick-item-text">AI 大模型</div>
            </div>
            <div class="quick-item-card">
                <div class="quick-item-icon">📊</div>
                <div class="quick-item-text">ERP 系统</div>
            </div>
            <div class="quick-item-card">
                <div class="quick-item-icon">🤝</div>
                <div class="quick-item-text">CRM 系统</div>
            </div>
            <div class="quick-item-card">
                <div class="quick-item-icon">📡</div>
                <div class="quick-item-text">起草文件</div>
            </div>
        </div>

        <div class="section-title">通知公告</div>
        <div class="notifications">
            <div class="notification-item">
                <div class="notification-avatar">ℹ️</div>
                <div class="notification-content">
                    <div class="notification-title">技术兼容性：系统支持 JDK 8/17/21，Vue 2/3</div>
                    <div class="notification-date">2026-01-26</div>
                </div>
            </div>
            <div class="notification-item">
                <div class="notification-avatar">⚙️</div>
                <div class="notification-content">
                    <div class="notification-title">架构灵活性：后端提供 Spring Boot 2.7/3.2 + Cloud 双架构</div>
                    <div class="notification-date">2026-01-26</div>
                </div>
            </div>
            <div class="notification-item">
                <div class="notification-avatar">✅</div>
                <div class="notification-content">
                    <div class="notification-title">开源免授权：全部开源，个人与企业可 100% 直接使用，无需授权</div>
                    <div class="notification-date">2026-01-26</div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>




