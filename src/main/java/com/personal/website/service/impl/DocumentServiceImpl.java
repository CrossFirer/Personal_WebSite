package com.personal.website.service.impl;

import com.personal.website.mapper.DocumentMapper;
import com.personal.website.pojo.Document;
import com.personal.website.service.DocumentService;
import com.personal.website.utils.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DocumentServiceImpl implements DocumentService {

    @Override
    public boolean saveDocument(Document document) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            DocumentMapper mapper = session.getMapper(DocumentMapper.class);
            int result = mapper.insertDocument(document);
            session.commit();
            return result > 0;
        } finally {
            session.close();
        }
    }

    @Override
    public List<Document> getAllDocuments() {
        SqlSession session = MyBatisUtil.getSession();
        try {
            DocumentMapper mapper = session.getMapper(DocumentMapper.class);
            return mapper.selectAllDocuments();
        } finally {
            session.close();
        }
    }

    @Override
    public List<Document> getDocumentsWithPagination(int page, int pageSize) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            DocumentMapper mapper = session.getMapper(DocumentMapper.class);
            Map<String, Object> params = new HashMap<>();
            params.put("offset", (page - 1) * pageSize);
            params.put("limit", pageSize);
            return mapper.selectAllDocumentsWithPagination(params);
        } finally {
            session.close();
        }
    }

    @Override
    public int getTotalCount() {
        SqlSession session = MyBatisUtil.getSession();
        try {
            DocumentMapper mapper = session.getMapper(DocumentMapper.class);
            return mapper.getTotalCount();
        } finally {
            session.close();
        }
    }

    @Override
    public Document getDocumentByUuid(String uuid) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            DocumentMapper mapper = session.getMapper(DocumentMapper.class);
            return mapper.selectByUuid(uuid);
        } finally {
            session.close();
        }
    }

    @Override
    public boolean updateDocument(Document document) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            DocumentMapper mapper = session.getMapper(DocumentMapper.class);
            int result = mapper.updateDocument(document);
            session.commit();
            return result > 0;
        } finally {
            session.close();
        }
    }

    @Override
    public boolean deleteDocument(String uuid) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            DocumentMapper mapper = session.getMapper(DocumentMapper.class);
            int result = mapper.deleteDocument(uuid);
            session.commit();
            return result > 0;
        } finally {
            session.close();
        }
    }
    
    @Override
    public List<Document> getDocumentsByType(String type) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            DocumentMapper mapper = session.getMapper(DocumentMapper.class);
            return mapper.selectByType(type);
        } finally {
            session.close();
        }
    }
    
    @Override
    public List<Document> getDocumentsByDrafter(String drafter) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            DocumentMapper mapper = session.getMapper(DocumentMapper.class);
            return mapper.selectByDrafter(drafter);
        } finally {
            session.close();
        }
    }
}