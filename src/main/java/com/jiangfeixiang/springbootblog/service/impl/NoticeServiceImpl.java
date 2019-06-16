package com.jiangfeixiang.springbootblog.service.impl;

import com.jiangfeixiang.springbootblog.dao.NoticeDoMapper;
import com.jiangfeixiang.springbootblog.entity.NoticeDo;
import com.jiangfeixiang.springbootblog.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.service.impl
 * @ClassName: NoticeServiceImpl
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: 公告实现类
 * @Date: 2019/6/16/0016 7:41
 */
@Service
@Transactional
public class NoticeServiceImpl implements NoticeService {

    @Autowired
    private NoticeDoMapper noticeDoMapper;

    /**
     * 查询公告
     * @return
     */
    @Override
    public NoticeDo selectNotice() {
        NoticeDo noticeDo = noticeDoMapper.selectNotice();
        if (noticeDo !=null){
            return noticeDo;
        }
        return null;
    }

    /**
     * 添加公告
     * @param record
     * @return
     */
    @Override
    public int insertSelective(NoticeDo record) {
        return noticeDoMapper.insertSelective(record);
    }

    /**
     * 查询所有公告
     * @return
     */
    @Override
    public List<NoticeDo> selectAllNotice() {
        List<NoticeDo> noticeDos = noticeDoMapper.selectAllNotice();
        if (noticeDos !=null){
            return noticeDos;
        }
        return null;
    }
}
