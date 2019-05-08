package com.jiangfeixiang.springbootblog;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

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
        //配置数据源和开启Mybatis的自动驼峰映射
        //1.初始化
        //SpringApplication application=  new SpringApplication(MybatisTransactionApplication.class);

        //2.添加数据源
       /* Map<String,Object> map = new HashMap<>();
        map.put("spring.datasource.url","jdbc:mysql://localhost:3306/springboot-blog?useSSL=false");
        map.put("spring.datasource.username","root");
        map.put("spring.datasource.password","1234");*/

        //3.开启驼峰映射 (Such as account_id ==> accountId)
       /* map.put("mybatis.configuration.map-underscore-to-camel-case",true);
        application.setDefaultProperties(map);*/
        SpringApplication.run(SpringbootBlogApplication.class, args);
    }

}
