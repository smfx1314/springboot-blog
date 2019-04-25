package com.jiangfeixiang.springbootblog.service;

import com.jiangfeixiang.springbootblog.entity.UserDo;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.service
 * @ClassName: UserService
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: UserService接口
 * @Date: 2019/4/23/0023 22:19
 */
public interface UserService {

     /**
     * 注册用户
     * @param userDo
     * @return
     */
    int insertUser(UserDo userDo);


    /**
     * 登录
     * @param username
     * @param password
     */
    UserDo login(String username, String password);

    /**
     * 校验用户名是否存在 根据用户名查询
     * @param username
     * @return
     */
    UserDo selectByUsername(String username);

    /**
     * 登录 根据用户名密码查询
     * @param username
     * @param password
     * @return
     */
    UserDo selectByUsernameAndPassword(String username,String password);
}
