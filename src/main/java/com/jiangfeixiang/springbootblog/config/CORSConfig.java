package com.jiangfeixiang.springbootblog.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

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
public class CORSConfig implements WebMvcConfigurer {
    /**
     * 跨域
     * @param registry
     */
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        // 允许所有跨域访问
        registry.addMapping("/**");
    }
}
