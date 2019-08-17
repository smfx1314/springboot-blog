package com.jiangfeixiang.springbootblog.dao;

import com.jiangfeixiang.springbootblog.entity.UserDo;

public interface UserDoMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_users
     *
     * @mbg.generated Mon Aug 12 23:18:09 CST 2019
     */
    int deleteByPrimaryKey(Integer uid);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_users
     *
     * @mbg.generated Mon Aug 12 23:18:09 CST 2019
     */
    int insert(UserDo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_users
     *
     * @mbg.generated Mon Aug 12 23:18:09 CST 2019
     */
    int insertSelective(UserDo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_users
     *
     * @mbg.generated Mon Aug 12 23:18:09 CST 2019
     */
    UserDo selectByPrimaryKey(Integer uid);

    UserDo selectByUsername(String paramString);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_users
     *
     * @mbg.generated Mon Aug 12 23:18:09 CST 2019
     */
    int updateByPrimaryKeySelective(UserDo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_users
     *
     * @mbg.generated Mon Aug 12 23:18:09 CST 2019
     */
    int updateByPrimaryKey(UserDo record);
}