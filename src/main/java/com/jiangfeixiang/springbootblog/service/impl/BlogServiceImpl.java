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
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

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

    @Autowired
    private RedisTemplate redisTemplate;

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
        ValueOperations<String,List<BlogDo>> valueOperations = redisTemplate.opsForValue();
        //如果缓存存在
        String key = "blog_";
        boolean hasKey = redisTemplate.hasKey(key);
        if (hasKey) {
            List<BlogDo> blogDos = valueOperations.get(key);
            log.info("selectAllBlogs"+blogDos);
            return blogDos;
        }
        //如果换成不存在从数据库查询
        List<BlogDo> blogDos = blogsDoMapper.selectAllBlogs();
        //存入缓存中.
        valueOperations.set(key, blogDos, 10, TimeUnit.SECONDS);
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
        ValueOperations<String,BlogDo> valueOperations = redisTemplate.opsForValue();
        //如果缓存存在
        String key = "blog_"+id;
        boolean hasKey = redisTemplate.hasKey(key);
        if (hasKey) {
            BlogDo blogDo = valueOperations.get(key);
            log.info("getByContentId() : 从缓存中获取了Blog " + blogDo.toString());
            ImagesDo imagesDo = imagesDoMapper.selectByBlogId(blogDo.getBid());
            BlogAndImageModel blogAndImageModel = BeanUtilsModel.imageAndBlogModel(imagesDo, blogDo);
            return blogAndImageModel;
        }
        //如果缓存不存在，从数据库查询
        BlogDo blogDo = blogsDoMapper.selectByPrimaryKey(id);
        ImagesDo imagesDo = imagesDoMapper.selectByBlogId(blogDo.getBid());
        BlogAndImageModel blogAndImageModel = BeanUtilsModel.imageAndBlogModel(imagesDo, blogDo);
        //存入缓存中.
        valueOperations.set(key, blogDo, 10, TimeUnit.SECONDS);
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
        //删除DB中的数据
        blogsDoMapper.deleteByPrimaryKey(id);
        imagesDoMapper.deleteByBlogId(id);
        //如果缓存中存在，移除。
        String key = "blog_"+id;
        boolean hasKey = redisTemplate.hasKey(key);
        if (hasKey) {
            redisTemplate.delete(key);
            log.info("deleteById 从缓存中移除了 ID:" + id);
        }
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

        //如果缓存中存在，移除。
        String key = "blog_"+blogAndImageModel.getBid();
        boolean hasKey = redisTemplate.hasKey(key);
        if (hasKey) {
            redisTemplate.delete(key);
            log.info("updateByPrimaryKeySelective 从缓存中移除了" + blogDo.toString());
        }
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
