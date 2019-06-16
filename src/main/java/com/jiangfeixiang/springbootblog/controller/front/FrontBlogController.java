package com.jiangfeixiang.springbootblog.controller.front;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiangfeixiang.springbootblog.common.CommonReturnType;
import com.jiangfeixiang.springbootblog.entity.BlogDo;
import com.jiangfeixiang.springbootblog.entity.ImagesDo;
import com.jiangfeixiang.springbootblog.entity.NoticeDo;
import com.jiangfeixiang.springbootblog.service.BlogService;
import com.jiangfeixiang.springbootblog.service.ImagesService;
import com.jiangfeixiang.springbootblog.service.NoticeService;
import com.jiangfeixiang.springbootblog.service.model.BlogAndImageModel;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
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
@Slf4j
@Controller
@RequestMapping("/blog")
public class FrontBlogController {

    @Autowired
    private BlogService blogService;

    @Autowired
    private ImagesService imagesService;

    @Autowired
    private NoticeService noticeService;

    /**
     * @title
     * @description  查询所有博客并分页
     * @author jiangfeixiang
     * @updateTime
     * @throws
     */
    @RequestMapping(value = "/getAllBlog",method = RequestMethod.GET)
    @ResponseBody
    public CommonReturnType getAllContents(@RequestParam(value = "pageNum",defaultValue = "1") int pageNum,
                                           @RequestParam(value = "pageSize",defaultValue = "3") int pageSize){
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

    /**
     * 查询标签
     * @return
     */
    @RequestMapping(value = "/selectAllTag",method = RequestMethod.GET)
    @ResponseBody
    public CommonReturnType selectAllTag(){
        List<BlogDo> blogDos = blogService.selectAllTag();
        if (blogDos !=null){
            return CommonReturnType.success(blogDos);
        }
        return CommonReturnType.fail("未查询到数据");
    }

    /**
     * 根据tag查询
     * @param
     * @return
     */
   /* @RequestMapping(value = "/selectByTag",method = RequestMethod.GET)
    @ResponseBody
    public CommonReturnType selectByTag(String tag){
        List<BlogDo> blogDos = blogService.selectByTag(tag);
        if (blogDos !=null){
            return CommonReturnType.success(blogDos);
        }
        return CommonReturnType.fail("未查询到数据");
    }*/


    @RequestMapping(value = "/selectNotice",method = RequestMethod.GET)
    @ResponseBody
   public CommonReturnType selectNotice(){
        NoticeDo noticeDo = noticeService.selectNotice();
        if (noticeDo !=null){
            return CommonReturnType.success(noticeDo);
        }
        return CommonReturnType.fail("未查询到数据");
   }
}
