package com.jiangfeixiang.springbootblog.controller.admin;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiangfeixiang.springbootblog.common.CommonReturnType;
import com.jiangfeixiang.springbootblog.entity.ReaderMassageDo;
import com.jiangfeixiang.springbootblog.service.ReaderMsgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.controller.admin
 * @ClassName: AdminReaderMsgController
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: 后端留言板controller
 * @Date: 2019/5/9/0009 13:45
 */
@Controller
@RequestMapping("/admin")
@CrossOrigin(allowCredentials = "true",allowedHeaders = "*")
public class AdminReaderMsgController {

    @Autowired
    private ReaderMsgService readerMsgService;


    /**
     * 获取所有留言
     * @param pageNum
     * @param pageSize
     * @return
     */
    @RequestMapping(value = "/getAllMsg",method = RequestMethod.GET)
    @ResponseBody
    public CommonReturnType getAllMsg(@RequestParam(value = "pageNum",defaultValue = "1") int pageNum,
                                      @RequestParam(value = "pageSize",defaultValue = "5") int pageSize) {

        PageHelper.startPage(pageNum, pageSize);
        List<ReaderMassageDo> allMsg = readerMsgService.getAllMsg();
        PageInfo<ReaderMassageDo> pageInfo=new PageInfo<>(allMsg);
        return CommonReturnType.success(pageInfo);

    }

    /**
     * 根据id查询留言信息内容
     * @param id
     * @return
     */
    @RequestMapping(value = "/selectByMsgId",method = RequestMethod.GET)
    @ResponseBody
    public CommonReturnType selectByPrimaryKey(Integer id) {
        ReaderMassageDo readerMassageDo = readerMsgService.selectByPrimaryKey(id);
        if (readerMassageDo !=null) {
            return CommonReturnType.success(readerMassageDo);
        }
        return CommonReturnType.fail();
    }
}
