-- 创建数据库
CREATE DATABASE IF NOT EXISTS website 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- 使用数据库
USE website;

-- 创建用户表
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '用户ID',
    username VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
    password VARCHAR(255) NOT NULL COMMENT '密码',
    email VARCHAR(100) COMMENT '邮箱',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_username (username),
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

-- 创建文档表
CREATE TABLE IF NOT EXISTS documents (
    uuid VARCHAR(36) NOT NULL PRIMARY KEY COMMENT '文档UUID',
    drafter VARCHAR(50) NOT NULL COMMENT '起草人',
    draft_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '起草时间',
    title VARCHAR(200) NOT NULL COMMENT '文档标题',
    content TEXT COMMENT '文档内容',
    type VARCHAR(50) COMMENT '文档类型',
    secondary_category VARCHAR(100) COMMENT '二级分类',
    tertiary_category VARCHAR(100) COMMENT '三级分类',
    status TINYINT NOT NULL DEFAULT 1 COMMENT '状态：1-正常，0-已删除',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_drafter (drafter),
    INDEX idx_type (type),
    INDEX idx_status (status),
    INDEX idx_create_time (create_time),
    INDEX idx_draft_time (draft_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文档表';
