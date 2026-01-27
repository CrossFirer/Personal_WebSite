package com.personal.website.pojo;

import java.util.Date;

public class Document {
    private String uuid;  // 修改为 UUID
    private String drafter;
    private Date draftTime;
    private String title;
    private String content;
    private String type;
    private String secondaryCategory;
    private String tertiaryCategory;
    private Integer status;
    private Date createTime;
    private Date updateTime;

    // 构造函数
    public Document() {}

    public Document(String drafter, String title, String content, String type,
                    String secondaryCategory, String tertiaryCategory) {
        this.uuid = java.util.UUID.randomUUID().toString().replace("-",""); // 自动生成 UUID
        this.drafter = drafter;
        this.title = title;
        this.content = content;
        this.type = type;
        this.secondaryCategory = secondaryCategory;
        this.tertiaryCategory = tertiaryCategory;
    }

    // Getter 和 Setter 方法
    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    // 其他 getter 和 setter 方法...
    public String getDrafter() {
        return drafter;
    }

    public void setDrafter(String drafter) {
        this.drafter = drafter;
    }

    public Date getDraftTime() {
        return draftTime;
    }

    public void setDraftTime(Date draftTime) {
        this.draftTime = draftTime;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getSecondaryCategory() {
        return secondaryCategory;
    }

    public void setSecondaryCategory(String secondaryCategory) {
        this.secondaryCategory = secondaryCategory;
    }

    public String getTertiaryCategory() {
        return tertiaryCategory;
    }

    public void setTertiaryCategory(String tertiaryCategory) {
        this.tertiaryCategory = tertiaryCategory;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
}
