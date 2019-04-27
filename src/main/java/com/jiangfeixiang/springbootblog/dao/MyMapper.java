package com.jiangfeixiang.springbootblog.dao;

import tk.mybatis.mapper.common.Mapper;
import tk.mybatis.mapper.common.MySqlMapper;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.service
 * @ClassName: MyMapper
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: 通用mapper接口
 * @Date: 2019/4/27/0027 15:09
 */
public interface MyMapper<T> extends Mapper<T>, MySqlMapper<T> {
    //特别注意，该接口不能被扫描到，否则会出错
}