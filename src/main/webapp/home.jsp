<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>个人网站</title>
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
            background-color: #f8fafc; /* 改为与页面一致的浅色背景 */
            position: fixed;
            top: 0;
            left: 0;
            z-index: 99;
            border-right: 1px solid #e2e8f0;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05); /* 添加轻微阴影 */
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

        .sidebar-menu {
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
            background-color: #edf2f7; /* 鼠标悬停时的背景色 */
            color: #2d3748;
            border-left-color: #409eff; /* 添加左边框高亮 */
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

        .music-controls {
            display: flex;
            align-items: center;
            gap: 4px;
        }
        
        .music-controls button {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 16px;
            color: #666;
            padding: 2px;
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 4px;
        }
        
        .music-controls button:hover {
            color: #409eff;
            background-color: #f5f5f5;
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
            white-space: nowrap;          /* 不换行 */
            overflow: hidden;             /* 隐藏溢出内容 */
            text-overflow: ellipsis;      /* 显示省略号 */
            max-width: 100%;              /* 设置最大宽度 */
        }

        .card-desc {
            color: #666;
            font-size: 14px;
            margin-bottom: 6px;
            white-space: nowrap;          /* 不换行 */
            overflow: hidden;             /* 隐藏溢出内容 */
            text-overflow: ellipsis;      /* 显示省略号 */
            max-width: 100%;              /* 设置最大宽度 */
        }

        .card-date {
            color: #999;
            font-size: 12px;
        }
        
        /* 为文档卡片添加的操作按钮样式 */
        .actions {
            float: right;
        }
        
        .edit-btn, .delete-btn {
            background: none;
            border: none;
            font-size: 16px;
            cursor: pointer;
            margin-left: 8px;
            padding: 2px;
        }
        
        .edit-btn:hover, .delete-btn:hover {
            opacity: 0.7;
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
                    window.location.href = window.location.origin + '/jsp/create.jsp';
                });
            }
        });
    });
</script>


<!-- 左侧导航栏 -->
<div class="sidebar">
    <div class="sidebar-header" style="color: #1a202c">
        <span>🐶</span>
        <div>天地不仁，<p/>以万物为小狗！</div>
    </div>
    <ul class="sidebar-menu">
        <li><a href="#" onclick="loadDocumentsByType('', event)" class="active"><span>🏠</span>首页</a></li>
        <li><a href="#" onclick="loadDocumentsByType('我的随笔', event)"><span>📝</span>我的随笔</a></li>
        <li><a href="#" onclick="loadDocumentsByType('我的图片', event)"><span>🖼️</span>我的图片</a></li>
        <li><a href="#" onclick="loadDocumentsByType('我的收藏', event)"><span>⭐</span>我的收藏</a></li>
        <li><a href="#" onclick="loadDocumentsByType('我的宝贝', event)"><span>💎</span>我的宝贝</a></li>
        <li><a href="#" onclick="loadDocumentsByType('留言板', event)"><span>💬</span>留言板</a></li>
        <li><a href="#" onclick="loadDocumentsByType('联系我', event)"><span>📧</span>联系我?</a></li>
        <c:if test="${sessionScope.user.username ne null}">
            <li><a href="#" onclick="loadDocumentsByDrafter(event)"><span>📤</span>我的发布</a></li>
        </c:if>
    </ul>
</div>

<!-- 固定头部 -->
<div class="fixed-header">
    <div class="header-left">
        <div class="user-info">
            <div class="avatar">Y</div>
            <c:choose>
                <c:when test="${sessionScope.user.username ne null}">
                    <span>你好 ${sessionScope.user.username} 祝你开心每一天!</span>
                </c:when>
                <c:otherwise>
                    <span><a href="${pageContext.request.contextPath}/login" style="color: #409eff;">请登录</a> 或 <a href="${pageContext.request.contextPath}/register" style="color: #409eff;">注册</a> 后发布文章</span>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="header-right">
        <div class="music-player">
            <span id="musicToggle" title="点击播放/暂停">🎵</span>
            <span id="musicStatus">奢香夫人</span>
            <div class="music-controls">
                <button id="prevBtn" title="上一首" disabled>⏮</button>
                <button id="playPauseBtn" title="播放/暂停">▶</button>
                <button id="nextBtn" title="下一首" disabled>⏭</button>
            </div>
            <audio id="backgroundMusic" preload="auto" style="display: none;">
                <source id="musicSource" src="${pageContext.request.contextPath}/music/奢香夫人.mp3" type="audio/mpeg">
                您的浏览器不支持音频播放
            </audio>
        </div>
        <div class="weather-info">
            天气信息加载中...
        </div>
    </div>
</div>

<!-- 主内容区 -->
<div class="main-content">
    <!-- 项目卡片 -->
    <div class="project-cards">
        <c:forEach items="${documents}" var="document">
            <div class="card" onclick="viewDocument('${document.uuid}')">
                <div class="card-title" title="${document.title}">${document.title}</div>
                <div class="card-desc" title="${document.content}">${document.content}</div>
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
        window.location.href = window.location.origin + '/document/view?uuid=' + uuid;
    }

    function changePage(page) {
        window.location.href = window.location.origin + '/index?page=' + page;
    }
    
    function loadDocumentsByType(type, event) {
        // 阻止默认的链接跳转行为
        if(event) {
            event.preventDefault();
        }
        
        // 清空当前内容
        const cardsContainer = document.querySelector('.project-cards');
        cardsContainer.innerHTML = '';
        
        // 更新导航栏选中状态
        document.querySelectorAll('.sidebar-menu a').forEach(link => {
            link.classList.remove('active');
        });
        
        // 确保点击的是链接本身或者找到其父级链接
        let clickedElement = event ? event.target : null;
        while (clickedElement && clickedElement.tagName !== 'A') {
            clickedElement = clickedElement.parentElement;
        }
        if (clickedElement) {
            clickedElement.classList.add('active');
        }
        
        // 如果是首页，重新加载所有文档
        if (!type || type.trim() === '') {
            window.location.href = window.location.origin + '/index';
            return;
        }
        
        // 发送AJAX请求获取指定类型的数据
        fetch(`${window.location.origin}${pageContext.request.contextPath}/type/` + encodeURIComponent(type))
            .then(response => {
                // 检查响应状态
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    const documents = data.documents || [];
                    
                    // 清空现有内容
                    cardsContainer.innerHTML = '';
                    
                    // 生成文档卡片
                    documents.forEach(doc => {  // 将参数名从document改为doc，避免与全局document对象混淆
                        const card = document.createElement('div');
                        card.className = 'card';
                        
                        // 使用箭头函数并正确传递uuid
                        card.onclick = () => viewDocument(doc.uuid);
                        
                        // 创建卡片元素
                        const titleDiv = document.createElement('div');
                        titleDiv.className = 'card-title';
                        titleDiv.title = doc.title || '';
                        titleDiv.textContent = doc.title || '';
                        
                        const descDiv = document.createElement('div');
                        descDiv.className = 'card-desc';
                        descDiv.title = doc.content || '';
                        descDiv.textContent = doc.content || '';
                        
                        const dateDiv = document.createElement('div');
                        dateDiv.className = 'card-date';
                        
                        // 安全地访问对象属性并格式化日期
                        const docType = doc.type || '';
                        const secondaryCat = doc.secondaryCategory || '';
                        const tertiaryCat = doc.tertiaryCategory || '';
                        const drafter = doc.drafter || '';
                        const createTime = doc.createTime;
                        
                        let formattedDate = '';
                        if (createTime) {
                            // 如果是ISO格式的日期字符串或Date对象，直接格式化
                            if (typeof createTime === 'string') {
                                try {
                                    // 尝试解析Java Date.toString()格式的日期
                                    const date = new Date(createTime);
                                    if (!isNaN(date.getTime())) {
                                        formattedDate = formatDate(date);
                                    } else {
                                        formattedDate = createTime; // 如果解析失败，使用原始值
                                    }
                                } catch (e) {
                                    formattedDate = createTime; // 使用原始值
                                }
                            } else if (createTime instanceof Date) {
                                formattedDate = formatDate(createTime);
                            } else {
                                formattedDate = String(createTime);
                            }
                        }
                        
                        dateDiv.textContent = 
                            (docType ? docType + ' ' : '') + 
                            (secondaryCat ? secondaryCat + ' ' : '') + 
                            (tertiaryCat ? tertiaryCat + ' ' : '') + 
                            '· ' + drafter + ' · ' + formattedDate;
                        
                        card.appendChild(titleDiv);
                        card.appendChild(descDiv);
                        card.appendChild(dateDiv);
                        
                        cardsContainer.appendChild(card);
                    });
                    
                    // 如果没有找到文档，显示提示信息
                    if (documents.length === 0) {
                        const noDataCard = document.createElement('div');
                        noDataCard.className = 'card';
                        noDataCard.innerHTML = '<div class="card-title">没有找到' + type + '相关的文档</div>';
                        cardsContainer.appendChild(noDataCard);
                    }
                } else {
                    console.error('加载数据失败:', data.message || '未知错误');
                    alert('加载数据失败: ' + (data.message || '未知错误'));
                }
            })
            .catch(error => {
                console.error('请求错误详情:', error);
                alert('请求发生错误，请稍后再试。错误详情: ' + error.message);
            });
    }
    
    function loadDocumentsByDrafter(event) {
        // 阻止默认的链接跳转行为
        if(event) {
            event.preventDefault();
        }
        
        // 清空当前内容
        const cardsContainer = document.querySelector('.project-cards');
        cardsContainer.innerHTML = '';
        
        // 更新导航栏选中状态
        document.querySelectorAll('.sidebar-menu a').forEach(link => {
            link.classList.remove('active');
        });
        
        // 确保点击的是链接本身或者找到其父级链接
        let clickedElement = event ? event.target : null;
        while (clickedElement && clickedElement.tagName !== 'A') {
            clickedElement = clickedElement.parentElement;
        }
        if (clickedElement) {
            clickedElement.classList.add('active');
        }
        
        // 发送AJAX请求获取当前用户起草的文档
        fetch(`${window.location.origin}${pageContext.request.contextPath}/drafter/documents`)
            .then(response => {
                // 检查响应状态
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    const documents = data.documents || [];
                    
                    // 清空现有内容
                    cardsContainer.innerHTML = '';
                    
                    // 生成文档卡片
                    documents.forEach(doc => {
                        const card = document.createElement('div');
                        card.className = 'card';
                        
                        // 使用箭头函数并正确传递uuid
                        card.onclick = () => viewDocument(doc.uuid);
                        
                        // 创建卡片元素
                        const titleDiv = document.createElement('div');
                        titleDiv.className = 'card-title';
                        // 限制标题长度，添加省略号
                        const shortTitle = (doc.title && doc.title.length > 50) ? doc.title.substring(0, 50) + '...' : doc.title || '';
                        titleDiv.title = doc.title || '';
                        titleDiv.innerHTML = shortTitle + ' ' + 
                            '<span class="actions">' +
                            '<button class="edit-btn" onclick="editDocument(\'' + doc.uuid + '\', event)">✏️</button>' +
                            '<button class="delete-btn" onclick="deleteDocument(\'' + doc.uuid + '\', event)">🗑️</button>' +
                            '</span>';
                        
                        const descDiv = document.createElement('div');
                        descDiv.className = 'card-desc';
                        descDiv.title = doc.content || '';
                        descDiv.textContent = doc.content || '';
                        
                        const dateDiv = document.createElement('div');
                        dateDiv.className = 'card-date';
                        
                        // 安全地访问对象属性并格式化日期
                        const docType = doc.type || '';
                        const secondaryCat = doc.secondaryCategory || '';
                        const tertiaryCat = doc.tertiaryCategory || '';
                        const drafter = doc.drafter || '';
                        const createTime = doc.createTime;
                        
                        let formattedDate = '';
                        if (createTime) {
                            // 如果是ISO格式的日期字符串或Date对象，直接格式化
                            if (typeof createTime === 'string') {
                                try {
                                    // 尝试解析Java Date.toString()格式的日期
                                    const date = new Date(createTime);
                                    if (!isNaN(date.getTime())) {
                                        formattedDate = formatDate(date);
                                    } else {
                                        formattedDate = createTime; // 如果解析失败，使用原始值
                                    }
                                } catch (e) {
                                    formattedDate = createTime; // 使用原始值
                                }
                            } else if (createTime instanceof Date) {
                                formattedDate = formatDate(createTime);
                            } else {
                                formattedDate = String(createTime);
                            }
                        }
                        
                        dateDiv.textContent = 
                            (docType ? docType + ' ' : '') + 
                            (secondaryCat ? secondaryCat + ' ' : '') + 
                            (tertiaryCat ? tertiaryCat + ' ' : '') + 
                            '· ' + drafter + ' · ' + formattedDate;
                        
                        card.appendChild(titleDiv);
                        card.appendChild(descDiv);
                        card.appendChild(dateDiv);
                        
                        cardsContainer.appendChild(card);
                    });
                    
                    // 如果没有找到文档，显示提示信息
                    if (documents.length === 0) {
                        const noDataCard = document.createElement('div');
                        noDataCard.className = 'card';
                        noDataCard.innerHTML = '<div class="card-title">您还没有发布任何文档</div>';
                        cardsContainer.appendChild(noDataCard);
                    }
                } else {
                    console.error('加载数据失败:', data.message || '未知错误');
                    alert('加载数据失败: ' + (data.message || '未知错误'));
                }
            })
            .catch(error => {
                console.error('请求错误详情:', error);
                alert('请求发生错误，请稍后再试。错误详情: ' + error.message);
            });
    }
    
    function formatDate(dateString) {
        const date = new Date(dateString);
        return date.toLocaleString('zh-CN', { 
            year: 'numeric', 
            month: '2-digit', 
            day: '2-digit', 
            hour: '2-digit', 
            minute: '2-digit', 
            second: '2-digit' 
        }).replace(/\//g, '-');
    }
    
    function editDocument(uuid, event) {
        // 阻止冒泡，避免触发卡片点击事件
        event.stopPropagation();
        // 跳转到创建页面并传递UUID进行编辑
        window.location.href = '${pageContext.request.contextPath}/document/form?uuid=' + uuid;
    }
    
    function deleteDocument(uuid, event) {
        // 阻止冒泡，避免触发卡片点击事件
        event.stopPropagation();
        
        if (confirm('确定要删除这篇文档吗？')) {
            fetch('${pageContext.request.contextPath}/document/delete', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'uuid=' + encodeURIComponent(uuid)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('删除成功');
                    // 重新加载当前页面的数据
                    loadDocumentsByDrafter(null);
                } else {
                    alert('删除失败: ' + data.message);
                }
            })
            .catch(error => {
                console.error('删除错误:', error);
                alert('删除时发生错误，请稍后再试');
            });
        }
    }
    
    // 页面加载完成后获取天气信息
    document.addEventListener('DOMContentLoaded', function() {
        updateWeatherInfo();
        // 每10分钟更新一次天气信息
        setInterval(updateWeatherInfo, 600000); 
        
        // 初始化背景音乐播放器
        initMusicPlayer();
    });
    
    function initMusicPlayer() {
        const audio = document.getElementById('backgroundMusic');
        const musicSource = document.getElementById('musicSource');
        const musicToggle = document.getElementById('musicToggle');
        const musicStatus = document.getElementById('musicStatus');
        const playPauseBtn = document.getElementById('playPauseBtn');
        const prevBtn = document.getElementById('prevBtn');
        const nextBtn = document.getElementById('nextBtn');
        
        // 尝试多种可能的路径
        const musicPath = `${pageContext.request.contextPath}/music/%E5%A5%A2%E9%A6%99%E5%A4%AB%E4%BA%BA.mp3`; // URL编码后的路径
        
        // 更新音乐信息显示
        function updateMusicDisplay() {
            musicStatus.textContent = "奢香夫人";
        }
        
        // 预加载音频文件
        function preloadAudio() {
            // 创建一个临时的XMLHttpRequest来检测文件是否存在
            const xhr = new XMLHttpRequest();
            xhr.open('HEAD', musicPath, true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        console.log("音频文件存在，状态码:", xhr.status);
                        // 文件存在，设置音频源
                        musicSource.src = musicPath;
                        audio.load();
                        updateMusicDisplay();
                    } else {
                        console.error("音频文件不存在，状态码:", xhr.status);
                        musicStatus.textContent = `音频文件未找到 (状态: ${xhr.status})，路径: ${musicPath}`;
                        // 尝试其他可能的路径
                        fallbackToAlternativePaths();
                    }
                }
            };
            xhr.send();
        }
        
        // 备用路径尝试
        function fallbackToAlternativePaths() {
            const alternativePaths = [
                `${pageContext.request.contextPath}/music/奢香夫人.mp3`,
                `music/奢香夫人.mp3`,
                `/music/奢香夫人.mp3`
            ];
            
            let attempt = 0;
            function tryPath() {
                if (attempt >= alternativePaths.length) {
                    musicStatus.textContent = "所有音频路径都不可用，请检查服务器配置和文件位置";
                    return;
                }
                
                const path = alternativePaths[attempt];
                console.log("尝试备用路径:", path);
                
                const xhr = new XMLHttpRequest();
                xhr.open('HEAD', path, true);
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4) {
                        if (xhr.status === 200) {
                            console.log("找到音频文件在路径:", path);
                            musicSource.src = path;
                            audio.load();
                            updateMusicDisplay();
                        } else {
                            console.log(`路径 ${path} 不存在，状态码: ${xhr.status}`);
                            attempt++;
                            tryPath();
                        }
                    }
                };
                xhr.send();
            }
            
            tryPath();
        }
        
        // 播放/暂停功能
        function togglePlayPause() {
            // 确保音频已加载
            if (audio.readyState >= 1) { // HAVE_METADATA
                if (audio.paused) {
                    audio.play()
                        .then(() => {
                            playPauseBtn.textContent = '⏸'; // 暂停图标
                            musicStatus.textContent = "奢香夫人 (播放中...)";
                        })
                        .catch(e => {
                            console.error('播放失败:', e);
                            musicStatus.textContent = `播放失败: ${e.name} - ${e.message}`;
                            
                            // 如果是自动播放策略错误，提示用户交互
                            if (e.name === 'NotAllowedError') {
                                musicStatus.textContent = "请先与页面交互再播放音乐";
                            }
                        });
                } else {
                    audio.pause();
                    playPauseBtn.textContent = '▶'; // 播放图标
                    musicStatus.textContent = "奢香夫人 (已暂停)";
                }
            } else {
                musicStatus.textContent = "音频尚未加载，请稍候...";
            }
        }
        
        // 监听音频播放事件
        audio.addEventListener('play', function() {
            playPauseBtn.textContent = '⏸';
            musicStatus.textContent = "奢香夫人 (播放中...)";
        });
        
        // 监听音频暂停事件
        audio.addEventListener('pause', function() {
            playPauseBtn.textContent = '▶';
            musicStatus.textContent = "奢香夫人 (已暂停)";
        });
        
        // 监听音频结束事件
        audio.addEventListener('ended', function() {
            playPauseBtn.textContent = '▶';
            musicStatus.textContent = "奢香夫人 (播放完毕)";
        });
        
        // 监听加载错误事件
        audio.addEventListener('error', function(e) {
            console.error('音频加载错误:', e.target.error);
            musicStatus.textContent = `音频加载失败: ${e.target.error}`;
        });
        
        // 绑定按钮事件
        playPauseBtn.addEventListener('click', togglePlayPause);
        musicToggle.addEventListener('click', togglePlayPause);
        
        prevBtn.addEventListener('click', function() {
            // 目前只有一首歌，禁用此功能
        });
        
        nextBtn.addEventListener('click', function() {
            // 目前只有一首歌，禁用此功能
        });
        
        // 页面加载后开始预加载音频
        preloadAudio();
        
        console.log('音乐播放器初始化完成，尝试路径:', musicPath);
    }
    
    function updateWeatherInfo() {
        fetch('${pageContext.request.contextPath}/weather?city=cangzhou')
            .then(response => {
                if (!response.ok) {
                    throw new Error('网络响应不正常: ' + response.status);
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    const weatherInfo = data.weather;
                    document.querySelector('.weather-info').textContent = '📍 ' + weatherInfo.cityName + ' ' + weatherInfo.condition + ', ' + weatherInfo.currentTemp;
                } else {
                    console.error('获取天气信息失败:', data.message || '未知错误');
                }
            })
            .catch(error => {
                console.error('请求天气信息时发生错误:', error);
                // 如果API调用失败，显示错误信息
                document.querySelector('.weather-info').textContent = '天气信息获取失败';
            });
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
            <c:choose>
                <c:when test="${sessionScope.user.username ne null}">
                    <div class="quick-item-card" onclick="window.location.href='${pageContext.request.contextPath}/document/form'">
                        <div class="quick-item-icon">📡</div>
                        <div class="quick-item-text">发布文章</div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="quick-item-card" onclick="window.location.href='${pageContext.request.contextPath}/login'">
                        <div class="quick-item-icon">📡</div>
                        <div class="quick-item-text">登录起草</div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</div>
</body>
</html>
