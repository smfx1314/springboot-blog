package com.jiangfeixiang.springbootblog.controller.front;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiangfeixiang.springbootblog.common.CommonReturnType;
import com.jiangfeixiang.springbootblog.entity.BlogsDo;
import com.jiangfeixiang.springbootblog.service.BlogService;
import com.jiangfeixiang.springbootblog.service.ContentsService;
import com.jiangfeixiang.springbootblog.service.model.ContentsImagesModel;
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
@CrossOrigin(allowCredentials = "true",allowedHeaders = "*")
public class FrontBlogController {
    private final static Logger logger = LoggerFactory.getLogger(FrontBlogController.class);

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
        List<BlogsDo> blogs = blogService.selectAllBlogs();
        PageInfo<BlogsDo> pageInfo=new PageInfo<>(blogs);
        return CommonReturnType.success(pageInfo);
    }
}
