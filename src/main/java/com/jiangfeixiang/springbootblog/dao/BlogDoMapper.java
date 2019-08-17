package com.jiangfeixiang.springbootblog.dao;

import com.jiangfeixiang.springbootblog.entity.BlogDo;

import java.util.List;

public interface BlogDoMapper {
    int deleteByPrimaryKey(Integer paramInteger);

    int insert(BlogDo paramBlogDo);

    int insertSelective(BlogDo paramBlogDo);

    BlogDo selectByPrimaryKey(Integer paramInteger);

    List<BlogDo> selectAllBlogs();

    int updateByPrimaryKeySelective(BlogDo paramBlogDo);

    int updateByPrimaryKeyWithBLOBs(BlogDo paramBlogDo);

    int updateByPrimaryKey(BlogDo paramBlogDo);

    List<BlogDo> selectAllTag();

    List<BlogDo> selectByTag(String paramString);

    List<BlogDo> getBlogByFuzzyQuery(String paramString);
}