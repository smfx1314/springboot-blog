package com.jiangfeixiang.springbootblog.service.impl;

import com.jiangfeixiang.springbootblog.dao.ReaderMassageDoMapper;
import com.jiangfeixiang.springbootblog.entity.ReaderMassageDo;
import com.jiangfeixiang.springbootblog.service.ReaderMsgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.service.impl
 * @ClassName: ReaderMsgServiceImpl
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: 留言板实现类
 * @Date: 2019/5/9/0009 13:32
 */
@Service
@Transactional
public class ReaderMsgServiceImpl implements ReaderMsgService {

    @Autowired
    private ReaderMassageDoMapper readerMassageDoMapper;

    /**
     * 插入
     * @param record
     * @return
     */
    @Override
    public int insertSelective(ReaderMassageDo record) {

        return readerMassageDoMapper.insertSelective(record);
    }

    /**
     * 根据id查询
     * @param id
     * @return
     */
    @Override
    public ReaderMassageDo selectByPrimaryKey(Integer id) {
        ReaderMassageDo readerMassageDo = readerMassageDoMapper.selectByPrimaryKey(id);
        if (readerMassageDo !=null){
            return readerMassageDo;
        }
        return null;
    }

    /**
     * 获取所有留言板信息
     * @return
     */
    @Override
    public List<ReaderMassageDo> getAllMsg() {
        List<ReaderMassageDo> allMsg = readerMassageDoMapper.getAllMsg();
        if (allMsg !=null){
            return allMsg;
        }
        return null;
    }
}
