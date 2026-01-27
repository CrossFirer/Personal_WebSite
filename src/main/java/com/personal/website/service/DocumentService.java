package com.personal.website.service;

import com.personal.website.pojo.Document;
import java.util.List;

public interface DocumentService {
    boolean saveDocument(Document document);
    List<Document> getAllDocuments();
    List<Document> getDocumentsWithPagination(int page, int pageSize);
    int getTotalCount();
    Document getDocumentByUuid(String uuid);
    boolean updateDocument(Document document);
    boolean deleteDocument(String uuid);
}
