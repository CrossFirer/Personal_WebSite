package com.personal.website.listener;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

/**
 * 编码监听器，用于设置系统级别的字符编码
 */
@WebListener
public class EncodingListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // 设置系统属性确保控制台输出使用UTF-8编码
        System.setProperty("file.encoding", "UTF-8");
        System.setProperty("sun.jnu.encoding", "UTF-8");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // 清理资源
    }
}