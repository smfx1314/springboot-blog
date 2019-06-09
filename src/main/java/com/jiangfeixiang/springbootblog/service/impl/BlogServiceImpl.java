package com.jiangfeixiang.springbootblog.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiangfeixiang.springbootblog.common.CommonReturnType;
import com.jiangfeixiang.springbootblog.dao.BlogDoMapper;
import com.jiangfeixiang.springbootblog.dao.ImagesDoMapper;
import com.jiangfeixiang.springbootblog.entity.BlogDo;
import com.jiangfeixiang.springbootblog.entity.ImagesDo;
import com.jiangfeixiang.springbootblog.service.BlogService;
import com.jiangfeixiang.springbootblog.service.model.BlogAndImageModel;
import com.jiangfeixiang.springbootblog.util.BeanUtilsModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.service.impl
 * @ClassName: BlogServiceImpl
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: blog实现类
 * @Date: 2019/5/8/0008 9:57
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class BlogServiceImpl implements BlogService {
    private final static Logger logger = LoggerFactory.getLogger(BeanUtilsModel.class);

    @Autowired
    private BlogDoMapper blogsDoMapper;

    @Autowired
    private ImagesDoMapper imagesDoMapper;

    /**
     * 插入博客
     * @param blogAndImageModel
     */
    @Override
    public void insertSelective(BlogAndImageModel blogAndImageModel) {
        //插入blogDo
        BlogDo blogDo = BeanUtilsModel.modelToBlog(blogAndImageModel);
        blogsDoMapper.insertSelective(blogDo);
        //主键回显
        blogAndImageModel.setBid(blogDo.getBid());
        //插入图片
        ImagesDo imagesDo = BeanUtilsModel.modelToImage(blogAndImageModel);
        imagesDoMapper.insertSelective(imagesDo);
    }


    /**
     * 查询所有，分页查询
     * @return
     */
    @Override
    public List<BlogAndImageModel> selectAllBlogs() {
        List<BlogDo> blogDos = blogsDoMapper.selectAllBlogs();
        List<BlogAndImageModel> list = new ArrayList<>();
        for (BlogDo blogDo:blogDos) {
            BlogAndImageModel blogAndImageModel = new BlogAndImageModel();
            blogAndImageModel.setBid(blogDo.getBid());
            blogAndImageModel.setTitle(blogDo.getTitle());
            blogAndImageModel.setContent(blogDo.getContent());
            blogAndImageModel.setDescription(blogDo.getDescription());
            blogAndImageModel.setStatus(blogDo.getStatus());
            blogAndImageModel.setTags(blogDo.getTags());
            blogAndImageModel.setCreated(blogDo.getCreated());
            //根据blogid查询图片
            ImagesDo imagesDo = imagesDoMapper.selectByBlogId(blogDo.getBid());
            blogAndImageModel.setTitleUrl(imagesDo.getTitleUrl());
            blogAndImageModel.setAllowComment(blogDo.getAllowComment());
            //添加list集合中
            list.add(blogAndImageModel);
        }
        return list;
    }

    /**
     * 根据id查询
     * @param id
     * @return
     */
    @Override
    public BlogAndImageModel getByContentId(Integer id) {
        BlogDo blogDo = blogsDoMapper.selectByPrimaryKey(id);
        ImagesDo imagesDo = imagesDoMapper.selectByBlogId(blogDo.getBid());
        BlogAndImageModel blogAndImageModel = BeanUtilsModel.imageAndBlogModel(imagesDo, blogDo);
        return blogAndImageModel;
    }


    /**
     * 模糊查询
     * @param title
     * @return
     */
    @Override
    public List<BlogAndImageModel> getBlogByFuzzyQuery(String title) {
        return null;
    }


    /**
     * 根据id删除
     * @param id
     */
    @Override
    public void deleteById(Integer id) {
        blogsDoMapper.deleteByPrimaryKey(id);
        imagesDoMapper.deleteByBlogId(id);
    }

    /**
     * 更新
     * @param blogAndImageModel
     * @return
     */
    @Override
    public int updateByPrimaryKeySelective(BlogAndImageModel blogAndImageModel) {
        BlogDo blogDo = BeanUtilsModel.modelToBlog(blogAndImageModel);
        blogsDoMapper.updateByPrimaryKeySelective(blogDo);

        /**
         * 图片要根据blog_id进行更新
         */
        ImagesDo imagesDo = BeanUtilsModel.modelToImage(blogAndImageModel);
        imagesDoMapper.updateByPrimaryKeySelective(imagesDo);
        return 0;
    }
}
