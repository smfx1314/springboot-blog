package com.jiangfeixiang.springbootblog.service.model;

import lombok.Data;

import javax.validation.constraints.Email;
import java.io.Serializable;
import java.util.Date;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.controller.vo
 * @ClassName: UserAndPassword
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: 用户和密码模型
 * @Date: 2019/6/7/0007 14:44
 */
@Data
public class UserAndPassword implements Serializable {
    private Integer uid;
    private String username;
    private String password;
    private String email;
    private Date created;
}
