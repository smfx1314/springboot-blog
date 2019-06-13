package com.jiangfeixiang.springbootblog.service;

import com.jiangfeixiang.springbootblog.entity.ImagesDo;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.service
 * @ClassName: ImagesService
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: image图片接口
 * @Date: 2019/4/25/0025 17:09
 */
public interface ImagesService {
    /**
     * 插入图片，保存图片
     * @param imagesDo
     * @return
     */
    int insertSelective(ImagesDo imagesDo);

    /**
     * 根据id查询
     * @param bid
     * @return
     */
    ImagesDo selectByBlogId(Integer bid);
}
