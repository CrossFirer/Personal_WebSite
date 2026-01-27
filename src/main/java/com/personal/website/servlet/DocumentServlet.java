package com.personal.website.servlet;


import com.personal.website.pojo.Document;
import com.personal.website.service.DocumentService;
import com.personal.website.service.impl.DocumentServiceImpl;
import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DocumentServlet extends HttpServlet {

    private DocumentService documentService = new DocumentServiceImpl();
    private Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String pathInfo = request.getPathInfo();

        switch (pathInfo) {
            case "/save":
                saveDocument(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        switch (pathInfo) {
            case "/form":
                showCreateForm(request, response);
                break;
            case "/view":
                String uuid = request.getParameter("uuid");
                if (uuid != null && !uuid.isEmpty()) {
                    Document document = documentService.getDocumentByUuid(uuid);
                    request.setAttribute("document", document);
                    request.getRequestDispatcher("/jsp/detail.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                }
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }

    }

    private void saveDocument(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        Object userObj = session.getAttribute("user");
        String drafter = "匿名用户";
        
        if (userObj != null) {
            if (userObj instanceof String) {
                drafter = (String) userObj;
            } else if (userObj instanceof com.personal.website.pojo.User) {
                drafter = ((com.personal.website.pojo.User) userObj).getUsername();
            }
        }

        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String type = request.getParameter("type");
        String secondaryCategory = request.getParameter("secondaryCategory");
        String tertiaryCategory = request.getParameter("tertiaryCategory");

        Document document = new Document(drafter, title, content, type, secondaryCategory, tertiaryCategory);

        Map<String, Object> result = new HashMap<>();
        if (documentService.saveDocument(document)) {
            result.put("success", true);
            result.put("message", "文档保存成功");
        } else {
            result.put("success", false);
            result.put("message", "文档保存失败");
        }

        response.setContentType("application/json;charset=utf-8");
        response.getWriter().write(gson.toJson(result));
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/jsp/create.jsp");
    }
}