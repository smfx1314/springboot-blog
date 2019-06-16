package com.jiangfeixiang.springbootblog.controller.admin;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiangfeixiang.springbootblog.aop.LogAnno;
import com.jiangfeixiang.springbootblog.common.CommonReturnType;
import com.jiangfeixiang.springbootblog.entity.LogsDo;
import com.jiangfeixiang.springbootblog.service.LogsService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.controller.admin
 * @ClassName: LogController
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: 操作日志记录
 * @Date: 2019/6/16/0016 12:00
 */
@Controller
@RequestMapping("/log")
@Slf4j
public class LogController {

    @Autowired
    private LogsService logsService;

    @LogAnno(operateType = "查询所有日志操作")
    @RequestMapping(value = "/selectAllLog",method = RequestMethod.GET)
    @ResponseBody
    public CommonReturnType selectAllLog(@RequestParam(value = "pageNum",defaultValue = "1") Integer pageNum,
                                         @RequestParam(value = "pageSize",defaultValue = "10") Integer pageSize){
        PageHelper.startPage(pageNum,pageSize);
        List<LogsDo> logsDos = logsService.selectAllLog();
        PageInfo<LogsDo> pageInfo = new PageInfo<>(logsDos);
        return  CommonReturnType.success(pageInfo);
    }
}
