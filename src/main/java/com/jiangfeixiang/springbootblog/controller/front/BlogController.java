package com.jiangfeixiang.springbootblog.controller.front;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiangfeixiang.springbootblog.common.CommonReturnType;
import com.jiangfeixiang.springbootblog.controller.admin.UserController;
import com.jiangfeixiang.springbootblog.service.ContentsService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

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
public class BlogController {
    private final static Logger logger = LoggerFactory.getLogger(BlogController.class);

    @Autowired
    private ContentsService contentsService;

    /**
     * @title
     * @description  查询所有博客并分页
     * @author jiangfeixiang
     * @updateTime
     * @throws
     */
    @RequestMapping(value = "/getAllBlog",method = RequestMethod.GET)
    @ResponseBody
    public CommonReturnType getAllContents(@RequestParam(value = "pageNum",defaultValue = "1") Integer pageNum){
        PageInfo<Object> pageInfo= PageHelper.startPage(pageNum,5).doSelectPageInfo(() -> contentsService.getAllContents());

        if (pageInfo !=null){
            logger.info("查询所有博客成功");
            return CommonReturnType.success(pageInfo);
        }
        return CommonReturnType.fail();
    }
}
