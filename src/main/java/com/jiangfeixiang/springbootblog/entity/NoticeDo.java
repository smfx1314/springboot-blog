package com.jiangfeixiang.springbootblog.entity;

import java.io.Serializable;
import java.util.Date;

public class NoticeDo implements Serializable {
    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_notice.id
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    private Integer id;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_notice.content
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    private String content;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_notice.user_id
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    private Integer userId;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_notice.create_time
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    private Date createTime;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_notice.id
     *
     * @return the value of t_notice.id
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_notice.id
     *
     * @param id the value for t_notice.id
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_notice.content
     *
     * @return the value of t_notice.content
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public String getContent() {
        return content;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_notice.content
     *
     * @param content the value for t_notice.content
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_notice.user_id
     *
     * @return the value of t_notice.user_id
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public Integer getUserId() {
        return userId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_notice.user_id
     *
     * @param userId the value for t_notice.user_id
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_notice.create_time
     *
     * @return the value of t_notice.create_time
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public Date getCreateTime() {
        return createTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_notice.create_time
     *
     * @param createTime the value for t_notice.create_time
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}