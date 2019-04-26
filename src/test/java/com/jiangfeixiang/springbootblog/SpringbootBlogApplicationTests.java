package com.jiangfeixiang.springbootblog;

import com.jiangfeixiang.springbootblog.dao.ContentsDoMapper;
import com.jiangfeixiang.springbootblog.dao.ImagesDoMapper;
import com.jiangfeixiang.springbootblog.entity.ContentsDo;
import com.jiangfeixiang.springbootblog.entity.ImagesDo;
import com.jiangfeixiang.springbootblog.service.model.ContentsImagesModel;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Bean;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;
import java.util.stream.Collectors;

@RunWith(SpringRunner.class)
@SpringBootTest
public class SpringbootBlogApplicationTests {

    @Autowired
    private ImagesDoMapper imagesDoMapper;

    @Autowired
    private ContentsDoMapper contentsDoMapper;

    @Test
    public void contextLoads() {
        List<ContentsDo> contents = contentsDoMapper.getAllContents();
        for (ContentsDo c:contents) {
            System.out.println(c);
        }
        /*ImagesDo imagesDo = imagesDoMapper.selectByContnteId(c.getCid());
        System.out.println(imagesDo.toString());*/

    }

}
