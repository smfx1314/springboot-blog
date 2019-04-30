### 简博客—开源免费个人博客
#### 概述
> 一直以来都想搭建自己的个人博客，期间也利用ssm框架搭建过但是由于种种原因没有整理发布  
这次主要通过springboot+mybatis搭建简单博客。通过前后端分离开发，后台主要有增删改查博客功能  
前台主要显示博客，分类标签以及留言板功能。 
#### 参考博主
本博客主要前后台模板主要参考[这位博主](http://www.dingyinwu.com/index.html)的模板，点击[网盘下载提取码: bi8h](https://pan.baidu.com/s/14cRvKkbERP9hOOFFY-Cgpg)即可。  
另外我觉得这位[博主](http://13blog.site/)的页面效果也不错，源码请点击[这里](https://github.com/smfx1314/pinghsu)  
本博客页面参考请点击[这里](https://github.com/smfx1314/springboot-blog-web)
#### 博客功能大纲
+ 前台
    + 首页
    + 标签
    + 留言
    ![首页](https://upload-images.jianshu.io/upload_images/8504906-6da6014f6850681b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

+ 后台
     + 博客管理
     ![文章管理](https://upload-images.jianshu.io/upload_images/8504906-d27792cf2b4654b0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
     + 写博客
     ![写博客](https://upload-images.jianshu.io/upload_images/8504906-08ec419d326fa20c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 打赏代码
```
<script>
    window.tctipConfig = {
      staticPrefix: "http://static.tctip.com",
      buttonImageId: 7,
      buttonTip: "dashang",
      list:{
        alipay: {qrimg: "https://files-cdn.cnblogs.com/files/smfx1314/zhifubao.bmp"},
        weixin:{qrimg: "https://files-cdn.cnblogs.com/files/smfx1314/weixin.bmp"},
      }
    };
</script>
<script src="https://files.cnblogs.com/files/hafiz/tctip.min.js"></script>
<link type="text/css" rel="stylesheet" href="https://files.cnblogs.com/files/hafiz/myRewards.css">
```

#### 打赏码插件参考
- [博客园](https://www.cnblogs.com/greedying/p/6483222.html)  
- [GitHub](https://github.com/greedying/tctip)

#### 技术概况
+ IDEA 2018版
+ springboot 2.1.4
+ mybatis 
+ mysql
+ kaptcha 2.3.2（暂未整合）
+ pagehelper 1.2.5
+ Redis （暂未整合）

#### 接口测试工具
+ [postman](https://www.getpostman.com/)

#### 使用方式
+ 直接[clone](git@github.com:smfx1314/springboot-blog.git)至IDEA
+ 更改mysql账号以及密码
+ 创建对应数据库以及更改数据库地址
+ sql导入创建表数据

#### 部署方式
+ Linux（我的是centos7.2）
+ 下载jdk并配置
+ 下载mysql
+ 打包jar包
+ java -jar 包名
+ 页面使用Nginx部署
#### 相关技术参考

#### 后续更新计划
+ 写博客页面尝试更改为Markdown
+ 增加Redis缓存
+ 完善验证码注册
+ 使用docker部署免去配置

#### 收获
+ 数据库创建会有很多麻烦，  
  特别是字段如果前期设计不好后期增删字段对整体都有影响 
+ 分表数据的整合，之前都是通过sql多表查询，但是影响性能，  
现在使用BeanUtils进行model整合，有说此方法性能不如mapStruct后边在慢慢学习
+ 加深了我对Linux部署开发的经验
+ 增强bug解决的能力
+ 等等
####  关于
> 本人一直以来自学java，现在熟练使用java主流技术包括spring，mybatis，sprigMVC，springboot等等技术。  
以及能够在Linux多平台开发，了解docker简单命令使用。简博客也是对我这段时间以来所学知识的整合使用，  
一直有从事java开发的激情，无奈社会太残酷。  

**最后，必须简历造假才可以吗？？？**

#### 脚印
+ [简书](https://www.jianshu.com/u/31ccce39a24b)
+ [博客园](https://www.cnblogs.com/smfx1314/)
+ [码云](https://gitee.com/smfx1314)