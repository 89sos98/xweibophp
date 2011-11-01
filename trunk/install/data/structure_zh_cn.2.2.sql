/*Table structure for table `xwb_account_proxy` */

DROP TABLE IF EXISTS `xwb_account_proxy`;

CREATE TABLE `xwb_account_proxy` (
  `id` int(11) NOT NULL auto_increment,
  `sina_uid` varchar(16) default NULL,
  `screen_name` varchar(45) default NULL,
  `token` varchar(45) default NULL,
  `secret` varchar(45) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `sina_uid` (`sina_uid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_account_proxy` */

LOCK TABLES `xwb_account_proxy` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_ad` */

DROP TABLE IF EXISTS `xwb_ad`;

CREATE TABLE `xwb_ad` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `content` text COMMENT '广告内容',
  `using` varchar(1) default '1' COMMENT '是否应用',
  `add_time` int(10) unsigned default NULL COMMENT '添加时间',
  `name` varchar(45) default NULL COMMENT '广告位名称',
  `description` text COMMENT '广告位描述',
  `page` varchar(45) default NULL COMMENT '页面Action',
  `flag` varchar(45) default NULL,
  `config` text COMMENT '广告配置',
  `width` int(11) default '0' COMMENT '广告容器宽度',
  `height` int(11) default '0' COMMENT '广告容器高度',
  `remarks` text COMMENT '广告使用方法描述',
  PRIMARY KEY  (`id`),
  KEY `index_using` (`using`,`page`,`flag`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='广告';

/*Data for the table `xwb_ad` */

LOCK TABLES `xwb_ad` WRITE;

insert  into `xwb_ad`(`id`,`content`,`using`,`add_time`,`name`,`description`,`page`,`flag`,`config`,`width`,`height`,`remarks`) values (1,'','1',1313994963,'页尾广告','全站','global','global_footer','',0,0,'建议大小，两栏800px *70px，三栏为960px*70px');
insert  into `xwb_ad`(`id`,`content`,`using`,`add_time`,`name`,`description`,`page`,`flag`,`config`,`width`,`height`,`remarks`) values (2,'','0',1313994969,'页头广告','全站','global','global_header','',0,0,'建议大小，两栏570px *70px，三栏为720px*70px');
insert  into `xwb_ad`(`id`,`content`,`using`,`add_time`,`name`,`description`,`page`,`flag`,`config`,`width`,`height`,`remarks`) values (3,'','0',1313994973,'右侧banner','全站','global','sidebar','',0,0,'建议大小，180px*任意高度');

UNLOCK TABLES;

/*Table structure for table `xwb_admin` */

DROP TABLE IF EXISTS `xwb_admin`;

CREATE TABLE `xwb_admin` (
  `id` int(11) NOT NULL auto_increment,
  `sina_uid` bigint(20) unsigned NOT NULL COMMENT '新浪用户ID',
  `pwd` varchar(32) default NULL,
  `add_time` int(10) unsigned default NULL COMMENT '加入的时间',
  `is_root` tinyint(1) NOT NULL default '0' COMMENT '是否拥有帐号管理权限 1.拥有 0.不拥有',
  `group_id` int(11) default NULL COMMENT '用户所属组',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `xwb_admin` */

LOCK TABLES `xwb_admin` WRITE;
UNLOCK TABLES;

/*Table structure for table `xwb_admin_group` */

DROP TABLE IF EXISTS `xwb_admin_group`;

CREATE TABLE `xwb_admin_group` (
  `gid` int(11) NOT NULL,
  `group_name` varchar(45) default NULL COMMENT '组名',
  `permissions` text COMMENT '权限',
  `description` varchar(45) default NULL,
  PRIMARY KEY  (`gid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xwb_admin_group` */

LOCK TABLES `xwb_admin_group` WRITE;

insert  into `xwb_admin_group`(`gid`,`group_name`,`permissions`,`description`) values (1,'超级管理员','^mgr/','');
insert  into `xwb_admin_group`(`gid`,`group_name`,`permissions`,`description`) values (2,'管理员','^((?!mgr/setting\\.|mgr/connection|mgr/admin\\.del|mgr/admin\\.userlist|mgr/admin.add|mgr/admin.search|mgr/backup\\.).)*$','');
insert  into `xwb_admin_group`(`gid`,`group_name`,`permissions`,`description`) values (3,'运营维护','mgr/admin\\.login,mgr/admin\\.logout,mgr/admin\\.index,mgr/admin\\.map,mgr/admin\\.default_page,mgr/admin\\.repassword,mgr/weibo/disableComment,mgr/weibo/disableWeibo,mgr/weibo/keyword,mgr/weibo/weiboCopy,mgr/users\\.,mgr/user_verify\\.,mgr/celeb_mgr\\.,mgr/user_recommend\\.','');

UNLOCK TABLES;
/*Table structure for table `xwb_celeb` */

DROP TABLE IF EXISTS `xwb_celeb`;

CREATE TABLE `xwb_celeb` (
  `c_id1` int(11) default NULL COMMENT '一级分类ID',
  `c_id2` int(11) default NULL COMMENT '二级分类ID',
  `char_index` tinyint(2) default NULL COMMENT '字母索引 1-26对应A-Z, 0为其它',
  `sina_uid` bigint(20) default NULL COMMENT 'sina用户ID',
  `nick` varchar(100) default NULL COMMENT 'sina用户昵称',
  `face` varchar(200) NOT NULL COMMENT '头像地址',
  `verified` tinyint(1) NOT NULL default '0' COMMENT '是否为官方认证用户 0.不是 1.是',
  `sort` int(11) default NULL COMMENT '排序值，小的在前',
  `add_time` int(11) default NULL COMMENT '添加时间',
  `id` int(11) unsigned NOT NULL auto_increment,
  PRIMARY KEY  (`id`),
  KEY `c_id1` (`c_id1`,`c_id2`,`sort`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='名人堂推荐用户表';

/*Data for the table `xwb_celeb` */

LOCK TABLES `xwb_celeb` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_celeb_category` */

DROP TABLE IF EXISTS `xwb_celeb_category`;

CREATE TABLE `xwb_celeb_category` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `parent_id` int(11) default NULL COMMENT '父ID,如果是0，则为一级分类',
  `name` varchar(50) default NULL COMMENT '分类名称',
  `sort` int(11) default NULL COMMENT '排序，数字小的在前',
  `add_time` int(11) default NULL COMMENT '增加时间',
  `status` tinyint(3) unsigned NOT NULL default '1' COMMENT '1:启用',
  `recommended` tinyint(3) unsigned NOT NULL default '1' COMMENT '1:推荐',
  `color` varchar(45) default NULL COMMENT '二级导航的显示颜色',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='名人堂用户分类';

/*Data for the table `xwb_celeb_category` */

LOCK TABLES `xwb_celeb_category` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_comment_copy` */

DROP TABLE IF EXISTS `xwb_comment_copy`;

CREATE TABLE `xwb_comment_copy` (
  `cid` bigint(20) unsigned NOT NULL COMMENT '评论ID',
  `sina_uid` bigint(20) unsigned NOT NULL COMMENT '发评论者的新浪UID',
  `uid` bigint(20) default NULL COMMENT '发评论的ID',
  `mid` bigint(20) unsigned NOT NULL COMMENT '微博ID',
  `m_uid` bigint(20) unsigned NOT NULL COMMENT '发微博的UID',
  `reply_cid` bigint(20) unsigned NOT NULL default '0' COMMENT '被回复的评论ID',
  `reply_uid` bigint(20) unsigned NOT NULL default '0' COMMENT '被回复者的ID',
  `content` varchar(140) character set utf8 NOT NULL COMMENT '评论内容',
  `source` varchar(80) collate utf8_bin default NULL COMMENT '内容来源',
  `post_ip` varchar(50) collate utf8_bin default NULL COMMENT '发布者IP',
  `dateline` int(11) unsigned NOT NULL COMMENT '评论时间',
  `sina_nick` varchar(45) collate utf8_bin default NULL COMMENT '发布者新浪的昵称',
  `disabled` varchar(1) collate utf8_bin NOT NULL default '0' COMMENT '是否屏蔽',
  PRIMARY KEY  (`cid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `xwb_comment_copy` */

LOCK TABLES `xwb_comment_copy` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_comment_delete` */

DROP TABLE IF EXISTS `xwb_comment_delete`;

CREATE TABLE `xwb_comment_delete` (
  `id` bigint(20) unsigned NOT NULL COMMENT '评论ID',
  `sina_uid` bigint(20) unsigned NOT NULL COMMENT '发评论者的新浪UID',
  `sina_nick` varchar(45) collate utf8_bin default NULL COMMENT '发布者新浪的昵称',
  `mid` bigint(20) unsigned NOT NULL COMMENT '微博ID',
  `reply_cid` bigint(20) unsigned NOT NULL default '0' COMMENT '被回复的评论ID',
  `content` varchar(140) character set utf8 NOT NULL COMMENT '评论内容',
  `post_ip` varchar(50) collate utf8_bin default NULL COMMENT '发布者IP',
  `dateline` int(10) unsigned NOT NULL COMMENT '评论时间',
  `add_time` int(11) unsigned NOT NULL COMMENT '增加时间',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `xwb_comment_delete` */

LOCK TABLES `xwb_comment_delete` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_comment_verify` */

DROP TABLE IF EXISTS `xwb_comment_verify`;

CREATE TABLE `xwb_comment_verify` (
  `id` bigint(20) unsigned NOT NULL auto_increment COMMENT '评论ID',
  `sina_uid` bigint(20) unsigned NOT NULL COMMENT '发评论者的新浪UID',
  `sina_nick` varchar(45) collate utf8_bin default NULL COMMENT '发布者新浪的昵称',
  `token` varchar(45) collate utf8_bin NOT NULL COMMENT '发布者的token',
  `token_secret` varchar(45) collate utf8_bin NOT NULL COMMENT '发布者的token_secret',
  `mid` bigint(20) unsigned NOT NULL COMMENT '微博ID',
  `reply_cid` bigint(20) unsigned NOT NULL default '0' COMMENT '被回复的评论ID',
  `content` varchar(140) character set utf8 NOT NULL COMMENT '评论内容',
  `post_ip` varchar(50) collate utf8_bin default NULL COMMENT '发布者IP',
  `dateline` int(11) unsigned NOT NULL COMMENT '用户评论时间',
  `forward` varchar(1) collate utf8_bin default NULL COMMENT '是否作为一条新微博发布',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `xwb_comment_verify` */

LOCK TABLES `xwb_comment_verify` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_component_cfg` */

DROP TABLE IF EXISTS `xwb_component_cfg`;

CREATE TABLE `xwb_component_cfg` (
  `component_id` int(10) unsigned NOT NULL,
  `cfgName` varchar(30) NOT NULL COMMENT '参数名称',
  `cfgValue` varchar(255) default NULL COMMENT '参数值',
  `desc` varchar(50) default NULL COMMENT '配置项说明',
  PRIMARY KEY  (`component_id`,`cfgName`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='组件对应的配置';

/*Data for the table `xwb_component_cfg` */

LOCK TABLES `xwb_component_cfg` WRITE;

insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (1,'show_num','5','组件显示的微博数');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (2,'group_id','1','名人推荐用户组对应的用户列表ID');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (2,'show_num','3','显示的名人数');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (3,'show_num','9','');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (3,'group_id','2','推荐用户组使用的用户列表ID');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (4,'group_id','3','人气关注榜的数据来源，0 使用新浪API >0　对应的用户组');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (10,'show_num','10','今日话题显示的微博数');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (10,'group_id','1','今日话题使用的话题组');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (11,'groups','{\"1\":\"\\u660e\\u661f\",\"2\":\"\\u8349\\u6839\"}','');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (9,'show_num','4','随便看看');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (5,'list_id','54355137','list id');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (5,'show_num','4','');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (4,'show_num','5','人气关注榜挂件人数');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (6,'show_num','10','');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (6,'topic_id','0','0 使用新浪API取数据　> 0 对应的话题组ID');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (7,'show_num','9','');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (8,'show_num','3','');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (2,'topic_id','0','0 使用新浪API取数据　> 0 对应的话题组ID');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (10,'source','1','0 使用全局数据 >0 使用本站数据');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (9,'source','0','0 使用全局数据 >0 使用本站数据');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (1,'source','1','0 使用全局数据 >0 使用本站数据');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (8,'source','1','0 使用全局数据 >0 使用本站数据');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (12,'topic','微小说','话题微薄的默认话题');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (12,'show_num','6','显示微博数');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (12,'source','1','微博来源');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (17,'show_num','5','组件显示的微博数');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (17,'source','0','0 使用全局数据 >0 使用本站数据');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (18,'show_num','3','');

UNLOCK TABLES;

/*Table structure for table `xwb_component_topic` */

DROP TABLE IF EXISTS `xwb_component_topic`;

CREATE TABLE `xwb_component_topic` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `topic_id` int(10) unsigned NOT NULL,
  `topic` varchar(50) NOT NULL COMMENT '话题',
  `date_time` int(10) unsigned NOT NULL COMMENT '生效时间或添加时间',
  `sort_num` int(10) unsigned NOT NULL default '0' COMMENT '排序',
  `ext1` varchar(45) default NULL COMMENT '扩展字段',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='热门话题列表';

/*Data for the table `xwb_component_topic` */

LOCK TABLES `xwb_component_topic` WRITE;

insert  into `xwb_component_topic`(`id`,`topic_id`,`topic`,`date_time`,`sort_num`,`ext1`) values (26,2,'Xweibo',1303107194,0,'1303107120');

UNLOCK TABLES;

/*Table structure for table `xwb_component_topiclist` */

DROP TABLE IF EXISTS `xwb_component_topiclist`;

CREATE TABLE `xwb_component_topiclist` (
  `topic_id` int(10) unsigned NOT NULL auto_increment COMMENT '话题ID',
  `topic_name` varchar(25) NOT NULL COMMENT '话题列表的名称',
  `native` tinyint(1) NOT NULL default '0' COMMENT '是否为内置话题，内置不能删除',
  `sort` varchar(1) NOT NULL default '1' COMMENT '类别下的话题是否允许排序',
  `app_with` text,
  `type` tinyint(4) NOT NULL default '0' COMMENT '话题分组类型',
  PRIMARY KEY  (`topic_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_component_topiclist` */

LOCK TABLES `xwb_component_topiclist` WRITE;

insert  into `xwb_component_topiclist`(`topic_id`,`topic_name`,`native`,`sort`,`app_with`,`type`) values (1,'推荐话题',1,'1','6,7,11',0);
insert  into `xwb_component_topiclist`(`topic_id`,`topic_name`,`native`,`sort`,`app_with`,`type`) values (2,'今日话题',1,'0','2,5',2);

UNLOCK TABLES;

/*Table structure for table `xwb_component_usergroups` */

DROP TABLE IF EXISTS `xwb_component_usergroups`;

CREATE TABLE `xwb_component_usergroups` (
  `group_id` int(10) unsigned NOT NULL auto_increment COMMENT '分组ID',
  `group_name` varchar(15) NOT NULL COMMENT '组名称',
  `native` tinyint(1) NOT NULL default '0' COMMENT '是否为内置列表 1:是 0:否',
  `related_id` varchar(50) default NULL COMMENT '组件应用情况，即哪位ID的组件使用了，可为多个，逗号分隔',
  `type` tinyint(1) unsigned NOT NULL default '0' COMMENT '分组类型，0:普通分组, 4:官方微博分组',
  PRIMARY KEY  (`group_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='推荐用户　的各个分组';

/*Data for the table `xwb_component_usergroups` */

LOCK TABLES `xwb_component_usergroups` WRITE;

insert  into `xwb_component_usergroups`(`group_id`,`group_name`,`native`,`related_id`,`type`) values (1,'第一次登录自动关注',1,'11:1,11:1',0);
insert  into `xwb_component_usergroups`(`group_id`,`group_name`,`native`,`related_id`,`type`) values (84,'首页用户推荐(他们在微博)',1,NULL,0);

UNLOCK TABLES;

/*Table structure for table `xwb_component_users` */

DROP TABLE IF EXISTS `xwb_component_users`;

CREATE TABLE `xwb_component_users` (
  `group_id` int(10) unsigned default NULL COMMENT '唯一、自增的用户分组ID',
  `uid` bigint(20) unsigned NOT NULL COMMENT '用户ID',
  `sort_num` int(11) NOT NULL default '0' COMMENT '排序',
  `nickname` varchar(20) default NULL COMMENT '用户昵称',
  `remark` varchar(255) default NULL COMMENT '备注',
  `id` int(10) unsigned NOT NULL auto_increment,
  PRIMARY KEY  (`id`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户列表成员表';

/*Data for the table `xwb_component_users` */

LOCK TABLES `xwb_component_users` WRITE;
INSERT INTO `xwb_component_users` (`group_id`,`uid`,`nickname`,`remark`,`sort_num`) VALUES("84","1904178193","微博开放平台","新浪微博API官方帐号","1");
INSERT INTO `xwb_component_users` (`group_id`,`uid`,`nickname`,`remark`,`sort_num`) VALUES("84","1662047260","SinaAppEngine","新浪SAE服务官方帐号","2");
INSERT INTO `xwb_component_users` (`group_id`,`uid`,`nickname`,`remark`,`sort_num`) VALUES("84","1076590735","xweibo官方","xweibo官方微博","3");
UNLOCK TABLES;

/*Table structure for table `xwb_components` */

DROP TABLE IF EXISTS `xwb_components`;

CREATE TABLE `xwb_components` (
  `component_id` int(10) unsigned NOT NULL auto_increment COMMENT '唯一、自增ID',
  `name` varchar(20) NOT NULL COMMENT '组件名称',
  `title` varchar(45) default NULL COMMENT '用于显示的名称',
  `type` tinyint(4) default NULL COMMENT '组件类型　0表示一个页面只有一个，>0表示一个页面可以有多个',
  `native` tinyint(1) NOT NULL default '1' COMMENT '是否为内置类型',
  `component_type` tinyint(4) NOT NULL COMMENT '组件类型 1: 页面主体 2: 侧边栏',
  `symbol` varchar(20) NOT NULL COMMENT '模块标识，程序中使用',
  `desc` varchar(255) default NULL COMMENT '模块说明',
  `preview_img` varchar(255) default NULL COMMENT '预览图片',
  `component_cty` varchar(16) default NULL COMMENT '组件分类:array(''user'' => ''用户'', ''wb'' => ''微博'', ''topic'' => ''话题'', ''others'' => ''其它'')',
  PRIMARY KEY  (`component_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `xwb_components` */

LOCK TABLES `xwb_components` WRITE;

insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (1,'热门转发与评论','热门转发与评论',0,1,1,'hotWb','当天转发最多的微博列表（倒序排列）','','wb');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (2,'用户组','用户组',2,1,1,'starRcm','一组用户的列表','','user');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (3,'推荐用户','推荐用户',3,1,2,'userRcm','指定某些用户的列表（右边栏）','','user');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (5,'自定义微博列表','自定义微博列表',5,1,1,'official','某些指定用户发布的微博列表','','wb');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (6,'话题推荐列表','话题推荐列表',6,1,2,'hotTopic','一组话题列表','','others');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (7,'可能感兴趣的人','可能感兴趣的人',0,1,2,'guessYouLike','根据当前用户的IP、个人资料推荐相关联的用户列表','','user');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (8,'同城微博','同城微博',0,1,1,'cityWb','根据当前用户的IP地址判断地区，并展示该地区用户的微博列表','','wb');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (9,'随便看看','随便看看',0,1,1,'looklook','一段特点时间内发布的（一般为最新）的微博列表，随机展现','','wb');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (10,'今日话题','今日话题',0,1,1,'todayTopic','自动获取与今日话题相关的微博消息。话题可以在“运营管理-话题推荐管理”中设置','','others');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (20,'专题介绍','专题介绍',10,1,1,'topicDesc','专题介绍',NULL,'topic');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (12,'话题微博','话题微博',12,1,1,'topicWb','当前设定话题的相关微博列表','','wb');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (15,'最新用户','最新用户',0,1,2,'newestWbUser','本站最新开通微博的用户列表','','user');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (14,'最新微博','最新微博',15,1,1,'newestWb','当前站点最新发布的微博列表','','wb');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (13,'专题banner图','专题banner图',13,1,1,'pageImg','在页面中添加一个宽度为560px的banner图片','','others');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (16,'微博发布框','微博发布框',0,1,1,'sendWb','微博发布框','','others');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (21,'专题发布框','专题发布框',1,1,1,'topicPub','专题发布框',NULL,'topic');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (19,'本地关注榜','本地关注榜',0,1,2,'localFollowTop','本地关注榜','','user');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (18,'活动列表','活动列表',0,1,2,'eventList','活动列表','','others');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (22,'专题介绍','专题介绍',10,1,2,'topicDesc','专题介绍',NULL,'topic');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (23,'相关视频','相关视频',10,1,2,'topicVideo','相关视频',NULL,'topic');

UNLOCK TABLES;

/*Table structure for table `xwb_content_unit` */

DROP TABLE IF EXISTS `xwb_content_unit`;

CREATE TABLE `xwb_content_unit` (
  `id` int(4) NOT NULL auto_increment,
  `unit_name` varchar(40) default NULL COMMENT '输出单元的名称',
  `title` varchar(40) default NULL COMMENT '输出单元的标题，暂时只用于群组微博',
  `width` int(4) default NULL COMMENT '输出单元的宽度',
  `height` int(4) default NULL COMMENT '输出单元的高度',
  `target` varchar(40) default NULL COMMENT '输出单元内容的来源对象',
  `type` int(4) default '1' COMMENT '输出单元的类型，默认是1.1是微博秀, 2是推荐用户列表, 3是互动话题，4是一键关注，5是群组微博',
  `skin` int(4) default '1' COMMENT '输出单元的样式皮肤,默认是1',
  `colors` int(4) default NULL COMMENT '输出单元的自定义样式',
  `show_title` tinyint(3) default '1' COMMENT '是否显示标题,默认是1, 1是显示, 0是不显示',
  `show_border` tinyint(3) default '1' COMMENT '是否显示边框,默认是1, 1是显示, 0是不显示',
  `show_logo` tinyint(3) default '1' COMMENT '是否显示logo,默认是1, 1是显示, 0是不显示',
  `show_publish` tinyint(3) default '0' COMMENT '是否显示发布框，默认是0, 1是显示，0是不显示',
  `auto_scroll` tinyint(3) default '0' COMMENT '是否自动滚动，默认是0, 1是自动滚动，0不是自动滚动',
  `add_time` int(10) default NULL COMMENT '添加时间',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='内容输出单元';

/*Data for the table `xwb_content_unit` */

LOCK TABLES `xwb_content_unit` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_disable_items` */

DROP TABLE IF EXISTS `xwb_disable_items`;

CREATE TABLE `xwb_disable_items` (
  `kw_id` int(10) unsigned NOT NULL auto_increment COMMENT '唯一、自增ID',
  `type` tinyint(4) NOT NULL COMMENT '内容类型：１微博ID　２评论ID　３昵称　４内容',
  `item` varchar(45) NOT NULL COMMENT '屏蔽或禁止的ID或内容',
  `comment` varchar(60) NOT NULL COMMENT '相关显示内容',
  `admin_name` varchar(24) NOT NULL COMMENT '管理员操作时的昵称',
  `admin_id` int(10) unsigned NOT NULL COMMENT '管理员ID',
  `user` varchar(45) NOT NULL COMMENT '微博或评论的作者',
  `publish_time` varchar(20) NOT NULL COMMENT '微博或评论的发布时间yyyy-mm-dd hh:ii:ss格式字串',
  `add_time` int(10) unsigned NOT NULL COMMENT '加入时间',
  PRIMARY KEY  (`kw_id`),
  UNIQUE KEY `Index_type_item` (`type`,`item`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='屏蔽或禁止的内容列表';

/*Data for the table `xwb_disable_items` */

LOCK TABLES `xwb_disable_items` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_event_comment` */

DROP TABLE IF EXISTS `xwb_event_comment`;

CREATE TABLE `xwb_event_comment` (
  `event_id` int(4) unsigned NOT NULL COMMENT '活动id',
  `wb_id` bigint(20) NOT NULL COMMENT '微博id',
  `weibo` text COMMENT '微博内容',
  `comment_time` int(10) default NULL COMMENT '评论时间',
  PRIMARY KEY  (`event_id`,`wb_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `xwb_event_comment` */

LOCK TABLES `xwb_event_comment` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_event_join` */

DROP TABLE IF EXISTS `xwb_event_join`;

CREATE TABLE `xwb_event_join` (
  `sina_uid` bigint(20) NOT NULL COMMENT 'SINA　UID',
  `event_id` int(11) NOT NULL COMMENT '活动ID',
  `contact` varchar(200) default NULL COMMENT '联系方式',
  `notes` text COMMENT '备注',
  `join_time` int(11) default NULL COMMENT '参与时间',
  PRIMARY KEY  (`sina_uid`,`event_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='活动参与表';

/*Data for the table `xwb_event_join` */

LOCK TABLES `xwb_event_join` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_events` */

DROP TABLE IF EXISTS `xwb_events`;

CREATE TABLE `xwb_events` (
  `id` int(11) unsigned NOT NULL auto_increment COMMENT '自增ID',
  `title` varchar(200) default NULL COMMENT '标题',
  `addr` varchar(200) default NULL COMMENT '地址',
  `desc` text COMMENT '简介',
  `cost` float default NULL COMMENT '费用',
  `sina_uid` bigint(20) default NULL COMMENT '发起人ID',
  `nickname` varchar(25) NOT NULL COMMENT '发起人昵称',
  `realname` varchar(25) default NULL COMMENT '真实姓名',
  `phone` varchar(20) default NULL COMMENT '联系电话',
  `start_time` int(11) default NULL COMMENT '开始时间',
  `end_time` int(11) default NULL COMMENT '结束时间',
  `pic` varchar(200) default NULL COMMENT '图片',
  `wb_id` bigint(20) default NULL COMMENT '微博ID',
  `join_num` int(11) default NULL COMMENT '参与人数',
  `view_num` int(11) default NULL COMMENT '查看次数',
  `comment_num` int(11) default NULL COMMENT '评论数',
  `state` tinyint(2) default '1' COMMENT '活动状态：1正常，2用户关闭，3，管理员封禁，4是推荐',
  `other` tinyint(2) default '1' COMMENT '是否要求参加填写联系方式和备注：1是不用，2是要求',
  `modify_time` int(11) default NULL COMMENT '修改时间',
  `add_time` int(11) default NULL COMMENT '发起时间',
  `add_ip` varchar(30) default NULL COMMENT '发起人所在地IP',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='活动主表';

/*Data for the table `xwb_events` */

LOCK TABLES `xwb_events` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_feedback` */

DROP TABLE IF EXISTS `xwb_feedback`;

CREATE TABLE `xwb_feedback` (
  `id` int(11) NOT NULL auto_increment,
  `content` text,
  `uid` bigint(20) default NULL,
  `nickname` varchar(45) default NULL,
  `mail` varchar(45) default NULL,
  `qq` varchar(45) default NULL,
  `tel` varchar(45) default NULL,
  `addtime` int(11) default NULL,
  `ip` varchar(16) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_feedback` */

LOCK TABLES `xwb_feedback` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_interview_wb` */

DROP TABLE IF EXISTS `xwb_interview_wb`;

CREATE TABLE `xwb_interview_wb` (
  `ask_id` bigint(20) unsigned NOT NULL COMMENT '提问微博ID',
  `answer_wb` bigint(20) unsigned NOT NULL default '0' COMMENT '第一条回答的微博ID;如果是点评的,ask_id=answer_wb',
  `interview_id` int(10) unsigned NOT NULL COMMENT '微访谈节目标识',
  `state` char(1) NOT NULL COMMENT 'P:待审;A:审核通过;删除为物理删除;主持人和嘉宾的微博不需要审核',
  `ask_uid` bigint(20) unsigned NOT NULL COMMENT '提问者uid',
  `answer_uid` bigint(20) unsigned default NULL COMMENT '第一个回答者uid',
  `weibo` text COMMENT 'json结构的微博内容',
  `answer_weibo` text COMMENT 'json结构的微博内容',
  PRIMARY KEY  (`ask_id`),
  KEY `interview_index` (`interview_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xwb_interview_wb` */

LOCK TABLES `xwb_interview_wb` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_interview_wb_atme` */

DROP TABLE IF EXISTS `xwb_interview_wb_atme`;

CREATE TABLE `xwb_interview_wb_atme` (
  `interview_id` int(10) NOT NULL COMMENT '微访谈节目ID',
  `ask_id` bigint(20) NOT NULL COMMENT '用户提问微博ID',
  `at_uid` bigint(20) NOT NULL COMMENT '提问嘉宾UID',
  `answer_wb` bigint(20) NOT NULL default '0' COMMENT '回答的微博ID',
  `weibo` text COMMENT 'json结构后的微博内容',
  PRIMARY KEY  (`interview_id`,`ask_id`,`at_uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xwb_interview_wb_atme` */

LOCK TABLES `xwb_interview_wb_atme` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_item_groups` */

DROP TABLE IF EXISTS `xwb_item_groups`;

CREATE TABLE `xwb_item_groups` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID 已定义的，1：分类用户推荐 2：引导关注类别',
  `item_id` int(11) NOT NULL COMMENT '分组对象的ID',
  `item_name` varchar(25) default NULL COMMENT '分组名称',
  `sort_num` int(11) default '0' COMMENT '排序ID，通常用于组内',
  PRIMARY KEY  (`id`),
  KEY `group_idx` (`group_id`,`sort_num`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用于存储ID分组列表，如用户分类';

/*Data for the table `xwb_item_groups` */

LOCK TABLES `xwb_item_groups` WRITE;
INSERT INTO `xwb_item_groups` VALUES (1,2,84,'首次登录引导关注',0);
UNLOCK TABLES;

/*Table structure for table `xwb_keep_userdomain` */

DROP TABLE IF EXISTS `xwb_keep_userdomain`;

CREATE TABLE `xwb_keep_userdomain` (
  `keep_domain` varchar(45) NOT NULL,
  PRIMARY KEY  (`keep_domain`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='保留一些个性域名';

/*Data for the table `xwb_keep_userdomain` */

LOCK TABLES `xwb_keep_userdomain` WRITE;

insert  into `xwb_keep_userdomain`(`keep_domain`) values ('account ');
insert  into `xwb_keep_userdomain`(`keep_domain`) values ('application');
insert  into `xwb_keep_userdomain`(`keep_domain`) values ('authImage ');
insert  into `xwb_keep_userdomain`(`keep_domain`) values ('custom ');
insert  into `xwb_keep_userdomain`(`keep_domain`) values ('feedback ');
insert  into `xwb_keep_userdomain`(`keep_domain`) values ('flash');
insert  into `xwb_keep_userdomain`(`keep_domain`) values ('html_demo');
insert  into `xwb_keep_userdomain`(`keep_domain`) values ('install');
insert  into `xwb_keep_userdomain`(`keep_domain`) values ('interview ');
insert  into `xwb_keep_userdomain`(`keep_domain`) values ('output ');
insert  into `xwb_keep_userdomain`(`keep_domain`) values ('readme');
insert  into `xwb_keep_userdomain`(`keep_domain`) values ('sae_install');
insert  into `xwb_keep_userdomain`(`keep_domain`) values ('search ');
insert  into `xwb_keep_userdomain`(`keep_domain`) values ('setting ');
insert  into `xwb_keep_userdomain`(`keep_domain`) values ('templates');
insert  into `xwb_keep_userdomain`(`keep_domain`) values ('welcome');
insert  into `xwb_keep_userdomain`(`keep_domain`) values ('xPluginApi ');

UNLOCK TABLES;

/*Table structure for table `xwb_local_pm_content` */

DROP TABLE IF EXISTS `xwb_local_pm_content`;

CREATE TABLE `xwb_local_pm_content` (
  `id` int(11) unsigned NOT NULL auto_increment COMMENT '私信id',
  `iid` int(11) unsigned NOT NULL default '0' COMMENT '隶属的私信集合id',
  `sender_id` bigint(20) unsigned NOT NULL default '0' COMMENT '发送方sina_uid',
  `recipient_id` bigint(20) unsigned NOT NULL default '0' COMMENT '接受方sina_uid',
  `created_at` int(11) unsigned NOT NULL default '0' COMMENT '发送时间',
  `recipient_unread` tinyint(1) unsigned NOT NULL default '1',
  `last_del_uid` bigint(20) unsigned NOT NULL default '0' COMMENT '上一个删除人',
  `text` text NOT NULL COMMENT '私信内容',
  PRIMARY KEY  (`id`),
  KEY `iid` (`iid`,`created_at`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xwb_local_pm_content` */

LOCK TABLES `xwb_local_pm_content` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_local_pm_index` */

DROP TABLE IF EXISTS `xwb_local_pm_index`;

CREATE TABLE `xwb_local_pm_index` (
  `iid` int(11) unsigned NOT NULL auto_increment COMMENT '私信集合id',
  `actors` char(100) NOT NULL default '' COMMENT '参与双方的id集合（格式：小sina_uid#大sina_uid）',
  PRIMARY KEY  (`iid`),
  UNIQUE KEY `actors` (`actors`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xwb_local_pm_index` */

LOCK TABLES `xwb_local_pm_index` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_local_pm_index_user` */

DROP TABLE IF EXISTS `xwb_local_pm_index_user`;

CREATE TABLE `xwb_local_pm_index_user` (
  `sina_uid` bigint(20) unsigned NOT NULL COMMENT '私信涉及sina_uid',
  `iid` int(11) unsigned NOT NULL COMMENT '私信集合id',
  `unread_count` int(11) unsigned NOT NULL default '0' COMMENT '该用户在该私信集合id的未读私信数',
  `total_number` int(11) unsigned NOT NULL default '0' COMMENT '该用户在该私信集合id的总计数',
  `lasttime` int(11) unsigned NOT NULL default '0' COMMENT '该用户在该私信集合id的最后更新时间',
  `last_id` int(11) unsigned NOT NULL default '0' COMMENT '该用户在该私信集合id的最后一条私信id',
  `last_data` text COMMENT '该用户在该私信集合id的最后一条私信内容',
  UNIQUE KEY `sina_uid` (`sina_uid`,`iid`),
  KEY `lasttime` (`sina_uid`,`lasttime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xwb_local_pm_index_user` */

LOCK TABLES `xwb_local_pm_index_user` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_log_error` */

DROP TABLE IF EXISTS `xwb_log_error`;

CREATE TABLE `xwb_log_error` (
  `id` int(10) unsigned NOT NULL auto_increment COMMENT '标识ID',
  `soft` varchar(45) NOT NULL COMMENT '软件名称',
  `version` varchar(10) NOT NULL COMMENT '版本',
  `akey` varchar(45) NOT NULL COMMENT 'app key',
  `type` varchar(10) NOT NULL COMMENT '日志类型，IO/DB/CACHE/API',
  `level` varchar(10) NOT NULL COMMENT '日志等级 ,error、warning',
  `msg` varchar(500) NOT NULL COMMENT '日志信息',
  `extra` varchar(500) default NULL COMMENT '扩展信息',
  `log_time` datetime NOT NULL COMMENT '记录时间',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_log_error` */

LOCK TABLES `xwb_log_error` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_log_error_api` */

DROP TABLE IF EXISTS `xwb_log_error_api`;

CREATE TABLE `xwb_log_error_api` (
  `id` int(10) unsigned NOT NULL auto_increment COMMENT '标识ID',
  `soft` varchar(45) NOT NULL COMMENT '软件名称',
  `version` varchar(10) NOT NULL COMMENT '版本',
  `akey` varchar(45) NOT NULL COMMENT 'app key',
  `type` varchar(10) NOT NULL COMMENT '日志类型，IO/DB/CACHE/API',
  `level` varchar(10) NOT NULL COMMENT '日志等级 ,error、warning',
  `msg` varchar(500) NOT NULL COMMENT '日志信息',
  `extra` varchar(500) default NULL COMMENT '扩展信息',
  `log_time` datetime NOT NULL COMMENT '记录时间',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_log_error_api` */

LOCK TABLES `xwb_log_error_api` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_log_http` */

DROP TABLE IF EXISTS `xwb_log_http`;

CREATE TABLE `xwb_log_http` (
  `id` int(4) unsigned NOT NULL auto_increment,
  `url` varchar(500) default NULL COMMENT '请求url',
  `base_string` varchar(500) NOT NULL default '' COMMENT '加密的base_string',
  `key_string` varchar(500) NOT NULL default '' COMMENT '加密的key_string',
  `http_code` int(4) default NULL COMMENT 'http code',
  `ret` varchar(200) NOT NULL default '' COMMENT '返回结果',
  `post_data` text COMMENT 'post数据',
  `request_time` float default NULL COMMENT '请求时间',
  `total_time` float default NULL COMMENT '总执行时间',
  `s_ip` char(15) default NULL COMMENT '服务器ip',
  `log_time` char(20) default NULL COMMENT '记录时间',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_log_http` */

LOCK TABLES `xwb_log_http` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_log_info` */

DROP TABLE IF EXISTS `xwb_log_info`;

CREATE TABLE `xwb_log_info` (
  `id` int(10) unsigned NOT NULL auto_increment COMMENT '标识ID',
  `soft` varchar(45) NOT NULL COMMENT '软件名称',
  `version` varchar(10) NOT NULL COMMENT '版本',
  `akey` varchar(45) NOT NULL COMMENT 'app key',
  `type` varchar(10) NOT NULL COMMENT '日志类型，IO/DB/CACHE/API',
  `level` varchar(10) NOT NULL COMMENT '日志等级 ,error、warning',
  `msg` varchar(500) NOT NULL COMMENT '日志信息',
  `extra` varchar(500) default NULL COMMENT '扩展信息',
  `log_time` datetime NOT NULL COMMENT '记录时间',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_log_info` */

LOCK TABLES `xwb_log_info` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_log_info_api` */

DROP TABLE IF EXISTS `xwb_log_info_api`;

CREATE TABLE `xwb_log_info_api` (
  `id` int(10) unsigned NOT NULL auto_increment COMMENT '标识ID',
  `soft` varchar(45) NOT NULL COMMENT '软件名称',
  `version` varchar(10) NOT NULL COMMENT '版本',
  `akey` varchar(45) NOT NULL COMMENT 'app key',
  `type` varchar(10) NOT NULL COMMENT '日志类型，IO/DB/CACHE/API',
  `level` varchar(10) NOT NULL COMMENT '日志等级 ,error、warning',
  `msg` varchar(500) NOT NULL COMMENT '日志信息',
  `extra` varchar(500) default NULL COMMENT '扩展信息',
  `log_time` datetime NOT NULL COMMENT '记录时间',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_log_info_api` */

LOCK TABLES `xwb_log_info_api` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_micro_interview` */

DROP TABLE IF EXISTS `xwb_micro_interview`;

CREATE TABLE `xwb_micro_interview` (
  `id` int(10) NOT NULL auto_increment COMMENT '标识',
  `title` varchar(200) NOT NULL COMMENT '标题',
  `desc` text NOT NULL COMMENT '说明',
  `banner_img` varchar(200) NOT NULL COMMENT 'Banner图片',
  `cover_img` varchar(200) NOT NULL COMMENT '封面图片',
  `state` char(1) NOT NULL default 'N' COMMENT '默认N;X:已删;',
  `wb_state` char(1) NOT NULL default 'A' COMMENT 'P:先审后发;A:直接发布',
  `master` varchar(200) default NULL COMMENT '主持人新浪uid列表，json结构保存',
  `guest` text COMMENT '嘉宾新浪uid列表，json结构保存',
  `backgroup_img` varchar(200) default NULL COMMENT '背景图片',
  `backgroup_color` varchar(20) default NULL COMMENT '外观颜色',
  `start_time` int(11) NOT NULL COMMENT '开始时间',
  `end_time` int(11) NOT NULL COMMENT '结束时间',
  `add_time` int(11) NOT NULL COMMENT '添加时间',
  `backgroup_style` tinyint(2) unsigned default NULL COMMENT '背景图方式,默认是1,1是平铺，2是居中',
  `custom_color` varchar(20) default NULL COMMENT '自定义颜色',
  `notice_time` int(10) unsigned default NULL COMMENT '提醒时间，以秒为单位',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_micro_interview` */

LOCK TABLES `xwb_micro_interview` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_micro_live` */

DROP TABLE IF EXISTS `xwb_micro_live`;

CREATE TABLE `xwb_micro_live` (
  `id` int(11) unsigned NOT NULL auto_increment COMMENT '自增ID',
  `title` varchar(200) NOT NULL COMMENT '标题',
  `trends` varchar(200) NOT NULL COMMENT '微直播的话题',
  `desc` text NOT NULL COMMENT '简介',
  `code` text COMMENT '直播视频代码',
  `start_time` int(11) NOT NULL COMMENT '开始时间',
  `end_time` int(11) NOT NULL COMMENT '结束时间',
  `master` varchar(200) NOT NULL COMMENT '主持人，json格式保存',
  `guest` text NOT NULL COMMENT '嘉宾，json格式保存',
  `banner_img` varchar(200) default NULL COMMENT '微直播的banner',
  `cover_img` varchar(200) default NULL COMMENT '封面图',
  `backgroup_img` varchar(200) default NULL COMMENT '背景图',
  `backgroup_style` tinyint(2) default NULL COMMENT '背景图方式，默认是1，1是平铺，2是居中',
  `backgroup_color` varchar(20) default NULL COMMENT '外观样式',
  `custom_color` varchar(20) default NULL COMMENT '自定义颜色',
  `state` char(1) NOT NULL default 'N' COMMENT '默认N，X:已删',
  `wb_state` char(1) NOT NULL default 'A' COMMENT 'P:先审后发;A:直接发布',
  `notice_time` int(11) default NULL COMMENT '提醒时间',
  `add_time` int(11) default NULL COMMENT '发起时间',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_micro_live` */

LOCK TABLES `xwb_micro_live` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_micro_live_wb` */

DROP TABLE IF EXISTS `xwb_micro_live_wb`;

CREATE TABLE `xwb_micro_live_wb` (
  `live_id` int(4) NOT NULL COMMENT '微直播的id',
  `wb_id` bigint(20) NOT NULL COMMENT '微博id',
  `weibo` text COMMENT '微博内容',
  `type` tinyint(2) NOT NULL default '1' COMMENT '发微博人的类型，默认是1，1是网友，2是主持人，3是嘉宾',
  `state` tinyint(2) NOT NULL default '1' COMMENT '微博状态，默认是1，1是正常，2是未审核，3是通过审核',
  `add_time` int(11) default NULL COMMENT '发布微博时间',
  PRIMARY KEY  (`live_id`,`wb_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xwb_micro_live_wb` */

LOCK TABLES `xwb_micro_live_wb` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_nav` */

DROP TABLE IF EXISTS `xwb_nav`;

CREATE TABLE `xwb_nav` (
  `id` int(10) NOT NULL auto_increment,
  `name` varchar(45) default NULL,
  `parent_id` int(10) default NULL,
  `in_use` tinyint(1) unsigned default '1',
  `sort_num` tinyint(4) unsigned default NULL,
  `page_id` int(10) default '0',
  `is_blank` tinyint(1) unsigned default '0',
  `url` varchar(255) default NULL,
  `type` tinyint(1) NOT NULL,
  `isNative` tinyint(1) unsigned NOT NULL default '1' COMMENT '0:自定义;1:系统预设',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='页面导航栏';

/*Data for the table `xwb_nav` */

LOCK TABLES `xwb_nav` WRITE;

insert  into `xwb_nav`(`id`,`name`,`parent_id`,`in_use`,`sort_num`,`page_id`,`is_blank`,`url`,`type`,`isNative`) values (142,'微博广场',0,1,0,1,0,'',1,0);
insert  into `xwb_nav`(`id`,`name`,`parent_id`,`in_use`,`sort_num`,`page_id`,`is_blank`,`url`,`type`,`isNative`) values (158,'名人堂',0,1,0,3,0,NULL,2,0);
insert  into `xwb_nav`(`id`,`name`,`parent_id`,`in_use`,`sort_num`,`page_id`,`is_blank`,`url`,`type`,`isNative`) values (159,'活动',0,1,0,35,0,NULL,2,0);
insert  into `xwb_nav`(`id`,`name`,`parent_id`,`in_use`,`sort_num`,`page_id`,`is_blank`,`url`,`type`,`isNative`) values (21,'我的首页',0,1,50,2,1,'',2,1);
insert  into `xwb_nav`(`id`,`name`,`parent_id`,`in_use`,`sort_num`,`page_id`,`is_blank`,`url`,`type`,`isNative`) values (149,'微直播',0,1,0,7,0,'',2,0);
insert  into `xwb_nav`(`id`,`name`,`parent_id`,`in_use`,`sort_num`,`page_id`,`is_blank`,`url`,`type`,`isNative`) values (147,'话题排行榜',0,1,0,6,0,'',1,0);
insert  into `xwb_nav`(`id`,`name`,`parent_id`,`in_use`,`sort_num`,`page_id`,`is_blank`,`url`,`type`,`isNative`) values (153,'微访谈',0,1,0,8,0,'',1,0);

UNLOCK TABLES;

/*Table structure for table `xwb_notice` */

DROP TABLE IF EXISTS `xwb_notice`;

CREATE TABLE `xwb_notice` (
  `notice_id` bigint(20) unsigned NOT NULL auto_increment COMMENT '通知ID',
  `sender_id` bigint(20) default '0' COMMENT '发送者的sina_uid，默认为0，表示系统发送',
  `title` varchar(100) default NULL COMMENT '通知标题',
  `content` text COMMENT '通知内容',
  `add_time` int(11) default NULL COMMENT '发布时间',
  `available_time` int(11) default NULL COMMENT '生效时间',
  PRIMARY KEY  (`notice_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_notice` */

LOCK TABLES `xwb_notice` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_notice_recipients` */

DROP TABLE IF EXISTS `xwb_notice_recipients`;

CREATE TABLE `xwb_notice_recipients` (
  `kid` bigint(20) unsigned NOT NULL auto_increment COMMENT '自增ID',
  `notice_id` bigint(20) unsigned NOT NULL COMMENT '消息ID',
  `recipient_id` bigint(20) unsigned NOT NULL default '0' COMMENT '接收者的sina_uid，为0表示全站用户',
  PRIMARY KEY  (`kid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_notice_recipients` */

LOCK TABLES `xwb_notice_recipients` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_page_manager` */

DROP TABLE IF EXISTS `xwb_page_manager`;

CREATE TABLE `xwb_page_manager` (
  `page_id` int(11) NOT NULL COMMENT '预定义的页面ID：如１：广场。。',
  `component_id` int(11) default NULL COMMENT '使用到的组件ID',
  `title` varchar(45) default NULL,
  `position` int(11) NOT NULL default '0' COMMENT '摆放的位置 1:左边　２：右侧栏',
  `sort_num` int(11) default '0' COMMENT '摆放的顺序',
  `in_use` tinyint(1) default '1' COMMENT '是否使用',
  `id` int(10) unsigned NOT NULL auto_increment,
  `isNative` int(1) unsigned NOT NULL default '1' COMMENT '1:系统自带，不能删除  0:用户添加，可以删除',
  `param` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='页面设置';

/*Data for the table `xwb_page_manager` */

LOCK TABLES `xwb_page_manager` WRITE;

INSERT INTO `xwb22_page_manager` VALUES (1, 10, '今日话题', 1, 1, 1, 1, 0, '{\"show_num\":\"8\",\"source\":\"1\",\"topic\":\"Xweibo\"}');
INSERT INTO `xwb22_page_manager` VALUES (1, 3, '用户推荐', 2, 6, 1, 8, 0, '{\"group_id\":\"84\",\"show_num\":\"3\"}');
INSERT INTO `xwb22_page_manager` VALUES (2, 3, '推荐用户', 2, 3, 1, 9, 1, '{\"group_id\":\"84\"}');
INSERT INTO `xwb22_page_manager` VALUES (2, 6, '话题推荐列表', 2, 4, 1, 10, 1, '{\"topic_get\":\"2\",\"topics\":[\"\\u672c\\u62c9\\u767b\"],\"topic_id\":0,\"tid\":[\"\"]}');
INSERT INTO `xwb22_page_manager` VALUES (2, 7, '猜你喜欢', 2, 2, 1, 11, 1, '{\"show_num\":\"10\"}');
INSERT INTO `xwb22_page_manager` VALUES (1, 6, '推荐话题', 2, 3, 1, 15, 0, '{\"topic_get\":\"1\",\"topic_id\":0,\"show_num\":\"4\",\"source\":\"1\",\"topics\":[\"\\u63a8\\u8350\",\"test\",\"helloworld\"],\"tid\":[\"\",\"\",\"\"]}');
INSERT INTO `xwb22_page_manager` VALUES (1, 14, '本站最新微博', 1, 3, 1, 363, 0, '{\"show_num\":\"10\"}');
INSERT INTO `xwb22_page_manager` VALUES (4, 6, '话题推荐', 2, 2, 1, 194, 0, '{\"topic_get\":\"2\",\"topic_id\":0,\"show_num\":\"20\",\"topics\":[]}');
INSERT INTO `xwb22_page_manager` VALUES (5, 11, '多用户组(tab)', 1, 0, 0, 213, 0, '[]');
INSERT INTO `xwb22_page_manager` VALUES (1, 9, '随便看看', 1, 4, 1, 425, 0, '{\"show_num\":\"3\",\"source\":\"0\"}');
INSERT INTO `xwb22_page_manager` VALUES (1, 7, '可能感兴趣', 2, 7, 1, 424, 0, '{\"show_num\":\"10\"}');
INSERT INTO `xwb22_page_manager` VALUES (1, 18, '推荐活动', 2, 5, 1, 303, 0, '{\"event_list_type\":\"1\",\"show_num\":\"3\"}');
INSERT INTO `xwb22_page_manager` VALUES (1, 19, '粉丝排行榜', 2, 2, 1, 304, 0, '{\"show_num\":\"10\"}');
INSERT INTO `xwb22_page_manager` VALUES (1, 15, '最新用户', 2, 4, 1, 423, 0, '{\"show_num\":\"10\"}');
INSERT INTO `xwb22_page_manager` VALUES (1, 8, '同城微博', 1, 2, 1, 410, 0, '{\"source\":\"0\",\"page_type\":\"0\",\"show_num\":\"15\"}');

UNLOCK TABLES;

/*Table structure for table `xwb_page_prototype` */

DROP TABLE IF EXISTS `xwb_page_prototype`;

CREATE TABLE `xwb_page_prototype` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  `desc` varchar(255) default NULL,
  `type` int(10) unsigned NOT NULL default '2',
  `components` text,
  `url` varchar(45) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='页面原型';

/*Data for the table `xwb_page_prototype` */

LOCK TABLES `xwb_page_prototype` WRITE;

insert  into `xwb_page_prototype`(`id`,`name`,`desc`,`type`,`components`,`url`) values (2,'自定义页面','自定义页面原型',2,'','custom');
insert  into `xwb_page_prototype`(`id`,`name`,`desc`,`type`,`components`,`url`) values (1,'自定义页面','自定义页面原型',1,'','custom');

UNLOCK TABLES;

/*Table structure for table `xwb_pages` */

DROP TABLE IF EXISTS `xwb_pages`;

CREATE TABLE `xwb_pages` (
  `page_id` int(10) unsigned NOT NULL auto_increment COMMENT '页面id',
  `page_name` varchar(20) default NULL COMMENT '页面名称',
  `desc` varchar(255) default NULL COMMENT '页面描述',
  `native` tinyint(1) NOT NULL default '0' COMMENT '是否为内置页',
  `url` varchar(45) default NULL,
  `prototype_id` int(10) unsigned default NULL,
  `type` int(11) default '0' COMMENT '页面类型：专题、普通',
  `params` text,
  PRIMARY KEY  (`page_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `xwb_pages` */

LOCK TABLES `xwb_pages` WRITE;

insert  into `xwb_pages`(`page_id`,`page_name`,`desc`,`native`,`url`,`prototype_id`,`type`,`params`) values (1,'微博广场','“微博广场”是用户免登录即可查看的页面，包含了今日话题、随便看看等组件。',1,'pub',0,0,NULL);
insert  into `xwb_pages`(`page_id`,`page_name`,`desc`,`native`,`url`,`prototype_id`,`type`,`params`) values (2,'我的首页','“我的首页”是登录用户操作微博的页面，包含了猜你喜欢、推荐话题等组件。',1,'index',0,0,NULL);
insert  into `xwb_pages`(`page_id`,`page_name`,`desc`,`native`,`url`,`prototype_id`,`type`,`params`) values (3,'名人堂','名人堂',1,'celeb',0,0,NULL);
insert  into `xwb_pages`(`page_id`,`page_name`,`desc`,`native`,`url`,`prototype_id`,`type`,`params`) values (4,'我的微博','我的微博',1,'index.profile',0,0,NULL);
insert  into `xwb_pages`(`page_id`,`page_name`,`desc`,`native`,`url`,`prototype_id`,`type`,`params`) values (35,'活动首页','活动列表页，包括最新活动和推荐活动',1,'event',0,0,NULL);
insert  into `xwb_pages`(`page_id`,`page_name`,`desc`,`native`,`url`,`prototype_id`,`type`,`params`) values (6,'话题排行榜','话题排行榜',1,'pub.topics',0,0,NULL);
insert  into `xwb_pages`(`page_id`,`page_name`,`desc`,`native`,`url`,`prototype_id`,`type`,`params`) values (37,'我的收藏','我的收藏',1,'index.favorites',2,0,NULL);
insert  into `xwb_pages`(`page_id`,`page_name`,`desc`,`native`,`url`,`prototype_id`,`type`,`params`) values (8,'微访谈','微访谈扩展工具',1,'interview',0,0,NULL);
insert  into `xwb_pages`(`page_id`,`page_name`,`desc`,`native`,`url`,`prototype_id`,`type`,`params`) values (7,'微直播','微直播扩展工具',1,'live',0,0,NULL);

UNLOCK TABLES;

/*Table structure for table `xwb_plugins` */

DROP TABLE IF EXISTS `xwb_plugins`;

CREATE TABLE `xwb_plugins` (
  `plugin_id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(20) default NULL COMMENT '名称',
  `desc` varchar(255) default NULL COMMENT '简介',
  `in_use` tinyint(1) default '1' COMMENT '是否开启',
  PRIMARY KEY  (`plugin_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_plugins` */

LOCK TABLES `xwb_plugins` WRITE;

insert  into `xwb_plugins`(`plugin_id`,`title`,`desc`,`in_use`) values (2,'用户首页聚焦位','开启该插件会将站长设定的内容以图文的形式显示于用户首页中。',1);
insert  into `xwb_plugins`(`plugin_id`,`title`,`desc`,`in_use`) values (3,'个人资料推广位','开启该插件会将站长设定的内容以文字链接的形式显示于用户的个人信息的下方。',1);
insert  into `xwb_plugins`(`plugin_id`,`title`,`desc`,`in_use`) values (4,'登录后引导关注','开启该插件后，用户首次登陆会强制关注指定的用户并且引导用户其它推荐用户。',1);
insert  into `xwb_plugins`(`plugin_id`,`title`,`desc`,`in_use`) values (5,'用户反馈意见','左导航会出现一个意见反馈通道',1);
insert  into `xwb_plugins`(`plugin_id`,`title`,`desc`,`in_use`) values (6,'数据本地备份','本站备份一份微博数据',1);

UNLOCK TABLES;

/*Table structure for table `xwb_profile_ad` */

DROP TABLE IF EXISTS `xwb_profile_ad`;

CREATE TABLE `xwb_profile_ad` (
  `link_id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(50) NOT NULL COMMENT '标题',
  `link` varchar(255) NOT NULL COMMENT '链接',
  `add_time` int(11) default NULL COMMENT '添加的时间',
  PRIMARY KEY  (`link_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='个人信息推广位的广告';

/*Data for the table `xwb_profile_ad` */

LOCK TABLES `xwb_profile_ad` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_sessions` */

DROP TABLE IF EXISTS `xwb_sessions`;

CREATE TABLE `xwb_sessions` (
  `sesskey` char(32) NOT NULL,
  `expiry` int(11) unsigned NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY  (`sesskey`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xwb_sessions` */

LOCK TABLES `xwb_sessions` WRITE;
UNLOCK TABLES;

/*Table structure for table `xwb_skin_groups` */

DROP TABLE IF EXISTS `xwb_skin_groups`;

CREATE TABLE `xwb_skin_groups` (
  `style_id` int(10) unsigned NOT NULL auto_increment COMMENT '模板分类ID',
  `style_name` varchar(15) NOT NULL COMMENT '分类名称',
  `sort_num` int(11) NOT NULL default '0' COMMENT '显示排序',
  PRIMARY KEY  (`style_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='皮肤类别表';

/*Data for the table `xwb_skin_groups` */

LOCK TABLES `xwb_skin_groups` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_skins` */

DROP TABLE IF EXISTS `xwb_skins`;

CREATE TABLE `xwb_skins` (
  `skin_id` int(10) unsigned NOT NULL auto_increment COMMENT '模板ID',
  `name` varchar(45) default NULL COMMENT '文件名名称',
  `directory` varchar(45) NOT NULL COMMENT '所在的目录',
  `desc` varchar(255) default NULL COMMENT '模板说明',
  `state` tinyint(4) NOT NULL default '1' COMMENT '模板状态　０正常（启用）　１禁用　２文件不存在（不可用）',
  `style_id` int(11) NOT NULL default '0' COMMENT '模板分类ID',
  `sort_num` int(11) NOT NULL default '0' COMMENT '显示排序',
  PRIMARY KEY  (`skin_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='模板列表';

/*Data for the table `xwb_skins` */

LOCK TABLES `xwb_skins` WRITE;

insert  into `xwb_skins`(`skin_id`,`name`,`directory`,`desc`,`state`,`style_id`,`sort_num`) values (185,'墨绿','skin_blackgreen','',0,0,1);
insert  into `xwb_skins`(`skin_id`,`name`,`directory`,`desc`,`state`,`style_id`,`sort_num`) values (186,'蓝色','skin_blue','',0,0,2);
insert  into `xwb_skins`(`skin_id`,`name`,`directory`,`desc`,`state`,`style_id`,`sort_num`) values (187,'魅紫','skin_charmpurple','',0,0,3);
insert  into `xwb_skins`(`skin_id`,`name`,`directory`,`desc`,`state`,`style_id`,`sort_num`) values (188,'默认','skin_default','默认皮肤',0,0,4);
insert  into `xwb_skins`(`skin_id`,`name`,`directory`,`desc`,`state`,`style_id`,`sort_num`) values (189,'风景','skin_landscape','',0,0,5);
insert  into `xwb_skins`(`skin_id`,`name`,`directory`,`desc`,`state`,`style_id`,`sort_num`) values (190,'荷花','skin_lotus','',0,0,6);
insert  into `xwb_skins`(`skin_id`,`name`,`directory`,`desc`,`state`,`style_id`,`sort_num`) values (191,'节日','skin_newyear','',0,0,7);
insert  into `xwb_skins`(`skin_id`,`name`,`directory`,`desc`,`state`,`style_id`,`sort_num`) values (192,'冬雪','skin_snow','',0,0,8);
insert  into `xwb_skins`(`skin_id`,`name`,`directory`,`desc`,`state`,`style_id`,`sort_num`) values (193,'科技','skin_tech','',0,0,9);
insert  into `xwb_skins`(`skin_id`,`name`,`directory`,`desc`,`state`,`style_id`,`sort_num`) values (194,'旅行','skin_tour','',0,0,10);
insert  into `xwb_skins`(`skin_id`,`name`,`directory`,`desc`,`state`,`style_id`,`sort_num`) values (184,'沙滩','skin_beach','',0,0,0);

UNLOCK TABLES;

/*Table structure for table `xwb_subject` */

DROP TABLE IF EXISTS `xwb_subject`;

CREATE TABLE `xwb_subject` (
  `id` int(11) NOT NULL auto_increment,
  `sina_uid` bigint(20) NOT NULL COMMENT 'sina id',
  `subject` varchar(100) NOT NULL default '' COMMENT '话题名称',
  `is_use` tinyint(1) NOT NULL default '1' COMMENT '是否启用，默认启用，如果用户删除该话题订阅，只进行软删除',
  PRIMARY KEY  (`id`),
  KEY `sina_uid` (`sina_uid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户话题收藏记录表，如果用户取消收藏，使用is_use来标记，不删除。';

/*Data for the table `xwb_subject` */

LOCK TABLES `xwb_subject` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_sys_config` */

DROP TABLE IF EXISTS `xwb_sys_config`;

CREATE TABLE `xwb_sys_config` (
  `key` varchar(40) NOT NULL,
  `value` text,
  `group_id` int(10) unsigned NOT NULL default '1' COMMENT '配置的分组ID',
  PRIMARY KEY  (`key`,`group_id`),
  KEY `idx_groupid` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='系统配置信息';

/*Data for the table `xwb_sys_config` */

LOCK TABLES `xwb_sys_config` WRITE;

insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('rewrite_enable','0',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('logo','',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('login_way','1',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('third_code','',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('site_record','',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('address_icon','',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('head_link','{\"1\":{\"link_name\":\"\\u65b0\\u6d6a\\u5fae\\u535a\",\"link_address\":\"http:\\/\\/t.sina.com.cn\\/\"},\"3\":{\"link_name\":\"\\u65b0\\u6d6a\\u7f51\",\"link_address\":\"http:\\/\\/www.sina.com.cn\"}}',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('foot_link','{\"3\":{\"link_name\":\"\\u5e2e\\u52a9\\u4e2d\\u5fc3\",\"link_address\":\"http:\\/\\/x.weibo.com\\/help.php\"}}',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('authen_type','3',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('authen_big_icon','img/logo/big_auth_icon.png',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('authen_small_icon','img/logo/small_auth_icon.png',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('skin_default','188',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('ad_header','',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('guide_auto_follow','0',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('ad_footer','',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('title','Xweibo',2);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('text','Xweibo是新浪微博推出的开源微博系统，提供了丰富的运营手段，帮助广大站长利用新浪微博的平台，架设属于自己网站的微博系统。',2);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('bg_pic','',2);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('oper','1',2);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('topic','xweibo',2);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('link','http://',2);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('btnTitle','了解更多',2);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('guide_auto_follow_id','3',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('authen_small_icon_title','Xweibo认证',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('ad_setting','',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('wb_page_type','2',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('wb_header_model','1',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('wb_header_htmlcode','',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('api_checking','',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('xwb_discuz_url','',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('xwb_discuz_enable','',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('use_person_domain','0',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('site_short_link','',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('microLive_setting','',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('microInterview_setting','',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('default_use_custom','0',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('authen_request_email','unknown@xweibo.com',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('xwb_login_group_id','84',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('sysLoginModel','0',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('celeb_banner','',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('logo_link','1',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('logo_wap','',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('logo_output','',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('open_user_local_relationship','0',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('xwb_strategy','{\"strategy\":0}',1);

UNLOCK TABLES;

/*Table structure for table `xwb_today_topics` */

DROP TABLE IF EXISTS `xwb_today_topics`;

CREATE TABLE `xwb_today_topics` (
  `group_id` int(10) unsigned NOT NULL COMMENT '话题分组ID',
  `topic` varchar(45) NOT NULL COMMENT '话题内容',
  `effect_time` int(10) unsigned NOT NULL COMMENT '生效时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='今日话题的内容';

/*Data for the table `xwb_today_topics` */

LOCK TABLES `xwb_today_topics` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_user_action` */

DROP TABLE IF EXISTS `xwb_user_action`;

CREATE TABLE `xwb_user_action` (
  `id` int(11) NOT NULL auto_increment,
  `sina_uid` bigint(20) NOT NULL,
  `action_type` smallint(6) NOT NULL COMMENT '1、禁言 2、禁止用户登录、3、清除用户信息（不删除、仅是在任何情况不显示） 4、恢复正常',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `sina_uid` (`sina_uid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_user_action` */

LOCK TABLES `xwb_user_action` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_user_ban` */

DROP TABLE IF EXISTS `xwb_user_ban`;

CREATE TABLE `xwb_user_ban` (
  `id` int(11) NOT NULL auto_increment,
  `sina_uid` bigint(20) unsigned NOT NULL COMMENT '新浪用户ID',
  `ban_time` int(11) default NULL COMMENT '封禁时间',
  `nick` varchar(20) default NULL COMMENT '封禁用户的昵称',
  PRIMARY KEY  (`id`),
  KEY `nick` (`nick`),
  KEY `sina_uid` (`sina_uid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='封禁用户列表';

/*Data for the table `xwb_user_ban` */

LOCK TABLES `xwb_user_ban` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_user_config` */

DROP TABLE IF EXISTS `xwb_user_config`;

CREATE TABLE `xwb_user_config` (
  `id` int(4) unsigned NOT NULL auto_increment,
  `sina_uid` bigint(20) unsigned NOT NULL,
  `values` varchar(510) NOT NULL default '0' COMMENT '用户自定义的配置',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `sina_uid` (`sina_uid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_user_config` */

LOCK TABLES `xwb_user_config` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_user_focus` */

DROP TABLE IF EXISTS `xwb_user_focus`;

CREATE TABLE `xwb_user_focus` (
  `id` int(10) NOT NULL,
  `sina_uid` bigint(20) NOT NULL,
  `topic` varchar(45) NOT NULL,
  `source` tinyint(1) default NULL,
  `add_time` date NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `user_focus_uid_index` (`sina_uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='保存用户关注的话题';

/*Data for the table `xwb_user_focus` */

LOCK TABLES `xwb_user_focus` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_user_follow` */

DROP TABLE IF EXISTS `xwb_user_follow`;

CREATE TABLE `xwb_user_follow` (
  `friend_uid` bigint(20) NOT NULL COMMENT '被关注用户ID',
  `fans_uid` bigint(20) NOT NULL COMMENT '粉丝用户ID',
  `datetime` int(10) default NULL COMMENT '时间',
  PRIMARY KEY  (`friend_uid`,`fans_uid`),
  KEY `datetime_idx` (`datetime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='关注表';

/*Data for the table `xwb_user_follow` */

LOCK TABLES `xwb_user_follow` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_user_follow_copy` */

DROP TABLE IF EXISTS `xwb_user_follow_copy`;

CREATE TABLE `xwb_user_follow_copy` (
  `friend_uid` bigint(20) NOT NULL COMMENT '被关注用户ID',
  `fans_uid` bigint(20) NOT NULL COMMENT '粉丝用户ID',
  `datetime` int(10) default NULL COMMENT '时间',
  PRIMARY KEY  (`friend_uid`,`fans_uid`),
  KEY `datetime_idx` (`datetime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xwb_user_follow_copy` */

LOCK TABLES `xwb_user_follow_copy` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_user_verify` */

DROP TABLE IF EXISTS `xwb_user_verify`;

CREATE TABLE `xwb_user_verify` (
  `id` int(11) NOT NULL auto_increment,
  `sina_uid` bigint(20) unsigned NOT NULL COMMENT '新浪用户ID',
  `nick` varchar(45) NOT NULL COMMENT '要加V的用户',
  `reason` varchar(50) default NULL COMMENT '认证理由',
  `add_time` int(10) unsigned default NULL COMMENT '添加认证时间',
  `operator` bigint(20) NOT NULL COMMENT '操作者的ID',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_nick` (`nick`),
  KEY `index_add_time` (`add_time`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_user_verify` */

LOCK TABLES `xwb_user_verify` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_users` */

DROP TABLE IF EXISTS `xwb_users`;

CREATE TABLE `xwb_users` (
  `id` int(11) NOT NULL auto_increment,
  `sina_uid` bigint(20) unsigned NOT NULL COMMENT '新浪用户ID',
  `nickname` varchar(25) NOT NULL COMMENT '昵称',
  `first_login` int(10) unsigned default NULL COMMENT '首次登陆时间',
  `access_token` varchar(50) default NULL COMMENT '授权后得到访问API的token',
  `token_secret` varchar(50) default NULL COMMENT 'API服务器生成的加密串',
  `uid` bigint(20) default NULL COMMENT '所捆绑的合作方的用户ID',
  `domain_name` varchar(45) default NULL COMMENT '用户设置的个性化域名',
  `max_notice_time` int(11) default '0' COMMENT '用户最后一次阅读的起效的最新通知的时间戳',
  `followers_count` int(11) unsigned default NULL COMMENT '用户的粉丝数，每次登陆时更新',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `sina_uid` (`sina_uid`),
  KEY `nickname` (`nickname`),
  KEY `site_uid` (`uid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `xwb_users` */

LOCK TABLES `xwb_users` WRITE;
UNLOCK TABLES;

/*Table structure for table `xwb_weibo_copy` */

DROP TABLE IF EXISTS `xwb_weibo_copy`;

CREATE TABLE `xwb_weibo_copy` (
  `id` bigint(20) unsigned NOT NULL COMMENT '微博id',
  `weibo` tinytext COMMENT '微博内容',
  `uid` bigint(20) unsigned default NULL,
  `nickname` varchar(45) default NULL COMMENT '作者',
  `addtime` int(11) default NULL COMMENT '发布时间',
  `disabled` varchar(1) default NULL COMMENT '是否被屏蔽',
  `pic` varchar(124) default NULL COMMENT '图片url',
  PRIMARY KEY  (`id`),
  KEY `addtime` (`addtime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xwb_weibo_copy` */

LOCK TABLES `xwb_weibo_copy` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_weibo_delete` */

DROP TABLE IF EXISTS `xwb_weibo_delete`;

CREATE TABLE `xwb_weibo_delete` (
  `id` int(4) unsigned NOT NULL auto_increment,
  `weibo` text NOT NULL COMMENT '微博内容',
  `picid` varchar(100) default NULL COMMENT '上传图片的id',
  `sina_uid` bigint(20) NOT NULL COMMENT '发微博的用户id',
  `nickname` varchar(45) default NULL COMMENT '用户昵称',
  `retweeted_status` text COMMENT '转发微博内容',
  `retweeted_wid` bigint(20) default NULL COMMENT '转发微博id',
  `access_token` varchar(50) NOT NULL,
  `token_secret` varchar(50) NOT NULL,
  `dateline` int(10) NOT NULL COMMENT '发布时间',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_weibo_delete` */

LOCK TABLES `xwb_weibo_delete` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_weibo_verify` */

DROP TABLE IF EXISTS `xwb_weibo_verify`;

CREATE TABLE `xwb_weibo_verify` (
  `id` int(4) unsigned NOT NULL auto_increment,
  `weibo` text NOT NULL COMMENT '微博内容',
  `cwid` varchar(50) default NULL COMMENT '要评论的微博id',
  `picid` varchar(100) default NULL COMMENT '上传图片的id',
  `sina_uid` bigint(20) NOT NULL COMMENT '发微博的用户id',
  `nickname` varchar(45) default NULL COMMENT '用户昵称',
  `retweeted_status` text COMMENT '转发微博内容',
  `retweeted_wid` bigint(20) default NULL COMMENT '转发微博id',
  `access_token` varchar(50) NOT NULL,
  `token_secret` varchar(50) NOT NULL,
  `type` varchar(20) default NULL COMMENT '类型,"live"微直播',
  `extend_id` int(4) default NULL COMMENT '扩展id',
  `extend_data` varchar(200) default NULL COMMENT '扩展数据',
  `dateline` int(10) NOT NULL COMMENT '发布时间',
  PRIMARY KEY  (`id`),
  KEY `type` (`type`),
  KEY `sina_uid` (`sina_uid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_weibo_verify` */

LOCK TABLES `xwb_weibo_verify` WRITE;

UNLOCK TABLES;
