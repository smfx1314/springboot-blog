package com.jiangfeixiang.springbootblog.entity;

import java.io.Serializable;

public class ImagesDo implements Serializable {
    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_images.pid
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    private Integer pid;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_images.title_url
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    private String titleUrl;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_images.blog_id
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    private Integer blogId;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_images.pid
     *
     * @return the value of t_images.pid
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public Integer getPid() {
        return pid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_images.pid
     *
     * @param pid the value for t_images.pid
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public void setPid(Integer pid) {
        this.pid = pid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_images.title_url
     *
     * @return the value of t_images.title_url
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public String getTitleUrl() {
        return titleUrl;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_images.title_url
     *
     * @param titleUrl the value for t_images.title_url
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public void setTitleUrl(String titleUrl) {
        this.titleUrl = titleUrl == null ? null : titleUrl.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_images.blog_id
     *
     * @return the value of t_images.blog_id
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public Integer getBlogId() {
        return blogId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_images.blog_id
     *
     * @param blogId the value for t_images.blog_id
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public void setBlogId(Integer blogId) {
        this.blogId = blogId;
    }
}