package com.jiangfeixiang.springbootblog.controller.front;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiangfeixiang.springbootblog.common.CommonReturnType;
import com.jiangfeixiang.springbootblog.entity.BlogDo;
import com.jiangfeixiang.springbootblog.service.BlogService;
import com.jiangfeixiang.springbootblog.service.model.BlogAndImageModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.controller.front
 * @ClassName: BlogController
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: 博客操作类
 * @Date: 2019/4/28/0028 12:57
 */

@Controller
@RequestMapping("/blog")
public class FrontBlogController {

    @Autowired
    private BlogService blogService;

    /**
     * @title
     * @description  查询所有博客并分页
     * @author jiangfeixiang
     * @updateTime
     * @throws
     */
    @RequestMapping(value = "/getAllBlog",method = RequestMethod.GET)
    @ResponseBody
    public CommonReturnType getAllContents(@RequestParam(value = "pageNum",defaultValue = "1") int pageNum){
        PageHelper.startPage(pageNum, 3);
        List<BlogAndImageModel> blogAndImageModels = blogService.selectAllBlogs();
        PageInfo<BlogAndImageModel> pageInfo=new PageInfo<>(blogAndImageModels);
        return CommonReturnType.success(pageInfo);
    }

    /**
     * 模糊查询
     * @param pageNum
     * @param title
     * @return
     */
    /*@RequestMapping(value = "/getBlogByFuzzyQuery",method = RequestMethod.GET)
    @ResponseBody
    public CommonReturnType getBlogByFuzzyQuery(@RequestParam(value = "pageNum",defaultValue = "1") int pageNum,
                                                @RequestParam(value = "keyword")String title){
        PageHelper.startPage(pageNum, 20);
        List<BlogDo> blogByFuzzyQuery = blogService.getBlogByFuzzyQuery(title);
        System.out.println(blogByFuzzyQuery);
        PageInfo<BlogDo> pageInfo=new PageInfo<>(blogByFuzzyQuery);
        return CommonReturnType.success(pageInfo);
    }*/


}
