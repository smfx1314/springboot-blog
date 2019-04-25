package com.jiangfeixiang.springbootblog.service;

import com.jiangfeixiang.springbootblog.entity.ContentsDo;
import com.jiangfeixiang.springbootblog.service.model.ContentsImagesModel;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.service
 * @ClassName: ContentsService
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: Contentsservice接口类
 * @Date: 2019/4/24/0024 15:06
 */
public interface ContentsService {

    /**
     * 插入博客内容
     * @param contentsImagesModel
     * @return
     */
    void insertSelective(ContentsImagesModel contentsImagesModel);
}
