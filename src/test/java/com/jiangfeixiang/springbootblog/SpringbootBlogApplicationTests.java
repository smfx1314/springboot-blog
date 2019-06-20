package com.jiangfeixiang.springbootblog;

import com.jiangfeixiang.springbootblog.util.CaptchaHelper;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
@Slf4j
public class SpringbootBlogApplicationTests {

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Test
    public void contextLoads() {
        stringRedisTemplate.opsForValue().set("aaa","bbb");
        log.info(stringRedisTemplate.opsForValue().get("aaa"));
    }
}
