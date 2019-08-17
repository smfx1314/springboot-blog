package com.jiangfeixiang.springbootblog.entity;

import java.io.Serializable;
import java.util.Date;

public class LogsDo implements Serializable {
    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_logs.id
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    private Integer id;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_logs.clientIp
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    private String clientip;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_logs.username
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    private String username;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_logs.operType
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    private String opertype;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_logs.operUrl
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    private String operurl;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_logs.operEvent
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    private String operevent;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_logs.reqParam
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    private String reqparam;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_logs.reqType
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    private String reqtype;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_logs.operTime
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    private Date opertime;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_logs.id
     *
     * @return the value of t_logs.id
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_logs.id
     *
     * @param id the value for t_logs.id
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_logs.clientIp
     *
     * @return the value of t_logs.clientIp
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public String getClientip() {
        return clientip;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_logs.clientIp
     *
     * @param clientip the value for t_logs.clientIp
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public void setClientip(String clientip) {
        this.clientip = clientip == null ? null : clientip.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_logs.username
     *
     * @return the value of t_logs.username
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public String getUsername() {
        return username;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_logs.username
     *
     * @param username the value for t_logs.username
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_logs.operType
     *
     * @return the value of t_logs.operType
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public String getOpertype() {
        return opertype;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_logs.operType
     *
     * @param opertype the value for t_logs.operType
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public void setOpertype(String opertype) {
        this.opertype = opertype == null ? null : opertype.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_logs.operUrl
     *
     * @return the value of t_logs.operUrl
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public String getOperurl() {
        return operurl;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_logs.operUrl
     *
     * @param operurl the value for t_logs.operUrl
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public void setOperurl(String operurl) {
        this.operurl = operurl == null ? null : operurl.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_logs.operEvent
     *
     * @return the value of t_logs.operEvent
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public String getOperevent() {
        return operevent;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_logs.operEvent
     *
     * @param operevent the value for t_logs.operEvent
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public void setOperevent(String operevent) {
        this.operevent = operevent == null ? null : operevent.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_logs.reqParam
     *
     * @return the value of t_logs.reqParam
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public String getReqparam() {
        return reqparam;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_logs.reqParam
     *
     * @param reqparam the value for t_logs.reqParam
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public void setReqparam(String reqparam) {
        this.reqparam = reqparam == null ? null : reqparam.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_logs.reqType
     *
     * @return the value of t_logs.reqType
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public String getReqtype() {
        return reqtype;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_logs.reqType
     *
     * @param reqtype the value for t_logs.reqType
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public void setReqtype(String reqtype) {
        this.reqtype = reqtype == null ? null : reqtype.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_logs.operTime
     *
     * @return the value of t_logs.operTime
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public Date getOpertime() {
        return opertime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_logs.operTime
     *
     * @param opertime the value for t_logs.operTime
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    public void setOpertime(Date opertime) {
        this.opertime = opertime;
    }
}