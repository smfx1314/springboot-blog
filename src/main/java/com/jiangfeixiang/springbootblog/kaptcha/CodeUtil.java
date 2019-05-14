package com.jiangfeixiang.springbootblog.kaptcha;

import javax.servlet.http.HttpServletRequest;

/**
 * @ProjectName: springboot-kaptcha
 * @Package: com.jiangfeixiang.springbootkaptcha.utils
 * @ClassName: CodeUtil
 * @Author: jiangfeixiang
 * @Description: 验证码工具类
 * @Date: 2019/4/21/0021 14:49
 */
public class CodeUtil {

    /**
     *验证码校验
     * @return
     */
    public static boolean checkVerifyCode(String key) {
        HttpServletRequest request=null;
        //获取生成的验证码
        String verifyCodeExpected = (String) request.getSession().getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
        //获取用户输入的验证码
        String verifyCodeActual =request.getParameter(key);
        if(verifyCodeActual == null ||!verifyCodeActual.equals(verifyCodeExpected)) {
            return false;
        }
        return true;
    }
}
