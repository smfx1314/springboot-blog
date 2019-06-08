package com.jiangfeixiang.springbootblog.Exception;

import com.jiangfeixiang.springbootblog.common.CommonReturnType;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.Exception
 * @ClassName: GlobalExceptionHandler
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: 全局异常类
 * @Date: 2019/4/24/0024 9:03
 */

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

    /**
     * 全局异常捕捉处理
     * @param ex
     * @return
     */
    @ExceptionHandler(value = Exception.class)
    public Map errorHandler(HttpServletRequest req,Exception ex) {
        Map map = new HashMap();
        map.put("code", 100);
        map.put("message", ex.getMessage());
        map.put("url", req.getRequestURL());
        map.put("params", req.getParameterMap());
        log.error("发生未处理的异常={}",ex.getMessage(),ex);
        return map;
    }

    /**
     * 拦截捕捉自定义异常 MyException.class
     * @param ex
     * @return
     */
    @ExceptionHandler(value = CommonException.class)
    public Map myErrorHandler(HttpServletRequest req, CommonException ex) {
        Map map = new HashMap();
        map.put("code", ex.getCode());
        map.put("message", ex.getMsg());
        map.put("url", req.getRequestURL());
        map.put("params", req.getParameterMap());
        return map;
    }
}
