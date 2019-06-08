package com.jiangfeixiang.springbootblog.util;

import com.jiangfeixiang.springbootblog.entity.BlogDo;
import com.jiangfeixiang.springbootblog.entity.ImagesDo;
import com.jiangfeixiang.springbootblog.service.model.BlogAndImageModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.util
 * @ClassName: BeanUtilsModel
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: 整合或者拆解实体类
 * @Date: 2019/6/7/0007 16:38
 */
public class BeanUtilsModel {
    private final static Logger logger = LoggerFactory.getLogger(BeanUtilsModel.class);

    /**
     * 拆解Model-->blogDo
     * @param blogAndImageModel
     * @return
     */
    public static BlogDo modelToBlog(BlogAndImageModel blogAndImageModel){
        BlogDo blogDo = new BlogDo();
        BeanUtils.copyProperties(blogAndImageModel,blogDo);
        return blogDo;
    }

    /**
     * 拆解Model-->ImagesDo
     * @param blogAndImageModel
     * @return
     */
    public static ImagesDo modelToImage(BlogAndImageModel blogAndImageModel){
        ImagesDo imagesDo = new ImagesDo();
        BeanUtils.copyProperties(blogAndImageModel,imagesDo);
        //外键
        imagesDo.setBlogId(blogAndImageModel.getBid());
        return imagesDo;
    }

    /**
     * ImagesDo+ContentsDo-->BlogAndImageModel
     */
    public static BlogAndImageModel imageAndBlogModel(ImagesDo imagesDo, BlogDo blogDo){
        BlogAndImageModel blogAndImageModel = new BlogAndImageModel();
        BeanUtils.copyProperties(blogDo, blogAndImageModel);
        blogAndImageModel.setTitleUrl(imagesDo.getTitleUrl());
        logger.info("ContentsServiceImpl中：contentsImagesModel整合成功");
        return blogAndImageModel;
    }
}
