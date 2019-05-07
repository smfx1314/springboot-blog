package com.jiangfeixiang.springbootblog.controller.admin;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiangfeixiang.springbootblog.common.CommonReturnType;
import com.jiangfeixiang.springbootblog.config.DateFormatConfig;
import com.jiangfeixiang.springbootblog.entity.UserDo;
import com.jiangfeixiang.springbootblog.service.ContentsService;
import com.jiangfeixiang.springbootblog.service.model.ContentsImagesModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.controller.admin
 * @ClassName: ContentsController
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: Contents控制类
 * @Date: 2019/4/24/0024 15:09
 */
@Controller
@RequestMapping("/contents")
@CrossOrigin(allowCredentials = "true",allowedHeaders = "*")
public class ContentsController {
    private final static Logger logger = LoggerFactory.getLogger(ContentsController.class);

    @Autowired
    private ContentsService contentsService;

    @Autowired
    private RedisTemplate redisTemplate;

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
        //String path = "/usr/local/upload";
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
     * 写博客，插入博客内容
     * @param title
     * @param content
     * @param description
     * @param status
     * @param tags
     * @param categories
     * @param allow_comment
     * @return
     */
    @RequestMapping(value = "/insertBlog",method = RequestMethod.POST)
    @ResponseBody
    public CommonReturnType insertBlog(@RequestParam("title") String title,
                                       @RequestParam("content") String content,
                                       @RequestParam("description") String description,
                                       @RequestParam(value = "status",defaultValue = "1") Integer status,
                                       @RequestParam("tags") String tags,
                                       @RequestParam("categories") String categories,
                                       @RequestParam(value = "allow_comment",defaultValue = "1") Integer allow_comment,
                                       HttpSession session) {

        ContentsImagesModel contentsImagesModel = new ContentsImagesModel();
        contentsImagesModel.setTitle(title);
        contentsImagesModel.setContent(content);
        contentsImagesModel.setDescription(description);
        contentsImagesModel.setCreated(new Date());
        contentsImagesModel.setStatus(status);
        contentsImagesModel.setTags(tags);
        contentsImagesModel.setCategories(categories);
        contentsImagesModel.setAllowComment(allow_comment);
        contentsImagesModel.setTitleUrl(newFileName);
        /*UserDo userDo = (UserDo) session.getAttribute("LOGIN_USER");
        contentsImagesModel.setAuthorId(userDo.getUid());*/
        contentsService.insertSelective(contentsImagesModel);
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
    public CommonReturnType getAllContents(@RequestParam(value = "pageNum",defaultValue = "1") Integer pageNum){
        PageHelper.startPage(pageNum, 3,true);
        List<ContentsImagesModel> cims = contentsService.getAllContents();
        PageInfo<ContentsImagesModel> pageInfo=new PageInfo<>(cims);
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
        ContentsImagesModel contentsImagesModel = contentsService.getByContentId(id);
        if (contentsImagesModel !=null){
            logger.info("根据id查询成功");
            return CommonReturnType.success(contentsImagesModel);
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
        contentsService.deleteById(id);
        logger.info("删除博客成功");
        return CommonReturnType.success();
    }
}
