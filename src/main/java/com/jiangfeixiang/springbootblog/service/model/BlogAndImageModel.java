package com.jiangfeixiang.springbootblog.service.model;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.service.model
 * @ClassName: BlogAndImageModel
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: contents和images模型类
 * @Date: 2019/4/24/0024 15:12
 */
@Data
public class BlogAndImageModel implements Serializable {

    private Integer bid;

    private String title;

    private String content;

    private String description;

    private Date created;

    private Integer authorId;

    private Integer status;

    private String tags;

    private Integer allowComment;

    private Date modified;

    private String titleUrl;

}
