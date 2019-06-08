package com.jiangfeixiang.springbootblog.Exception;

import lombok.Data;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.Exception
 * @ClassName: CommonException
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: 自定义异常处理类
 * @Date: 2019/6/8/0008 11:55
 */
@Data
public class CommonException extends RuntimeException {
    private int code;
    private String msg;
    public CommonException(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

}
