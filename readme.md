### 简博客—开源免费个人博客
![首页](https://upload-images.jianshu.io/upload_images/8504906-6da6014f6850681b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 概述
> 本人自学java有一段时间了，前后学习了基础知识以及主流技术框架。
一直以来都想搭建自己的个人博客，期间也利用ssm框架搭建过但是由于种种原因没有整理发布  
这次主要通过springboot+mybatis+mysql前后端分离开发.也算对自己技术的一次巩固

#### 参考
+ 本博客前后台模板主要参考[这位博主](http://www.dingyinwu.com/index.html)的模板，点击[网盘下载提取码: bi8h](https://pan.baidu.com/s/14cRvKkbERP9hOOFFY-Cgpg)即可。  
+ 另外我觉得这位[博主](http://13blog.site/)的页面效果也不错，源码请点击[这里](https://github.com/smfx1314/pinghsu)  
+ 本博客页面参考请点击[这里](https://github.com/smfx1314/springboot-blog-web)
#### 博客功能大纲
+ 前台
    + 首页
      + banner
      + 文章列表
      + 文章详情
      + 热门文章（计划）
      + 公告
    + 标签
    + 留言
      + 留言实时邮件通知管理员

+ 后台
     + 博客管理
       + 新增文章
       + 文章列表
       + 修改文章
       + 删除文章
     + 公告
       + 发布公告
       + 公告列表
     + 评论
     + 留言
       + 留言列表
       + 留言详情
     + 日志
       + 管理员操作日志记录列表
       
    部分页面截图
    ![文章管理](https://upload-images.jianshu.io/upload_images/8504906-d27792cf2b4654b0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
   
    ![写博客](https://upload-images.jianshu.io/upload_images/8504906-ccd29345bc920bc7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

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

#### 主要技术概况
+ IDEA 2019.1.1版
+ jdk8
+ springboot 2.1.4
+ mybatis 
+ mysql
+ kaptcha 2.3.2
+ pagehelper
+ redis
+ aop


#### 接口测试工具
+ [postman](https://www.getpostman.com/)

#### 使用方式
+ 直接[clone](git@github.com:smfx1314/springboot-blog.git)至IDEA
+ 更改mysql账号以及密码
+ 更改邮件用户名以及密码，发送者等相关配置
+ 创建对应数据库以及更改数据库地址
+ sql导入创建表数据
+ 克隆web页面(请看上面介绍中的地址)
+ 直接进入login登陆页面(用户名：smfx1314 密码：123456)
+ 或者运行register注册页面，注册账户之后登陆即可

#### 部署方式
+ Linux（我的是centos7.2）
+ 下载jdk并配置
+ 下载mysql
+ 打包jar包
+ java -jar 包名
+ 页面使用Nginx部署
+ 更改url地址
#### 相关技术参考
+ [Springboot整合pagehelper分页](https://www.jianshu.com/p/7c4bc076ff63)
+ [给你自己搭的博客加个 Markdown](https://www.jianshu.com/p/5be7dc9afcb5)
+ [HTML5 FormData实现文件上传实例](http://www.cnblogs.com/hutuzhu/p/4409292.html)
+ [springboot整合kaptcha验证码](https://www.jianshu.com/p/1f2f7c47e812)
+ [MyBatis 实现主键回写](https://blog.csdn.net/u010452388/article/details/80822657)

#### 问题总结
+ [Ajax请求回调函数没有被调用](https://blog.csdn.net/molashaonian/article/details/52966329)
+ 跨域问题
+ 前端页面跳转session丢失问题
+ mysql版本的不同导致部分问题
+ 嵌套查询分页问题



#### 后续更新计划
+ 写博客页面尝试更改为Markdown(已经完善)
+ 增加Redis缓存
+ 完善验证码注册
+ 注册邮箱校验

#### 收获
+ 数据库创建会有很多麻烦，  
  特别是字段如果前期设计不好后期增删字段对整体都有影响 
+ 多表数据的整合，之前都是通过sql多表查询，但是影响性能，  
  现在使用BeanUtils进行model整合，有说此方法性能不如mapStruct后边在慢慢学习
+ 解决多表整合pagehelp分页问题
+ 加深了我对Linux部署开发的经验
+ 增强bug解决的能力
+ 巩固了ajax等前端技术的使用
+ 等等

#### 脚印
+ [简书](https://www.jianshu.com/u/31ccce39a24b)
+ [博客园](https://www.cnblogs.com/smfx1314/)
+ [码云](https://gitee.com/smfx1314)

#### 后记
本人也是一直边上班边自学java，不过一直没有找到合适的工作。不知道这个算入门了吗？


