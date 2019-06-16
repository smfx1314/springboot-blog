/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 80015
Source Host           : localhost:3306
Source Database       : springboot-blog

Target Server Type    : MYSQL
Target Server Version : 80015
File Encoding         : 65001

Date: 2019-06-16 15:49:17
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
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_blogs
-- ----------------------------
INSERT INTO `t_blogs` VALUES ('91', '关于pageHelper无法查到总数踩到的坑', '问题代码\n\n```\nPageHelper.startPage(pageNum,pageSize);\nList<pojoVo> pojoVo=robotService.getPageList();\nPageInfo pageResult = new PageInfo(pojoVo);\n```\n 结果\n\n```\npageResult.getTotal(); //结果为当前页数量或者没有\npageResult.getPage(); //结果为1\n```\n\n 经过微信小伙伴ken提示;发现是VO拼接姿势不对\n\n> pageHelper是多线程操作,通过new PageInfo()查询出总条数和总页数;当为new PageInfo(pojoVo)时,是按照pojoVo去查询,所以无法查pojo到数据库中数据的总数的;需要先查出pojoList,然后拼接到Vo里面,在set到pageInfo中\n\n修改后的代码如下\n\n```\npublic CommonReturnType getList(Model model,@RequestParam(value = \"pageNum\",defaultValue = \"1\")Integer pageNum,\n                        @RequestParam(value = \"pageSize\",defaultValue = \"5\")Integer pageSize){\nPageHelper.startPage(pageNum,pageSize);\nList<Pojo> pojoList=pojoService.getPageList();\nPageInfo pageResult = new PageInfo(pojoList);\n\nList<PojoVo> voList=new ArrayList<>();\nfor(Pojo item:pojoList){\n    PojoVo pojoVo=assembleRobotListVo(item);\n    voList.add(pojoVo);\n}\n//这一步记得添加\npageResult.setList(voList);\n\nSystem.out.println(pageResult.getTotal()); //此处已经查询出总条数\nSystem.out.println(pageResult.getPages());\nSystem.out.println(pageResult.getSize());\nreturn CommonReturnType.success(pageResult );\n}\n```\n//拼接vo\n```\nprivate PojoVo assembleRobotListVo(Pojo pojo){\n    PojoVo pojoVo=new PojoVo ();\n    pojoVo.setId(pojo.getId());\n    pojoVo.setMac(pojo.getMac());\n    pojoVo.setName(pojo.getName());\n    return pojoVo;\n}\n```\n \n备注: pojo为实体类  pojoVo为拼接的Vo显示字段', '嵌套查询，到时分页出现问题', '2019-06-16 14:56:21', '2019-06-16 14:56:21', '0', '1', 'pagehelp', '0', '0', '1');

-- ----------------------------
-- Table structure for t_images
-- ----------------------------
DROP TABLE IF EXISTS `t_images`;
CREATE TABLE `t_images` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `title_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '标题图片',
  `blog_id` int(11) DEFAULT NULL COMMENT '所属文章id',
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_images
-- ----------------------------
INSERT INTO `t_images` VALUES ('71', '18d68005-9834-4140-870c-d9c459640517backtop.png', '91');

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
) ENGINE=InnoDB AUTO_INCREMENT=172 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES ('1', '你好', '1', '2019-06-16 07:38:04');
INSERT INTO `t_notice` VALUES ('4', '通知：请关注简书，第一时间获取最新博客', null, '2019-06-16 11:50:47');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_password
-- ----------------------------
INSERT INTO `t_password` VALUES ('4', 'e10adc3949ba59abbe56e057f20f883e', '39');

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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_readermassage
-- ----------------------------
INSERT INTO `t_readermassage` VALUES ('13', '姜总', '新年好', '新年快乐', 'smfx1314@126.com', '2019-06-16 14:46:03');
INSERT INTO `t_readermassage` VALUES ('14', '姜总', '新年好', '新年快乐', 'smfx1314@126.com', '2019-06-16 14:46:04');
INSERT INTO `t_readermassage` VALUES ('15', '姜总', '新年好', '新年快乐', 'smfx1314@126.com', '2019-06-16 14:46:06');
INSERT INTO `t_readermassage` VALUES ('16', '姜总', '新年好', '新年快乐', 'smfx1314@126.com', '2019-06-16 14:46:03');
INSERT INTO `t_readermassage` VALUES ('17', '姜总', '新年好', '新年快乐', 'smfx1314@126.com', '2019-06-16 14:46:04');
INSERT INTO `t_readermassage` VALUES ('18', '姜总', '新年好', '新年快乐', 'smfx1314@126.com', '2019-06-16 14:46:04');
INSERT INTO `t_readermassage` VALUES ('19', '姜总', '新年好', '新年快乐', 'smfx1314@126.com', '2019-06-16 14:46:14');
INSERT INTO `t_readermassage` VALUES ('20', '姜总', '新年好', '新年快乐', 'smfx1314@126.com', '2019-06-16 14:46:14');
INSERT INTO `t_readermassage` VALUES ('21', '姜总', '新年好', '新年快乐', 'smfx1314@126.com', '2019-06-16 14:46:14');
INSERT INTO `t_readermassage` VALUES ('22', '姜总', '新年好', '新年快乐', 'smfx1314@126.com', '2019-06-16 14:46:14');
INSERT INTO `t_readermassage` VALUES ('23', '姜总', '新年好', '新年快乐', 'smfx1314@126.com', '2019-06-16 14:46:15');
INSERT INTO `t_readermassage` VALUES ('24', '姜总', '新年好', '新年快乐', 'smfx1314@126.com', '2019-06-16 14:46:15');

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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_users
-- ----------------------------
INSERT INTO `t_users` VALUES ('39', 'smfx1314', '1016767658@qq.com', null, '0', '2019-06-16 15:37:45', '0');
