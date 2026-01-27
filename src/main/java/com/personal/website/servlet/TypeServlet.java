package com.personal.website.servlet;

import com.personal.website.pojo.Document;
import com.personal.website.service.DocumentService;
import com.personal.website.service.impl.DocumentServiceImpl;
import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/type/*")
public class TypeServlet extends HttpServlet {

    private DocumentService documentService = new DocumentServiceImpl();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        String type = pathInfo.substring(1); // 移除开头的"/"

        if (type != null && !type.isEmpty()) {
            List<Document> documents = documentService.getDocumentsByType(type);
            
            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("documents", documents);
            result.put("type", type);
            result.put("count", documents.size());

            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write(gson.toJson(result));
        } else {
            Map<String, Object> result = new HashMap<>();
            result.put("success", false);
            result.put("message", "类型参数不能为空");

            response.setContentType("application/json;charset=utf-8");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(gson.toJson(result));
        }
    }
}