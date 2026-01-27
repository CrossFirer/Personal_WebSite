package com.personal.website.servlet;

import com.google.gson.Gson;
import com.personal.website.pojo.Document;
import com.personal.website.service.DocumentService;
import com.personal.website.service.impl.DocumentServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/drafter/*")
public class DrafterServlet extends HttpServlet {

    private DocumentService documentService = new DocumentServiceImpl();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        String drafter = null;
        
        // 从session中获取当前登录用户作为起草人
        Object userObj = request.getSession().getAttribute("user");
        if (userObj != null) {
            if (userObj instanceof String) {
                drafter = (String) userObj;
            } else if (userObj instanceof com.personal.website.pojo.User) {
                drafter = ((com.personal.website.pojo.User) userObj).getUsername();
            }
        }

        if (drafter != null && !drafter.isEmpty()) {
            // 根据起草人查询文档
            List<Document> documents = documentService.getDocumentsByDrafter(drafter);
            
            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("documents", documents);
            result.put("drafter", drafter);
            result.put("count", documents.size());

            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write(gson.toJson(result));
        } else {
            Map<String, Object> result = new HashMap<>();
            result.put("success", false);
            result.put("message", "用户未登录或起草人信息为空");

            response.setContentType("application/json;charset=utf-8");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write(gson.toJson(result));
        }
    }
}