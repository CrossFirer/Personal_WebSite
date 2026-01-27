package com.personal.website.servlet;

import com.personal.website.pojo.Document;
import com.personal.website.service.DocumentService;
import com.personal.website.service.impl.DocumentServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class IndexServlet extends HttpServlet {

    private DocumentService documentService = new DocumentServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

        request.setAttribute("documents", documents);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalCount", totalCount);

        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
