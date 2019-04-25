package com.jiangfeixiang.springbootblog.service.impl;

import com.jiangfeixiang.springbootblog.dao.ContentsDoMapper;
import com.jiangfeixiang.springbootblog.dao.ImagesDoMapper;
import com.jiangfeixiang.springbootblog.entity.ContentsDo;
import com.jiangfeixiang.springbootblog.entity.ImagesDo;
import com.jiangfeixiang.springbootblog.service.ContentsService;
import com.jiangfeixiang.springbootblog.service.model.ContentsImagesModel;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.service.impl
 * @ClassName: ContentsServiceImpl
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: 对应ContentsService实现类
 * @Date: 2019/4/24/0024 15:07
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class ContentsServiceImpl implements ContentsService {

    @Autowired
    private ContentsDoMapper contentsDoMapper;

    @Autowired
    private ImagesDoMapper imagesDoMapper;


    /**
     * 插入博客内容
     * @param contentsImagesModel
     * @return
     */
    @Override
    public void insertSelective(ContentsImagesModel contentsImagesModel) {
        //实现model-->contentsDo
        ContentsDo contentsDo = contentsDoFromModel(contentsImagesModel);
        contentsDoMapper.insertSelective(contentsDo);
        //获取自增id，为下面ImagesDo的外键user_id传值
        contentsImagesModel.setCid(contentsDo.getCid());

        //实现model-->ImagesDo
        ImagesDo imagesDo = ImagesDoFromModel(contentsImagesModel);
        imagesDoMapper.insertSelective(imagesDo);

    }

    /**
     * 拆解Model-->ContentsDo
     * @param contentsImagesModel
     * @return
     */
    private ContentsDo contentsDoFromModel(ContentsImagesModel contentsImagesModel){
        ContentsDo contentsDo = new ContentsDo();
        BeanUtils.copyProperties(contentsImagesModel,contentsDo);
        return contentsDo;
    }

    /**
     * 拆解Model-->ImagesDo
     * @param contentsImagesModel
     * @return
     */
    private ImagesDo ImagesDoFromModel(ContentsImagesModel contentsImagesModel){
        ImagesDo imagesDo = new ImagesDo();
        imagesDo.setTitleUrl(contentsImagesModel.getTitleUrl());
        //外键
        imagesDo.setContentId(contentsImagesModel.getCid());
        return imagesDo;
    }
}
