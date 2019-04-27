package com.jiangfeixiang.springbootblog.service.model;

import lombok.Data;

import java.util.Date;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.service.model
 * @ClassName: ContentsImagesModel
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: contents和images模型类
 * @Date: 2019/4/24/0024 15:12
 */
public class ContentsImagesModel {

    private Integer cid;

    private String title;

    private String content;

    private String description;

    private Date created;

    private Integer authorId;

    private Integer status;

    private String tags;

    private String categories;

    private Integer allowComment;

    private String titleUrl;

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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getAuthorId() {
        return authorId;
    }

    public void setAuthorId(Integer authorId) {
        this.authorId = authorId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getTags() {
        return tags;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }

    public String getCategories() {
        return categories;
    }

    public void setCategories(String categories) {
        this.categories = categories;
    }

    public Integer getAllowComment() {
        return allowComment;
    }

    public void setAllowComment(Integer allowComment) {
        this.allowComment = allowComment;
    }

    public String getTitleUrl() {
        return titleUrl;
    }

    public void setTitleUrl(String titleUrl) {
        this.titleUrl = titleUrl;
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

    @Override
    public String toString() {
        return "ContentsImagesModel{" +
                "cid=" + cid +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", description='" + description + '\'' +
                ", created=" + created +
                ", authorId=" + authorId +
                ", status=" + status +
                ", tags='" + tags + '\'' +
                ", categories='" + categories + '\'' +
                ", allowComment=" + allowComment +
                ", titleUrl='" + titleUrl + '\'' +
                '}';
    }
}
