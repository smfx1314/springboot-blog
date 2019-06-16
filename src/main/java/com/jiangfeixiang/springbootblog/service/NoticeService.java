package com.jiangfeixiang.springbootblog.service;

import com.jiangfeixiang.springbootblog.entity.NoticeDo;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.service
 * @ClassName: NoticeService
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: 公共接口
 * @Date: 2019/6/16/0016 7:40
 */
public interface NoticeService {
    /**
     * 查询一条数据，根据最新时间
     * @return
     */
    NoticeDo selectNotice();
}
