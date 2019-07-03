package com.jiangfeixiang.springbootblog.service;

import com.github.pagehelper.PageInfo;
import com.jiangfeixiang.springbootblog.common.CommonReturnType;
import com.jiangfeixiang.springbootblog.entity.BlogDo;
import com.jiangfeixiang.springbootblog.service.model.BlogAndImageModel;

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
     * 查询所有,分页查询
     */
    List<BlogDo> selectAllBlogs();

    /**
     * 插入博客内容
     * @param blogAndImageModel 实体类
     * @return
     */
    void insertSelective(BlogAndImageModel blogAndImageModel);

    /**
     * 根据id查询
     * @param id
     * @return
     */
    BlogAndImageModel getByContentId(Integer id);

    /**
     * 模糊查询
     * @param title
     * @return
     */
    List<BlogDo> getBlogByFuzzyQuery(String title);

    /**
     * 删除
     * @param id
     */
    void deleteById(Integer id);

    /**
     *  更新
     * @param blogAndImageModel
     * @return
     */
    int updateByPrimaryKeySelective(BlogAndImageModel blogAndImageModel);

    /**
     * 根据标签查询
     */
    List<BlogDo> selectAllTag();

    /**
     * 根据标签查询
     * @param tag
     * @return
     */
    List<BlogDo> selectByTag(String tag);
}
