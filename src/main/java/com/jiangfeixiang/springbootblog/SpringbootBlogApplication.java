package com.jiangfeixiang.springbootblog;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
/**
 * @title
 * @description
 * @author jiangfeixiang
 * @updateTime
 * @throws
 */

@SpringBootApplication
@MapperScan("com.jiangfeixiang.springbootblog.dao")
public class SpringbootBlogApplication {

    public static void main(String[] args) {
        SpringApplication.run(SpringbootBlogApplication.class, args);
    }

}
