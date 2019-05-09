package com.jiangfeixiang.springbootblog.service;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.service
 * @ClassName: MailService
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: 邮件接口
 * @Date: 2019/5/9/0009 17:04
 */
public interface MailService {
    /**
     * 发送文本邮件
     * @param to
     * @param subject
     * @param content
     */
    void sendSimpleMail(String to, String subject, String content);

}
