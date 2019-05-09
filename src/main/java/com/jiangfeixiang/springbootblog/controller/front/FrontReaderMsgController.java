package com.jiangfeixiang.springbootblog.controller.front;

import com.jiangfeixiang.springbootblog.common.CommonReturnType;
import com.jiangfeixiang.springbootblog.entity.ReaderMassageDo;
import com.jiangfeixiang.springbootblog.service.MailService;
import com.jiangfeixiang.springbootblog.service.ReaderMsgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.controller.front
 * @ClassName: ReaderMsgController
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: 留言板controller
 * @Date: 2019/5/9/0009 13:42
 */
@Controller
@RequestMapping("/front")
@CrossOrigin(allowCredentials = "true",allowedHeaders = "*")
public class FrontReaderMsgController {

    @Autowired
    private ReaderMsgService readerMsgService;

    @Autowired
    private MailService mailService;

    /**
     * 插入留言
     * @return
     */
    @RequestMapping(value = "/insertMsg",method = RequestMethod.POST)
    @ResponseBody
    public CommonReturnType insertMsg(ReaderMassageDo readerMassageDo) {
        readerMassageDo.setCreated(new Date());
        readerMsgService.insertSelective(readerMassageDo);
        //同时发送博主邮箱通知留言
        mailService.sendSimpleMail("1016767658@qq.com",readerMassageDo.getTitle(),readerMassageDo.getContent());
        return CommonReturnType.success();

    }

}
