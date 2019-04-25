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
     *
     * @param file 上传的文件
     * @param path  文件存放路径
     * @param fileName  源文件名称
     * @return
     */
    public static boolean upload(MultipartFile file, String path, String fileName) {

        //随机生成新的文件名
        String realPath = UUID.randomUUID()+path + "/" + fileName;
        //封装上传文件位置的全路径
        File dest = new File(realPath);
        //判断文件父目录是否存在
        if (!dest.getParentFile().exists()) {
            dest.getParentFile().mkdir();
        }
        try {
            //保存文件
            file.transferTo(dest);
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
