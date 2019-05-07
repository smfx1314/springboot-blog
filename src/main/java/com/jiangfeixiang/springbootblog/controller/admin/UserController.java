package com.jiangfeixiang.springbootblog.controller.admin;

import com.jiangfeixiang.springbootblog.common.CommonReturnType;
import com.jiangfeixiang.springbootblog.entity.UserDo;
import com.jiangfeixiang.springbootblog.service.UserService;
import com.jiangfeixiang.springbootblog.util.MyMD5Util;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.controller.admin
 * @ClassName: UserController
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: User控制l类
 * @Date: 2019/4/23/0023 22:17
 */
@Controller
@RequestMapping("/user")
@CrossOrigin(allowCredentials = "true",allowedHeaders = "*")
public class UserController {
    private final static Logger logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private UserService userService;


    /**
     * 注册用户
     * @param
     * @return
     */
    @RequestMapping("/insertUser")
    @ResponseBody
    public CommonReturnType insertUser(@RequestParam("username") String username,
                                       @RequestParam("password") String password,
                                       @RequestParam("email") String email){
        /*System.out.println("111111"+CodeUtil.checkVerifyCode(request));
        if (CodeUtil.checkVerifyCode(request)==false) {
            return CommonReturnType.fail("验证码不能为空");
        }
        System.out.println(CodeUtil.checkVerifyCode(request));*/
        //md5加密密码
        String md5Password = MyMD5Util.md5Password(password);
        UserDo userDo = new UserDo();
        userDo.setUsername(username);
        userDo.setPassword(md5Password);
        userDo.setEmail(email);
        userDo.setCreated(new Date());

        int i = userService.insertUser(userDo);
        if (i>0){
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
    @RequestMapping("/login")
    @ResponseBody
    public CommonReturnType login(@RequestParam("username") String username,
                                  @RequestParam("password") String password,
                                  HttpSession session){

        //比对加密后的密码是否一致
        String md5Password = MyMD5Util.md5Password(password);
        UserDo userDo = userService.login(username, md5Password);
        if (userDo!=null){
            //用户session
            session.setAttribute("LOGIN_USER",userDo);
            return CommonReturnType.success();
        }
        return CommonReturnType.fail("用户名或密码不正确");
    }

}
