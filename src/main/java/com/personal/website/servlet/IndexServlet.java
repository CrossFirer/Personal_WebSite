package com.personal.website.servlet;

import com.personal.website.pojo.Document;
import com.personal.website.service.DocumentService;
import com.personal.website.service.impl.DocumentServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

public class IndexServlet extends HttpServlet {

    private DocumentService documentService = new DocumentServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 检查用户是否已登录
        HttpSession session = request.getSession(false); // 注意这里使用false，不自动创建session
        if(session == null || session.getAttribute("user") == null) {
            // 强制重定向到登录页面
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // 获取分页参数
        int page = 1;
        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                page = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            // 默认第一页
        }
        if (page < 1) page = 1;

        int pageSize = 5;
        List<Document> documents = documentService.getDocumentsWithPagination(page, pageSize);
        int totalCount = documentService.getTotalCount();
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);

        // 添加调试信息
        System.out.println("IndexServlet: Found " + documents.size() + " documents for page " + page);
        System.out.println("IndexServlet: Total count is " + totalCount);

        request.setAttribute("documents", documents);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalCount", totalCount);

        request.getRequestDispatcher("/home.jsp").forward(request, response);
    }
}