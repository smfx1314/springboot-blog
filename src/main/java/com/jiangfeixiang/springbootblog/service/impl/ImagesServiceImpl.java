package com.jiangfeixiang.springbootblog.service.impl;

import com.jiangfeixiang.springbootblog.dao.ImagesDoMapper;
import com.jiangfeixiang.springbootblog.entity.ImagesDo;
import com.jiangfeixiang.springbootblog.service.ImagesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.service.impl
 * @ClassName: ImagesServiceImpl
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: images图片接口实现类
 * @Date: 2019/4/25/0025 17:09
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class ImagesServiceImpl implements ImagesService {

    @Autowired
    private ImagesDoMapper imagesDoMapper;

    /**
     * @title
     * @description  插入保存图片
     * @author jiangfeixiang
     * @updateTime
     * @throws
     */
    @Override
    public int insertSelective(ImagesDo imagesDo) {

        return  imagesDoMapper.insertSelective(imagesDo);
    }

    /**
     * 根据id查询
     * @param bid
     * @return
     */
    @Override
    public ImagesDo selectByBlogId(Integer bid) {
        return imagesDoMapper.selectByBlogId(bid);
    }

}
