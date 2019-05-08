package com.jiangfeixiang.springbootblog.service;

import com.jiangfeixiang.springbootblog.entity.BlogsDo;
import com.jiangfeixiang.springbootblog.service.model.ContentsImagesModel;

import java.util.List;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.service
 * @ClassName: BlogService
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: blog接口
 * @Date: 2019/5/8/0008 9:54
 */
public interface BlogService {

    /**
     * 查询所有
     */
    List<BlogsDo> selectAllBlogs();

    /**
     * 插入博客内容
     * @param blogsDo
     * @return
     */
    void insertSelective(BlogsDo blogsDo);

    /**
     * 根据id查询
     */
    BlogsDo getByContentId(Integer id);

    /**
     * 删除
     */
    void deleteById(Integer id);

    /**
     * 更新
     */
    int updateByPrimaryKeySelective(BlogsDo blogsDo);
}
