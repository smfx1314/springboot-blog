package com.jiangfeixiang.springbootblog.service.impl;

import com.jiangfeixiang.springbootblog.dao.UserDoMapper;
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

    /**
     * 登录：根据用户名和密码查询
     * @param username
     * @param password
     * @return
     */
    @Override
    public UserDo selectByUsernameAndPassword(String username, String password) {
        UserDo userDo = userDoMapper.selectByUsernameAndPassword(username, password);
        if (userDo !=null){
            return userDo;
        }
        return null;
    }

    /**
     * 注册
     * @param userDo
     * @return
     */
    @Override
    public int insertUser(UserDo userDo) {
        int i = userDoMapper.insertSelective(userDo);
        if (i>0){
            return i;
        }
        return 0;
    }

    /**
     * 校验用户名是否存在
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
     * @param password
     */
    @Override
    public UserDo login(String username, String password) {
        UserDo userDo = userDoMapper.selectByUsernameAndPassword(username, password);
        if (userDo !=null){
            return userDo;
        }
        return null;
    }

    
}
