package com.personal.website.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;

@WebServlet("/music/*")
public class MusicServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        // 确保路径安全，防止路径遍历攻击
        if (pathInfo == null || pathInfo.contains("..")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid path");
            return;
        }
        
        // 构建实际文件路径
        String filePath = getServletContext().getRealPath("/music" + pathInfo);
        
        File file = new File(filePath);
        
        // 检查文件是否存在且在允许的目录内
        if (!file.exists() || !filePath.startsWith(getServletContext().getRealPath("/music"))) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // 根据文件扩展名设置正确的MIME类型
        String mimeType = getServletContext().getMimeType(file.getName());
        if (mimeType == null) {
            mimeType = "application/octet-stream";
        }
        response.setContentType(mimeType);
        response.setContentLengthLong(file.length());
        
        // 设置缓存头
        response.setHeader("Cache-Control", "public, max-age=3600"); // 缓存1小时
        
        // 提供文件内容
        try (InputStream inputStream = new FileInputStream(file);
             ServletOutputStream outputStream = response.getOutputStream()) {
            
            byte[] buffer = new byte[8192];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
        }
    }
}