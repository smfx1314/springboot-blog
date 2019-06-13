package com.jiangfeixiang.springbootblog.service.impl;

import com.jiangfeixiang.springbootblog.dao.LogsDoMapper;
import com.jiangfeixiang.springbootblog.entity.LogsDo;
import com.jiangfeixiang.springbootblog.service.LogsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.service.impl
 * @ClassName: LogServiceImpl
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: 日志实现类
 * @Date: 2019/6/12/0012 22:07
 */
@Service
public class LogServiceImpl implements LogsService {

    @Autowired
    private LogsDoMapper logsDoMapper;


    @Override
    public int deleteByPrimaryKey(Integer id) {
        return 0;
    }

    @Override
    public int insert(LogsDo record) {
        return 0;
    }

    @Override
    public int insertSelective(LogsDo record) {
        return logsDoMapper.insertSelective(record);
    }

    @Override
    public LogsDo selectByPrimaryKey(Integer id) {
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(LogsDo record) {
        return 0;
    }

    @Override
    public int updateByPrimaryKey(LogsDo record) {
        return 0;
    }
}
