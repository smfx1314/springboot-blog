package com.jiangfeixiang.springbootblog.controller.admin;

import com.jiangfeixiang.springbootblog.aop.LogAnno;
import com.jiangfeixiang.springbootblog.common.CommonReturnType;
import com.jiangfeixiang.springbootblog.entity.NoticeDo;
import com.jiangfeixiang.springbootblog.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.controller.admin
 * @ClassName: NoticeController
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: 公告控制类
 * @Date: 2019/6/16/0016 9:43
 */
@Controller
@RequestMapping("/notice")
public class NoticeController {

    @Autowired
    private NoticeService noticeService;

    /**
     * 添加公告
     * @param content
     * @return
     */
    @LogAnno(operateType = "增加公告")
    @RequestMapping(value = "/insertNotice",method = RequestMethod.POST)
    @ResponseBody
    public CommonReturnType insertNotice(@RequestParam("content") String content){
        NoticeDo noticeDo = new NoticeDo();
        noticeDo.setContent(content);
        noticeDo.setCreateTime(new Date());
        noticeService.insertSelective(noticeDo);
        return CommonReturnType.success();
    }


    /**
     * 查询所有公告
     * @return
     */
    @LogAnno(operateType="查询所有公告")
    @RequestMapping(value = "/selectAllNotice",method = RequestMethod.GET)
    @ResponseBody
    public CommonReturnType selectAllNotice(){
        List<NoticeDo> noticeDos = noticeService.selectAllNotice();
        if (noticeDos !=null){
            return CommonReturnType.success(noticeDos);
        }
        return CommonReturnType.fail("未查询到数据");
    }
}
