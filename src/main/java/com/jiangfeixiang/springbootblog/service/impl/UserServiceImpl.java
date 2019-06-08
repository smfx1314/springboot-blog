package com.jiangfeixiang.springbootblog.service.impl;

import com.jiangfeixiang.springbootblog.service.model.UserAndPassword;
import com.jiangfeixiang.springbootblog.dao.PasswordDoMapper;
import com.jiangfeixiang.springbootblog.dao.UserDoMapper;
import com.jiangfeixiang.springbootblog.entity.PasswordDo;
import com.jiangfeixiang.springbootblog.entity.UserDo;
import com.jiangfeixiang.springbootblog.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.service.impl
 * @ClassName: UserServiceImpl
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: userservice实现类
 * @Date: 2019/4/23/0023 22:26
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class UserServiceImpl implements UserService {

    /**
     * 注入dao接口
     */
    @Autowired
    private UserDoMapper userDoMapper;

    @Autowired
    private PasswordDoMapper passwordDoMapper;


    /**
     * 注册
     * @param userAndPassword
     * @return
     */
    @Override
    public Boolean insertUser(UserAndPassword userAndPassword) {
        /**
         * 插入用户信息
         */
        UserDo userDo = new UserDo();
        userDo.setUsername(userAndPassword.getUsername());
        userDo.setCreated(userAndPassword.getCreated());
        userDo.setEmail(userAndPassword.getEmail());
        userDoMapper.insertSelective(userDo);
        //获取自增uid，为下面password的外键user_id传值
        userAndPassword.setUid(userDo.getUid());
        /**
         * 插入密码
         */
        PasswordDo passwordDo = new PasswordDo();
        passwordDo.setPassword(userAndPassword.getPassword());
        passwordDo.setUserId(userAndPassword.getUid());
        passwordDoMapper.insertSelective(passwordDo);
        return true;
    }


    /**
     * 校验用户名是否存在/根据用户名查询
     * @param username
     * @return
     */
    @Override
    public UserDo selectByUsername(String username) {
        UserDo userDo = userDoMapper.selectByUsername(username);
        if (userDo !=null){
            return userDo;
        }
        return null;
    }
    
    
    /**
     * 登录
     * @param username
     */
    @Override
    public UserAndPassword login(String username) {
        UserDo userDo = userDoMapper.selectByUsername(username);
        PasswordDo passwordDo = passwordDoMapper.selectByUserId(userDo.getUid());
        UserAndPassword userAndPassword = new UserAndPassword();
        userAndPassword.setUid(userDo.getUid());
        userAndPassword.setPassword(passwordDo.getPassword());
        userAndPassword.setUsername(userDo.getUsername());
        userAndPassword.setEmail(userDo.getEmail());
        userAndPassword.setCreated(userDo.getCreated());
        return userAndPassword;
    }
}
