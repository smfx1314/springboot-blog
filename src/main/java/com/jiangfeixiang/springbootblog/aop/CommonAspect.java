package com.jiangfeixiang.springbootblog.aop;

import com.jiangfeixiang.springbootblog.entity.LogsDo;
import com.jiangfeixiang.springbootblog.service.LogsService;
import com.jiangfeixiang.springbootblog.util.AopContextUtil;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.*;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Date;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.aop
 * @ClassName: CommonAspect
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: springaop系统日志：切面处理类
 * @Date: 2019/6/12/0012 20:34
 */
@Aspect
@Component
@Slf4j
public class CommonAspect {

    @Autowired
    private LogsService logsService;

    /**
     *  定义切点 @Pointcut
     */
    @Pointcut("execution(* com.jiangfeixiang.springbootblog.controller.admin.*.*(..))")
    public void log(){
    }

    /**
     * ProceedingJoinPoint仅支持@Around
     */
    @AfterReturning("log()")
    public void saveOperation(JoinPoint joinPoint ){
        log.info("---------------接口日志记录---------------");
        // 创建一个日志对象(准备记录日志)
        LogsDo logsDo = new LogsDo();

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        //IP地址
        String ipAddr = AopContextUtil.getIpAddress(request);
        logsDo.setClientip(ipAddr);
        //url
        String url = request.getRequestURL().toString();
        logsDo.setOperurl(url);
        //请求参数
        String reqParam =AopContextUtil.preHandle(joinPoint,request);
        logsDo.setReqparam(reqParam);
        // 1.方法执行前的处理，相当于前置通知
        // 获取方法签名
        MethodSignature signature = (MethodSignature) joinPoint.getSignature();
        //获取切入点所在的方法
        Method method = signature.getMethod();
        // 获取方法上面的注解
        LogAnno logAnno = method.getAnnotation(LogAnno.class);
        if (logAnno !=null){
        // 获取操作描述的属性值
        String operateType = logAnno.operateType();
        // 保存操作说明
        logsDo.setOpertype(operateType);
        }
        //TODO 设置操作人，从session中获取，这里简化了一下，写死了。

        // 设置操作日期
        logsDo.setOpertime(new Date());
        logsService.insertSelective(logsDo);
    }
}
