package com.jiangfeixiang.springbootblog.util;

import org.apache.xmlbeans.impl.xb.xsdschema.Public;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.util
 * @ClassName: CaptchaHelper
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: wueasy验证码接口
 * @Date: 2019/6/17/0017 22:05
 */
public interface CaptchaHelper {
    /**
     * 保存验证码
     *
     * @param key     手机号码或邮箱，唯一
     * @param captcha 验证码
     * @param ip      ip地址码
     * @author: fallsea
     */
    void save(String key, String captcha, String ip);

    /**
     * 检查验证码是否有效
     *
     * @param key     手机号码或邮箱，唯一
     * @param captcha 验证码
     * @author: fallsea
     */
    void check(String key, String captcha);
}
