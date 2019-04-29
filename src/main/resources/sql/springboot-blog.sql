/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80015
 Source Host           : localhost:3306
 Source Schema         : springboot-blog

 Target Server Type    : MySQL
 Target Server Version : 80015
 File Encoding         : 65001

 Date: 29/04/2019 10:50:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_attach
-- ----------------------------
DROP TABLE IF EXISTS `t_attach`;
CREATE TABLE `t_attach`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `ftype` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `fkey` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `author_id` int(10) NULL DEFAULT NULL,
  `created` int(10) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_comments
-- ----------------------------
DROP TABLE IF EXISTS `t_comments`;
CREATE TABLE `t_comments`  (
  `coid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cid` int(10) UNSIGNED NULL DEFAULT 0,
  `created` int(10) UNSIGNED NULL DEFAULT 0,
  `author` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `author_id` int(10) UNSIGNED NULL DEFAULT 0,
  `owner_id` int(10) UNSIGNED NULL DEFAULT 0,
  `mail` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `status` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'approved',
  `parent` int(10) UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`coid`) USING BTREE,
  INDEX `cid`(`cid`) USING BTREE,
  INDEX `created`(`created`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_contents
-- ----------------------------
DROP TABLE IF EXISTS `t_contents`;
CREATE TABLE `t_contents`  (
  `cid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容文字',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '描述',
  `created` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `modified` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `author_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '作者ID',
  `status` int(11) NULL DEFAULT 1 COMMENT '状态1发布，0草稿',
  `tags` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签',
  `categories` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类',
  `allow_comment` int(1) NULL DEFAULT 1 COMMENT '允许评论1允许，0不允许',
  PRIMARY KEY (`cid`) USING BTREE,
  INDEX `created`(`created`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_contents
-- ----------------------------
INSERT INTO `t_contents` VALUES (32, 'Springboot整合pagehelper分页', '一、在pom中添加依赖      <dependency>           <groupId>com.github.pagehelper</groupId>           <artifactId>pagehelper-spring-boot-starter</artifactId>           <version>1.2.2</version>       </dependency>二、使用网络上很多文章都会说需要在application.properties进行配置其实完全不需要，默认的设置就已经满足大部分需要了直接使用即可@RequestMapping(value = \"/getAllComtents\",method = RequestMethod.GET)@ResponseBodypublic CommonReturnType getAllComtents(@RequestParam(defaultValue=\"1\",required=true,value=\"pageNo\") Integer pageNo){        //每页显示记录数        Integer pageSize=4;        //分页查询        PageHelper.startPage(pageNo, pageSize);        List<ContentsImagesModel> contentsImagesModels = contentsService.getAllContents();        PageInfo<ContentsImagesModel> pageInfo=new PageInfo<>(contentsImagesModels);return CommonReturnType.success(pageInfo);PageHelper.startPage(需要显示的第几个页面，每个页面显示的数量);下一行紧跟查询语句，不可以写其他的，否则没有效果。PageHelper.startPage(pageNo, pageSize);List<ContentsImagesModel> contentsImagesModels = contentsService.getAllContents();这样只起到了分页效果，对总页面数之类的没有详细信息如果对页面数量等有需求，则需要加上下面这行 PageInfo<ContentsImagesModel> pageInfo=new PageInfo<>(contentsImagesModels);这样就满足了全部的分页要求', '最近使用SpringBoot， 由于需要数据库分页功能 这里使用pagehelp结合分页\n\n官网 https://github.com/pagehelper/Mybatis-PageHelper可以参考', '2019-04-28 15:30:37', '2019-04-28 15:30:37', 0, 1, 'springboot', 'springboot', 1);
INSERT INTO `t_contents` VALUES (33, 'ajax请求成功回调函数没有执行问题', '如下常见的ajax前端请求，请求成功后success：function(result){ 这里的数据没有执行 }： $.ajax({            type:\"post\",            url:\"http://localhost:8080/user/insertUser\",            xhrFields:{widthCredentials:true},//这里解决跨域问题需要结合后端哦            data:{                \"username\":$(\"#username\").val(),                \"password\":$(\"#password\").val()            },            success:function (result) {                if (0==result.code){                    alert(\"注册成功\");//这里没有正常弹出                    window.location.href =\"login.html\";                                   }else {                    alert(\"注册失败，请重新注册\");                }            },            error:function (result) {                alert(\"未知错误\");            }        })回调函数没有正常执行，解决办法： 添加async: false,（默认是true）;如上：false为同步，这个Ajax请求将整个浏览器锁死，只有url请求中后台的方法执行结束后，才可以执行其它操作。当async: true 时，ajax请求是异步的。但是其中有个问题：ajax请求和其后面的操作是异步执行的，那么当后台方法还未执行完，就可能已经执行了 ajax请求后面的操作。然而，data这个数据是在ajax请求success后才赋值的，结果，输出时会为空。所以导致一种回调函数没有被调用的假象。问题2在添加async: false；后success回调函数能够正常alert弹窗，但是下面的window.location.href =\"login.html\";不能正常跳转，这个时候您检查一下您绑定的点击button按钮是否是 type=\"button\"，如果是submit改成button即可。', '当async: true 时，ajax请求是异步的。但是其中有个问题：ajax请求和其后面的操作是异步执行的，那么当后台方法还未执行完，就可能已经执行了 ajax请求后面的操作。然而，data这个数据是在ajax请求success后才赋值的，结果，输出时会为空。\n所以导致一种回调函数没有被调用的假象。', '2019-04-28 15:52:50', '2019-04-28 15:52:50', 0, 1, 'ajax', 'Linux', 1);

-- ----------------------------
-- Table structure for t_images
-- ----------------------------
DROP TABLE IF EXISTS `t_images`;
CREATE TABLE `t_images`  (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `title_Url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题图片',
  `content_id` int(11) NULL DEFAULT NULL COMMENT '所属文章id',
  PRIMARY KEY (`pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_images
-- ----------------------------
INSERT INTO `t_images` VALUES (22, '39f3367c-c7ae-4ea0-ba1c-f300db2e27b9banner_01.jpg', 32);
INSERT INTO `t_images` VALUES (23, '7ad2a1d7-af9f-4954-ae65-1fe73adbd065banner_02.jpg', 33);

-- ----------------------------
-- Table structure for t_logs
-- ----------------------------
DROP TABLE IF EXISTS `t_logs`;
CREATE TABLE `t_logs`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `action` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `data` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `author_id` int(10) NULL DEFAULT NULL,
  `ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `created` int(10) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_metas
-- ----------------------------
DROP TABLE IF EXISTS `t_metas`;
CREATE TABLE `t_metas`  (
  `mid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `slug` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `description` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sort` int(10) UNSIGNED NULL DEFAULT 0,
  `parent` int(10) UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`mid`) USING BTREE,
  INDEX `slug`(`slug`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_metas
-- ----------------------------
INSERT INTO `t_metas` VALUES (1, 'default', NULL, 'category', NULL, 0, 0);
INSERT INTO `t_metas` VALUES (6, 'my github', 'https://github.com/ZHENFENG13', 'link', NULL, 0, 0);

-- ----------------------------
-- Table structure for t_options
-- ----------------------------
DROP TABLE IF EXISTS `t_options`;
CREATE TABLE `t_options`  (
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `value` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `description` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_options
-- ----------------------------
INSERT INTO `t_options` VALUES ('site_description', '13 Blog', NULL);
INSERT INTO `t_options` VALUES ('site_keywords', '13 Blog', NULL);
INSERT INTO `t_options` VALUES ('site_record', '', '备案号');
INSERT INTO `t_options` VALUES ('site_theme', 'default', NULL);
INSERT INTO `t_options` VALUES ('site_title', 'My Blog', '');
INSERT INTO `t_options` VALUES ('social_github', '', NULL);
INSERT INTO `t_options` VALUES ('social_twitter', '', NULL);
INSERT INTO `t_options` VALUES ('social_weibo', '', NULL);
INSERT INTO `t_options` VALUES ('social_zhihu', '', NULL);

-- ----------------------------
-- Table structure for t_users
-- ----------------------------
DROP TABLE IF EXISTS `t_users`;
CREATE TABLE `t_users`  (
  `uid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `home_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `state` int(255) NULL DEFAULT 0,
  `created` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `logged` int(10) UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`uid`) USING BTREE,
  UNIQUE INDEX `name`(`username`) USING BTREE,
  UNIQUE INDEX `mail`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_users
-- ----------------------------
INSERT INTO `t_users` VALUES (2, '姜飞祥', '81dc9bdb52d04dc20036dbd8313ed055', '1016767658@qq.com', NULL, 0, '2019-04-24 13:29:21', 0);
INSERT INTO `t_users` VALUES (27, '李世民', '81dc9bdb52d04dc20036dbd8313ed055', '666@qq.com', NULL, 0, '2019-04-26 20:57:16', 0);

SET FOREIGN_KEY_CHECKS = 1;
