/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 80015
Source Host           : localhost:3306
Source Database       : springboot-blog

Target Server Type    : MYSQL
Target Server Version : 80015
File Encoding         : 65001

Date: 2019-05-09 17:35:53
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
  `cid` int(10) unsigned NOT NULL AUTO_INCREMENT,
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
  `title_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '图片地址',
  `allow_comment` int(1) DEFAULT '1' COMMENT '允许评论1允许，0不允许',
  PRIMARY KEY (`cid`) USING BTREE,
  KEY `created` (`created`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_blogs
-- ----------------------------
INSERT INTO `t_blogs` VALUES ('65', 'ajax请求成功回调函数没有执行问题', '如下常见的ajax前端请求，请求成功后success：function(result){ 这里的数据没有执行 }：\n```\n $.ajax({\n	        type:\"post\",\n	        url:\"http://localhost:8080/user/insertUser\",\n	        xhrFields:{widthCredentials:true},//这里解决跨域问题需要结合后端哦\n	        data:{\n	        	\"username\":$(\"#username\").val(),\n	        	\"password\":$(\"#password\").val()\n	        },\n	        success:function (result) {\n	            if (0==result.code){\n	                alert(\"注册成功\");//这里没有正常弹出\n	                window.location.href =\"login.html\";\n	               \n	            }else {\n	                alert(\"注册失败，请重新注册\");\n	            }\n	        },\n	        error:function (result) {\n	            alert(\"未知错误\");\n	        }\n	    })\n```\n回调函数没有正常执行，解决办法： 添加async: false,（默认是true）;\n如上：false为同步，这个Ajax请求将整个浏览器锁死，\n只有url请求中后台的方法执行结束后，才可以执行其它操作。\n\n当async: true 时，ajax请求是异步的。但是其中有个问题：ajax请求和其后面的操作是异步执行的，那么当后台方法还未执行完，就可能已经执行了 ajax请求后面的操作。然而，data这个数据是在ajax请求success后才赋值的，结果，输出时会为空。\n所以导致一种回调函数没有被调用的假象。\n#### 问题2\n在添加async: false；后success回调函数能够正常alert弹窗，但是下面的window.location.href =\"login.html\";不能正常跳转，这个时候您检查一下您绑定的点击button按钮是否是 type=\"button\"，如果是submit改成button即可。', '当async: true 时，ajax请求是异步的。但是其中有个问题：ajax请求和其后面的操作是异步执行的，那么当后台方法还未执行完，就可能已经执行了 ajax请求后面的操作。然而，data这个数据是在ajax请求success后才赋值的，结果，输出时会为空。\n所以导致一种回调函数没有被调用的假象。', '2019-05-08 20:10:07', '2019-05-08 20:10:07', '0', '1', 'ajax', '0', '0', '17bdbcdb-6794-454e-9f5e-66e9fb02f52bbacktop.png', '1');
INSERT INTO `t_blogs` VALUES ('66', '给你自己的博客加个 Markdown', '今天给大家推荐一个简单易用的开源 Markdown 组件,  Markdown 组件仓库地址是:\n\n```\nhttps://github.com/pandao/editor.md\n```\n\n### Markdown 是什么\n\nMarkdown 是一个简单的电子邮件风格的标记语言, 甚至比世界上最好的两门语言 Python 还要简单.\n\n使用 Markdown 码字有以下优点:\n\n*   纯文本，所以兼容性极强，可以用所有文本编辑器打开。\n*   让你专注于文字而不是排版。\n*   格式转换方便，Markdown 的文本你可以轻松转换为 html、电子书等。\n*   Markdown 的标记语法有极好的可读性。\n\n### 谁在用\n\n Github 上项目的 README 都是用 Markdown 写的, 文件后缀是`.md`, 网易云笔记, 简书也都支持 Markdown 语法.\n\n很多人使用微信排版也是用 Markdown 写完直接交给转换插件转化为 HTML 后复制过去一键搞定.\n\n#### 引入编辑器\n\n使用方法很简单, 直接把仓库克隆下来, 然后在你的网页中贴上下面的代码:\n(在 Django 或其他Web 框架中, 更推荐使用类似 Jinja 的非硬编码引入格式而非下述的绝对地址)\n\n```\n<link rel=\"stylesheet\" href=\"css/editormd.min.css\" />\n<div id=\"editormd\">\n    <textarea style=\"display:none;\">### Hello Editor.md !</textarea>\n</div>\n\n```\n\n并添加 JavaScript 代码启用(同样推荐软编码来引入文件), 可以对编辑器的大小等进行设置, 具体参考文档:\n\n```\n<script src=\"jquery.min.js\"></script>\n<script src=\"editormd.min.js\"></script>\n<script type=\"text/javascript\">\n	$(function(){\n    /**\n     * markdown实例化\n     * @type {[type]}\n     */\n    var editor = editormd(\"editormd\", {\n      height : 500,\n      path : \"./lib/\", // Autoload modules mode, codemirror, marked... dependents libs path\n      saveHTMLToTextarea : true,\n  	  previewTheme : \"dark\",       //下面这一行将使用dark主题\n      watch : true,                // 开启实时预览\n      tex: true,                   // 开启科学公式TeX语言支持，默认关闭\n      flowChart: true,             // 开启流程图支持，默认关闭\n      sequenceDiagram: true       // 开启时序/序列图支持，默认关闭,\n    });\n</script>\n\n```\n\n引入之后大概是这个样子:\n\n![image](https://upload-images.jianshu.io/upload_images/5530017-6164e37bb5decc58.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/976/format/webp)\n\n#### Markdown 转化为 HTML\n\n如果是想把文章呈现在网页而不是编辑, 那么引入下面的代码即可:\n\n```\n<!-- Markdown -->\n<link rel=\"stylesheet\" href=\"css/editormd.min.css\" />\n <link rel=\"stylesheet\" href=\"css/editormd.preview.css\" />\n<div id=\"test-editormd-view2\">\n    <textarea id=\"blog_content\"></textarea>          \n</div>\n```\n然后是对应js\n```\n<script type=\"text/javascript\">\n        $(function() {\n       /**\n       * 解析Markdown\n       * @type {String}\n       */\n      var testEditormdView2 = editormd.markdownToHTML(\"test-editormd-view2\", {\n            markdown        : contentsDo.content,// 这里是要显示的字段内容,\n            htmlDecode      : \"style,script,iframe\",  // you can filter tags decode\n            tocm            : true,    // Using [TOCM]\n            emoji           : true,\n            taskList        : true,\n            tex             : true,  // 默认不解析\n            flowChart       : true,  // 默认不解析\n            sequenceDiagram : true,  // 默认不解析\n        });\n        });\n</script>\n\n```\n\n需要注意的是我们在<textarea>标签中的内容不能留有空格, 否则可能会出现与预想内容不符合的情况. \n![image](https://upload-images.jianshu.io/upload_images/5530017-62cc8a3c9a8331bc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/956/format/webp)', 'Markdown 是一个简单的电子邮件风格的标记语言, 甚至比世界上最好的两门语言 Python 还要简单', '2019-05-08 11:00:14', '2019-05-08 11:00:14', '0', '1', 'markdown', '0', '0', '4a9e6fa1-49a6-4e09-ab66-41fb9e4ad995', '1');
INSERT INTO `t_blogs` VALUES ('67', 'redis入门', '##### **下载**\n\n首先我们要到GitHub（https://github.com/MicrosoftArchive/redis/releases）上下载[Source code (tar.gz)](https://github.com/MicrosoftArchive/redis/archive/win-3.2.100.tar.gz)\n\n上传到Linux上，我的位置在/usr/local/darren下。这里我使用的是rz命令进行上传\n\n也可以通过命令wget [ ](https://github.com/MicrosoftArchive/redis/archive/win-3.2.100.tar.gz%E8%BF%9B%E8%A1%8C%E5%9C%A8%E7%BA%BF%E4%B8%8B%E8%BD%BD%E3%80%82)https://github.com/MicrosoftArchive/redis/archive/win-3.2.100.tar.gz进行在线下载\n\n![image](http://upload-images.jianshu.io/upload_images/8504906-b610f65122251be6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240) \n\n查看\n\n ![image](http://upload-images.jianshu.io/upload_images/8504906-326b878764e9d584.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\n##### **解压**\n\n解压：通过命令 tar -xzvf redis文件名\n\n ![image](http://upload-images.jianshu.io/upload_images/8504906-141d96f78509cc81.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\n查看\n\n ![image](http://upload-images.jianshu.io/upload_images/8504906-fe1110f08fb5a3ed.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\n重命名\n\n ![image](http://upload-images.jianshu.io/upload_images/8504906-960982d642fc7c5f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\n查看\n\n ![image](http://upload-images.jianshu.io/upload_images/8504906-f3ae787ff813a07e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\n编译\n\n进入解压后的redis文件目录下，通过命令make进行编译。\n\n>如果编译失败，错误提示一般有两种。第一种是gcc命令没有找到，是由于没有安装gcc导致的，你可以通过yum -y install gcc进行安装。第二种错误是error:jemalloc/jemalloc.h.No.such file or directory.这种错误你只需要make MALLOC=libc即可.\n\n**注意**：make编译失败之后，如果在make先执行make distclean清理一下上次make后产生的文件。\n\n另外：\n\n有人在make执行之后再执行make install,该操作是将src下的执行文件复制到/usr/local/bin目录下，方便在任意目录下执行redis命令，此操作可以不用执行。如果不执行的话，需要在redis目录下的src目录下通过./xx来执行redis命令。\n\n### 启动 Redis\n\n**进入Redis安装目录，之后输入src/redis-server**\n\n ![image](http://upload-images.jianshu.io/upload_images/8504906-4f240f687e3f0eaf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\n注意：这种启动属于前台启动，当关闭窗口时就直接终端服务。我们可以在启动的时候加一个“&”号，如：redis-server &，这是后台启动，当关闭窗口时会在后台进行运行。\n\n 这时我们可以查看进程ps -ef | grep redis，发现还在后台运行中。\n\n后台启动并输出日志到nohup.out文件：**nohub /usr/local/redis /redis-server &**\n\n**关闭**\n\n**redis-cli shutdown**\n\n**或者使用暴力模式 kill pid /kill -9 pid**\n\n**客户端** \n\n通过命令 src/redis-cli来启动客户端。  \n\n也可以通过命令redis-clli -h ip地址 -p 6379来连接远程redis.\n\n注意：如果一台服务器上有多个redis，可以通过指定端口号来确定启动哪一个。\n\n ![image](http://upload-images.jianshu.io/upload_images/8504906-1e40328b1b3b847f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)\n\n127.0.0.1 是本机 IP ，6379 是 redis 服务端口。现在我们输入 PING 命令。\n\nredis 127.0.0.1:6379> ping\n\nPONG\n\n##### **Redis 配置**\n\nRedis 的配置文件位于 Redis 安装目录下，文件名为 redis.conf。\n\n#### **参数说明**\n\nredis.conf 配置项说明如下：\n\n1\\. Redis默认不是以守护进程的方式运行，可以通过该配置项修改，使用yes启用守护进程\n\n    **daemonize no**\n\n2. 当Redis以守护进程方式运行时，Redis默认会把pid写入/var/run/redis.pid文件，可以通过pidfile指定\n\n    **pidfile /var/run/redis.pid**\n\n**2.1.将 requirepass 注释打开，并设置密码为 123456（密码自己设置）。**\n\n**requirepass 123456**\n\n**由于我们设置了密码，在启动客户端之后，输入 auth 123456 即可登录进入客户端。**\n\n3. 指定Redis监听端口，默认端口为6379，作者在自己的一篇博文中解释了为什么选用6379作为默认端口，因为6379在手机按键上MERZ对应的号码，而MERZ取自意大利歌女Alessia Merz的名字\n\n    **port 6379**\n\n4. 绑定的主机地址,将 bind 配置成 0.0.0.0，允许任意服务器访问 Redis\n\n    **bind 127.0.0.1**\n\n5.当客户端闲置多长时间后关闭连接，如果指定为0，表示关闭该功能\n\n    **timeout 300**\n\n6. 指定日志记录级别，Redis总共支持四个级别：debug、verbose、notice、warning，默认为verbose\n\n    **loglevel verbose**\n\n7. 日志记录方式，默认为标准输出，如果配置Redis为守护进程方式运行，而这里又配置为日志记录方式为标准输出，则日志将会发送给/dev/null\n\n    **logfile stdout**\n\n8. 设置数据库的数量，默认数据库为0，可以使用SELECT <dbid>命令在连接上指定数据库id\n\n    **databases 16**\n\n9. 指定在多长时间内，有多少次更新操作，就将数据同步到数据文件，可以多个条件配合\n\n    **save <seconds> <changes>**\n\n    Redis默认配置文件中提供了三个条件：\n\n    **save 900 1**\n\n**save 300 10**\n\n**save 60 10000**\n\n    分别表示900秒（15分钟）内有1个更改，300秒（5分钟）内有10个更改以及60秒内有10000个更改。\n\n10. 指定存储至本地数据库时是否压缩数据，默认为yes，Redis采用LZF压缩，如果为了节省CPU时间，可以关闭该选项，但会导致数据库文件变的巨大\n\n    **rdbcompression yes**\n\n11. 指定本地数据库文件名，默认值为dump.rdb\n\n    **dbfilename dump.rdb**\n\n12. 指定本地数据库存放目录\n\n    **dir ./**\n\n13. 设置当本机为slav服务时，设置master服务的IP地址及端口，在Redis启动时，它会自动从master进行数据同步\n\n    **slaveof <masterip> <masterport>**\n\n14. 当master服务设置了密码保护时，slav服务连接master的密码\n\n    **masterauth <master-password>**\n\n15. 设置Redis连接密码，如果配置了连接密码，客户端在连接Redis时需要通过AUTH <password>命令提供密码，默认关闭\n\n    **requirepass foobared**\n\n16. 设置同一时间最大客户端连接数，默认无限制，Redis可以同时打开的客户端连接数为Redis进程可以打开的最大文件描述符数，如果设置 maxclients 0，表示不作限制。当客户端连接数到达限制时，Redis会关闭新的连接并向客户端返回max number of clients reached错误信息\n\n    **maxclients 128**\n\n17. 指定Redis最大内存限制，Redis在启动时会把数据加载到内存中，达到最大内存后，Redis会先尝试清除已到期或即将到期的Key，当此方法处理 后，仍然到达最大内存设置，将无法再进行写入操作，但仍然可以进行读取操作。Redis新的vm机制，会把Key存放内存，Value会存放在swap区\n\n    **maxmemory <bytes>**\n\n18. 指定是否在每次更新操作后进行日志记录，Redis在默认情况下是异步的把数据写入磁盘，如果不开启，可能会在断电时导致一段时间内的数据丢失。因为 redis本身同步数据文件是按上面save条件来同步的，所以有的数据会在一段时间内只存在于内存中。默认为no\n\n    **appendonly no**\n\n19. 指定更新日志文件名，默认为appendonly.aof\n\n     **appendfilename appendonly.aof**\n\n20. 指定更新日志条件，共有3个可选值： \n    **no**：表示等操作系统进行数据缓存同步到磁盘（快） \n    **always**：表示每次更新操作后手动调用fsync()将数据写到磁盘（慢，安全） \n    **everysec**：表示每秒同步一次（折衷，默认值）\n\n    **appendfsync everysec**\n\n21. 指定是否启用虚拟内存机制，默认值为no，简单的介绍一下，VM机制将数据分页存放，由Redis将访问量较少的页即冷数据swap到磁盘上，访问多的页面由磁盘自动换出到内存中（在后面的文章我会仔细分析Redis的VM机制）\n\n     **vm-enabled no**\n\n22. 虚拟内存文件路径，默认值为/tmp/redis.swap，不可多个Redis实例共享\n\n     **vm-swap-file /tmp/redis.swap**\n\n23. 将所有大于vm-max-memory的数据存入虚拟内存,无论vm-max-memory设置多小,所有索引数据都是内存存储的(Redis的索引数据 就是keys),也就是说,当vm-max-memory设置为0的时候,其实是所有value都存在于磁盘。默认值为0\n\n     **vm-max-memory 0**\n\n24\\. Redis swap文件分成了很多的page，一个对象可以保存在多个page上面，但一个page上不能被多个对象共享，vm-page-size是要根据存储的 数据大小来设定的，作者建议如果存储很多小对象，page大小最好设置为32或者64bytes；如果存储很大大对象，则可以使用更大的page，如果不 确定，就使用默认值\n\n     **vm-page-size 32**\n\n25. 设置swap文件中的page数量，由于页表（一种表示页面空闲或使用的bitmap）是在放在内存中的，，在磁盘上每8个pages将消耗1byte的内存。\n\n     **vm-pages 134217728**\n\n26. 设置访问swap文件的线程数,最好不要超过机器的核数,如果设置为0,那么所有对swap文件的操作都是串行的，可能会造成比较长时间的延迟。默认值为4\n\n     **vm-max-threads 4**\n\n27. 设置在向客户端应答时，是否把较小的包合并为一个包发送，默认为开启\n\n    **glueoutputbuf yes**\n\n28. 指定在超过一定的数量或者最大的元素超过某一临界值时，采用一种特殊的哈希算法\n\n    **hash-max-zipmap-entries 64**\n\n**hash-max-zipmap-value 512**\n\n29. 指定是否激活重置哈希，默认为开启（后面在介绍Redis的哈希算法时具体介绍）\n\n    **activerehashing yes**\n\n30. 指定包含其它的配置文件，可以在同一主机上多个Redis实例之间使用同一份配置文件，而同时各个实例又拥有自己的特定配置文件\n\n**include /path/to/local.conf**\n\n### 桌面客户端连接\n\n首先需要在redis-conf中设置这几点，不然连接不上：\n\n第一：将绑定的ip地址端口号给注释\n\n第二：protect-mode为yes，改为no\n\n第三：Linux上的redis如果你不指定配置文件去启动，那么你做的修改就没有用，会读取默认配置.所以启动时指定配置文件。如：src/redis-server ./redis.conf\n\n这样客户端就可以成功连接了。', 'Redis是一个开源的使用ANSIC语言编写、支持网络、可基于内存亦可持久化的日志型、Key-Value数据库，并提供多种语言的API。', '2019-05-08 11:03:21', '2019-05-08 11:03:20', '0', '1', 'redis', '0', '0', '0b34b5ca-b1c6-4946-9f38-85bb0b170ac1loading.gif', '1');
INSERT INTO `t_blogs` VALUES ('68', 'Springboot整合pagehelper分页', '#### 一、在pom中添加依赖\n ```\n       <dependency>\n            <groupId>com.github.pagehelper</groupId>\n            <artifactId>pagehelper-spring-boot-starter</artifactId>\n            <version>1.2.2</version>\n        </dependency>\n```\n\n#### 二、使用\n>网络上很多文章都会说需要在application.properties进行配置\n其实完全不需要，默认的设置就已经满足大部分需要了直接使用即可\n\n```\n@RequestMapping(value = \"/getAllComtents\",method = RequestMethod.GET)\n@ResponseBody\npublic CommonReturnType getAllComtents(@RequestParam(defaultValue=\"1\",required=true,value=\"pageNo\") Integer pageNo){\n        //每页显示记录数\n        Integer pageSize=4;\n        //分页查询\n        PageHelper.startPage(pageNo, pageSize);\n        List<ContentsImagesModel> contentsImagesModels = contentsService.getAllContents();\n        PageInfo<ContentsImagesModel> pageInfo=new PageInfo<>(contentsImagesModels);\n\nreturn CommonReturnType.success(pageInfo);\n```\n \n\nPageHelper.startPage(需要显示的第几个页面，每个页面显示的数量);\n\n下一行紧跟查询语句，不可以写其他的，否则没有效果。\n```\nPageHelper.startPage(pageNo, pageSize);\nList<ContentsImagesModel> contentsImagesModels = contentsService.getAllContents();\n``` \n\n这样只起到了分页效果，对总页面数之类的没有详细信息\n\n\n\n如果对页面数量等有需求，则需要加上下面这行\n\n```\n PageInfo<ContentsImagesModel> pageInfo=new PageInfo<>(contentsImagesModels);\n```\n这样就满足了全部的分页要求\n![分页](https://upload-images.jianshu.io/upload_images/8504906-74353618b85b6cfd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)', 'Help:Page history From Wikipedia, the free encyclopedia   （Redirected from Wikipedia:Page history ） Jump to navigation Jump to search If you are looking for help finding ...', '2019-05-08 11:04:49', '2019-05-08 11:04:49', '0', '1', 'springboot', '0', '0', '7643bc8e-aaa8-4b83-b526-21fbfcc46fdbbrowser.jpg', '1');

-- ----------------------------
-- Table structure for t_comments
-- ----------------------------
DROP TABLE IF EXISTS `t_comments`;
CREATE TABLE `t_comments` (
  `coid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cid` int(10) unsigned DEFAULT '0',
  `created` int(10) unsigned DEFAULT '0',
  `author` varchar(200) DEFAULT NULL,
  `author_id` int(10) unsigned DEFAULT '0',
  `owner_id` int(10) unsigned DEFAULT '0',
  `mail` varchar(200) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `ip` varchar(64) DEFAULT NULL,
  `content` text,
  `status` varchar(16) DEFAULT 'approved',
  `parent` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`coid`),
  KEY `cid` (`cid`),
  KEY `created` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_comments
-- ----------------------------

-- ----------------------------
-- Table structure for t_contents
-- ----------------------------
DROP TABLE IF EXISTS `t_contents`;
CREATE TABLE `t_contents` (
  `cid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '内容文字',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '描述',
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `author_id` int(10) unsigned DEFAULT '0' COMMENT '作者ID',
  `status` int(11) DEFAULT '1' COMMENT '状态1发布，0草稿',
  `tags` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '标签',
  `categories` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '分类',
  `allow_comment` int(1) DEFAULT '1' COMMENT '允许评论1允许，0不允许',
  PRIMARY KEY (`cid`) USING BTREE,
  KEY `created` (`created`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_contents
-- ----------------------------

-- ----------------------------
-- Table structure for t_images
-- ----------------------------
DROP TABLE IF EXISTS `t_images`;
CREATE TABLE `t_images` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `title_Url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '标题图片',
  `content_id` int(11) DEFAULT NULL COMMENT '所属文章id',
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_images
-- ----------------------------
INSERT INTO `t_images` VALUES ('50', 'aefe8b93-8fef-4330-b092-89f6f0d7aba6backtop.png', '60');
INSERT INTO `t_images` VALUES ('51', null, '61');
INSERT INTO `t_images` VALUES ('52', null, '62');
INSERT INTO `t_images` VALUES ('53', null, '63');
INSERT INTO `t_images` VALUES ('54', null, '64');

-- ----------------------------
-- Table structure for t_logs
-- ----------------------------
DROP TABLE IF EXISTS `t_logs`;
CREATE TABLE `t_logs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `action` varchar(100) DEFAULT NULL,
  `data` varchar(2000) DEFAULT NULL,
  `author_id` int(10) DEFAULT NULL,
  `ip` varchar(20) DEFAULT NULL,
  `created` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_logs
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_readermassage
-- ----------------------------
INSERT INTO `t_readermassage` VALUES ('4', '姜', 'pagehelp问题', '少时诵诗书', '1016767658@qq.com', '2019-05-09 16:17:38');
INSERT INTO `t_readermassage` VALUES ('5', '姜', 'pagehelp问题', '少时诵诗书', '1016767658@qq.com', '2019-05-09 16:23:15');
INSERT INTO `t_readermassage` VALUES ('6', 'q', 'q', 'q', 'q', '2019-05-09 16:23:22');
INSERT INTO `t_readermassage` VALUES ('7', 'jiang', 's', 's', '100@', '2019-05-09 17:24:18');
INSERT INTO `t_readermassage` VALUES ('8', '姜一窝', '关于分页问题', 'pagehelp 分页出现问题', '1016767658@qq.com', '2019-05-09 17:28:01');
INSERT INTO `t_readermassage` VALUES ('9', '姜一窝', '关于分页问题', 'pagehelp 分页出现问题', '1016767658@qq.com', '2019-05-09 17:28:05');
INSERT INTO `t_readermassage` VALUES ('10', '王', 'mybatis-plus使用', '一个非常好用的开源框架', '1016767658@qq.com', '2019-05-09 17:30:44');

-- ----------------------------
-- Table structure for t_users
-- ----------------------------
DROP TABLE IF EXISTS `t_users`;
CREATE TABLE `t_users` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `home_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `state` int(255) DEFAULT '0',
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `logged` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`uid`) USING BTREE,
  UNIQUE KEY `name` (`username`) USING BTREE,
  UNIQUE KEY `mail` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_users
-- ----------------------------
INSERT INTO `t_users` VALUES ('2', '姜飞祥', '81dc9bdb52d04dc20036dbd8313ed055', '1016767658@qq.com', null, '0', '2019-04-24 13:29:21', '0');
INSERT INTO `t_users` VALUES ('29', 'jia', '03c7c0ace395d80182db07ae2c30f034', 's@', null, '0', '2019-05-09 16:56:43', '0');
