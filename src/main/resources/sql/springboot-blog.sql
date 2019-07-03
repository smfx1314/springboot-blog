/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 80015
Source Host           : localhost:3306
Source Database       : springboot-blog

Target Server Type    : MYSQL
Target Server Version : 80015
File Encoding         : 65001

Date: 2019-07-03 08:31:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_attach
-- ----------------------------
DROP TABLE IF EXISTS `t_attach`;
CREATE TABLE `t_attach` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `fname` varchar(100) NOT NULL DEFAULT '',
  `ftype` varchar(50) DEFAULT '',
  `fkey` varchar(100) NOT NULL DEFAULT '',
  `author_id` int(10) DEFAULT NULL,
  `created` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_attach
-- ----------------------------

-- ----------------------------
-- Table structure for t_blogs
-- ----------------------------
DROP TABLE IF EXISTS `t_blogs`;
CREATE TABLE `t_blogs` (
  `bid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '内容文字',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '描述',
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `author_id` int(10) unsigned DEFAULT '0' COMMENT '作者ID',
  `status` int(11) DEFAULT '1' COMMENT '状态1发布，0草稿',
  `tags` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '标签',
  `comments_num` int(11) DEFAULT '0' COMMENT '评论数',
  `hits` int(11) DEFAULT '0' COMMENT '点击量',
  `allow_comment` int(1) DEFAULT '1' COMMENT '允许评论1允许，0不允许',
  PRIMARY KEY (`bid`) USING BTREE,
  KEY `created` (`created`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_blogs
-- ----------------------------
INSERT INTO `t_blogs` VALUES ('91', '关于pageHelper无法查到总数踩到的坑', '问题代码\n\n```\nPageHelper.startPage(pageNum,pageSize);\nList<pojoVo> pojoVo=robotService.getPageList();\nPageInfo pageResult = new PageInfo(pojoVo);\n```\n 结果\n\n```\npageResult.getTotal(); //结果为当前页数量或者没有\npageResult.getPage(); //结果为1\n```\n发现是VO拼接姿势不对\n\n> pageHelper是多线程操作,通过new PageInfo()查询出总条数和总页数;当为new PageInfo(pojoVo)时,是按照pojoVo去查询,所以无法查pojo到数据库中数据的总数的;需要先查出pojoList,然后拼接到Vo里面,在set到pageInfo中\n\n修改后的代码如下\n\n```\npublic CommonReturnType getList(Model model,@RequestParam(value = \"pageNum\",defaultValue = \"1\")Integer pageNum,\n                        @RequestParam(value = \"pageSize\",defaultValue = \"5\")Integer pageSize){\nPageHelper.startPage(pageNum,pageSize);\nList<Pojo> pojoList=pojoService.getPageList();\nPageInfo pageResult = new PageInfo(pojoList);\n\nList<PojoVo> voList=new ArrayList<>();\nfor(Pojo item:pojoList){\n    PojoVo pojoVo=assembleRobotListVo(item);\n    voList.add(pojoVo);\n}\n//这一步记得添加\npageResult.setList(voList);\n\nSystem.out.println(pageResult.getTotal()); //此处已经查询出总条数\nSystem.out.println(pageResult.getPages());\nSystem.out.println(pageResult.getSize());\nreturn CommonReturnType.success(pageResult );\n}\n```\n//拼接vo\n```\nprivate PojoVo assembleRobotListVo(Pojo pojo){\n    PojoVo pojoVo=new PojoVo ();\n    pojoVo.setId(pojo.getId());\n    pojoVo.setMac(pojo.getMac());\n    pojoVo.setName(pojo.getName());\n    return pojoVo;\n}\n```\n \n备注: pojo为实体类  pojoVo为拼接的Vo显示字段', '嵌套查询，分页出现问题', '2019-07-02 14:46:03', '2019-07-02 14:46:04', '0', '1', 'pagehelp', '0', '0', '1');
INSERT INTO `t_blogs` VALUES ('100', 'centos7.0利用yum快速安装mysql8.0', '我这里直接使用MySQL Yum存储库的方式快速安装：\n\n#### 抽象\nMySQL Yum存储库提供用于在Linux平台上安装MySQL服务器，客户端和其他组件的RPM包。这些软件包还可以升级和替换从Linux发行版本机软件存储库安装的任何第三方MySQL软件包，如果可以从MySQL获得它们的替代品。\n\n#### MySQL Yum存储库支持以下Linux发行版：\n\n*   基于EL6和EL7的平台（例如，Oracle Linux，Red Hat Enterprise Linux和CentOS的相应版本）\n\n*   Fedora 29和30\n\n#### 注意\n>并非所有这些Linux发行版都支持所有版本的MySQL。有关 如何确定Linux发行版是否支持特定版本的信息，请参阅[选择发布系列](https://dev.mysql.com/doc/refman/8.0/en/linux-installation-yum-repo.html#yum-repo-select-series)。\n\n## 完全安装MySQL的步骤\n\n#### 1. 清理原有的mysql\n```\nrpm -qa | grep mysql\n#可能的显示情况如下\n#mysql-community-libs-8.0.12-1.el7.x86_64\n#mysql80-community-release-el7-1.noarch\n#mysql-community-client-8.0.12-1.el7.x86_64\n#mysql-community-common-8.0.12-1.el7.x86_64\n#mysql-community-server-8.0.12-1.el7.x86_64\n#通过下面的命令进行删除\nyum remove mysql-xxx-xxx-\n#根据自身的需求删除mysql的配置文件信息\nrm -rf /var/lib/mysql\n```\n删除CentOS7默认的数据库mariadb\n```\nrpm -qa | grep mariadb\n#查找mariadb\n#可能出现的结果mariadb-libs-5.5.56-2.el7.x86_64\n#将查找出来的结果进行强制删除\nrpm -e --nodeps mariadb-libs-5.5.56-2.el7.x86_64\n```\n\n2.  #### 添加MySQL Yum存储库\n\n    首先，将MySQL Yum存储库添加到系统的存储库列表中。跟着这些步骤：\n\n    1.  访问[https://dev.mysql.com/downloads/repo/yum/](https://dev.mysql.com/downloads/repo/yum/)上的MySQL Yum存储库下载页面 。\n![yum存储库](https://upload-images.jianshu.io/upload_images/8504906-6486046ca41c0c58.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\n    2.  选择并下载适用于您的平台的发行包,如果是现在到本地之后需要上传到Linux指定路径\n\n    3.  安装yum源\n```yum localinstall mysql80-community-release-el7-3.noarch```\n \n    4. 更新yum源\n     ```\n       yum clean all\n       yum makecache\n     ```\n    5. 开始安装MySQL\n    ``` yum install mysql-community-server```\n![安装完成](https://upload-images.jianshu.io/upload_images/8504906-ad4a235fd9777652.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\n \n#### 启动MySQL\n```systemctl start mysqld```\n![启动成功](https://upload-images.jianshu.io/upload_images/8504906-0803c6a11d9d9577.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\n \n### 启动成功后可以查看初始化密码随机生成的\n```cat /var/log/mysqld.log | grep password```\n![查看密码](https://upload-images.jianshu.io/upload_images/8504906-bdb990fc64cc7c45.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\n通过使用生成的临时密码登录并为超级用户帐户设置自定义密码，尽快更改root密码：\n\n ``` mysql -uroot -p ```\n输入上述密码，进入mysql\n\n#### 修改密码\n ```\n mysql> ALTER USER \'root\'@\'localhost\' IDENTIFIED BY \'NewPass\';\n ```\n\n#### 注意\n\nMySQL的 [validate_password](https://dev.mysql.com/doc/refman/8.0/en/validate-password.html) 插件默认安装。这将要求密码包含至少一个大写字母，一个小写字母，一个数字和一个特殊字符，并且密码总长度至少为8个字符。\n#### 远程连接\n以上安装好之后，在服务器端使用正常，但是通过桌面工具，例如：Navicat连接，发现连接失败。\n![远程连接失败](https://upload-images.jianshu.io/upload_images/8504906-323c3a3fff0a1024.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/475/format/webp)\n\n![image.png](https://upload-images.jianshu.io/upload_images/8504906-371143a58afc3557.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/769/format/webp)\n\n以上是yum在线安装的方式，还有一种常用的是本地安装包方式，后面有机会再说。不过我还是感觉这种安装比较方便\n\n\n#### 安装出现的问题总结：\n1. 解决MySQL登录报ERROR 1045 (28000): Access denied for user \'root\'@\'localhost\' (using password: YES)的问题\n\n>使用mysql -uroot -p,然后输入密码登录mysql时，出现了如下错误：\nERROR 1045 (28000): Access denied for user \'root\'@\'localhost\' (using password: YES)\n\n一般这个错误是由密码错误引起，解决的办法自然就是重置密码\n\n解决方案如下：\n\n1.停止mysql数据库：systemctl stop mysqld\n\n2.用以下命令启动MySQL，以不检查权限的方式启动：\n\nmysqld --skip-grant-tables &\n\n此时又报了一个错误：2018-02-01T02:52:55.093724Z 0 [ERROR] Fatal error: Please read \"Security\" section of the manual to find out how to run mysqld as root!\n\n执行命令：mysqld --user=root --skip-grant-tables &\n\n3.登录mysql：mysql -uroot或mysql\n\n4.更新root密码\n\nmysql5.7以下版本：UPDATE mysql.user SET Password=PASSWORD(\'123456\') where USER=\'root\';\n\nmysql5.7版本：UPDATE mysql.user SET authentication_string=PASSWORD(\'123456\') where USER=\'root\';\n\n5.刷新权限：flush privileges;\n\n6.退出mysql：exit或quit\n\n7.使用root用户重新登录mysql\n\nmysql -uroot -p\n\nEnter password:<输入新设的密码123456>\n\n', 'MySQL Yum存储库提供用于在Linux平台上安装MySQL服务器，客户端和其他组件的RPM包。这些软件包还可以升级和替换从Linux发行版本机软件存储库安装的任何第三方MySQL软件包，如果可以从MySQL获得它们的替代品', '2019-07-02 14:56:46', '2019-07-02 14:56:46', '0', '1', 'mysql', '0', '0', '1');
INSERT INTO `t_blogs` VALUES ('101', '一个简单易上手的短信服务Spring Boot Starter', '# 前言\n\n短信服务在用户注册、登录、找回密码等相关操作中，可以让用户使用更加便捷，越来越多的公司都采用短信验证的方式让用户进行操作，从而提高用户的实用性。\n\n# Spring Boot Starter\n\n由于 Spring boot 的约定大于配置的理念，使得在使用Spring变得更加方便。Spring Boot 项目组提供了很多Starter ，让我们在使用 Spring 的时候变得非常容易。对于官方提供的Starter 采用 spring-boot-starter-xxx开头，对于非官方提供的Spring Boot Starter ,官方建议采用 xxxx-spring-boot-starter命名。\n\n# 短信服务Starter\n\n## 1\\. 开发工具及编译\n\n> IntelliJ IDEA 2018.2.5\n> Maven 3.5\n> JDK 1.8\n\n## 2\\. 如何使用sms-spring-boot-starter\n\n### (1). 在pom文件中引入\n\n```\n   <dependency>\n         <groupId>com.github.jackieonway.sms</groupId>\n         <artifactId>sms-spring-boot-starter</artifactId>\n         <version>0.0.1-SNAPSHOT</version>\n     </dependency>\n\n```\n\n在pom.xml中配置maven中央仓库Snapshots地址\n\n```\n<repositories>\n      <repository>\n          <id>mavenRepoCenter</id>\n          <name>Maven Development Snapshot Repository</name>\n          <url>https://oss.sonatype.org/content/repositories/snapshots</url>\n          <releases>\n              <enabled>false</enabled>\n          </releases>\n          <snapshots>\n              <enabled>true</enabled>\n          </snapshots>\n      </repository>\n  </repositories>\n\n```\n\n### (2).在application.yml中加入\n\n```\nspring:\n pengzu:\n   sms:\n     sms-type: tentcent  # 短信服务商 暂目前只有 腾讯和阿里的短信服务\n     security-key: your security-key # 短信的私钥\n     appid: your appid # 短信的应用id\n     sign: your sign # 短信的签名\n\n```\n\n### (3). 在Springboot主程序中 加入\n\n```\n@EnabledPengzuSmsAutoConfiguration\n@ComponentScan(basePackages = {\"com.example.demo.sms\", //项目包\n\"com.pengzu.sms\"}) // 短信服务所在包\n\n```\n\n### (4). 创建发送短信程序\n\n```\n@RestController\npublic class HelloController {\n\n    @Autowired\n    private PengzuSmsService pengzuSmsService;\n\n    @GetMapping(\"/sayHello\")\n    public Object sayHello() throws ClientException, HTTPException, IOException {\n        // 具体参数请参考各短信服务商\n        // your template params\n        String[] paramst = {\"5678\",\"5\"};\n        TencentSmsRequest tencentSmsRequest = new TencentSmsRequest();\n        tencentSmsRequest.setPhoneNumber(new String[]{\"your cellphone\"});\n        tencentSmsRequest.setParams(paramst);\n        return pengzuSmsService.sendTemplateSms(\"your template id\", tencentSmsRequest);\n    }\n}\n\n```\n\n### (5). 发送\n\n访问 localhost:8080/sayHello\n\n![image](//upload-images.jianshu.io/upload_images/12660257-e408bef0f9735a2a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)\n\n## 3\\. PengzuSmsService接口\n\n```\n    /**\n     *  单个发送短信\n     * @param params 根据对应的短信服务商所需信息填写\n     */\n    public Object sendSms(Integer type,Object params) throws HTTPException, IOException, ClientException;\n\n    /**\n     * 单个发送模板短信\n     * @param tempalteId 短信模板id\n     * @param params 根据对应的短信服务商所需信息填写\n     */\n    public Object sendTemplateSms(String tempalteId, Object params) throws HTTPException, IOException, ClientException;\n\n    /**\n     *  批量发送短信\n     * @param params 根据对应的短信服务商所需信息填写\n     */\n    public Object sendBatchSms(int type,Object params) throws HTTPException, IOException, ClientException;\n\n    /**\n     * 批量发送模板短信\n     * @param tempalteId 短信模板id\n     * @param params 根据对应的短信服务商所需信息填写\n     */\n    public Object sendBatchTemplateSms(String tempalteId, Object params) throws HTTPException, IOException, ClientException;\n\n```\n\n该接口提供了单个和群发短信与模板短信，注意目前只提供了同步发送方法，异步发送方法，请结合线程池进行。\n\n# 总结\n\n只是针对腾讯短信服务进行了试验，阿里的短信服务并未真正验证，希望各位小伙伴能合作完成验证，共同完善该starter，觉得有用请starter该项目。如果只想使用而腾讯云短信业务的话，按照Demo使用即可。\n\ngithub地址:**[sms-spring-boot-project](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjackieonway%2Fsms-spring-boot-project)**\n', '短信服务在用户注册、登录、找回密码等相关操作中，可以让用户使用更加便捷，越来越多的公司都采用短信验证的方式让用户进行操作，从而提高用户的实用性。', '2019-07-02 14:58:08', '2019-07-02 14:58:07', '0', '1', '短信', '0', '0', '1');
INSERT INTO `t_blogs` VALUES ('102', 'SqlHelper发布—比Pagehelper更好用的分页插件', '>SqlHelper发布—比PageHelper性能更高\n\n## 起源\n\n前段时间开启了一个新的项目，在选择分页插件时，发现github上很流行的一个是pagehelper，在百度上搜索了一下，使用量。由于项目紧急，所先拿来用了。但是我知道它并不适合我们。原因是它有如下几个缺点：\n\n1） 对国产数据库支持不足\n\n2） 扩展不方便\n\n3） 配置复杂\n\n4） 性能底下 （不要喷我， 因为它不是用的占位符?，发挥不了PrepareSatement的优势）\n\n5） 只支持MyBatis\n\n鉴于它的这些不足，我就趁闲暇时间新开发了一款解决上述缺点的分页工具，它已经在公司里的两个项目得到了验证。但它不仅仅是个分页工具那么简单，目前支持的特性有Pagination、UrlParser，未来会支持更多特性。\n\n## 关键特性\n\n1.  支持MyBatis, JFinal，Ebean，Mango\n2.  支持 90+ 种数据库, 支持列表参见 ***[here](https://github.com/f1194361820/sqlhelper/wiki/Pagination_Database)***. 包含了几乎所有的国产数据库:\n\n*   TiDB (北京平凯星辰科技))\n*   Doris (Apache Doris，百度研发)\n*   MaxCompute (阿里巴巴)\n*   K-DB (浪潮)\n*   GBase (南大通用)\n*   DM (达梦)\n*   OSCAR (神州通用)\n*   HighGo (瀚高)\n*   KingBase (金仓)\n*   OpenBase (东软)\n*   SequoiaDB (巨杉)\n\n如果你想知道所有的数据库排名的话，你可以在这里找到： [DB Engines](https://db-engines.com/en/ranking/relational+dbms).\n\n3.  同一个应用中支持多种数据库\n4.  不需要配置dialect，可以自动的获取。\n5.  **比 Mybatis-PageHelper性能更高**, 原因是limit , offset等参数使用 PrepareStatement placeholder \'?\' ， Mybatis是硬编码拼接的\n6.  通过Java SPI的方式支持了插件\n7.  支持 spring boot 1.x , 2.x\n8.  支持 mybatis 3.x\n9.  支持 JDK6+\n\n### Vs Pagehelper \n| **metric** | **pagehelper** | **sqlhelper** |\n| --- | --- | --- |\n| databases | 13 | 90+ |\n| multiple databases in runtime | √ | √ |\n| auto detect dialect | √ | √ |\n| plugin | √ | √ |\n| PrepareStatement with \'?\' | X | √ |\n| mybatis | 3.x | 3.x |\n| spring boot | 1.x, 2.x | 1.x, 2.x |\n| JDK | 1.6+ | 1.6+ |\n| jFinal | X | √ |\n| EBean | X | √ |\n| Mango | X | √ |\n| 国产数据库 | X | √ （参见上述列表） |\n\n## 安装\n\n可以在多种场景下使用，支持MyBatis，JFinal，EBean等。先就说说MyBatis下如何使用：\n\n### 1)  与Mybatis + SpringBoot结合使用\n\n此应用环境下，只需导入下列包即可：\n\n```<dependency>\n        <groupId>com.github.fangjinuo.sqlhelper</groupId>\n        <artifactId>sqlhelper-mybatis-spring-boot-autoconfigure</artifactId>\n        <version>${sqlhelper.version}</version>\n    </dependency>\n    <dependency>\n        <groupId>com.github.fangjinuo.sqlhelper</groupId>\n        <artifactId>sqlhelper-mybatis-spring-boot-starter</artifactId>\n        <version>${sqlhelper.version}</version>\n    </dependency>\n```\n\n\n### 2）与MyBatis （无spring boot）结合使用\n\n此应用环境下，使用也不麻烦。\n\n第一步，导入依赖：\n\n```\n<dependency>\n        <groupId>com.github.fangjinuo.sqlhelper</groupId>\n        <artifactId>sqlhelper-dialect</artifactId>\n        <version>${sqlhelper.version}</version>\n    </dependency>\n```\n\n第二步：配置插件：\n\n```\n<configuration>\n        ...\n        <databaseIdProvider type=\"DB_VENDOR\">\n          <property name=\"SQL Server\" value=\"sqlserver\"/>\n          <property name=\"DB2\" value=\"db2\"/>\n          <property name=\"Oracle\" value=\"oracle\" />\n        </databaseIdProvider>\n        ...\n        <settings>\n            ...\n            <setting name=\"defaultScriptingLanguage\" value=\"com.github.fangjinuo.sqlhelper.mybatis.plugins.pagination.CustomScriptLanguageDriver\" />\n            ...\n        </settings>\n        ...\n    </configuration>\n    \n    <plugins>\n      <plugin interceptor=\"com.github.fangjinuo.sqlhelper.mybatis.plugins.pagination.MybatisPaginationPlugin\" />\n    </plugins>\n```\n\n## 使用\n\n```\n @GetMapping\n    public PagingResult list(){\n        User queryCondtion = new User();\n        queryCondtion.setAge(10);\n        PagingRequest request = new PagingRequest()\n                .setPageNo(1)\n                .setPageSize(10);\n        PagingRequestContextHolder.getContext().setPagingRequest(request);\n        List users = userDao.selectByLimit(queryCondtion);\n        request.getResult().setItems(users);\n        return request.getResult();\n    }\n```\n\n\n## 从mybatis-pagehelper迁移\n\n为了兼容已有的应用，特意提供了从mybatis-pagehelper迁移工具。使用也很简单，把mybatis-pagehelper.jar移除，导入下面的包即可。\n\n```\n <dependency>\n        <groupId>com.github.fangjinuo.sqlhelper</groupId>\n        <artifactId>sqlhelper-mybatis-over-pagehelper</artifactId>\n        <version>${sqlhelper.version}</version>\n    </dependency>\n```\n\n## 支持\n\n[https://github.com/fangjinuo/sqlhelper](https://github.com/fangjinuo/sqlhelper)\n', '前段时间开启了一个新的项目，在选择分页插件时，发现github上很流行的一个是pagehelper，在百度上搜索了一下，使用量。由于项目紧急，所先拿来用了。但是我知道它并不适合我们', '2019-07-02 14:59:12', '2019-07-02 14:59:12', '0', '1', 'pagehelp', '0', '0', '1');
INSERT INTO `t_blogs` VALUES ('103', 'IntelliJ IDEA必装插件以及SpringBoot使用小技巧合集', '![idea](https://upload-images.jianshu.io/upload_images/8504906-403d3de7669f5710.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)\n\n### IntelliJ IDEA必装插件\n\n> 有不知道怎么安装的吗？File-->settings打开设置面板，找到plugins,输入想要安装的插件回车即可\n\n![plugins面板](https://upload-images.jianshu.io/upload_images/8504906-cbb8080b9bd665e2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\n#### 1.背景图片\n目前，IDEA支持设置背景图片。这对于广大程序员来说无疑是个好功能。整日对着枯燥的代码实在是会让人疲乏。要是可以设置一张美女图片的话。。。\n设置方法：\nCtrl+Shift+A(或者help -> find action)调用弹窗后输入Set Background Image\n![image.png](https://upload-images.jianshu.io/upload_images/8504906-a7cc1e2891894b8c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\n在里面设定要设置为Image的图片,透明度调到15左右，保存即可。\n\n![image.png](https://upload-images.jianshu.io/upload_images/8504906-1da5fe16e7e5562c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n效果如图：\n![image.png](https://upload-images.jianshu.io/upload_images/8504906-40623b7d77d16dfe.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\n#### 2.Maven Helper\n日常开发中，可能经常会遇到jar包冲突等问题，就需要通过查看maven依赖树来查看依赖情况。这种方式不是很高效，这里推荐一个插件，安装之后，直接打开pom文件，即可查看依赖数，还能自动分析是否存在jar包冲突。\n一旦安装了Maven Helper插件，只要打开pom文件，就可以打开该pom文件的Dependency Analyzer视图（在文件打开之后，文件下面会多出这样一个tab）。\n![image.png](https://upload-images.jianshu.io/upload_images/8504906-c52ef0e8e5dfa6f6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\n![image.png](https://upload-images.jianshu.io/upload_images/8504906-708719265d15c1e0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n进入Dependency Analyzer视图之后有三个查看选项分别是：\n+ Conflicts(冲突)\n+ All Dependencies as List(列表形式查看所有依赖)\n+ All Dependencies as Tree(树结构查看所有依赖)，并且这个页面还支持搜索。\n\n#### 3.FindBugs-IDEA\nFindBugs很多人都并不陌生，Eclipse中有插件可以帮助查找代码中隐藏的bug，IDEA中也有这款插件。\n\n使用方法很简单，就是可以对多种级别的内容进行finbugs\n![findBugs](https://upload-images.jianshu.io/upload_images/8504906-b203d3243d67941f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n分析完之后会有一个视图进行提示，详细的说明是哪种问题。\n![image.png](https://upload-images.jianshu.io/upload_images/8504906-62dd87452ed408d3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\n#### 4.阿里巴巴代码规约检测\n检测JAVA代码中存在不规范得位置然后给予提示,阿里巴巴规约插件包含三个子菜单：编码规约扫描、关闭试试检测功能。\n![阿里巴巴代码插件](https://upload-images.jianshu.io/upload_images/8504906-9aee8c28757027d1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n安装好此插件即可自动在不规范位置给与提示\n![提示](https://upload-images.jianshu.io/upload_images/8504906-5282161711eadcdf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\n#### 5.GsonFormat\nJava开发中，经常有把json格式的内容转成Object的需求，比如项目开始时，合作方给你提供了一个json格式request/response，这时候你就需要将其定义成一个Java类，GsonFormat这款插件可以实现该功能。\n![image.png](https://upload-images.jianshu.io/upload_images/7852807-c4898cb07026191b?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)\n\n#### 6.Lombok plugin\n在Java中，我们经常会定义很多JavaBean，这些Bean需要有getter、setter、toString、equals和hashCode等方法。\n通常情况下，我们可以使用IDEA的快捷键生成这些代码，但是自动生成的代码后，如果bean中的属性一旦有修改，需要重新生成，给代码维护增加了一定的负担。\n有一款很好的插件，可以帮助开发者节省这部分工作。那就是Lombok。\n只要在IDEA中安装了该插件，只需要在JavaBean中添加一行注解代码，插件就会自动帮我们生成getter、setter、toString、equals和hashCode等方法。\n当然，这些方法不止在IDE中的代码调用中需要用到，在真正线上部署的时候也需要有，所以，还需要使用maven引入一个lombok的包。\n```\n@Data\nclass Wechat {\n    private String id;\n    private String desc;\n}\n```\n我们在Wechat类上面添加了@Data注解，插件就自动帮我们添加了getter/setter和toString方法。\n\n#### 7.String Manipulation\n字符串日常开发中经常用到的，但是不同的字符串类型在不同的地方可能有一些不同的规则，比如类名要用驼峰形式、常量需要全部大写等，有时候还需要进行编码解码等。这里推荐一款强大的字符串转换工具——String Manipulation。\n\n它强大到什么程度，看下他的功能列表你就知道了：\n![image.png](https://upload-images.jianshu.io/upload_images/8504906-0526fb169478dffc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n安装好插件后，选中需要处理的内容后，按快捷键Alt+m，即可弹出工具功能列表。\n\n很好很强大的一款字符串处理工具。\n\n#### 8.Mybatis plugin\n目前ORM框架中，Mybatis非常受欢迎。但是，同时给很多开发带来困扰的就是Mybatis需要很多xml的配置文件，有的时候很难去进行修改。\n\n这里推荐一款神器，可以让你像编辑java代码一样编辑mybatis的文件。\n\nIntellij Idea Mybatis插件主要功能：\n\n*   提供Mapper接口与配置文件中对应SQL的导航\n\n*   编辑XML文件时自动补全\n\n*   根据Mapper接口, 使用快捷键生成xml文件及SQL标签\n\n*   ResultMap中的property支持自动补全，支持级联(属性A.属性B.属性C)\n\n*   快捷键生成@Param注解\n\n*   XML中编辑SQL时, 括号自动补全\n\n*   XML中编辑SQL时, 支持参数自动补全(基于@Param注解识别参数)\n\n*   自动检查Mapper XML文件中ID冲突\n\n*   自动检查Mapper XML文件中错误的属性值\n\n*   支持Find Usage\n\n*   支持重构从命名\n\n*   支持别名\n\n*   自动生成ResultMap属性\n\n![image](//upload-images.jianshu.io/upload_images/7852807-8bdea18050e476c4?imageMogr2/auto-orient/strip%7CimageView2/2/w/557/format/webp)\n\n![image](//upload-images.jianshu.io/upload_images/7852807-ef423030458874ec?imageMogr2/auto-orient/strip%7CimageView2/2/w/643/format/webp)\n\n（图源：[https://www.oschina.net/p/intellij-mybatis-plugin](https://www.oschina.net/p/intellij-mybatis-plugin)）\n\n但是这款插件是收费的，但是不影响他确实是一个很实用，可以很大程度上提升开发效率的插件。读者可以考虑使用Free Mybatis plugin（这款插件我没用过，具体是否好用有待考证）。\n\n#### 9.Key promoter X\n对于很多刚刚开始使用IDEA的开发者来说，最苦恼的就是不知道快捷键操作是什么。\n\n**使用IDEA，如果所有操作都使用鼠标，那么说明你还不是一个合格的程序员。**\n\n这里推荐一款可以进行快捷键提示的插件Key promoter X。\n\nKey Promoter X 是一个提示插件，当你在IDEA里面使用鼠标的时候，如果这个鼠标操作是能够用快捷键替代的，那么Key Promoter X会弹出一个提示框，告知你这个鼠标操作可以用什么快捷键替代。\n\n当我使用鼠标查看一个方法都被哪些类使用的时候，就会提示：\n\n![image](//upload-images.jianshu.io/upload_images/7852807-4234b2f439a98fd0?imageMogr2/auto-orient/strip%7CimageView2/2/w/714/format/webp)\n\n记住这个快捷键以后，就可以使用快捷键代替鼠标啦。\n\n#### 10.activate-power-mode\n最后，介绍一款程序员很好的在妹子面前装X的插件——activate-power-mode 。\n\n安装了这款插件之后，你写代码的时候，就会附加一些狂拽炫酷屌炸天的效果：\n![](https://upload-images.jianshu.io/upload_images/7852807-42692a82184265f8?imageMogr2/auto-orient/strip%7CimageView2/2/w/736/format/webp)\n\n#### 以上内容[参考](https://mp.weixin.qq.com/s?__biz=MzI5NTYwNDQxNA==&mid=2247484667&idx=1&sn=b54e84c0369bd0196e75fa8345bbeb4b&chksm=ec505d2adb27d43c390ad535b80f331747fed0c34391b2f4def40909b9ffd5233f037b05fc6d&scene=0##)地址\n---\n#### 11.ignore\ngit提交时过滤掉不需要提交的文件，很方便，有些本地文件是不需要提交到Git上的。\n\n#### 12.CamelCase\n将不是驼峰格式的名称，快速转成驼峰格式，安装好后，选中要修改的名称，按快捷键shift+alt+u。\n\n#### 13.CodeGlance\n在编辑区的右侧显示的代码地图。\n\n![image](https://upload-images.jianshu.io/upload_images/7440820-9e9695bc2f573fa5?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)\n\n#### 14.Material Theme UI\n这是一款主题插件，可以让你的ide的图标变漂亮，配色搭配的很到位，还可以切换不同的颜色，甚至可以自定义颜色。默认的配色就很漂亮了，如果需要修改配色，可以在工具栏中Tools->Material Theme然后修改配色等。\n\n#### 15.Background image Plus\n这是一款可以设置idea背景图片的插件，不但可以设置固体的图片，还可以设置一段时间后随机变化背景图片，以及设置图片的透明度等等。\n\n#### 16.### Rainbow Brackets\n\n彩虹颜色的括号 看着很舒服 敲代码效率变高\n\n![image](https://upload-images.jianshu.io/upload_images/7440820-64f6217f6b3fb779?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)\n\n#### 以上内容[参考](https://www.jianshu.com/p/30a018bc98d0)\n---\n### SpringBoot | 番外：使用小技巧合集\n\n## 设置网站图标\n\n原来我们在使用`tomcat`开发时，设置网站图片时，即icon图标时，一般都是直接替换`root`包下的`favicon.ico`替换成自己的，或者在网页的头部设置`link`的ref为`icon`然后设置其`href`值。而在`SpringBoot`中，替换图片也是很简单的，只需要将自定义图片放置在`静态资源`目录下即可，即默认有`static`、`public`、`resources`、`/META-INF/resources`或者自定义的静态目录下即可。\n\n目录结构：\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F21175470.jpg)\n\n![image](//upload-images.jianshu.io/upload_images/13587608-9854126f098499a6.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/385/format/webp)\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F21175470.jpg)\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F22377559.jpg)\n\n![image](//upload-images.jianshu.io/upload_images/13587608-7ff2a9e794455685.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/799/format/webp)\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F22377559.jpg)\n\n## 允许跨域访问\n\n> CORS是一个W3C标准，全称是”跨域资源共享”（Cross-origin resource sharing）。它允许浏览器向跨源(协议 + 域名 + 端口)服务器，发出XMLHttpRequest请求，从而克服了AJAX只能同源使用的限制。\n\n简单来说，跨域问题是可以通过`nginx`来解决的，或者通过`jsonp(只支持get请求)`来解决。而`SpringBoot`中也提供了配置方法。\n0.利用`@CrossOrigin`注解，可放至在类上或者方法上。类上代表整个控制层所有的映射方法都支持跨域请求。\n\n```\n@CrossOrigin(origins = \"http://blog.lqdev.cn\", maxAge = 3600)\n@RestController\npublic class demoController{\n\n   @GetMapper(\"/\")\n   public String index(){\n      return \"hello,CORS\";\n   }\n}\n\n```\n\n1.配置全局`CORS`配置。[官网](https://links.jianshu.com/go?to=https%3A%2F%2Fdocs.spring.io%2Fspring-boot%2Fdocs%2F1.5.15.RELEASE%2Freference%2Fhtmlsingle%2F%23boot-features-cors)也有给出实例，具体如下：\n\n```\n@Configuration\npublic class MyConfiguration {\n\n    @Bean\n    public WebMvcConfigurer corsConfigurer() {\n        return new WebMvcConfigurerAdapter() {\n            @Override\n            public void addCorsMappings(CorsRegistry registry) {      registry.addMapping(\"/api/**\").allowedOrigins(\"https://blog.lqdev.cn\");\n            }\n        };\n    }\n}\n\n```\n\n## 独立Tomcat运行\n\n> 讲解了这么久，一般上我们都是通过jar包的方式进行启动的应用的。所以部署在独立的`tomcat`时，需要如何解决呢？其实也简单，只需要将项目打包方式修改为`war`包，然后修改下启动类配置即可。\n\n0.修改pom打包方式为`war`，同时排除了内置的`tomcat`。\n\n```\n<packaging>war</packaging>\n\n<!-- 排除内置的tomcat -->\n        <dependency>\n            <groupId>org.springframework.boot</groupId>\n            <artifactId>spring-boot-starter-tomcat</artifactId>\n            <scope>compile</scope>\n        </dependency>\n<!-- 若直接有使用servlet对象时(这是废话，⊙﹏⊙‖∣)，需要将servlet引入，本例是没有的~ -->\n       <dependency>\n          <groupId>javax.servlet</groupId>\n          <artifactId>javax.servlet-api</artifactId>\n          <scope>provided</scope>\n       </dependency>\n\n```\n\n1.改造下启动类，使其继承`SpringBootServletInitializer`,同时覆盖`configure`方法。\n\n```\n@SpringBootApplication\n@Slf4j\npublic class ChapterApplication extends SpringBootServletInitializer{\n\n    public static void main(String[] args) {\n        SpringApplication.run(ChapterApplication.class, args);\n    //    new SpringApplicationBuilder().sources(ChapterApplication.class).web(false).run(args);\n    //之后这里设置业务逻辑 比如挂起一个线程 或者设置一个定时任务。保证不退出\n        //不然它就是一个启动类，启动后就停止了。\n        log.info(\"jar,chapter启动!\");\n    } \n\n    @Override\n    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {\n        log.info(\"外部tomcat,chapter启动!\");\n        return application.sources(ChapterApplication.class);\n    }\n}\n\n```\n\n2.maven打包成war(`mvn clean install`),然后放入tomcat中，启动运行即可。\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F99998653.jpg)\n\n![image](//upload-images.jianshu.io/upload_images/13587608-ed33da66ad3c951a.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/797/format/webp)\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F99998653.jpg)\n\n其实这样设置的话，在开发时直接运行启动类也还是可以直接运行的，方便.\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F20869347.jpg)\n\n![image](//upload-images.jianshu.io/upload_images/13587608-6ab57b46b4afb5eb.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/893/format/webp)\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F20869347.jpg)\n\n## 启动不设置端口\n\n对一些定时任务服务项目，其本身只是提供一个定时调度功能，不需要其他服务调用，只是去调度其他服务。像这样的服务，正常也就不需要设置端口了。这时候`SpringBoot`也是支持的。只需要改下启动方式：\n\n```\nnew SpringApplicationBuilder().sources(ChapterApplication.class).web(false).run(args);\n//之后这里设置业务逻辑 比如挂起一个线程 或者设置一个定时任务。保证不退出\n//不然它就是一个启动类，启动后就停止了。\n\n```\n\n或者修改配置文件的属性：\n\n```\nspring.main.web-environment=false\n\n```\n\n最后效果，是不是没有看见端口了：\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F54581167.jpg)\n\n![image](//upload-images.jianshu.io/upload_images/13587608-1476544b9d154a1d.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/886/format/webp)\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F54581167.jpg)\n\n## 启动完成前进行业务逻辑\n\n利用`CommandLineRunner`或者`ApplicationRunner`可实现在`SpringApplication`的`run()`完成前执行一些业务逻辑\n\n0.修改启动类，实现`CommandLineRunner`接口,`ApplicationRunner`类似，只是`run`的入参不同而已。\n\n```\n@Override\n    public void run(String... args) throws Exception {\n        log.info(\"CommandLineRunner运行\");\n    }\n\n```\n\n1.运行应用，注意查看控制台输出：\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F32524168.jpg)\n\n![image](//upload-images.jianshu.io/upload_images/13587608-62c4b963b8eef657.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F32524168.jpg)\n\n**当然，直接申明一个`bean`也是可以的。**\n\n```\n@Configuration\n@Slf4j\npublic class CommandLineRunnerConfig {\n    @Bean \n    public CommandLineRunner runner(){  \n      return new CommandLineRunner() {  \n        public void run(String... args){  \n            log.info(\"CommandLineRunner运行2\");\n        }  \n      };  \n    }  \n}\n\n```\n\n**若多个时，可设置`@Order`来确定执行的顺序。**\n\n## 动态修改日志级别\n\n通过`org.springframework.boot.logging.LoggingSystem`提供的api即可。\n\n```\nloggingSystem.setLogLevel(null, LogLevel.DEBUG);\n\n```\n\n如，默认时是`info`模式，未修改时，`debug`模式是不会输出的。\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F82194936.jpg)\n\n![image](//upload-images.jianshu.io/upload_images/13587608-0f71390a682f3416.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/685/format/webp)\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F82194936.jpg)\n\n动态设置后\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F44121162.jpg)\n\n![image](//upload-images.jianshu.io/upload_images/13587608-120285ba7eb27886.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/673/format/webp)\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F44121162.jpg)\n\n## 热部署\n\n前面讲了这么多章节，因为功能都很单一，所以一般上都是直接重启服务来进行更新操作。但当服务功能一多，启动速度缓慢时，还是配置个热部署比较方便。在`SpringBoot`中，只需要加入一个`spring-boot-devtools`即可\n\n```\n<dependencies>\n    <dependency>\n        <groupId>org.springframework.boot</groupId>\n        <artifactId>spring-boot-devtools</artifactId>\n        <optional>true</optional>\n    </dependency>\n</dependencies>\n\n```\n\n**题外话：这里的`<optional>true</optional>`是表示依赖不会传递，依赖了此项目的需要额外引入此包，若需要使用的话。**\n\n* * *\n\n若不生效，可试着在打包工具`spring-boot-maven-plugin`下的`configuration`加入`<fork>true</fork>`看看，具体配置项如下：\n\n```\n<plugin>\n    <groupId>org.springframework.boot</groupId>\n    <artifactId>spring-boot-maven-plugin</artifactId>\n    <configuration>\n      <fork>true</fork>\n    </configuration>\n</plugin>\n\n```\n\n## 自定义启动Banner\n\n看烦了自带的`Banner`，动手修改一个属于自己的`Banner`，提现逼格的时候到了~哈哈，以下是官网给的配置指南：\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F44960524.jpg)\n\n![image](//upload-images.jianshu.io/upload_images/13587608-db48ec8c9d965876.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F44960524.jpg)\n\n### 文字形式\n\n其实，替换很简单，只需要在`classpath`路径下创建一个`banner.txt`即可。具体的一些变量官网也有给出，具体如下：\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F20672206.jpg)\n\n![image](//upload-images.jianshu.io/upload_images/13587608-76db2790bb6cdcd7.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F20672206.jpg)\n\n现在我们就定制一个自己的`Banner`。\n\n```\n_              _   _                       _  __                          _ \n | |            | | | |                     | |/ /                         | |\n | |__     ___  | | | |   ___         ___   | \' /    ___    _ __     __ _  | |\n | \'_ \\   / _ \\ | | | |  / _ \\       / _ \\  |  <    / _ \\  | \'_ \\   / _` | | |\n | | | | |  __/ | | | | | (_) |  _  | (_) | | . \\  | (_) | | | | | | (_| | |_|\n |_| |_|  \\___| |_| |_|  \\___/  ( )  \\___/  |_|\\_\\  \\___/  |_| |_|  \\__, | (_)\n                                |/                                   __/ |    \n                                                                    |___/     \n\n${AnsiColor.BRIGHT_RED}\nSpring Boot Version: ${spring-boot.version}${spring-boot.formatted-version}\n\n```\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F66912864.jpg)\n\n![image](//upload-images.jianshu.io/upload_images/13587608-fc853ae4c0212e14.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/888/format/webp)\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F66912864.jpg)\n\n题外话：手输字符画是不太现实的，大家可通过一些网站进行快速生成。可自行搜索下，网上一搜一大把。\n\n### 图片形式\n\n若觉得使用文字不够酷炫，当然也可以将图片设置为启动的`banner`。目前支持的图片格式有`gif`、`png`、`jpg`。使用也很简单，只需要命名为`banner`即可。\n\n如将头像放入目录中，最后的效果如下：\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F54464544.jpg)\n\n![image](//upload-images.jianshu.io/upload_images/13587608-c2f0ebdf619c39cf.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F54464544.jpg)\n\n当然，若图片是有色彩的，也是可以的，对于太复杂的图片显示效果就不佳了，如下。\n\n**原图：**\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F85334713.jpg)\n\n![image](//upload-images.jianshu.io/upload_images/13587608-0b4e8241419c2bee.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/416/format/webp)\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F85334713.jpg)\n\n原图\n\n**banner效果图：**\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F59004365.jpg)\n\n![image](//upload-images.jianshu.io/upload_images/13587608-8ad7d303fe58d3a9.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/698/format/webp)\n\n[](https://links.jianshu.com/go?to=http%3A%2F%2Fqiniu.xds123.cn%2F18-8-11%2F59004365.jpg)\n#### 以上内容[参考](https://www.jianshu.com/p/e6db2d5fe204)\n', '目前，IDEA支持设置背景图片。这对于广大程序员来说无疑是个好功能。整日对着枯燥的代码实在是会让人疲乏。要是可以设置一张美女图片的话。。。', '2019-07-02 15:01:27', '2019-07-02 15:01:26', '0', '1', 'IDEA', '0', '0', '1');
INSERT INTO `t_blogs` VALUES ('104', 'springboot整合easyexcel实现Excel导入导出', '##easyexcel：快速、简单避免OOM的java处理Excel工具\n>Java解析、生成Excel比较有名的框架有Apache poi、jxl。但他们都存在一个严重的问题就是非常的耗内存，poi有一套SAX模式的API可以一定程度的解决一些内存溢出的问题，但POI还是有一些缺陷，比如07版Excel解压缩以及解压后存储都是在内存中完成的，内存消耗依然很大。\n\neasyexcel重写了poi对07版Excel的解析，能够原本一个3M的excel用POI sax依然需要100M左右内存降低到KB级别，并且再大的excel不会出现内存溢出，03版依赖POI的sax模式。在上层做了模型转换的封装，让使用者更加简单方便\n详细使用及介绍请参考[官网](https://github.com/alibaba/easyexcel)\n\n#### 快速使用\n创建springboot工程，然后引入相关依赖包如下：\n```\n<dependencies>\n        <dependency>\n            <groupId>org.springframework.boot</groupId>\n            <artifactId>spring-boot-starter-web</artifactId>\n        </dependency>\n\n        <dependency>\n            <groupId>org.springframework.boot</groupId>\n            <artifactId>spring-boot-devtools</artifactId>\n            <scope>runtime</scope>\n        </dependency>\n        <dependency>\n            <groupId>org.projectlombok</groupId>\n            <artifactId>lombok</artifactId>\n            <optional>true</optional>\n        </dependency>\n        <dependency>\n            <groupId>org.springframework.boot</groupId>\n            <artifactId>spring-boot-starter-test</artifactId>\n            <scope>test</scope>\n        </dependency>\n    </dependencies>\n```\n工程结构如下图：\n![springboot工程](https://upload-images.jianshu.io/upload_images/8504906-8da24b901096aa6f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\nspringboot工程创建好之后，引入easyExcel依赖包即可，使用前最好咨询下最新版，或者到mvn仓库搜索先easyexcel的最新版，本文使用的是如下版本\n```\n<dependency>\n       <groupId>com.alibaba</groupId>\n       <artifactId>easyexcel</artifactId>\n       <version>1.1.2-beta5</version>\n</dependency>\n```\n\n然后创建User实体类并继承BaseRowModel ，然后在对应字段上添加注解\n```\n@Data\n@Builder\npublic class User extends BaseRowModel {\n\n    @ExcelProperty(value = \"姓名\",index = 0)\n    private String name;\n\n    @ExcelProperty(value = \"密码\",index = 1)\n    private String password;\n\n    @ExcelProperty(value = \"年龄\",index = 2)\n    private Integer age;\n}\n```\n注：@Data,@Builder注解是引入的lombok的注解，省略了get/set方法。@Builder是后边方便批量创建实体类所用的。\n@ExcelProperty注解是引入的easyExcel依赖包中的，上面字段注解的意思value是表头名称，index是第几列，可以参考如下图：\n![image.png](https://upload-images.jianshu.io/upload_images/8504906-61304127c4a383b7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\n\n之后创建UserController类并创建返回list集合的方法，用于测试输出Excel表中\n```\n public List<User> getAllUser(){\n        List<User> userList = new ArrayList<>();\n       for (int i=0;i<100;i++){\n           User user = User.builder().name(\"张三\"+ i).password(\"1234\").age(i).build();\n           userList.add(user);\n       }\n        return userList;\n    }\n```\n上面for循环目的是用了批量创建list集合，你可以自己一个个的创建\n\n下面进行测试，\n```\npublic class EasyexceldemoApplicationTests {\n    //注入controller类用来调用返回list集合的方法\n    @Autowired\n    private UserController userController;\n\n\n    @Test\n    public void contextLoads(){\n        // 文件输出位置\n        OutputStream out = null;\n        try {\n            out = new FileOutputStream(\"C:\\\\Users\\\\smfx1314\\\\Desktop\\\\bbb\\\\test.xlsx\");\n            ExcelWriter writer = EasyExcelFactory.getWriter(out);\n\n            // 写仅有一个 Sheet 的 Excel 文件, 此场景较为通用\n            Sheet sheet1 = new Sheet(1, 0, User.class);\n\n            // 第一个 sheet 名称\n            sheet1.setSheetName(\"第一个sheet\");\n\n            // 写数据到 Writer 上下文中\n            // 入参1: 数据库查询的数据list集合\n            // 入参2: 要写入的目标 sheet\n            writer.write(userController.getAllUser(), sheet1);\n\n            // 将上下文中的最终 outputStream 写入到指定文件中\n            writer.finish();\n        } catch (FileNotFoundException e) {\n            e.printStackTrace();\n        }finally {\n            try {\n                // 关闭流\n                out.close();\n            } catch (IOException e) {\n                e.printStackTrace();\n            }\n        }\n\n    }\n\n}\n\n```\n注：文件输出位置要自定义好，包括xxx.xlsx文档名称，意思数据输出就在这个文档了。\nsheet1.setSheetName(\"第一个sheet\")用了设置文档名称，看下图：\n![image.png](https://upload-images.jianshu.io/upload_images/8504906-22799ce70e7ddb37.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n测试成功，然后看看你的xxx.xlsx文档里面是否有内容输出\n[源码参考](https://github.com/smfx1314/easyexceldemo)', 'Java解析、生成Excel比较有名的框架有Apache poi、jxl。但他们都存在一个严重的问题就是非常的耗内存，poi有一套SAX模式的API可以一定程度的解决一些内存溢出的问题，但POI还是有一些缺陷，比如07版Excel解压缩以及解压后存储都是在内存中完成的，内存消耗依然很大。', '2019-07-02 15:02:32', '2019-07-02 15:02:32', '0', '1', 'easyexcel', '0', '0', '1');
INSERT INTO `t_blogs` VALUES ('106', '手机号，身份证号，姓名加*号工具类，你可能用的到', '```\n\npublic class ReStrUtils {\n\n    /**\n     * 身份证号加*号\n     */\n    public static String reNo(String realNo) {\n        String newNo = \"\";\n        if (realNo.length() == 15){\n            newNo = realNo.replaceAll(\"(\\\\d{4})\\\\d{7}(\\\\d{4})\", \"$1*******$2\");\n        }\n        if (realNo.length() == 18){\n            newNo = realNo.replaceAll(\"(\\\\d{4})\\\\d{10}(\\\\d{4})\", \"$1**********$2\");\n        }\n        return newNo;\n    }\n\n    /**\n     * 名字加*号\n     * @param realname\n     * @return\n     */\n    public static String reName(String realname) {\n        char[] r = realname.toCharArray();\n        String name = \"\";\n        if (r.length == 1){\n            name = realname;\n        }\n\n        if (r.length == 2){\n            name = realname.replaceFirst(realname.substring(1), \"*\");\n        }\n\n        if (r.length > 2){\n            name = realname.replaceFirst(realname.substring(1, r.length - 1), \"*\");\n\n        }\n        return name;\n    }\n\n    /**\n     * 手机号加*号\n     * @param realPhone\n     * @return\n     */\n    public static String rePhone(String realPhone) {\n        String phoneNumber;\n        if (realPhone.length() == 11){\n            phoneNumber = realPhone.replaceAll(\"(\\\\d{3})\\\\d{4}(\\\\d{4})\", \"$1****$2\");\n        }else{\n            phoneNumber = realPhone;\n        }\n        return phoneNumber;\n    }\n}\n\n```', '手机号，身份证号，姓名加*号工具类，你可能用的到', '2019-07-03 08:14:38', '2019-07-03 08:14:38', '0', '1', '前端', '0', '0', '1');
INSERT INTO `t_blogs` VALUES ('107', 'jenkins安装', '#### 概述\nJenkins是一个开源软件项目，是基于Java开发的一种[持续集成工具，持续、自动地构建/测试软件项目。旨在提供一个开放易用的软件平台，使软件的持续集成变成可能。\n\nJenkins拥有的特性包括：\n\n* 易于安装-只要把jenkins.war部署到servlet容器，不需要数据库支持。\n* 易于配置-所有配置都是通过其提供的web界面实现。\n* 集成RSS/E-mail通过RSS发布构建结果或当构建完成时通过e-mail通知。\n* 生成JUnit/TestNG测试报告。\n* 分布式构建支持Jenkins能够让多台计算机一起构建/测试。\n* 文件识别:Jenkins能够跟踪哪次构建生成哪些jar，哪次构建使用哪个版本的jar等。\n* 插件支持:支持扩展插件，你可以开发适合自己团队使用的工具。\n\n传统方式\n![手动部署](https://upload-images.jianshu.io/upload_images/8504906-727a7271a7427448.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\n持续集成\n![Jenkins持续集成](https://upload-images.jianshu.io/upload_images/8504906-aa81d4d3473dae43.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\n\n#### 下载\n首先进入[Jenkins官网]([https://jenkins.io/](https://jenkins.io/)\n)\n![官网](https://upload-images.jianshu.io/upload_images/8504906-8f85a1e888578755.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n点击下载\n![下载](https://upload-images.jianshu.io/upload_images/8504906-69a4affac032215b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n左边是稳定版，右边是最新版，你根据需要下载即可。本文下载的是 Generic Java package (.war) ，这样对所有系统都通用。\n#### 安装\n安装Jenkins非常简单，只需准备一个Tomcat，然后将下载下来的 jenkins.war 丢到Tomcat的 webapps 目录中，然后启动Tomcat即可。\n![image.png](https://upload-images.jianshu.io/upload_images/8504906-1d8e6bc24bf3a619.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\n#### 初始化\nJenkins启动片刻后，访问 http://localhost:8080/jenkins ，即可看到类似如下的界面：\n![登录页面](https://upload-images.jianshu.io/upload_images/8504906-841b31546a0f31ba.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n##### 注：密码请到途中提示的路径下寻找即可\n输入密码点击继续，看到如下页面\n![自定义页面](https://upload-images.jianshu.io/upload_images/8504906-b03eaa116f0062c7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\n+  安装推荐的插件：该选项包含了Jenkins常用的一些插件，基本满足日常使用；\n+ 选择插件来安装 ：该选项更具灵活性。\n这里以安装推荐的插件为例，点击后，将会看到类似如下的界面：\n![新手入门-安装插件](https://upload-images.jianshu.io/upload_images/8504906-23ef8c61d22a0239.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n待插件安装完毕后（等待的时间长短视您的网络而定），将会看到类似如下的界面：\n![创建用户](https://upload-images.jianshu.io/upload_images/8504906-173e851396f35d57.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\nJenkins要求我们创建第一个管理员账户。填入相关信息，并点击 保存并完成 按钮，Jenkins即可初始化完成。\n\n![实例配置](https://upload-images.jianshu.io/upload_images/8504906-4d6c1267bfa8c43d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\n![就绪](https://upload-images.jianshu.io/upload_images/8504906-baf28c80821b9830.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\n>TIPS\n安装完成后，如果访问 http://localhost:18080/jenkins 变成白板，而且没有反应，建议重启Jenkins服务器，并重新访问尝试。\n\n配置\n下面，我们来配置Jenkins。点击系统管理 - 全局工具配置 \n![image.png](https://upload-images.jianshu.io/upload_images/8504906-20d18d80fb295c24.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\n将会看到类似如下图的界面。按需添加JDK、Git、Gradle、Maven、Docker等配置。配置比较简单，这里就不赘述了。\n\n![image.png](https://upload-images.jianshu.io/upload_images/8504906-e3952a1b4dac6fcc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n未完待续。。。', 'Jenkins是一个开源软件项目，是基于Java开发的一种[持续集成工具，持续、自动地构建/测试软件项目。旨在提供一个开放易用的软件平台，使软件的持续集成变成可能。', '2019-07-03 08:15:59', '2019-07-03 08:15:58', '0', '1', 'jekins', '0', '0', '1');
INSERT INTO `t_blogs` VALUES ('108', 'Boostnote跨平台 Markdown 编辑器', '![image.png](https://upload-images.jianshu.io/upload_images/8504906-35dd461385ff5b58.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\nBoostnote 0.11.6 发布了，Boostnote 是一个 Markdown 编辑器，可用于 Mac、Windows、Linux、Android 和 iOS 平台。\n\n#### 新版特性\n\n*   Dev: 更新 Travis CI node 及 npm 版本 [#2929](https://github.com/BoostIO/Boostnote/pull/2929)\n\n*   将 React hooks section 添加到代码样式指南 [#3000](https://github.com/BoostIO/Boostnote/pull/3000)\n\n*   新增 “Ctrl + /” 及 “Shift + Ctrl + /”，用来插入今天的日期和时间 [#2962](https://github.com/BoostIO/Boostnote/pull/2962)\n\n*   粘贴附带 URL 的 Markdown 有效标题时，捕获页面标题 [#2908](https://github.com/BoostIO/Boostnote/pull/2908)\n\n*   添加默认值到自定义 CSS 编辑器 [#2888](https://github.com/BoostIO/Boostnote/pull/2888)\n\n*   新增 Nord 编辑器主体 [#2887](https://github.com/BoostIO/Boostnote/pull/2887)\n\n*   自动更新可用的表格内容 [#2869](https://github.com/BoostIO/Boostnote/pull/2869)\n\n*   markdownlint 介绍 #864 [#2846](https://github.com/BoostIO/Boostnote/pull/2846)\n\n*   [特性] 在预览界面编辑 [#2819](https://github.com/BoostIO/Boostnote/pull/2819)\n\n*   将 Markdown 笔记导出成 PDF 格式 [#2678](https://github.com/BoostIO/Boostnote/pull/2678)\n\n*   将 ~ 及 _ 添加到自动关闭的括号 [#2545](https://github.com/BoostIO/Boostnote/pull/2545)\n\n*   macOS mojave 支持暗黑模式 [#2509](https://github.com/BoostIO/Boostnote/pull/2509)\n\n*   为偏好页面加入缺失的中文翻译 [#2493](https://github.com/BoostIO/Boostnote/pull/2493)\n\n此外还有一些 bug 修复等内容，详情可查看[发布公告](https://medium.com/boostnote/boostnote-v0-11-6-release-5cd78597c05b)。\n\n下载地址：[https://boostnote.io/#download](https://boostnote.io/#download)\n\n#### 详细介绍\n\n+ 您的markdown 笔记会在您编写时自动保存，并且各种格式选项具有半实时预览，因此您可以仔细检查您正在编写的内容。文本会在您键入时进行格式化。\n对于代码片段，该应用程序能够突出显示100多种语言的代码语法，包括Javascript，Python，HTML和CSS，您可以在同一个代码段中存储多个代码片段。“\n\n\n+ Boostnote由程序员社区支持。它在GitHub上获得了很多关注，并得到了许多贡献者的支持。\n受到来自200多个国家和地区的程序员的信赖。\n我们的社区永远欢迎您！\n\n+ 即使您处于离线状态，也可以从任何地方轻松编写笔记。当您更新笔记本电脑上的笔记时，它们也会反映在您的移动设备上。\nBoostnote无处不在。\n\n+ 有很多代码块，编辑器和UI主题。您也可以根据需要设置热键。\n使Boostnote成为您自己的！', 'Boostnote 0.11.6 发布了，Boostnote 是一个 Markdown 编辑器，可用于 Mac、Windows、Linux、Android 和 iOS 平台。', '2019-07-03 08:16:54', '2019-07-03 08:16:54', '0', '1', 'markdown', '0', '0', '1');

-- ----------------------------
-- Table structure for t_images
-- ----------------------------
DROP TABLE IF EXISTS `t_images`;
CREATE TABLE `t_images` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `title_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '标题图片',
  `blog_id` int(11) DEFAULT NULL COMMENT '所属文章id',
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_images
-- ----------------------------
INSERT INTO `t_images` VALUES ('71', '05f25db6-ce6d-4fba-b1aa-9430ddd9d9e21.jpg', '91');
INSERT INTO `t_images` VALUES ('80', '2662826c-efd5-4add-8ee8-8669aa9a1e0a2.jpg', '100');
INSERT INTO `t_images` VALUES ('81', '284e88e4-777e-4b7d-ab5f-78f61adc07df3.jpg', '101');
INSERT INTO `t_images` VALUES ('82', 'f48f0487-cc84-48b4-b262-cdd5701e22f14.jpg', '102');
INSERT INTO `t_images` VALUES ('83', 'd38b2f2c-6f10-4c6b-b46d-d2918b9b0dc85.jpg', '103');
INSERT INTO `t_images` VALUES ('84', '4b81d9b1-412d-4c54-b1fd-7f9e0a06d89f6.jpg', '104');
INSERT INTO `t_images` VALUES ('86', '87cbf3fd-6441-4b2b-8ded-e6d750bd0cd0下载 (1).jpg', '106');
INSERT INTO `t_images` VALUES ('87', 'ace8e66d-7b47-4941-91fa-dd9c2ae34050下载.jpg', '107');
INSERT INTO `t_images` VALUES ('88', 'c54d750c-61fa-4914-b91d-accb0d73d4a4images.jpg', '108');

-- ----------------------------
-- Table structure for t_logs
-- ----------------------------
DROP TABLE IF EXISTS `t_logs`;
CREATE TABLE `t_logs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `clientIp` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '客户端ip',
  `username` varchar(200) DEFAULT NULL COMMENT '操作人姓名',
  `operType` varchar(20) DEFAULT NULL COMMENT '日志类型',
  `operUrl` varchar(255) DEFAULT NULL COMMENT '操作的url',
  `operEvent` varchar(255) DEFAULT NULL COMMENT '操作事件',
  `reqParam` varchar(255) DEFAULT NULL COMMENT '请求参数信息',
  `reqType` varchar(255) DEFAULT NULL COMMENT '请求方式：POST或者GET',
  `operTime` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=374 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_logs
-- ----------------------------
INSERT INTO `t_logs` VALUES ('53', '127.0.0.1', null, '查询所有公告', 'http://localhost:8081/notice/selectAllNotice', null, '{}', null, '2019-06-16 11:50:51');
INSERT INTO `t_logs` VALUES ('54', '127.0.0.1', null, null, 'http://localhost:8081/log/selectAllLog', null, '{}', null, '2019-06-16 12:22:11');
INSERT INTO `t_logs` VALUES ('55', '127.0.0.1', null, null, 'http://localhost:8081/log/selectAllLog', null, '{\"pageNum\":[\"1\"]}', null, '2019-06-16 12:22:58');
INSERT INTO `t_logs` VALUES ('56', '127.0.0.1', null, null, 'http://localhost:8081/log/selectAllLog', null, '{\"pageNum\":[\"1\"]}', null, '2019-06-16 12:24:04');
INSERT INTO `t_logs` VALUES ('57', '127.0.0.1', null, null, 'http://localhost:8081/log/selectAllLog', null, '{\"pageNum\":[\"5\"]}', null, '2019-06-16 12:24:11');
INSERT INTO `t_logs` VALUES ('58', '127.0.0.1', null, null, 'http://localhost:8081/log/selectAllLog', null, '{\"pageNum\":[\"2\"]}', null, '2019-06-16 12:24:13');
INSERT INTO `t_logs` VALUES ('59', '127.0.0.1', null, null, 'http://localhost:8081/log/selectAllLog', null, '{\"pageNum\":[\"2\"]}', null, '2019-06-16 12:24:15');
INSERT INTO `t_logs` VALUES ('60', '127.0.0.1', null, null, 'http://localhost:8081/log/selectAllLog', null, '{\"pageNum\":[\"3\"]}', null, '2019-06-16 12:24:16');
INSERT INTO `t_logs` VALUES ('61', '127.0.0.1', null, null, 'http://localhost:8081/log/selectAllLog', null, '{\"pageNum\":[\"1\"]}', null, '2019-06-16 12:26:35');
INSERT INTO `t_logs` VALUES ('62', '127.0.0.1', null, null, 'http://localhost:8081/log/selectAllLog', null, '{\"pageNum\":[\"2\"]}', null, '2019-06-16 12:26:37');
INSERT INTO `t_logs` VALUES ('63', '127.0.0.1', null, null, 'http://localhost:8081/log/selectAllLog', null, '{\"pageNum\":[\"3\"]}', null, '2019-06-16 12:26:39');
INSERT INTO `t_logs` VALUES ('64', '127.0.0.1', null, null, 'http://localhost:8081/log/selectAllLog', null, '{\"pageNum\":[\"4\"]}', null, '2019-06-16 12:26:41');
INSERT INTO `t_logs` VALUES ('65', '127.0.0.1', null, null, 'http://localhost:8081/log/selectAllLog', null, '{\"pageNum\":[\"5\"]}', null, '2019-06-16 12:26:42');
INSERT INTO `t_logs` VALUES ('66', '127.0.0.1', null, null, 'http://localhost:8081/log/selectAllLog', null, '{\"pageNum\":[\"6\"]}', null, '2019-06-16 12:26:44');
INSERT INTO `t_logs` VALUES ('67', '127.0.0.1', null, null, 'http://localhost:8081/log/selectAllLog', null, '{\"pageNum\":[\"6\"]}', null, '2019-06-16 12:26:47');
INSERT INTO `t_logs` VALUES ('68', '127.0.0.1', null, null, 'http://localhost:8081/log/selectAllLog', null, '{\"pageNum\":[\"7\"]}', null, '2019-06-16 12:26:49');
INSERT INTO `t_logs` VALUES ('69', '127.0.0.1', null, null, 'http://localhost:8081/log/selectAllLog', null, '{\"pageNum\":[\"1\"]}', null, '2019-06-16 12:28:51');
INSERT INTO `t_logs` VALUES ('70', '127.0.0.1', null, null, 'http://localhost:8081/log/selectAllLog', null, '{\"pageNum\":[\"1\"]}', null, '2019-06-16 12:29:38');
INSERT INTO `t_logs` VALUES ('71', '127.0.0.1', null, null, 'http://localhost:8081/log/selectAllLog', null, '{\"pageNum\":[\"2\"]}', null, '2019-06-16 12:29:43');
INSERT INTO `t_logs` VALUES ('72', '127.0.0.1', null, null, 'http://localhost:8081/log/selectAllLog', null, '{\"pageNum\":[\"1\"]}', null, '2019-06-16 12:29:45');
INSERT INTO `t_logs` VALUES ('73', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, '{\"id\":[\"80\"]}', null, '2019-06-16 12:43:58');
INSERT INTO `t_logs` VALUES ('74', '127.0.0.1', null, '校验用户名', 'http://localhost:8081/user/checkUsername', null, '{\"username\":[\"姜飞祥\"]}', null, '2019-06-16 14:46:57');
INSERT INTO `t_logs` VALUES ('75', '127.0.0.1', null, '用户登录', 'http://localhost:8081/user/login', null, '{\"username\":[\"姜飞祥\"],\"password\":[\"123456\"]}', null, '2019-06-16 14:47:41');
INSERT INTO `t_logs` VALUES ('76', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, '{\"pageNum\":[\"1\"]}', null, '2019-06-16 14:47:49');
INSERT INTO `t_logs` VALUES ('77', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, '{\"pageNum\":[\"1\"]}', null, '2019-06-16 14:47:57');
INSERT INTO `t_logs` VALUES ('78', '127.0.0.1', null, '根据id删除', 'http://localhost:8081/contents/deleteById', null, '{\"id\":[\"84\"]}', null, '2019-06-16 14:48:02');
INSERT INTO `t_logs` VALUES ('79', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, '{\"pageNum\":[\"1\"]}', null, '2019-06-16 14:48:03');
INSERT INTO `t_logs` VALUES ('80', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, '{\"id\":[\"85\"]}', null, '2019-06-16 14:48:05');
INSERT INTO `t_logs` VALUES ('81', '127.0.0.1', null, '更新博客', 'http://localhost:8081/contents/updateBlog', null, '{\"bid\":[\"85\"],\"title\":[\"是21\"],\"content\":[\"是是是\"],\"description\":[\"是是是\"],\"status\":[\"1\"],\"tags\":[\"搜索\"],\"allowcomment\":[\"1\"]}', null, '2019-06-16 14:48:13');
INSERT INTO `t_logs` VALUES ('82', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, '{\"pageNum\":[\"1\"]}', null, '2019-06-16 14:48:16');
INSERT INTO `t_logs` VALUES ('83', '127.0.0.1', null, '上传文件', 'http://localhost:8081/contents/uploadImage', null, '{}', null, '2019-06-16 14:49:56');
INSERT INTO `t_logs` VALUES ('84', '127.0.0.1', null, '添加博客', 'http://localhost:8081/contents/insertBlog', null, null, null, '2019-06-16 14:52:10');
INSERT INTO `t_logs` VALUES ('85', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 14:52:14');
INSERT INTO `t_logs` VALUES ('86', '127.0.0.1', null, '根据id删除', 'http://localhost:8081/contents/deleteById', null, null, null, '2019-06-16 14:52:31');
INSERT INTO `t_logs` VALUES ('87', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 14:52:32');
INSERT INTO `t_logs` VALUES ('88', '127.0.0.1', null, '根据id删除', 'http://localhost:8081/contents/deleteById', null, null, null, '2019-06-16 14:52:34');
INSERT INTO `t_logs` VALUES ('89', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 14:52:35');
INSERT INTO `t_logs` VALUES ('90', '127.0.0.1', null, '根据id删除', 'http://localhost:8081/contents/deleteById', null, null, null, '2019-06-16 14:52:37');
INSERT INTO `t_logs` VALUES ('91', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 14:52:38');
INSERT INTO `t_logs` VALUES ('92', '127.0.0.1', null, '根据id删除', 'http://localhost:8081/contents/deleteById', null, null, null, '2019-06-16 14:52:40');
INSERT INTO `t_logs` VALUES ('93', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 14:52:41');
INSERT INTO `t_logs` VALUES ('94', '127.0.0.1', null, '根据id删除', 'http://localhost:8081/contents/deleteById', null, null, null, '2019-06-16 14:52:44');
INSERT INTO `t_logs` VALUES ('95', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 14:52:45');
INSERT INTO `t_logs` VALUES ('96', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 14:52:48');
INSERT INTO `t_logs` VALUES ('97', '127.0.0.1', null, '根据id删除', 'http://localhost:8081/contents/deleteById', null, null, null, '2019-06-16 14:52:51');
INSERT INTO `t_logs` VALUES ('98', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 14:52:52');
INSERT INTO `t_logs` VALUES ('99', '127.0.0.1', null, '根据id删除', 'http://localhost:8081/contents/deleteById', null, null, null, '2019-06-16 14:52:55');
INSERT INTO `t_logs` VALUES ('100', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 14:52:56');
INSERT INTO `t_logs` VALUES ('101', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-06-16 14:53:26');
INSERT INTO `t_logs` VALUES ('102', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-06-16 14:54:53');
INSERT INTO `t_logs` VALUES ('103', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-06-16 14:55:14');
INSERT INTO `t_logs` VALUES ('104', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-06-16 14:55:23');
INSERT INTO `t_logs` VALUES ('105', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-06-16 14:56:08');
INSERT INTO `t_logs` VALUES ('106', '127.0.0.1', null, '更新博客', 'http://localhost:8081/contents/updateBlog', null, null, null, '2019-06-16 14:56:21');
INSERT INTO `t_logs` VALUES ('107', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 14:56:23');
INSERT INTO `t_logs` VALUES ('108', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-06-16 14:56:27');
INSERT INTO `t_logs` VALUES ('109', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-06-16 14:56:37');
INSERT INTO `t_logs` VALUES ('110', '127.0.0.1', null, '查询所有公告', 'http://localhost:8081/notice/selectAllNotice', null, null, null, '2019-06-16 14:56:57');
INSERT INTO `t_logs` VALUES ('111', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 14:57:10');
INSERT INTO `t_logs` VALUES ('112', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 15:00:28');
INSERT INTO `t_logs` VALUES ('113', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 15:00:58');
INSERT INTO `t_logs` VALUES ('114', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 15:01:02');
INSERT INTO `t_logs` VALUES ('115', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 15:01:24');
INSERT INTO `t_logs` VALUES ('116', '127.0.0.1', null, '查询所有日志操作', 'http://localhost:8081/log/selectAllLog', null, null, null, '2019-06-16 15:01:27');
INSERT INTO `t_logs` VALUES ('117', '127.0.0.1', null, '查询所有日志操作', 'http://localhost:8081/log/selectAllLog', null, null, null, '2019-06-16 15:01:34');
INSERT INTO `t_logs` VALUES ('118', '127.0.0.1', null, '查询所有日志操作', 'http://localhost:8081/log/selectAllLog', null, null, null, '2019-06-16 15:01:36');
INSERT INTO `t_logs` VALUES ('119', '127.0.0.1', null, '查询所有日志操作', 'http://localhost:8081/log/selectAllLog', null, null, null, '2019-06-16 15:01:38');
INSERT INTO `t_logs` VALUES ('120', '127.0.0.1', null, '查询所有日志操作', 'http://localhost:8081/log/selectAllLog', null, null, null, '2019-06-16 15:01:39');
INSERT INTO `t_logs` VALUES ('121', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 15:02:28');
INSERT INTO `t_logs` VALUES ('122', '127.0.0.1', null, '查询所有公告', 'http://localhost:8081/notice/selectAllNotice', null, null, null, '2019-06-16 15:02:31');
INSERT INTO `t_logs` VALUES ('123', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 15:02:35');
INSERT INTO `t_logs` VALUES ('124', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 15:02:40');
INSERT INTO `t_logs` VALUES ('125', '127.0.0.1', null, '查询所有公告', 'http://localhost:8081/notice/selectAllNotice', null, null, null, '2019-06-16 15:02:47');
INSERT INTO `t_logs` VALUES ('126', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 15:02:51');
INSERT INTO `t_logs` VALUES ('127', '127.0.0.1', null, '查询所有公告', 'http://localhost:8081/notice/selectAllNotice', null, null, null, '2019-06-16 15:02:55');
INSERT INTO `t_logs` VALUES ('128', '127.0.0.1', null, '查询所有公告', 'http://localhost:8081/notice/selectAllNotice', null, null, null, '2019-06-16 15:05:56');
INSERT INTO `t_logs` VALUES ('129', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 15:05:59');
INSERT INTO `t_logs` VALUES ('130', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 15:06:09');
INSERT INTO `t_logs` VALUES ('131', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 15:06:12');
INSERT INTO `t_logs` VALUES ('132', '127.0.0.1', null, '查询所有公告', 'http://localhost:8081/notice/selectAllNotice', null, null, null, '2019-06-16 15:06:17');
INSERT INTO `t_logs` VALUES ('133', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 15:06:19');
INSERT INTO `t_logs` VALUES ('134', '127.0.0.1', null, '查询所有公告', 'http://localhost:8081/notice/selectAllNotice', null, null, null, '2019-06-16 15:06:34');
INSERT INTO `t_logs` VALUES ('135', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 15:06:40');
INSERT INTO `t_logs` VALUES ('136', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 15:07:07');
INSERT INTO `t_logs` VALUES ('137', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 15:07:08');
INSERT INTO `t_logs` VALUES ('138', '127.0.0.1', null, '查询所有公告', 'http://localhost:8081/notice/selectAllNotice', null, null, null, '2019-06-16 15:07:10');
INSERT INTO `t_logs` VALUES ('139', '127.0.0.1', null, '查询所有公告', 'http://localhost:8081/notice/selectAllNotice', null, null, null, '2019-06-16 15:07:13');
INSERT INTO `t_logs` VALUES ('140', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 15:07:14');
INSERT INTO `t_logs` VALUES ('141', '127.0.0.1', null, '查询所有公告', 'http://localhost:8081/notice/selectAllNotice', null, null, null, '2019-06-16 15:07:39');
INSERT INTO `t_logs` VALUES ('142', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 15:07:42');
INSERT INTO `t_logs` VALUES ('143', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 15:08:02');
INSERT INTO `t_logs` VALUES ('144', '127.0.0.1', null, '查询所有公告', 'http://localhost:8081/notice/selectAllNotice', null, null, null, '2019-06-16 15:08:03');
INSERT INTO `t_logs` VALUES ('145', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 15:08:05');
INSERT INTO `t_logs` VALUES ('146', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 15:08:19');
INSERT INTO `t_logs` VALUES ('147', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 15:08:20');
INSERT INTO `t_logs` VALUES ('148', '127.0.0.1', null, '查询所有公告', 'http://localhost:8081/notice/selectAllNotice', null, null, null, '2019-06-16 15:08:20');
INSERT INTO `t_logs` VALUES ('149', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 15:08:21');
INSERT INTO `t_logs` VALUES ('150', '127.0.0.1', null, '查询所有公告', 'http://localhost:8081/notice/selectAllNotice', null, null, null, '2019-06-16 15:08:29');
INSERT INTO `t_logs` VALUES ('151', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 15:09:38');
INSERT INTO `t_logs` VALUES ('152', '127.0.0.1', null, '查询所有公告', 'http://localhost:8081/notice/selectAllNotice', null, null, null, '2019-06-16 15:09:39');
INSERT INTO `t_logs` VALUES ('153', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 15:09:42');
INSERT INTO `t_logs` VALUES ('154', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 15:10:58');
INSERT INTO `t_logs` VALUES ('155', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 15:11:00');
INSERT INTO `t_logs` VALUES ('156', '127.0.0.1', null, '查询所有公告', 'http://localhost:8081/notice/selectAllNotice', null, null, null, '2019-06-16 15:11:01');
INSERT INTO `t_logs` VALUES ('157', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 15:11:03');
INSERT INTO `t_logs` VALUES ('158', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 15:11:14');
INSERT INTO `t_logs` VALUES ('159', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 15:11:44');
INSERT INTO `t_logs` VALUES ('160', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 15:11:48');
INSERT INTO `t_logs` VALUES ('161', '127.0.0.1', null, '查询所有公告', 'http://localhost:8081/notice/selectAllNotice', null, null, null, '2019-06-16 15:11:49');
INSERT INTO `t_logs` VALUES ('162', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 15:11:50');
INSERT INTO `t_logs` VALUES ('163', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 15:12:32');
INSERT INTO `t_logs` VALUES ('164', '127.0.0.1', null, '查询所有公告', 'http://localhost:8081/notice/selectAllNotice', null, null, null, '2019-06-16 15:12:33');
INSERT INTO `t_logs` VALUES ('165', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 15:12:34');
INSERT INTO `t_logs` VALUES ('166', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 15:12:44');
INSERT INTO `t_logs` VALUES ('167', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 15:13:06');
INSERT INTO `t_logs` VALUES ('168', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 15:13:50');
INSERT INTO `t_logs` VALUES ('169', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 15:13:53');
INSERT INTO `t_logs` VALUES ('170', '127.0.0.1', null, '查询所有公告', 'http://localhost:8081/notice/selectAllNotice', null, null, null, '2019-06-16 15:13:54');
INSERT INTO `t_logs` VALUES ('171', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 15:13:55');
INSERT INTO `t_logs` VALUES ('172', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 16:00:50');
INSERT INTO `t_logs` VALUES ('173', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 16:01:10');
INSERT INTO `t_logs` VALUES ('174', '127.0.0.1', null, '导出至Excel表', 'http://localhost:8081/admin/excelOut', null, null, null, '2019-06-16 16:01:21');
INSERT INTO `t_logs` VALUES ('175', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 16:02:55');
INSERT INTO `t_logs` VALUES ('176', '127.0.0.1', null, '查询所有日志操作', 'http://localhost:8081/log/selectAllLog', null, null, null, '2019-06-16 16:11:01');
INSERT INTO `t_logs` VALUES ('177', '127.0.0.1', null, '校验用户名', 'http://localhost:8081/user/checkUsername', null, null, null, '2019-06-16 17:04:02');
INSERT INTO `t_logs` VALUES ('178', '127.0.0.1', null, '校验用户名', 'http://localhost:8081/user/checkUsername', null, null, null, '2019-06-16 17:04:13');
INSERT INTO `t_logs` VALUES ('179', '127.0.0.1', null, '注册用户', 'http://localhost:8081/user/insertUser', null, null, null, '2019-06-16 17:04:30');
INSERT INTO `t_logs` VALUES ('180', '127.0.0.1', null, '校验用户名', 'http://localhost:8081/user/checkUsername', null, null, null, '2019-06-16 17:04:37');
INSERT INTO `t_logs` VALUES ('181', '127.0.0.1', null, '用户登录', 'http://localhost:8081/user/login', null, null, null, '2019-06-16 17:04:41');
INSERT INTO `t_logs` VALUES ('182', '127.0.0.1', null, '校验用户名', 'http://localhost:8081/user/checkUsername', null, null, null, '2019-06-16 17:05:44');
INSERT INTO `t_logs` VALUES ('183', '127.0.0.1', null, '用户登录', 'http://localhost:8081/user/login', null, null, null, '2019-06-16 17:05:47');
INSERT INTO `t_logs` VALUES ('184', '127.0.0.1', null, '校验用户名', 'http://localhost:8081/user/checkUsername', null, null, null, '2019-06-16 17:06:12');
INSERT INTO `t_logs` VALUES ('185', '127.0.0.1', null, '用户登录', 'http://localhost:8081/user/login', null, null, null, '2019-06-16 17:06:16');
INSERT INTO `t_logs` VALUES ('186', '127.0.0.1', null, '校验用户名', 'http://localhost:8081/user/checkUsername', null, null, null, '2019-06-16 17:06:29');
INSERT INTO `t_logs` VALUES ('187', '127.0.0.1', null, '用户登录', 'http://localhost:8081/user/login', null, null, null, '2019-06-16 17:06:31');
INSERT INTO `t_logs` VALUES ('188', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 17:06:42');
INSERT INTO `t_logs` VALUES ('189', '127.0.0.1', null, '查询所有公告', 'http://localhost:8081/notice/selectAllNotice', null, null, null, '2019-06-16 17:07:33');
INSERT INTO `t_logs` VALUES ('190', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 17:08:09');
INSERT INTO `t_logs` VALUES ('191', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 17:08:27');
INSERT INTO `t_logs` VALUES ('192', '127.0.0.1', null, '查询所有日志操作', 'http://localhost:8081/log/selectAllLog', null, null, null, '2019-06-16 17:08:30');
INSERT INTO `t_logs` VALUES ('193', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 17:08:41');
INSERT INTO `t_logs` VALUES ('194', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-06-16 17:10:28');
INSERT INTO `t_logs` VALUES ('195', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 17:13:48');
INSERT INTO `t_logs` VALUES ('196', '127.0.0.1', null, '查询所有公告', 'http://localhost:8081/notice/selectAllNotice', null, null, null, '2019-06-16 17:14:30');
INSERT INTO `t_logs` VALUES ('197', '127.0.0.1', null, '查询所有公告', 'http://localhost:8081/notice/selectAllNotice', null, null, null, '2019-06-16 17:15:00');
INSERT INTO `t_logs` VALUES ('198', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 17:19:10');
INSERT INTO `t_logs` VALUES ('199', '127.0.0.1', null, '校验用户名', 'http://localhost:8081/user/checkUsername', null, null, null, '2019-06-16 17:31:48');
INSERT INTO `t_logs` VALUES ('200', '127.0.0.1', null, '用户登录', 'http://localhost:8081/user/login', null, null, null, '2019-06-16 17:31:53');
INSERT INTO `t_logs` VALUES ('201', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 17:31:59');
INSERT INTO `t_logs` VALUES ('202', '127.0.0.1', null, '校验用户名', 'http://localhost:8081/user/checkUsername', null, null, null, '2019-06-16 17:36:27');
INSERT INTO `t_logs` VALUES ('203', '127.0.0.1', null, '用户登录', 'http://localhost:8081/user/login', null, null, null, '2019-06-16 17:36:31');
INSERT INTO `t_logs` VALUES ('204', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-16 17:36:35');
INSERT INTO `t_logs` VALUES ('205', '127.0.0.1', null, '上传文件', 'http://localhost:8081/contents/uploadImage', null, null, null, '2019-06-17 22:01:49');
INSERT INTO `t_logs` VALUES ('206', '127.0.0.1', null, '上传文件', 'http://localhost:8081/contents/uploadImage', null, null, null, '2019-06-17 22:03:45');
INSERT INTO `t_logs` VALUES ('207', '127.0.0.1', null, '上传文件', 'http://localhost:8081/contents/uploadImage', null, null, null, '2019-06-17 22:03:52');
INSERT INTO `t_logs` VALUES ('208', '127.0.0.1', null, '上传文件', 'http://localhost:8081/contents/uploadImage', null, null, null, '2019-06-17 22:04:02');
INSERT INTO `t_logs` VALUES ('209', '127.0.0.1', null, '校验用户名', 'http://localhost:8081/user/checkUsername', null, null, null, '2019-06-19 06:25:29');
INSERT INTO `t_logs` VALUES ('210', '127.0.0.1', null, '用户登录', 'http://localhost:8081/user/login', null, null, null, '2019-06-19 06:25:40');
INSERT INTO `t_logs` VALUES ('211', '127.0.0.1', null, '用户登录', 'http://localhost:8081/user/login', null, null, null, '2019-06-19 06:26:02');
INSERT INTO `t_logs` VALUES ('212', '127.0.0.1', null, '用户登录', 'http://localhost:8081/user/login', null, null, null, '2019-06-19 06:26:16');
INSERT INTO `t_logs` VALUES ('213', '127.0.0.1', null, '用户登录', 'http://localhost:8081/user/login', null, null, null, '2019-06-19 06:26:24');
INSERT INTO `t_logs` VALUES ('214', '127.0.0.1', null, '用户登录', 'http://localhost:8081/user/login', null, null, null, '2019-06-19 06:26:36');
INSERT INTO `t_logs` VALUES ('215', '127.0.0.1', null, '用户登录', 'http://localhost:8081/user/login', null, null, null, '2019-06-19 06:26:43');
INSERT INTO `t_logs` VALUES ('216', '127.0.0.1', null, '用户登录', 'http://localhost:8081/user/login', null, null, null, '2019-06-19 06:30:51');
INSERT INTO `t_logs` VALUES ('217', '127.0.0.1', null, '校验用户名', 'http://localhost:8081/user/checkUsername', null, null, null, '2019-06-19 06:34:01');
INSERT INTO `t_logs` VALUES ('218', '127.0.0.1', null, '用户登录', 'http://localhost:8081/user/login', null, null, null, '2019-06-19 06:34:06');
INSERT INTO `t_logs` VALUES ('219', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-19 06:34:15');
INSERT INTO `t_logs` VALUES ('220', '127.0.0.1', null, '上传文件', 'http://localhost:8081/contents/uploadImage', null, null, null, '2019-06-19 06:34:53');
INSERT INTO `t_logs` VALUES ('221', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-06-20 21:32:11');
INSERT INTO `t_logs` VALUES ('222', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-06-20 21:32:29');
INSERT INTO `t_logs` VALUES ('223', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-06-20 21:33:10');
INSERT INTO `t_logs` VALUES ('224', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-06-20 21:46:54');
INSERT INTO `t_logs` VALUES ('225', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-06-20 21:47:02');
INSERT INTO `t_logs` VALUES ('226', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-20 21:49:24');
INSERT INTO `t_logs` VALUES ('227', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-20 21:49:31');
INSERT INTO `t_logs` VALUES ('228', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-06-20 21:49:38');
INSERT INTO `t_logs` VALUES ('229', '127.0.0.1', null, '更新博客', 'http://localhost:8081/contents/updateBlog', null, null, null, '2019-06-20 21:49:55');
INSERT INTO `t_logs` VALUES ('230', '127.0.0.1', null, '校验用户名', 'http://localhost:8081/user/checkUsername', null, null, null, '2019-06-20 22:01:28');
INSERT INTO `t_logs` VALUES ('231', '127.0.0.1', null, '用户登录', 'http://localhost:8081/user/login', null, null, null, '2019-06-20 22:01:34');
INSERT INTO `t_logs` VALUES ('232', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-06-20 22:06:18');
INSERT INTO `t_logs` VALUES ('233', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-01 22:39:55');
INSERT INTO `t_logs` VALUES ('234', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-01 22:40:33');
INSERT INTO `t_logs` VALUES ('235', '127.0.0.1', null, '查询所有公告', 'http://localhost:8081/notice/selectAllNotice', null, null, null, '2019-07-01 22:40:37');
INSERT INTO `t_logs` VALUES ('236', '127.0.0.1', null, '增加公告', 'http://localhost:8081/notice/insertNotice', null, null, null, '2019-07-01 22:41:14');
INSERT INTO `t_logs` VALUES ('237', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 08:10:27');
INSERT INTO `t_logs` VALUES ('238', '127.0.0.1', null, '查询所有公告', 'http://localhost:8081/notice/selectAllNotice', null, null, null, '2019-07-02 08:10:29');
INSERT INTO `t_logs` VALUES ('239', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 08:10:32');
INSERT INTO `t_logs` VALUES ('240', '127.0.0.1', null, '查询所有公告', 'http://localhost:8081/notice/selectAllNotice', null, null, null, '2019-07-02 08:10:34');
INSERT INTO `t_logs` VALUES ('241', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 08:10:35');
INSERT INTO `t_logs` VALUES ('242', '127.0.0.1', null, '查询所有公告', 'http://localhost:8081/notice/selectAllNotice', null, null, null, '2019-07-02 08:10:41');
INSERT INTO `t_logs` VALUES ('243', '127.0.0.1', null, '获取所有留言', 'http://localhost:8081/admin/getAllMsg', null, null, null, '2019-07-02 08:10:48');
INSERT INTO `t_logs` VALUES ('244', '127.0.0.1', null, '校验用户名', 'http://localhost:8081/user/checkUsername', null, null, null, '2019-07-02 11:39:05');
INSERT INTO `t_logs` VALUES ('245', '127.0.0.1', null, '用户登录', 'http://localhost:8081/user/login', null, null, null, '2019-07-02 11:39:15');
INSERT INTO `t_logs` VALUES ('246', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 11:39:24');
INSERT INTO `t_logs` VALUES ('247', '127.0.0.1', null, '添加博客', 'http://localhost:8081/contents/insertBlog', null, null, null, '2019-07-02 11:39:43');
INSERT INTO `t_logs` VALUES ('248', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 11:39:45');
INSERT INTO `t_logs` VALUES ('249', '127.0.0.1', null, '添加博客', 'http://localhost:8081/contents/insertBlog', null, null, null, '2019-07-02 11:39:59');
INSERT INTO `t_logs` VALUES ('250', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 11:40:01');
INSERT INTO `t_logs` VALUES ('251', '127.0.0.1', null, '添加博客', 'http://localhost:8081/contents/insertBlog', null, null, null, '2019-07-02 11:40:35');
INSERT INTO `t_logs` VALUES ('252', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 11:40:37');
INSERT INTO `t_logs` VALUES ('253', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 11:40:40');
INSERT INTO `t_logs` VALUES ('254', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 13:35:54');
INSERT INTO `t_logs` VALUES ('255', '127.0.0.1', null, '根据id删除', 'http://localhost:8081/contents/deleteById', null, null, null, '2019-07-02 13:36:12');
INSERT INTO `t_logs` VALUES ('256', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 13:36:14');
INSERT INTO `t_logs` VALUES ('257', '127.0.0.1', null, '根据id删除', 'http://localhost:8081/contents/deleteById', null, null, null, '2019-07-02 13:36:17');
INSERT INTO `t_logs` VALUES ('258', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 13:36:18');
INSERT INTO `t_logs` VALUES ('259', '127.0.0.1', null, '添加博客', 'http://localhost:8081/contents/insertBlog', null, null, null, '2019-07-02 13:37:37');
INSERT INTO `t_logs` VALUES ('260', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 13:37:40');
INSERT INTO `t_logs` VALUES ('261', '127.0.0.1', null, '添加博客', 'http://localhost:8081/contents/insertBlog', null, null, null, '2019-07-02 13:38:01');
INSERT INTO `t_logs` VALUES ('262', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 13:38:03');
INSERT INTO `t_logs` VALUES ('263', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 13:38:05');
INSERT INTO `t_logs` VALUES ('264', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 13:43:35');
INSERT INTO `t_logs` VALUES ('265', '127.0.0.1', null, '添加博客', 'http://localhost:8081/contents/insertBlog', null, null, null, '2019-07-02 13:50:53');
INSERT INTO `t_logs` VALUES ('266', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 13:50:55');
INSERT INTO `t_logs` VALUES ('267', '127.0.0.1', null, '添加博客', 'http://localhost:8081/contents/insertBlog', null, null, null, '2019-07-02 13:51:31');
INSERT INTO `t_logs` VALUES ('268', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 13:51:32');
INSERT INTO `t_logs` VALUES ('269', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 13:53:59');
INSERT INTO `t_logs` VALUES ('270', '127.0.0.1', null, '根据id删除', 'http://localhost:8081/contents/deleteById', null, null, null, '2019-07-02 14:13:31');
INSERT INTO `t_logs` VALUES ('271', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 14:13:32');
INSERT INTO `t_logs` VALUES ('272', '127.0.0.1', null, '根据id删除', 'http://localhost:8081/contents/deleteById', null, null, null, '2019-07-02 14:13:35');
INSERT INTO `t_logs` VALUES ('273', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 14:13:36');
INSERT INTO `t_logs` VALUES ('274', '127.0.0.1', null, '根据id删除', 'http://localhost:8081/contents/deleteById', null, null, null, '2019-07-02 14:13:38');
INSERT INTO `t_logs` VALUES ('275', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 14:13:39');
INSERT INTO `t_logs` VALUES ('276', '127.0.0.1', null, '根据id删除', 'http://localhost:8081/contents/deleteById', null, null, null, '2019-07-02 14:13:42');
INSERT INTO `t_logs` VALUES ('277', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 14:13:43');
INSERT INTO `t_logs` VALUES ('278', '127.0.0.1', null, '根据id删除', 'http://localhost:8081/contents/deleteById', null, null, null, '2019-07-02 14:13:45');
INSERT INTO `t_logs` VALUES ('279', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 14:13:47');
INSERT INTO `t_logs` VALUES ('280', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 14:25:46');
INSERT INTO `t_logs` VALUES ('281', '127.0.0.1', null, '上传文件', 'http://localhost:8081/contents/uploadImage', null, null, null, '2019-07-02 14:26:45');
INSERT INTO `t_logs` VALUES ('282', '127.0.0.1', null, '更新博客', 'http://localhost:8081/contents/updateBlog', null, null, null, '2019-07-02 14:26:49');
INSERT INTO `t_logs` VALUES ('283', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 14:26:52');
INSERT INTO `t_logs` VALUES ('284', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 14:38:34');
INSERT INTO `t_logs` VALUES ('285', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 14:38:47');
INSERT INTO `t_logs` VALUES ('286', '127.0.0.1', null, '上传文件', 'http://localhost:8081/contents/uploadImage', null, null, null, '2019-07-02 14:38:57');
INSERT INTO `t_logs` VALUES ('287', '127.0.0.1', null, '更新博客', 'http://localhost:8081/contents/updateBlog', null, null, null, '2019-07-02 14:39:20');
INSERT INTO `t_logs` VALUES ('288', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 14:45:47');
INSERT INTO `t_logs` VALUES ('289', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 14:45:51');
INSERT INTO `t_logs` VALUES ('290', '127.0.0.1', null, '上传文件', 'http://localhost:8081/contents/uploadImage', null, null, null, '2019-07-02 14:46:03');
INSERT INTO `t_logs` VALUES ('291', '127.0.0.1', null, '更新博客', 'http://localhost:8081/contents/updateBlog', null, null, null, '2019-07-02 14:46:04');
INSERT INTO `t_logs` VALUES ('292', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 14:46:11');
INSERT INTO `t_logs` VALUES ('293', '127.0.0.1', null, '查询所有日志操作', 'http://localhost:8081/log/selectAllLog', null, null, null, '2019-07-02 14:49:49');
INSERT INTO `t_logs` VALUES ('294', '127.0.0.1', null, '查询所有日志操作', 'http://localhost:8081/log/selectAllLog', null, null, null, '2019-07-02 14:49:52');
INSERT INTO `t_logs` VALUES ('295', '127.0.0.1', null, '查询所有日志操作', 'http://localhost:8081/log/selectAllLog', null, null, null, '2019-07-02 14:51:21');
INSERT INTO `t_logs` VALUES ('296', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 14:51:24');
INSERT INTO `t_logs` VALUES ('297', '127.0.0.1', null, '上传文件', 'http://localhost:8081/contents/uploadImage', null, null, null, '2019-07-02 14:56:43');
INSERT INTO `t_logs` VALUES ('298', '127.0.0.1', null, '添加博客', 'http://localhost:8081/contents/insertBlog', null, null, null, '2019-07-02 14:56:47');
INSERT INTO `t_logs` VALUES ('299', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 14:56:49');
INSERT INTO `t_logs` VALUES ('300', '127.0.0.1', null, '上传文件', 'http://localhost:8081/contents/uploadImage', null, null, null, '2019-07-02 14:58:05');
INSERT INTO `t_logs` VALUES ('301', '127.0.0.1', null, '添加博客', 'http://localhost:8081/contents/insertBlog', null, null, null, '2019-07-02 14:58:09');
INSERT INTO `t_logs` VALUES ('302', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 14:58:11');
INSERT INTO `t_logs` VALUES ('303', '127.0.0.1', null, '上传文件', 'http://localhost:8081/contents/uploadImage', null, null, null, '2019-07-02 14:59:10');
INSERT INTO `t_logs` VALUES ('304', '127.0.0.1', null, '添加博客', 'http://localhost:8081/contents/insertBlog', null, null, null, '2019-07-02 14:59:12');
INSERT INTO `t_logs` VALUES ('305', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 14:59:15');
INSERT INTO `t_logs` VALUES ('306', '127.0.0.1', null, '上传文件', 'http://localhost:8081/contents/uploadImage', null, null, null, '2019-07-02 15:01:00');
INSERT INTO `t_logs` VALUES ('307', '127.0.0.1', null, '添加博客', 'http://localhost:8081/contents/insertBlog', null, null, null, '2019-07-02 15:01:29');
INSERT INTO `t_logs` VALUES ('308', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 15:01:31');
INSERT INTO `t_logs` VALUES ('309', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 15:01:37');
INSERT INTO `t_logs` VALUES ('310', '127.0.0.1', null, '上传文件', 'http://localhost:8081/contents/uploadImage', null, null, null, '2019-07-02 15:02:30');
INSERT INTO `t_logs` VALUES ('311', '127.0.0.1', null, '添加博客', 'http://localhost:8081/contents/insertBlog', null, null, null, '2019-07-02 15:02:33');
INSERT INTO `t_logs` VALUES ('312', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 15:02:34');
INSERT INTO `t_logs` VALUES ('313', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 15:02:37');
INSERT INTO `t_logs` VALUES ('314', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 15:02:42');
INSERT INTO `t_logs` VALUES ('315', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:15:52');
INSERT INTO `t_logs` VALUES ('316', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:18:01');
INSERT INTO `t_logs` VALUES ('317', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:18:30');
INSERT INTO `t_logs` VALUES ('318', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:19:11');
INSERT INTO `t_logs` VALUES ('319', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:20:06');
INSERT INTO `t_logs` VALUES ('320', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:21:26');
INSERT INTO `t_logs` VALUES ('321', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:22:46');
INSERT INTO `t_logs` VALUES ('322', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:24:16');
INSERT INTO `t_logs` VALUES ('323', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:24:47');
INSERT INTO `t_logs` VALUES ('324', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:25:08');
INSERT INTO `t_logs` VALUES ('325', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:25:24');
INSERT INTO `t_logs` VALUES ('326', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:25:59');
INSERT INTO `t_logs` VALUES ('327', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:26:12');
INSERT INTO `t_logs` VALUES ('328', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:26:20');
INSERT INTO `t_logs` VALUES ('329', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:27:25');
INSERT INTO `t_logs` VALUES ('330', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:28:08');
INSERT INTO `t_logs` VALUES ('331', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:29:20');
INSERT INTO `t_logs` VALUES ('332', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:29:31');
INSERT INTO `t_logs` VALUES ('333', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:29:39');
INSERT INTO `t_logs` VALUES ('334', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:29:51');
INSERT INTO `t_logs` VALUES ('335', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:32:23');
INSERT INTO `t_logs` VALUES ('336', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:35:35');
INSERT INTO `t_logs` VALUES ('337', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:35:55');
INSERT INTO `t_logs` VALUES ('338', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:35:59');
INSERT INTO `t_logs` VALUES ('339', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:36:15');
INSERT INTO `t_logs` VALUES ('340', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:36:47');
INSERT INTO `t_logs` VALUES ('341', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:37:29');
INSERT INTO `t_logs` VALUES ('342', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:43:15');
INSERT INTO `t_logs` VALUES ('343', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:47:15');
INSERT INTO `t_logs` VALUES ('344', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:50:29');
INSERT INTO `t_logs` VALUES ('345', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:51:33');
INSERT INTO `t_logs` VALUES ('346', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 15:55:50');
INSERT INTO `t_logs` VALUES ('347', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 16:14:06');
INSERT INTO `t_logs` VALUES ('348', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 16:16:23');
INSERT INTO `t_logs` VALUES ('349', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 16:17:22');
INSERT INTO `t_logs` VALUES ('350', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 16:18:45');
INSERT INTO `t_logs` VALUES ('351', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 16:19:40');
INSERT INTO `t_logs` VALUES ('352', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 16:21:38');
INSERT INTO `t_logs` VALUES ('353', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 16:52:42');
INSERT INTO `t_logs` VALUES ('354', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 17:00:10');
INSERT INTO `t_logs` VALUES ('355', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-02 21:19:00');
INSERT INTO `t_logs` VALUES ('356', '127.0.0.1', null, '用户登录', 'http://localhost:8081/user/login', null, null, null, '2019-07-02 21:33:40');
INSERT INTO `t_logs` VALUES ('357', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 21:33:45');
INSERT INTO `t_logs` VALUES ('358', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-02 21:47:32');
INSERT INTO `t_logs` VALUES ('359', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-03 07:21:38');
INSERT INTO `t_logs` VALUES ('360', '127.0.0.1', null, '添加博客', 'http://localhost:8081/contents/insertBlog', null, null, null, '2019-07-03 07:22:00');
INSERT INTO `t_logs` VALUES ('361', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-03 07:22:02');
INSERT INTO `t_logs` VALUES ('362', '127.0.0.1', null, '根据id删除', 'http://localhost:8081/contents/deleteById', null, null, null, '2019-07-03 07:39:39');
INSERT INTO `t_logs` VALUES ('363', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-03 07:39:41');
INSERT INTO `t_logs` VALUES ('364', '127.0.0.1', null, '上传文件', 'http://localhost:8081/contents/uploadImage', null, null, null, '2019-07-03 08:14:33');
INSERT INTO `t_logs` VALUES ('365', '127.0.0.1', null, '添加博客', 'http://localhost:8081/contents/insertBlog', null, null, null, '2019-07-03 08:14:39');
INSERT INTO `t_logs` VALUES ('366', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-03 08:14:42');
INSERT INTO `t_logs` VALUES ('367', '127.0.0.1', null, '上传文件', 'http://localhost:8081/contents/uploadImage', null, null, null, '2019-07-03 08:15:56');
INSERT INTO `t_logs` VALUES ('368', '127.0.0.1', null, '添加博客', 'http://localhost:8081/contents/insertBlog', null, null, null, '2019-07-03 08:15:59');
INSERT INTO `t_logs` VALUES ('369', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-03 08:16:01');
INSERT INTO `t_logs` VALUES ('370', '127.0.0.1', null, '上传文件', 'http://localhost:8081/contents/uploadImage', null, null, null, '2019-07-03 08:16:52');
INSERT INTO `t_logs` VALUES ('371', '127.0.0.1', null, '添加博客', 'http://localhost:8081/contents/insertBlog', null, null, null, '2019-07-03 08:16:55');
INSERT INTO `t_logs` VALUES ('372', '127.0.0.1', null, '查询博客', 'http://localhost:8081/contents/getAllContents', null, null, null, '2019-07-03 08:16:57');
INSERT INTO `t_logs` VALUES ('373', '127.0.0.1', null, '根据id查询', 'http://localhost:8081/contents/getById', null, null, null, '2019-07-03 08:20:08');

-- ----------------------------
-- Table structure for t_metas
-- ----------------------------
DROP TABLE IF EXISTS `t_metas`;
CREATE TABLE `t_metas` (
  `mid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `slug` varchar(200) DEFAULT NULL,
  `type` varchar(32) NOT NULL DEFAULT '',
  `description` varchar(200) DEFAULT NULL,
  `sort` int(10) unsigned DEFAULT '0',
  `parent` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`mid`),
  KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_metas
-- ----------------------------
INSERT INTO `t_metas` VALUES ('1', 'default', null, 'category', null, '0', '0');
INSERT INTO `t_metas` VALUES ('6', 'my github', 'https://github.com/ZHENFENG13', 'link', null, '0', '0');

-- ----------------------------
-- Table structure for t_notice
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES ('1', '你好', '1', '2019-06-16 07:38:04');
INSERT INTO `t_notice` VALUES ('4', '通知：请关注简书，第一时间获取最新博客', null, '2019-06-16 11:50:47');
INSERT INTO `t_notice` VALUES ('5', 'hello 我的博客', null, '2019-07-01 22:41:13');

-- ----------------------------
-- Table structure for t_options
-- ----------------------------
DROP TABLE IF EXISTS `t_options`;
CREATE TABLE `t_options` (
  `name` varchar(32) NOT NULL DEFAULT '',
  `value` varchar(1000) DEFAULT '',
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_options
-- ----------------------------
INSERT INTO `t_options` VALUES ('site_description', '13 Blog', null);
INSERT INTO `t_options` VALUES ('site_keywords', '13 Blog', null);
INSERT INTO `t_options` VALUES ('site_record', '', '备案号');
INSERT INTO `t_options` VALUES ('site_theme', 'default', null);
INSERT INTO `t_options` VALUES ('site_title', 'My Blog', '');
INSERT INTO `t_options` VALUES ('social_github', '', null);
INSERT INTO `t_options` VALUES ('social_twitter', '', null);
INSERT INTO `t_options` VALUES ('social_weibo', '', null);
INSERT INTO `t_options` VALUES ('social_zhihu', '', null);

-- ----------------------------
-- Table structure for t_password
-- ----------------------------
DROP TABLE IF EXISTS `t_password`;
CREATE TABLE `t_password` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_password
-- ----------------------------
INSERT INTO `t_password` VALUES ('4', 'e10adc3949ba59abbe56e057f20f883e', '39');
INSERT INTO `t_password` VALUES ('6', 'e10adc3949ba59abbe56e057f20f883e', '42');

-- ----------------------------
-- Table structure for t_readermassage
-- ----------------------------
DROP TABLE IF EXISTS `t_readermassage`;
CREATE TABLE `t_readermassage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_readermassage
-- ----------------------------
INSERT INTO `t_readermassage` VALUES ('13', '姜总', '新年好', '新年快乐', 'smfx1314@126.com', '2019-06-16 14:46:03');
INSERT INTO `t_readermassage` VALUES ('14', '姜总', '新年好', '新年快乐', 'smfx1314@126.com', '2019-06-16 14:46:04');
INSERT INTO `t_readermassage` VALUES ('15', '姜总', '新年好', '新年快乐', 'smfx1314@126.com', '2019-06-16 14:46:06');
INSERT INTO `t_readermassage` VALUES ('25', 'springboot', '七行代码实现Excel导出功能', 'sss', 'sss', '2019-06-18 21:07:54');
INSERT INTO `t_readermassage` VALUES ('26', 'ss', '这款IDEA中的聊天插件方便上班摸鱼', 'ss', 'sss', '2019-06-18 21:09:49');
INSERT INTO `t_readermassage` VALUES ('27', '11', '11', '111', '1016767658@qq.com', '2019-07-02 13:54:40');

-- ----------------------------
-- Table structure for t_users
-- ----------------------------
DROP TABLE IF EXISTS `t_users`;
CREATE TABLE `t_users` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `home_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `state` int(255) DEFAULT '0',
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `logged` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`uid`) USING BTREE,
  UNIQUE KEY `name` (`username`) USING BTREE,
  UNIQUE KEY `mail` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_users
-- ----------------------------
INSERT INTO `t_users` VALUES ('39', 'smfx1314', '1016767658@qq.com', null, '0', '2019-06-16 15:37:45', '0');
INSERT INTO `t_users` VALUES ('42', '姜飞祥', '101676658@qq.com', null, '0', '2019-06-16 17:04:30', '0');
