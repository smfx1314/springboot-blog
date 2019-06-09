package com.jiangfeixiang.springbootblog.Exception;

import com.jiangfeixiang.springbootblog.common.CommonReturnType;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

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
 * @Description: 全局异常处理类
 * 如果全部异常处理都返回json，那么可以使用 @RestControllerAdvice 代替 @ControllerAdvice
 * 这样在方法上就可以不需要添加 @ResponseBody。
 * @RestControllerAdvice在注解上已经添加了@ResponseBody。
 * @Date: 2019/4/24/0024 9:03
 */
@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    /**
     * 捕获CustomException
     * 指定拦截异常的类型
     * 自定义浏览器返回状态码
     * @param e
     * @return json格式类型
     */
    @ExceptionHandler({CommonException.class})
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public Map<String, Object> customExceptionHandler(CommonException e) {
        Map<String, Object> map = new HashMap<>(20);
        map.put("code", e.getCode());
        map.put("msg", e.getMsg());
        return map;
    }
}
