package com.jiangfeixiang.springbootblog.service;

import com.jiangfeixiang.springbootblog.entity.ContentsDo;
import com.jiangfeixiang.springbootblog.entity.ImagesDo;
import com.jiangfeixiang.springbootblog.service.model.ContentsImagesModel;

import java.util.List;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.service
 * @ClassName: ContentsService
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: Contentsservice接口类
 * @Date: 2019/4/24/0024 15:06
 */
public interface ContentsService {

    /**
     * 插入博客内容
     * @param contentsImagesModel
     * @return
     */
    void insertSelective(ContentsImagesModel contentsImagesModel);

    /**
     * 查询所有
     * @return
     */
    List<ContentsImagesModel> getAllContents();

    /**
     * 根据id查询
     */


    /**
     * 删除
     */
    void deleteById(Integer id);
}
