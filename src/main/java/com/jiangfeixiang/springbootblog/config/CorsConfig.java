package com.jiangfeixiang.springbootblog.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.config
 * @ClassName: CORSConfig
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: 跨域配置
 * @Date: 2019/5/13/0013 14:45
 */
@Configuration
public class CorsConfig implements WebMvcConfigurer {
    /**
     * 跨域
     * @param registry
     */
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        //设置允许跨域的路径
        registry.addMapping("/**")
                //设置允许跨域请求的域名
                .allowedOrigins("*")
                //是否允许证书 不再默认开启
                .allowCredentials(true)
                //允许可以接受cookie
                .allowCredentials(true)
                //设置允许的方法
                .allowedMethods("*");
    }
}
