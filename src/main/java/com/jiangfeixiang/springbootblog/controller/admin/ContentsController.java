package com.jiangfeixiang.springbootblog.controller.admin;

import com.jiangfeixiang.springbootblog.common.CommonReturnType;
import com.jiangfeixiang.springbootblog.entity.UserDo;
import com.jiangfeixiang.springbootblog.service.ContentsService;
import com.jiangfeixiang.springbootblog.service.model.ContentsImagesModel;
import com.jiangfeixiang.springbootblog.util.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;

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

    /**
     * 上传文件
     * @param file
     * @return
     */
    @RequestMapping(value = "/uploadImage",method = RequestMethod.POST)
    @ResponseBody
    public CommonReturnType uploadImage(@RequestParam(value="title_Url") MultipartFile file) {
        //图片上传成功后，将图片的地址写到数据库
        //保存图片的路径
        String path = "M:\\upload";
        if (FileUtils.upload(file, path)) {
            logger.info("上传图片成功");
            // 上传成功，给出页面提示
            return CommonReturnType.success("上传成功");
        } else {
            logger.info("上传图片失败");
            return CommonReturnType.fail("图片上传失败");
        }
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
                                       HttpServletRequest request) {
        //判断用户是否登录
        UserDo userDo = (UserDo) request.getSession().getAttribute("userDo");
        System.out.println(userDo);
        if (userDo == null){
            return CommonReturnType.fail("用户未登录");
        }
        ContentsImagesModel contentsImagesModel = new ContentsImagesModel();
        contentsImagesModel.setTitle(title);
        contentsImagesModel.setContent(content);
        contentsImagesModel.setDescription(description);
        contentsImagesModel.setStatus(status);
        contentsImagesModel.setTags(tags);
        contentsImagesModel.setCategories(categories);
        contentsImagesModel.setAllowComment(allow_comment);
        contentsImagesModel.setAuthorId(userDo.getUid());
        contentsService.insertSelective(contentsImagesModel);
        return CommonReturnType.success();
    }
}
