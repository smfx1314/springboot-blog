package com.jiangfeixiang.springbootblog.util;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.util
 * @ClassName: FileUtils
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: 文件上传工具类
 * @Date: 2019/4/24/0024 20:25
 */
public class FileUtils {


    /**
     * @param file 上传的文件
     * @param path  文件上传路径
     * @return
     */
    public static boolean upload(MultipartFile file,String path) {

        //获取原始图片的拓展名
        String originalFilename = file.getOriginalFilename();
        //UUID+源文件名称随机生成新的文件名
        String newFileName = UUID.randomUUID()+ originalFilename;
        //封装上传文件位置的全路径
        File targetFile  = new File(path,newFileName);
        try {
            //保存文件
            file.transferTo(targetFile );
            return true;
        } catch (IllegalStateException e) {
            e.printStackTrace();
            return false;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
}
