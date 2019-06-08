package com.jiangfeixiang.springbootblog.service.impl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
public class ContentsServiceImpl {

    /**
     * 插入博客内容
     * @param blogAndImageModel
     * @return
     */
   /* public void insertSelective(BlogAndImageModel blogAndImageModel) {
        //实现model-->contentsDo
        ContentsDo contentsDo = contentsDoFromModel(blogAndImageModel);
        contentsDoMapper.insertSelective(contentsDo);
        //获取自增id，为下面ImagesDo的外键user_id传值
        blogAndImageModel.setCid(contentsDo.getCid());

        //实现model-->ImagesDo
        ImagesDo imagesDo = imagesDoFromModel(blogAndImageModel);
        imagesDoMapper.insertSelective(imagesDo);

    }*/


    /**
     * 查询所有contents
     */

    /*public List<BlogAndImageModel> getAllContents() {
        *//**
         * 通过stream流化，把每一个contentsDo流化
         * 然后在根据contentsDo的属性contentId查询图片
         * 最后整合在一起再返回list
         *//*
        List<ContentsDo> contentsDos = contentsDoMapper.getAllContents();
        List<BlogAndImageModel> blogAndImageModels = contentsDos.stream().map(contentsDo -> {
            //根据contentId查询对应的图片
            ImagesDo imagesDo = imagesDoMapper.selectByContnteId(contentsDo.getCid());
            //把每项image与contentDo结合
            BlogAndImageModel blogAndImageModel = modelContentsAndImagesModel(imagesDo.getTitleUrl(), contentsDo);
            return blogAndImageModel;
            //最终组合在返回list
        }).collect(Collectors.toList());
        return blogAndImageModels;
    }*/


    /**
     * @title
     * @description 根据id查询
     * @author jiangfeixiang
     * @updateTime
     * @throws
     */
   /* public BlogAndImageModel getByContentId(Integer id) {
        ContentsDo contentsDo = contentsDoMapper.selectByPrimaryKey(id);
        ImagesDo imagesDo = imagesDoMapper.selectByContnteId(contentsDo.getCid());
        BlogAndImageModel blogAndImageModel = modelContentsAndImagesModel(imagesDo.getTitleUrl(), contentsDo);
        return blogAndImageModel;
    }*/
    
    
    /**
     * 删除
     */
    /*public void deleteById(Integer id) {
        ContentsDo contentsDo = contentsDoMapper.selectByPrimaryKey(id);
        imagesDoMapper.deleteByContentId(contentsDo.getCid());
        contentsDoMapper.deleteByPrimaryKey(id);
    }*/
    
}
