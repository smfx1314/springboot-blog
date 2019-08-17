package com.jiangfeixiang.springbootblog.service.impl;

import com.jiangfeixiang.springbootblog.dao.BlogDoMapper;
import com.jiangfeixiang.springbootblog.dao.ImagesDoMapper;
import com.jiangfeixiang.springbootblog.entity.BlogDo;
import com.jiangfeixiang.springbootblog.entity.ImagesDo;
import com.jiangfeixiang.springbootblog.service.BlogService;
import com.jiangfeixiang.springbootblog.service.model.BlogAndImageModel;
import com.jiangfeixiang.springbootblog.util.BeanUtilsModel;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
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
@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class BlogServiceImpl implements BlogService {

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
    public List<BlogDo> selectAllBlogs() {
        List<BlogDo> blogDos = blogsDoMapper.selectAllBlogs();
        return blogDos;
    }

    /**
     * 根据id查询
     * 如果缓存存在，从缓存中获取城市信息
     * 如果缓存不存在，从 DB 中获取信息，然后插入缓存
     * @param id
     * @return
     */
    @Override
    public BlogAndImageModel getByContentId(Integer id) {
        //从数据库查询
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
    public List<BlogDo> getBlogByFuzzyQuery(String title) {
        List<BlogDo> blogDos = blogsDoMapper.getBlogByFuzzyQuery(title);
        if (blogDos !=null){
            return blogDos;
        }
        return null;
    }


    /**
     * 根据id删除
     * @param id
     */
    @Override
    public void deleteById(Integer id) {
        //删除DB中的数据
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
        //更新DB中的数据
        BlogDo blogDo = BeanUtilsModel.modelToBlog(blogAndImageModel);
        blogsDoMapper.updateByPrimaryKeySelective(blogDo);

        /**
         * 图片要根据blog_id进行更新
         */
        ImagesDo imagesDo = BeanUtilsModel.modelToImage(blogAndImageModel);
        imagesDoMapper.updateByPrimaryKeySelective(imagesDo);

        return 0;
    }

    /**
     * 查询标签
     * @return
     */
    @Override
    public List<BlogDo> selectAllTag() {
        List<BlogDo> blogDos = blogsDoMapper.selectAllTag();
        if (blogDos !=null){
            return blogDos;
        }
        return null;
    }

    /**
     * 根据标签查询
     * @param tag
     * @return
     */
    @Override
    public List<BlogDo> selectByTag(String tag) {
        List<BlogDo> blogDos = blogsDoMapper.selectByTag(tag);
        return blogDos;
    }
}
