package com.jiangfeixiang.springbootblog.filter;

import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.filter
 * @ClassName: AuthorityInterceptor
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: 跨域过滤器
 * @Date: 2019/6/8/0008 8:37
 */
@Component
public class CorsInterceptor implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        response.setHeader("Access-Control-Allow-Origin", request.getHeader("Origin"));
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
        response.setHeader("Access-Control-Max-Age", "3600");
        response.setHeader("Access-Control-Allow-Headers", "x-requested-with");
        //是否支持cookie跨域
        response.setHeader("Access-Control-Allow-Credentials","true");
        filterChain.doFilter(servletRequest, servletResponse);
    }
}
