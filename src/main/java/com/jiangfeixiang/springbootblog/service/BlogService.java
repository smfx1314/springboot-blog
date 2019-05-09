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
     * @param blogsDo 实体类
     * @return
     */
    void insertSelective(BlogsDo blogsDo);

    /**
     * 根据id查询
     * @param id
     * @return
     */
    BlogsDo getByContentId(Integer id);

    /**
     * 模糊查询
     * @param title
     * @return
     */
    List<BlogsDo> getBlogByFuzzyQuery(String title);

    /**
     * 删除
     * @param id
     */
    void deleteById(Integer id);

    /**
     *  更新
     * @param blogsDo
     * @return
     */
    int updateByPrimaryKeySelective(BlogsDo blogsDo);
}
