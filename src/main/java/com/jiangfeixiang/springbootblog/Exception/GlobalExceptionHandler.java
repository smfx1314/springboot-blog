package com.jiangfeixiang.springbootblog.Exception;

import com.jiangfeixiang.springbootblog.common.CommonReturnType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.Exception
 * @ClassName: GlobalExceptionHandler
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: 全局异常类
 * @Date: 2019/4/24/0024 9:03
 */
@ControllerAdvice
@ResponseBody
public class GlobalExceptionHandler {
    /**
     * 打印log
     */
    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    /**
     * 缺少参数异常
     * @param ex
     * @return
     */
    @ExceptionHandler(MissingServletRequestParameterException.class)
    @ResponseStatus(value = HttpStatus.BAD_REQUEST)
    public CommonReturnType handleHttpMessageNotReadableException(
            MissingServletRequestParameterException ex) {
        logger.error("缺少请求参数，{}", ex.getMessage());
        return CommonReturnType.fail("参数缺少");
    }

    /**
     * 空指针异常
     * @param ex NullPointerException
     * @return
     */
    @ExceptionHandler(NullPointerException.class)
    @ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR)
    public CommonReturnType handleTypeMismatchException(NullPointerException ex) {
        logger.error("空指针异常，{}", ex.getMessage());
        return CommonReturnType.fail("空指针异常");
    }

    /**
     * 系统异常 预期以外异常
     * @param ex
     * @return
     */
    @ExceptionHandler(Exception.class)
    @ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR)
    public CommonReturnType handleUnexpectedServer(Exception ex) {
        logger.error("系统异常：", ex);
        return CommonReturnType.fail("系统发生异常，请联系管理员");
    }
}
