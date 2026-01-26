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
<!-- 左侧导航栏 -->
<div class="sidebar">
    <div class="sidebar-header" style="color: white">
        <span>🐶</span>
        <div>天地不仁，<p/>以万物为小狗！</div>
    </div>
    <ul class="sidebar-menu">
        <li><a href="#" class="active"><span>🏠</span>我的首页</a></li>
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
        <div class="card">
            <div class="card-title">外星人来了</div>
            <div class="card-desc">扯淡呢</div>
            <div class="card-date">杂谈 外星人 · 2025-01-02</div>
        </div>
        <div class="card">
            <div class="card-title">外星人走了</div>
            <div class="card-desc">又扯淡呢</div>
            <div class="card-date">杂谈 外星人 · 2025-02-03</div>
        </div>
        <div class="card">
            <div class="card-title">肯德基回应涨价</div>
            <div class="card-desc">1月26日起，肯德基对部分外送产品价格做出小幅调整，平均调整金额为0.8元，堂食价格保持不变。</div>
            <div class="card-date">新闻 肯德基 · 2025-03-04</div>
        </div>
        <div class="card">
            <div class="card-title">死了么”App公司被列入经营异常名录</div>
            <div class="card-desc">1月23日，记者查询国家企业信用信息公示系统发现，“死了么”App开发商月境（郑州）技术服务有限公司，被郑州市金水区市场监督管理局列入经营异常名录，原因为通过登记的住所或者经营场所无法联系。</div>
            <div class="card-date">奇闻异事 死了么APP · 2025-04-05</div>
        </div>
        <div class="card">
            <div class="card-title">日本最后两只大熊猫明日返回中国，超31万人抽签送别</div>
            <div class="card-desc">1月25日，游客在日本东京上野动物园参观大熊猫后伤心地离开。

                据环球网援引日本广播协会（NHK）网站25日报道，上野动物园当天参观者仅限于提前抽签抽中者，预计约有4400名中签者前来参观。据悉，从1月14日至25日，共有超过31万人参与提前抽签，其中25日当天的申请人数与中签人数之比最高，达到24.6：1。</div>
            <div class="card-date">新闻 大熊猫 · 2025-05-06</div>
        </div>

        <!-- 分页组件 -->
        <div class="pagination">
            <button class="pagination-btn disabled">上一页</button>
            <button class="pagination-btn active">1</button>
            <button class="pagination-btn">2</button>
            <button class="pagination-btn">3</button>
            <button class="pagination-btn">4</button>
            <button class="pagination-btn">5</button>
            <button class="pagination-btn">下一页</button>
        </div>
    </div>

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
                <div class="quick-item-text">IoT 物联网</div>
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




