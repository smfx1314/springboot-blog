package com.jiangfeixiang.springbootblog.dao;

import com.jiangfeixiang.springbootblog.entity.ContentsDo;

public interface ContentsDoMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_contents
     *
     * @mbg.generated Wed Apr 24 16:21:10 CST 2019
     */
    int deleteByPrimaryKey(Integer cid);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_contents
     *
     * @mbg.generated Wed Apr 24 16:21:10 CST 2019
     */
    int insert(ContentsDo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_contents
     *
     * @mbg.generated Wed Apr 24 16:21:10 CST 2019
     */
    int insertSelective(ContentsDo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_contents
     *
     * @mbg.generated Wed Apr 24 16:21:10 CST 2019
     */
    ContentsDo selectByPrimaryKey(Integer cid);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_contents
     *
     * @mbg.generated Wed Apr 24 16:21:10 CST 2019
     */
    int updateByPrimaryKeySelective(ContentsDo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_contents
     *
     * @mbg.generated Wed Apr 24 16:21:10 CST 2019
     */
    int updateByPrimaryKeyWithBLOBs(ContentsDo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_contents
     *
     * @mbg.generated Wed Apr 24 16:21:10 CST 2019
     */
    int updateByPrimaryKey(ContentsDo record);
}