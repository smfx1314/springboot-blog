package com.jiangfeixiang.springbootblog.entity;


import java.io.Serializable;
import java.util.Date;

/**
 * @title
 * @description 用户userDo类
 * @author jiangfeixiang
 * @updateTime
 * @throws
 */
public class UserDo implements Serializable {
    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_users.uid
     *
     * @mbg.generated Tue Apr 23 22:05:19 CST 2019
     */
    private Integer uid;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_users.username
     *
     * @mbg.generated Tue Apr 23 22:05:19 CST 2019
     */
    private String username;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_users.password
     *
     * @mbg.generated Tue Apr 23 22:05:19 CST 2019
     */
    private String password;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_users.email
     *
     * @mbg.generated Tue Apr 23 22:05:19 CST 2019
     */
    private String email;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_users.home_url
     *
     * @mbg.generated Tue Apr 23 22:05:19 CST 2019
     */
    private String homeUrl;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_users.state
     *
     * @mbg.generated Tue Apr 23 22:05:19 CST 2019
     */
    private Integer state;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_users.created
     *
     * @mbg.generated Tue Apr 23 22:05:19 CST 2019
     */
    private Date created;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_users.logged
     *
     * @mbg.generated Tue Apr 23 22:05:19 CST 2019
     */
    private Integer logged;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_users.uid
     *
     * @return the value of t_users.uid
     *
     * @mbg.generated Tue Apr 23 22:05:19 CST 2019
     */
    public Integer getUid() {
        return uid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_users.uid
     *
     * @param uid the value for t_users.uid
     *
     * @mbg.generated Tue Apr 23 22:05:19 CST 2019
     */
    public void setUid(Integer uid) {
        this.uid = uid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_users.username
     *
     * @return the value of t_users.username
     *
     * @mbg.generated Tue Apr 23 22:05:19 CST 2019
     */
    public String getUsername() {
        return username;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_users.username
     *
     * @param username the value for t_users.username
     *
     * @mbg.generated Tue Apr 23 22:05:19 CST 2019
     */
    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_users.password
     *
     * @return the value of t_users.password
     *
     * @mbg.generated Tue Apr 23 22:05:19 CST 2019
     */
    public String getPassword() {
        return password;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_users.password
     *
     * @param password the value for t_users.password
     *
     * @mbg.generated Tue Apr 23 22:05:19 CST 2019
     */
    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_users.email
     *
     * @return the value of t_users.email
     *
     * @mbg.generated Tue Apr 23 22:05:19 CST 2019
     */
    public String getEmail() {
        return email;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_users.email
     *
     * @param email the value for t_users.email
     *
     * @mbg.generated Tue Apr 23 22:05:19 CST 2019
     */
    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_users.home_url
     *
     * @return the value of t_users.home_url
     *
     * @mbg.generated Tue Apr 23 22:05:19 CST 2019
     */
    public String getHomeUrl() {
        return homeUrl;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_users.home_url
     *
     * @param homeUrl the value for t_users.home_url
     *
     * @mbg.generated Tue Apr 23 22:05:19 CST 2019
     */
    public void setHomeUrl(String homeUrl) {
        this.homeUrl = homeUrl == null ? null : homeUrl.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_users.state
     *
     * @return the value of t_users.state
     *
     * @mbg.generated Tue Apr 23 22:05:19 CST 2019
     */
    public Integer getState() {
        return state;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_users.state
     *
     * @param state the value for t_users.state
     *
     * @mbg.generated Tue Apr 23 22:05:19 CST 2019
     */
    public void setState(Integer state) {
        this.state = state;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_users.created
     *
     * @return the value of t_users.created
     *
     * @mbg.generated Tue Apr 23 22:05:19 CST 2019
     */
    public Date getCreated() {
        return created;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_users.created
     *
     * @param created the value for t_users.created
     *
     * @mbg.generated Tue Apr 23 22:05:19 CST 2019
     */

    public void setCreated(Date created) {
        this.created = created;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_users.logged
     *
     * @return the value of t_users.logged
     *
     * @mbg.generated Tue Apr 23 22:05:19 CST 2019
     */
    public Integer getLogged() {
        return logged;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_users.logged
     *
     * @param logged the value for t_users.logged
     *
     * @mbg.generated Tue Apr 23 22:05:19 CST 2019
     */
    public void setLogged(Integer logged) {
        this.logged = logged;
    }

    @Override
    public String toString() {
        return "UserDo{" +
                "uid=" + uid +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", homeUrl='" + homeUrl + '\'' +
                ", state=" + state +
                ", created=" + created +
                ", logged=" + logged +
                '}';
    }
}