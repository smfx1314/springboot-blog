package com.jiangfeixiang.springbootblog.service.impl;

import com.jiangfeixiang.springbootblog.dao.BlogsDoMapper;
import com.jiangfeixiang.springbootblog.entity.BlogsDo;
import com.jiangfeixiang.springbootblog.service.BlogService;
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
@Service
@Transactional
public class BlogServiceImpl implements BlogService {

    @Autowired
    private BlogsDoMapper blogsDoMapper;

    /**
     * 查询所有
     * @return
     */
    @Override
    public List<BlogsDo> selectAllBlogs() {

        return blogsDoMapper.selectAllBlogs();
    }

    /**
     * 插入博客
     * @param blogsDo
     */
    @Override
    public void insertSelective(BlogsDo blogsDo) {
        blogsDoMapper.insertSelective(blogsDo);
    }

    /**
     * 根据id查询
     * @param id
     * @return
     */
    @Override
    public BlogsDo getByContentId(Integer id) {
        return blogsDoMapper.selectByPrimaryKey(id);
    }

    /**
     * 根据id删除
     * @param id
     */
    @Override
    public void deleteById(Integer id) {
        blogsDoMapper.deleteByPrimaryKey(id);
    }

    /**
     * 更新
     * @param blogsDo
     * @return
     */
    @Override
    public int updateByPrimaryKeySelective(BlogsDo blogsDo) {
        int i = blogsDoMapper.updateByPrimaryKeySelective(blogsDo);
        return i;
    }


}
