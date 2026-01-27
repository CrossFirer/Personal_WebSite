package com.personal.website.mapper;

import com.personal.website.pojo.Document;
import java.util.List;
import java.util.Map;

public interface DocumentMapper {
    int insertDocument(Document document);
    
    List<Document> selectAllDocuments();
    
    Document selectByUuid(String uuid);
    
    int updateDocument(Document document);
    
    int deleteDocument(String uuid);
    
    List<Document> selectAllDocumentsWithPagination(Map<String, Object> params);
    
    int getTotalCount();
    
    List<Document> selectByType(String type);
}