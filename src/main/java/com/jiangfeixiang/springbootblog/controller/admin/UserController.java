package com.jiangfeixiang.springbootblog.controller.admin;

import com.jiangfeixiang.springbootblog.aop.LogAnno;
import com.jiangfeixiang.springbootblog.common.CommonReturnType;
import com.jiangfeixiang.springbootblog.service.model.UserAndPassword;
import com.jiangfeixiang.springbootblog.entity.UserDo;
import com.jiangfeixiang.springbootblog.service.UserService;
import com.jiangfeixiang.springbootblog.util.MyMD5Util;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.Date;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.controller.admin
 * @ClassName: UserController
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: User控制l类
 * @Date: 2019/4/23/0023 22:17
 * 下面这种方式跨域也可以
 * @CrossOrigin(allowCredentials = "true",allowedHeaders = "*")
 */
@Controller
@RequestMapping("/user")
public class UserController {
    private final static Logger logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private UserService userService;


    /**
     * 注册用户
     * @param
     * @return
     */
    @LogAnno(operateType = "注册用户")
    @RequestMapping("/insertUser")
    @ResponseBody
    public CommonReturnType insertUser(@Valid @RequestParam("username") String username,
                                       @Valid @RequestParam("password") String password,
                                       @Valid @RequestParam("email") String email){

        //md5加密密码
        String md5Password = MyMD5Util.md5Password(password);
        UserAndPassword userAndPassword = new UserAndPassword();
        userAndPassword.setUsername(username);
        userAndPassword.setPassword(md5Password);
        userAndPassword.setEmail(email);
        userAndPassword.setCreated(new Date());

        Boolean aBoolean = userService.insertUser(userAndPassword);
        if (aBoolean){
            logger.info("插入用户成功");
            return CommonReturnType.success();
        }else {
            logger.info("插入用户失败");
            return CommonReturnType.fail();
        }
    }

    /**
     * 校验用户
     * @param username
     * @return
     */
    @LogAnno(operateType = "校验用户名")
    @RequestMapping("/checkUsername")
    @ResponseBody
    public CommonReturnType checkUsername(String username){
        UserDo userDo = userService.selectByUsername(username);
        logger.info("校验用户名");
        if (userDo !=null){
            return CommonReturnType.success();
        }
        return CommonReturnType.fail("用户名不存在");
    }

    /**
     * 用户登录
     * @param username
     * @param password
     * @return
     */
    @LogAnno(operateType = "用户登录")
    @RequestMapping("/login")
    @ResponseBody
    public CommonReturnType login(@RequestParam("username") String username,
                                  @RequestParam("password") String password,
                                  HttpSession session){

        //比对加密后的密码是否一致
        String md5Password = MyMD5Util.md5Password(password);
        UserAndPassword userAndPassword = userService.login(username);
        if (md5Password.equals(userAndPassword.getPassword())){
            return CommonReturnType.success();
        }
        return CommonReturnType.fail("用户名或密码不正确");
    }
}
