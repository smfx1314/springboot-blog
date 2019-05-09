package com.jiangfeixiang.springbootblog.controller.admin;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiangfeixiang.springbootblog.common.CommonReturnType;
import com.jiangfeixiang.springbootblog.entity.BlogsDo;
import com.jiangfeixiang.springbootblog.service.BlogService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.controller.admin
 * @ClassName: BlogController
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: blog controller类
 * @Date: 2019/5/8/0008 10:03
 */
@Controller
@RequestMapping("/contents")
@CrossOrigin(allowCredentials = "true",allowedHeaders = "*")
public class AdminBlogController {
    private final static Logger logger = LoggerFactory.getLogger(AdminBlogController.class);


    @Autowired
    private BlogService blogService;

    /**
     * 源文件拓展名称
     */
    String newFileName=null;
    /**
     * 上传文件
     * @param file
     * @return
     */
    @RequestMapping(value = "/uploadImage",method = RequestMethod.POST)
    @ResponseBody
    public CommonReturnType uploadImage(@RequestParam(value="title_Url") MultipartFile file) {
        //保存图片的路径
        String path = "M:\\upload";
        //获取原始图片的拓展名
        String originalFilename = file.getOriginalFilename();
        //UUID+源文件名称随机生成新的文件名
        newFileName = UUID.randomUUID()+ originalFilename;
        System.out.println(newFileName);
        //封装上传文件位置的全路径
        File targetFile  = new File(path,newFileName);
        //保存文件
        try {
            file.transferTo(targetFile );
            logger.info("上传图片成功");
        } catch (IOException e) {
            e.printStackTrace();
        }
        return CommonReturnType.success();
    }

    /**
     * 插入blog
     * @param title
     * @param content
     * @param description
     * @param status
     * @param tags
     * @param allowcomment
     * @param session
     * @return
     */
    @RequestMapping(value = "/insertBlog",method = RequestMethod.POST)
    @ResponseBody
    public CommonReturnType insertBlog(@RequestParam("title") String title,
                                       @RequestParam("content") String content,
                                       @RequestParam("description") String description,
                                       @RequestParam("status") Integer status,
                                       @RequestParam("tags") String tags,
                                       @RequestParam("allowcomment") Integer allowcomment,
                                       HttpSession session) {

        BlogsDo blogsDo = new BlogsDo();
        blogsDo.setTitle(title);
        blogsDo.setContent(content);
        blogsDo.setDescription(description);
        blogsDo.setCreated(new Date());
        blogsDo.setStatus(status);
        blogsDo.setTags(tags);
        blogsDo.setAllowComment(allowcomment);
        blogsDo.setTitleUrl(newFileName);
        blogService.insertSelective(blogsDo);

        return CommonReturnType.success();
    }


    /**
     * @title
     * @description  查询博客
     * @author jiangfeixiang
     * @updateTime
     * @throws
     */
    @RequestMapping(value = "/getAllContents",method = RequestMethod.GET)
    @ResponseBody
    //@Cacheable(value="blog-key")
    public CommonReturnType getAllContents(@RequestParam(value = "pageNum",defaultValue = "1") Integer pageNum,
                                           @RequestParam(value = "pageSize",defaultValue = "3") Integer pageSize){
        PageHelper.startPage(pageNum, pageSize);
        List<BlogsDo> blogsDos = blogService.selectAllBlogs();
        PageInfo<BlogsDo> pageInfo=new PageInfo<>(blogsDos);
        return CommonReturnType.success(pageInfo);
    }

    /**
     * @title
     * @description  根据id查询
     * @author jiangfeixiang
     * @updateTime
     * @throws
     */
    @RequestMapping(value = "/getById",method = RequestMethod.GET)
    @ResponseBody
    public CommonReturnType getByContentId(Integer id){
        BlogsDo byContentId = blogService.getByContentId(id);
        if (byContentId !=null){
            logger.info("根据id查询成功");
            return CommonReturnType.success(byContentId);
        }
        return CommonReturnType.fail("未查到数据");
    }
    /**
     * @title
     * @description 删除
     * @author jiangfeixiang
     * @updateTime
     * @throws
     */
    @RequestMapping(value = "/deleteById",method = RequestMethod.GET)
    @ResponseBody
    public CommonReturnType deleteById(Integer id){
        blogService.deleteById(id);
        logger.info("删除博客成功");
        return CommonReturnType.success();
    }

    /**
     * 更新博客
     * @param title
     * @param content
     * @param description
     * @param status
     * @param tags
     * @param allowcomment
     * @param session
     * @return
     */
    @RequestMapping(value = "/updateBlog",method = RequestMethod.POST)
    @ResponseBody
    public CommonReturnType updateBlog(@RequestParam("cid") Integer cid,
                                       @RequestParam("title") String title,
                                       @RequestParam("content") String content,
                                       @RequestParam("description") String description,
                                       @RequestParam("status") Integer status,
                                       @RequestParam("tags") String tags,
                                       @RequestParam("allowcomment") Integer allowcomment,
                                       HttpSession session){


        BlogsDo blogsDo = new BlogsDo();
        blogsDo.setCid(cid);
        blogsDo.setTitle(title);
        blogsDo.setContent(content);
        blogsDo.setDescription(description);
        blogsDo.setModified(new Date());
        blogsDo.setStatus(status);
        blogsDo.setTags(tags);
        blogsDo.setAllowComment(allowcomment);
        blogsDo.setTitleUrl(newFileName);
        blogService.updateByPrimaryKeySelective(blogsDo);
        return CommonReturnType.success();
    }
}