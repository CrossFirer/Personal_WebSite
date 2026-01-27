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
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/document/*")
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
            case "/delete":
                deleteDocument(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        System.out.println("DocumentServlet.doGet called with pathInfo: " + pathInfo); // 调试输出

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
                System.out.println("Unknown pathInfo: " + pathInfo); // 调试输出
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
        String uuid = request.getParameter("uuid"); // 用于编辑现有文档

        Document document;
        if (uuid != null && !uuid.isEmpty()) {
            // 编辑现有文档
            document = documentService.getDocumentByUuid(uuid);
            if (document != null) {
                document.setTitle(title);
                document.setContent(content);
                document.setType(type);
                document.setSecondaryCategory(secondaryCategory);
                document.setTertiaryCategory(tertiaryCategory);
            }
        } else {
            // 创建新文档
            document = new Document(drafter, title, content, type, secondaryCategory, tertiaryCategory);
        }

        Map<String, Object> result = new HashMap<>();
        boolean success;
        if (uuid != null && !uuid.isEmpty() && document != null) {
            // 更新现有文档
            success = documentService.updateDocument(document);
            if (success) {
                result.put("success", true);
                result.put("message", "文档更新成功");
                result.put("uuid", document.getUuid());
            } else {
                result.put("success", false);
                result.put("message", "文档更新失败");
            }
        } else {
            // 保存新文档
            success = documentService.saveDocument(document);
            if (success) {
                result.put("success", true);
                result.put("message", "文档保存成功");
                result.put("uuid", document.getUuid());
            } else {
                result.put("success", false);
                result.put("message", "文档保存失败");
            }
        }

        response.setContentType("application/json;charset=utf-8");
        response.getWriter().write(gson.toJson(result));
    }

    private void deleteDocument(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String uuid = request.getParameter("uuid");
        
        if (uuid == null || uuid.isEmpty()) {
            Map<String, Object> result = new HashMap<>();
            result.put("success", false);
            result.put("message", "文档ID不能为空");
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write(gson.toJson(result));
            return;
        }

        // 检查当前用户是否为文档的起草人
        HttpSession session = request.getSession();
        Object userObj = session.getAttribute("user");
        String currentUser = null;
        if (userObj != null) {
            if (userObj instanceof String) {
                currentUser = (String) userObj;
            } else if (userObj instanceof com.personal.website.pojo.User) {
                currentUser = ((com.personal.website.pojo.User) userObj).getUsername();
            }
        }

        Document document = documentService.getDocumentByUuid(uuid);
        if (document == null) {
            Map<String, Object> result = new HashMap<>();
            result.put("success", false);
            result.put("message", "文档不存在");
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write(gson.toJson(result));
            return;
        }

        if (currentUser == null || !currentUser.equals(document.getDrafter())) {
            Map<String, Object> result = new HashMap<>();
            result.put("success", false);
            result.put("message", "没有权限删除此文档");
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write(gson.toJson(result));
            return;
        }

        boolean success = documentService.deleteDocument(uuid);
        Map<String, Object> result = new HashMap<>();
        if (success) {
            result.put("success", true);
            result.put("message", "文档删除成功");
        } else {
            result.put("success", false);
            result.put("message", "文档删除失败");
        }

        response.setContentType("application/json;charset=utf-8");
        response.getWriter().write(gson.toJson(result));
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uuid = request.getParameter("uuid");  // 获取UUID参数，用于编辑
        
        if (uuid != null && !uuid.isEmpty()) {
            // 如果有UUID参数，则是编辑模式，获取文档数据
            Document document = documentService.getDocumentByUuid(uuid);
            if (document != null) {
                request.setAttribute("document", document);
            }
        }
        
        request.getRequestDispatcher("/jsp/create.jsp").forward(request, response);
    }
}