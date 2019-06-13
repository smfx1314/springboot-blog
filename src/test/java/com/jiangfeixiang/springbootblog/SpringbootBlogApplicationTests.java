package com.jiangfeixiang.springbootblog;

import com.github.pagehelper.PageInfo;
import com.jiangfeixiang.springbootblog.service.BlogService;
import com.jiangfeixiang.springbootblog.service.model.BlogAndImageModel;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest
public class SpringbootBlogApplicationTests {

    @Autowired
    private BlogService blogService;

    @Test
    public void contextLoads() {
      /*  List<BlogAndImageModel> blogAndImageModelPageInfo = blogService.selectAllBlogs();
        System.out.println(blogAndImageModelPageInfo);*/
    }
}
