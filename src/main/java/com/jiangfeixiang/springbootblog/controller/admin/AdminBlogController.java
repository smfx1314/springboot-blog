package com.jiangfeixiang.springbootblog.controller.admin;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiangfeixiang.springbootblog.aop.LogAnno;
import com.jiangfeixiang.springbootblog.common.CommonReturnType;
import com.jiangfeixiang.springbootblog.entity.BlogDo;
import com.jiangfeixiang.springbootblog.entity.ImagesDo;
import com.jiangfeixiang.springbootblog.service.BlogService;
import com.jiangfeixiang.springbootblog.service.ImagesService;
import com.jiangfeixiang.springbootblog.service.model.BlogAndImageModel;
import com.jiangfeixiang.springbootblog.service.model.UserAndPassword;
import com.jiangfeixiang.springbootblog.util.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
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
public class AdminBlogController {
    private final static Logger logger = LoggerFactory.getLogger(AdminBlogController.class);


    @Autowired
    private BlogService blogService;

    @Autowired
    private ImagesService imagesService;
    /**
     * 源文件拓展名称
     */
    private static String newFileName;

    /**
     * 上传文件
     * @param file
     * @return
     */
    @LogAnno(operateType = "上传文件")
    @RequestMapping(value = "/uploadImage",method = RequestMethod.POST)
    @ResponseBody
    public CommonReturnType uploadImage(@RequestParam(value="title_Url") MultipartFile file) {
        //保存图片的路径
        String path = "M:\\upload";
        //String path = "/usr/local/upload";
        //上传图片
        //获取原始图片的拓展名
        String originalFilename = file.getOriginalFilename();
        //UUID+源文件名称随机生成新的文件名
        newFileName = UUID.randomUUID()+ originalFilename;
        //封装上传文件位置的全路径
        File targetFile  = new File(path,newFileName);
        try {
            //保存文件
            file.transferTo(targetFile );
        } catch (IllegalStateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return CommonReturnType.success();
    }

    /**
     * 插入blog
     * @param session
     * @return
     */
    @LogAnno(operateType = "添加博客")
    @RequestMapping(value = "/insertBlog",method = RequestMethod.POST)
    @ResponseBody
    public CommonReturnType insertBlog(BlogAndImageModel blogAndImageModel,HttpSession session) {
        blogAndImageModel.setTitleUrl(newFileName);
        blogAndImageModel.setCreated(new Date());
        //获取用户id
        /*UserAndPassword login_user = (UserAndPassword) session.getAttribute("user");
        blogAndImageModel.setAuthorId(login_user.getUid());*/
        blogService.insertSelective(blogAndImageModel);

        return CommonReturnType.success();
    }


    /**
     * @title
     * @description  查询博客
     * @author jiangfeixiang
     * @updateTime
     * @throws
     */
    @LogAnno(operateType = "查询博客")
    @RequestMapping(value = "/getAllContents",method = RequestMethod.GET)
    @ResponseBody
    public CommonReturnType getAllContents(@RequestParam(value = "pageNum",defaultValue = "1") Integer pageNum,
                                           @RequestParam(value = "pageSize",defaultValue = "10") Integer pageSize){
        PageHelper.startPage(pageNum, pageSize);
        List<BlogDo> blogDos = blogService.selectAllBlogs();
        PageInfo pageInfo = new PageInfo(blogDos);

        List<BlogAndImageModel> list = new ArrayList<>();
        for (BlogDo blogDo:blogDos) {
            BlogAndImageModel blogAndImageModel = new BlogAndImageModel();
            blogAndImageModel.setBid(blogDo.getBid());
            blogAndImageModel.setTitle(blogDo.getTitle());
            blogAndImageModel.setContent(blogDo.getContent());
            blogAndImageModel.setDescription(blogDo.getDescription());
            blogAndImageModel.setStatus(blogDo.getStatus());
            blogAndImageModel.setTags(blogDo.getTags());
            blogAndImageModel.setCreated(blogDo.getCreated());
            //根据blogid查询图片
            ImagesDo imagesDo = imagesService.selectByBlogId(blogDo.getBid());
            blogAndImageModel.setTitleUrl(imagesDo.getTitleUrl());
            blogAndImageModel.setAllowComment(blogDo.getAllowComment());
            //添加list集合中
            list.add(blogAndImageModel);
        }
        pageInfo.setList(list);
        return CommonReturnType.success(pageInfo);
    }


    /**
     * @title
     * @description  根据id查询
     * @author jiangfeixiang
     * @updateTime
     * @throws
     */
    @LogAnno(operateType = "根据id查询")
    @RequestMapping(value = "/getById",method = RequestMethod.GET)
    @ResponseBody
    public CommonReturnType getByContentId(Integer id){
        BlogAndImageModel byContentId = blogService.getByContentId(id);
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
    @LogAnno(operateType = "根据id删除")
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
    @LogAnno(operateType = "更新博客")
    @RequestMapping(value = "/updateBlog",method = RequestMethod.POST)
    @ResponseBody
    public CommonReturnType updateBlog( @RequestParam("bid") Integer bid,
                                        @RequestParam("title") String title,
                                        @RequestParam("content") String content,
                                        @RequestParam("description") String description,
                                        @RequestParam("status") Integer status,
                                        @RequestParam("tags") String tags,
                                        @RequestParam("allowcomment") Integer allowcomment,
                                        HttpSession session){


        BlogAndImageModel blogAndImageModel = new BlogAndImageModel();
        blogAndImageModel.setBid(bid);
        blogAndImageModel.setTitle(title);
        blogAndImageModel.setContent(content);
        blogAndImageModel.setDescription(description);
        blogAndImageModel.setModified(new Date());
        blogAndImageModel.setStatus(status);
        blogAndImageModel.setTags(tags);
        blogAndImageModel.setAllowComment(allowcomment);
        blogAndImageModel.setTitleUrl(newFileName);
        blogService.updateByPrimaryKeySelective(blogAndImageModel);
        return CommonReturnType.success();
    }
}
