package com.jiangfeixiang.springbootblog.dao;

import com.jiangfeixiang.springbootblog.entity.ReaderMassageDo;

import java.util.List;

public interface ReaderMassageDoMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_readermassage
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_readermassage
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    int insert(ReaderMassageDo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_readermassage
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    int insertSelective(ReaderMassageDo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_readermassage
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    ReaderMassageDo selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_readermassage
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    int updateByPrimaryKeySelective(ReaderMassageDo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_readermassage
     *
     * @mbg.generated Mon Aug 12 23:13:45 CST 2019
     */
    int updateByPrimaryKey(ReaderMassageDo record);

    List<ReaderMassageDo> getAllMsg();
}