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
  `content` text COMMENT '廣告內容',
  `using` varchar(1) default '1' COMMENT '是否應用',
  `add_time` int(10) unsigned default NULL COMMENT '添加時間',
  `name` varchar(45) default NULL COMMENT '廣告位名稱',
  `description` text COMMENT '廣告位描述',
  `page` varchar(45) default NULL COMMENT '頁面Action',
  `flag` varchar(45) default NULL,
  `config` text COMMENT '廣告配置',
  `width` int(11) default '0' COMMENT '廣告容器寬度',
  `height` int(11) default '0' COMMENT '廣告容器高度',
  `remarks` text COMMENT '廣告使用方法描述',
  PRIMARY KEY  (`id`),
  KEY `index_using` (`using`,`page`,`flag`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='廣告';

/*Data for the table `xwb_ad` */

LOCK TABLES `xwb_ad` WRITE;

insert  into `xwb_ad`(`id`,`content`,`using`,`add_time`,`name`,`description`,`page`,`flag`,`config`,`width`,`height`,`remarks`) values (1,'','1',1313994963,'頁尾廣告','全站','global','global_footer','',0,0,'建議大小，兩欄800px *70px，三欄為960px*70px');
insert  into `xwb_ad`(`id`,`content`,`using`,`add_time`,`name`,`description`,`page`,`flag`,`config`,`width`,`height`,`remarks`) values (2,'','0',1313994969,'頁頭廣告','全站','global','global_header','',0,0,'建議大小，兩欄570px *70px，三欄為720px*70px');
insert  into `xwb_ad`(`id`,`content`,`using`,`add_time`,`name`,`description`,`page`,`flag`,`config`,`width`,`height`,`remarks`) values (3,'','0',1313994973,'右側banner','全站','global','sidebar','',0,0,'建議大小，180px*任意高度');

UNLOCK TABLES;

/*Table structure for table `xwb_admin` */

DROP TABLE IF EXISTS `xwb_admin`;

CREATE TABLE `xwb_admin` (
  `id` int(11) NOT NULL auto_increment,
  `sina_uid` bigint(20) unsigned NOT NULL COMMENT '新浪用戶ID',
  `pwd` varchar(32) default NULL,
  `add_time` int(10) unsigned default NULL COMMENT '加入的時間',
  `is_root` tinyint(1) NOT NULL default '0' COMMENT '是否擁有帳號管理權限 1.擁有 0.不擁有',
  `group_id` int(11) default NULL COMMENT '用戶所屬組',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `xwb_admin` */

LOCK TABLES `xwb_admin` WRITE;
UNLOCK TABLES;

/*Table structure for table `xwb_admin_group` */

DROP TABLE IF EXISTS `xwb_admin_group`;

CREATE TABLE `xwb_admin_group` (
  `gid` int(11) NOT NULL,
  `group_name` varchar(45) default NULL COMMENT '組名',
  `permissions` text COMMENT '許可權',
  `description` varchar(45) default NULL,
  PRIMARY KEY  (`gid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xwb_admin_group` */

LOCK TABLES `xwb_admin_group` WRITE;

insert  into `xwb_admin_group`(`gid`,`group_name`,`permissions`,`description`) values (1,'超級管理員','^mgr/','');
insert  into `xwb_admin_group`(`gid`,`group_name`,`permissions`,`description`) values (2,'管理員','^((?!mgr/setting\\.|mgr/connection|mgr/admin\\.del|mgr/admin\\.userlist|mgr/admin.add|mgr/admin.search|mgr/backup\\.).)*$','');
insert  into `xwb_admin_group`(`gid`,`group_name`,`permissions`,`description`) values (3,'運營維護','mgr/admin\\.login,mgr/admin\\.logout,mgr/admin\\.index,mgr/admin\\.map,mgr/admin\\.default_page,mgr/admin\\.repassword,mgr/weibo/disableComment,mgr/weibo/disableWeibo,mgr/weibo/keyword,mgr/weibo/weiboCopy,mgr/users\\.,mgr/user_verify\\.,mgr/celeb_mgr\\.,mgr/user_recommend\\.','');

UNLOCK TABLES;
/*Table structure for table `xwb_celeb` */

DROP TABLE IF EXISTS `xwb_celeb`;

CREATE TABLE `xwb_celeb` (
  `c_id1` int(11) default NULL COMMENT '一級分類ID',
  `c_id2` int(11) default NULL COMMENT '二級分類ID',
  `char_index` tinyint(2) default NULL COMMENT '字母索引 1-26對應A-Z, 0為其他',
  `sina_uid` bigint(20) default NULL COMMENT 'sina用戶ID',
  `nick` varchar(100) default NULL COMMENT 'sina用戶昵稱',
  `face` varchar(200) NOT NULL COMMENT '頭像地址',
  `verified` tinyint(1) NOT NULL default '0' COMMENT '是否為官方認證用戶 0.不是 1.是',
  `sort` int(11) default NULL COMMENT '排序值，小的在前',
  `add_time` int(11) default NULL COMMENT '添加時間',
  `id` int(11) unsigned NOT NULL auto_increment,
  PRIMARY KEY  (`id`),
  KEY `c_id1` (`c_id1`,`c_id2`,`sort`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='名人堂推薦用戶表';

/*Data for the table `xwb_celeb` */

LOCK TABLES `xwb_celeb` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_celeb_category` */

DROP TABLE IF EXISTS `xwb_celeb_category`;

CREATE TABLE `xwb_celeb_category` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `parent_id` int(11) default NULL COMMENT '父ID,如果是0，則為一級分類',
  `name` varchar(50) default NULL COMMENT '分類名稱',
  `sort` int(11) default NULL COMMENT '排序，數字小的在前',
  `add_time` int(11) default NULL COMMENT '增加時間',
  `status` tinyint(3) unsigned NOT NULL default '1' COMMENT '1:啟用',
  `recommended` tinyint(3) unsigned NOT NULL default '1' COMMENT '1:推薦',
  `color` varchar(45) default NULL COMMENT '二級導航的顯示顏色',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='名人堂用戶分類';

/*Data for the table `xwb_celeb_category` */

LOCK TABLES `xwb_celeb_category` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_comment_copy` */

DROP TABLE IF EXISTS `xwb_comment_copy`;

CREATE TABLE `xwb_comment_copy` (
  `cid` bigint(20) unsigned NOT NULL COMMENT '評論ID',
  `sina_uid` bigint(20) unsigned NOT NULL COMMENT '發評論者的新浪UID',
  `uid` bigint(20) default NULL COMMENT '發評論的ID',
  `mid` bigint(20) unsigned NOT NULL COMMENT '微博ID',
  `m_uid` bigint(20) unsigned NOT NULL COMMENT '發微博的UID',
  `reply_cid` bigint(20) unsigned NOT NULL default '0' COMMENT '被回復的評論ID',
  `reply_uid` bigint(20) unsigned NOT NULL default '0' COMMENT '被回復者的ID',
  `content` varchar(140) character set utf8 NOT NULL COMMENT '評論內容',
  `source` varchar(80) collate utf8_bin default NULL COMMENT '內容來源',
  `post_ip` varchar(50) collate utf8_bin default NULL COMMENT '發佈者IP',
  `dateline` int(11) unsigned NOT NULL COMMENT '評論時間',
  `sina_nick` varchar(45) collate utf8_bin default NULL COMMENT '發佈者新浪的昵稱',
  `disabled` varchar(1) collate utf8_bin NOT NULL default '0' COMMENT '是否遮罩',
  PRIMARY KEY  (`cid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `xwb_comment_copy` */

LOCK TABLES `xwb_comment_copy` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_comment_delete` */

DROP TABLE IF EXISTS `xwb_comment_delete`;

CREATE TABLE `xwb_comment_delete` (
  `id` bigint(20) unsigned NOT NULL COMMENT '評論ID',
  `sina_uid` bigint(20) unsigned NOT NULL COMMENT '發評論者的新浪UID',
  `sina_nick` varchar(45) collate utf8_bin default NULL COMMENT '發佈者新浪的昵稱',
  `mid` bigint(20) unsigned NOT NULL COMMENT '微博ID',
  `reply_cid` bigint(20) unsigned NOT NULL default '0' COMMENT '被回復的評論ID',
  `content` varchar(140) character set utf8 NOT NULL COMMENT '評論內容',
  `post_ip` varchar(50) collate utf8_bin default NULL COMMENT '發佈者IP',
  `dateline` int(10) unsigned NOT NULL COMMENT '評論時間',
  `add_time` int(11) unsigned NOT NULL COMMENT '增加時間',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `xwb_comment_delete` */

LOCK TABLES `xwb_comment_delete` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_comment_verify` */

DROP TABLE IF EXISTS `xwb_comment_verify`;

CREATE TABLE `xwb_comment_verify` (
  `id` bigint(20) unsigned NOT NULL auto_increment COMMENT '評論ID',
  `sina_uid` bigint(20) unsigned NOT NULL COMMENT '發評論者的新浪UID',
  `sina_nick` varchar(45) collate utf8_bin default NULL COMMENT '發佈者新浪的昵稱',
  `token` varchar(45) collate utf8_bin NOT NULL COMMENT '發佈者的token',
  `token_secret` varchar(45) collate utf8_bin NOT NULL COMMENT '發佈者的token_secret',
  `mid` bigint(20) unsigned NOT NULL COMMENT '微博ID',
  `reply_cid` bigint(20) unsigned NOT NULL default '0' COMMENT '被回復的評論ID',
  `content` varchar(140) character set utf8 NOT NULL COMMENT '評論內容',
  `post_ip` varchar(50) collate utf8_bin default NULL COMMENT '發佈者IP',
  `dateline` int(11) unsigned NOT NULL COMMENT '用戶評論時間',
  `forward` varchar(1) collate utf8_bin default NULL COMMENT '是否作為一條新微博發佈',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `xwb_comment_verify` */

LOCK TABLES `xwb_comment_verify` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_component_cfg` */

DROP TABLE IF EXISTS `xwb_component_cfg`;

CREATE TABLE `xwb_component_cfg` (
  `component_id` int(10) unsigned NOT NULL,
  `cfgName` varchar(30) NOT NULL COMMENT '參數名稱',
  `cfgValue` varchar(255) default NULL COMMENT '參數值',
  `desc` varchar(50) default NULL COMMENT '配置項說明',
  PRIMARY KEY  (`component_id`,`cfgName`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='組件對應的配置';

/*Data for the table `xwb_component_cfg` */

LOCK TABLES `xwb_component_cfg` WRITE;

insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (1,'show_num','5','組件顯示的微博數');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (2,'group_id','1','名人推薦用戶組對應的用戶列表ID');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (2,'show_num','3','顯示的名人數');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (3,'show_num','9','');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (3,'group_id','2','推薦用戶組使用的用戶列表ID');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (4,'group_id','3','人氣關注榜的數據來源，0 使用新浪API >0　對應的用戶組');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (10,'show_num','10','今日話題顯示的微博數');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (10,'group_id','1','今日話題使用的話題組');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (11,'groups','{\"1\":\"\\u660e\\u661f\",\"2\":\"\\u8349\\u6839\"}','');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (9,'show_num','4','隨便看看');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (5,'list_id','54355137','list id');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (5,'show_num','4','');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (4,'show_num','5','人氣關注榜掛件人數');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (6,'show_num','10','');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (6,'topic_id','0','0 使用新浪API取數據　> 0 對應的話題組ID');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (7,'show_num','9','');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (8,'show_num','3','');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (2,'topic_id','0','0 使用新浪API取數據　> 0 對應的話題組ID');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (10,'source','1','0 使用全局數據 >0 使用本站數據');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (9,'source','0','0 使用全局數據 >0 使用本站數據');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (1,'source','1','0 使用全局數據 >0 使用本站數據');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (8,'source','1','0 使用全局數據 >0 使用本站數據');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (12,'topic','微小說','話題微薄的默認話題');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (12,'show_num','6','顯示微博數');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (12,'source','1','微博來源');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (17,'show_num','5','組件顯示的微博數');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (17,'source','0','0 使用全局數據 >0 使用本站數據');
insert  into `xwb_component_cfg`(`component_id`,`cfgName`,`cfgValue`,`desc`) values (18,'show_num','3','');

UNLOCK TABLES;

/*Table structure for table `xwb_component_topic` */

DROP TABLE IF EXISTS `xwb_component_topic`;

CREATE TABLE `xwb_component_topic` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `topic_id` int(10) unsigned NOT NULL,
  `topic` varchar(50) NOT NULL COMMENT '話題',
  `date_time` int(10) unsigned NOT NULL COMMENT '生效時間或添加時間',
  `sort_num` int(10) unsigned NOT NULL default '0' COMMENT '排序',
  `ext1` varchar(45) default NULL COMMENT '擴展字段',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='熱門話題列表';

/*Data for the table `xwb_component_topic` */

LOCK TABLES `xwb_component_topic` WRITE;

insert  into `xwb_component_topic`(`id`,`topic_id`,`topic`,`date_time`,`sort_num`,`ext1`) values (26,2,'Xweibo',1303107194,0,'1303107120');

UNLOCK TABLES;

/*Table structure for table `xwb_component_topiclist` */

DROP TABLE IF EXISTS `xwb_component_topiclist`;

CREATE TABLE `xwb_component_topiclist` (
  `topic_id` int(10) unsigned NOT NULL auto_increment COMMENT '話題ID',
  `topic_name` varchar(25) NOT NULL COMMENT '話題列表的名稱',
  `native` tinyint(1) NOT NULL default '0' COMMENT '是否為內置話題，內置不能刪除',
  `sort` varchar(1) NOT NULL default '1' COMMENT '類別下的話題是否允許排序',
  `app_with` text,
  `type` tinyint(4) NOT NULL default '0' COMMENT '話題分組類型',
  PRIMARY KEY  (`topic_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_component_topiclist` */

LOCK TABLES `xwb_component_topiclist` WRITE;

insert  into `xwb_component_topiclist`(`topic_id`,`topic_name`,`native`,`sort`,`app_with`,`type`) values (1,'推薦話題',1,'1','6,7,11',0);
insert  into `xwb_component_topiclist`(`topic_id`,`topic_name`,`native`,`sort`,`app_with`,`type`) values (2,'今日話題',1,'0','2,5',2);

UNLOCK TABLES;

/*Table structure for table `xwb_component_usergroups` */

DROP TABLE IF EXISTS `xwb_component_usergroups`;

CREATE TABLE `xwb_component_usergroups` (
  `group_id` int(10) unsigned NOT NULL auto_increment COMMENT '分組ID',
  `group_name` varchar(15) NOT NULL COMMENT '組名稱',
  `native` tinyint(1) NOT NULL default '0' COMMENT '是否為內置列表 1:是 0:否',
  `related_id` varchar(50) default NULL COMMENT '組件應用情況，即哪位ID的組件使用了，可為多個，逗號分隔',
  `type` tinyint(1) unsigned NOT NULL default '0' COMMENT '分組類型，0:普通分組, 4:官方微博分組',
  PRIMARY KEY  (`group_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='推薦用戶　的各個分組';

/*Data for the table `xwb_component_usergroups` */

LOCK TABLES `xwb_component_usergroups` WRITE;

insert  into `xwb_component_usergroups`(`group_id`,`group_name`,`native`,`related_id`,`type`) values (1,'第一次登入自動關注',1,'11:1,11:1',0);
insert  into `xwb_component_usergroups`(`group_id`,`group_name`,`native`,`related_id`,`type`) values (84,'首頁用戶推薦(他們在微博)',1,NULL,0);

UNLOCK TABLES;

/*Table structure for table `xwb_component_users` */

DROP TABLE IF EXISTS `xwb_component_users`;

CREATE TABLE `xwb_component_users` (
  `group_id` int(10) unsigned default NULL COMMENT '唯一、自增的用戶分組ID',
  `uid` bigint(20) unsigned NOT NULL COMMENT '用戶ID',
  `sort_num` int(11) NOT NULL default '0' COMMENT '排序',
  `nickname` varchar(20) default NULL COMMENT '用戶昵稱',
  `remark` varchar(255) default NULL COMMENT '備註',
  `id` int(10) unsigned NOT NULL auto_increment,
  PRIMARY KEY  (`id`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用戶列表成員表';

/*Data for the table `xwb_component_users` */

LOCK TABLES `xwb_component_users` WRITE;
INSERT INTO `xwb_component_users` (`group_id`,`uid`,`nickname`,`remark`,`sort_num`) VALUES("84","1904178193","微博开放平台","新浪微博API官方帳號","1");
INSERT INTO `xwb_component_users` (`group_id`,`uid`,`nickname`,`remark`,`sort_num`) VALUES("84","1662047260","SinaAppEngine","新浪SAE服務官方帳號","2");
INSERT INTO `xwb_component_users` (`group_id`,`uid`,`nickname`,`remark`,`sort_num`) VALUES("84","1076590735","xweibo官方","xweibo官方微博","3");
UNLOCK TABLES;

/*Table structure for table `xwb_components` */

DROP TABLE IF EXISTS `xwb_components`;

CREATE TABLE `xwb_components` (
  `component_id` int(10) unsigned NOT NULL auto_increment COMMENT '唯一、自增ID',
  `name` varchar(20) NOT NULL COMMENT '組件名稱',
  `title` varchar(45) default NULL COMMENT '用於顯示的名稱',
  `type` tinyint(4) default NULL COMMENT '組件類型　0表示一個頁面只有一個，>0表示一個頁面可以有多個',
  `native` tinyint(1) NOT NULL default '1' COMMENT '是否為內置類型',
  `component_type` tinyint(4) NOT NULL COMMENT '組件類型 1: 頁面主體 2: 側邊欄',
  `symbol` varchar(20) NOT NULL COMMENT '模組標識，程式中使用',
  `desc` varchar(255) default NULL COMMENT '模組說明',
  `preview_img` varchar(255) default NULL COMMENT '預覽圖片',
  `component_cty` varchar(16) default NULL COMMENT '組件分類:array(''user'' => ''用戶'', ''wb'' => ''微博'', ''topic'' => ''話題'', ''others'' => ''其他'')',
  PRIMARY KEY  (`component_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `xwb_components` */

LOCK TABLES `xwb_components` WRITE;

insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (1,'熱門轉發與評論','熱門轉發與評論',0,1,1,'hotWb','當天轉發最多的微博列表（倒序排列）','','wb');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (2,'用戶組','用戶組',2,1,1,'starRcm','一組用戶的列表','','user');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (3,'推薦用戶','推薦用戶',3,1,2,'userRcm','指定某些用戶的列表（右邊欄）','','user');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (5,'自定義微博列表','自定義微博列表',5,1,1,'official','某些指定用戶發佈的微博列表','','wb');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (6,'話題推薦列表','話題推薦列表',6,1,2,'hotTopic','一組話題列表','','others');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (7,'可能感興趣的人','可能感興趣的人',0,1,2,'guessYouLike','根據當前用戶的IP、個人資料推薦相關聯的用戶列表','','user');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (8,'同城微博','同城微博',0,1,1,'cityWb','根據當前用戶的IP地址判斷地區，並展示該地區用戶的微博列表','','wb');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (9,'隨便看看','隨便看看',0,1,1,'looklook','一段特點時間內發佈的（一般為最新）的微博列表，隨機展現','','wb');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (10,'今日話題','今日話題',0,1,1,'todayTopic','自動獲取與今日話題相關的微博消息。話題可以在“運營管理-話題推薦管理”中設置','','others');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (20,'專題介紹','專題介紹',10,1,1,'topicDesc','專題介紹',NULL,'topic');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (12,'話題微博','話題微博',12,1,1,'topicWb','當前設定話題的相關微博列表','','wb');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (15,'最新用戶','最新用戶',0,1,2,'newestWbUser','本站最新開通微博的用戶列表','','user');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (14,'最新微博','最新微博',15,1,1,'newestWb','當前站點最新發佈的微博列表','','wb');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (13,'專題banner圖','專題banner圖',13,1,1,'pageImg','在頁面中添加一個寬度為560px的banner圖片','','others');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (16,'微博發佈框','微博發佈框',0,1,1,'sendWb','微博發佈框','','others');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (21,'專題發佈框','專題發佈框',1,1,1,'topicPub','專題發佈框',NULL,'topic');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (19,'本地關注榜','本地關注榜',0,1,2,'localFollowTop','本地關注榜','','user');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (18,'活動列表','活動列表',0,1,2,'eventList','活動列表','','others');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (22,'專題介紹','專題介紹',10,1,2,'topicDesc','專題介紹',NULL,'topic');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (23,'相關視頻','相關視頻',10,1,2,'topicVideo','相關視頻',NULL,'topic');

UNLOCK TABLES;

/*Table structure for table `xwb_content_unit` */

DROP TABLE IF EXISTS `xwb_content_unit`;

CREATE TABLE `xwb_content_unit` (
  `id` int(4) NOT NULL auto_increment,
  `unit_name` varchar(40) default NULL COMMENT '輸出單元的名稱',
  `title` varchar(40) default NULL COMMENT '輸出單元的標題，暫時只用於群組微博',
  `width` int(4) default NULL COMMENT '輸出單元的寬度',
  `height` int(4) default NULL COMMENT '輸出單元的高度',
  `target` varchar(40) default NULL COMMENT '輸出單元內容的來源對象',
  `type` int(4) default '1' COMMENT '輸出單元的類型，默認是1.1是微博秀, 2是推薦用戶列表, 3是互動話題，4是一鍵關注，5是群組微博',
  `skin` int(4) default '1' COMMENT '輸出單元的樣式皮膚,默認是1',
  `colors` int(4) default NULL COMMENT '輸出單元的自定義樣式',
  `show_title` tinyint(3) default '1' COMMENT '是否顯示標題,默認是1, 1是顯示, 0是不顯示',
  `show_border` tinyint(3) default '1' COMMENT '是否顯示邊框,默認是1, 1是顯示, 0是不顯示',
  `show_logo` tinyint(3) default '1' COMMENT '是否顯示logo,默認是1, 1是顯示, 0是不顯示',
  `show_publish` tinyint(3) default '0' COMMENT '是否顯示發佈框，默認是0, 1是顯示，0是不顯示',
  `auto_scroll` tinyint(3) default '0' COMMENT '是否自動滾動，默認是0, 1是自動滾動，0不是自動滾動',
  `add_time` int(10) default NULL COMMENT '添加時間',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='內容輸出單元';

/*Data for the table `xwb_content_unit` */

LOCK TABLES `xwb_content_unit` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_disable_items` */

DROP TABLE IF EXISTS `xwb_disable_items`;

CREATE TABLE `xwb_disable_items` (
  `kw_id` int(10) unsigned NOT NULL auto_increment COMMENT '唯一、自增ID',
  `type` tinyint(4) NOT NULL COMMENT '內容類型：１微博ID　２評論ID　３昵稱　４內容',
  `item` varchar(45) NOT NULL COMMENT '遮罩或禁止的ID或內容',
  `comment` varchar(60) NOT NULL COMMENT '相關顯示內容',
  `admin_name` varchar(24) NOT NULL COMMENT '管理員操作時的昵稱',
  `admin_id` int(10) unsigned NOT NULL COMMENT '管理員ID',
  `user` varchar(45) NOT NULL COMMENT '微博或評論的作者',
  `publish_time` varchar(20) NOT NULL COMMENT '微博或評論的發佈時間yyyy-mm-dd hh:ii:ss格式字串',
  `add_time` int(10) unsigned NOT NULL COMMENT '加入時間',
  PRIMARY KEY  (`kw_id`),
  UNIQUE KEY `Index_type_item` (`type`,`item`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='遮罩或禁止的內容列表';

/*Data for the table `xwb_disable_items` */

LOCK TABLES `xwb_disable_items` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_event_comment` */

DROP TABLE IF EXISTS `xwb_event_comment`;

CREATE TABLE `xwb_event_comment` (
  `event_id` int(4) unsigned NOT NULL COMMENT '活動id',
  `wb_id` bigint(20) NOT NULL COMMENT '微博id',
  `weibo` text COMMENT '微博內容',
  `comment_time` int(10) default NULL COMMENT '評論時間',
  PRIMARY KEY  (`event_id`,`wb_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `xwb_event_comment` */

LOCK TABLES `xwb_event_comment` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_event_join` */

DROP TABLE IF EXISTS `xwb_event_join`;

CREATE TABLE `xwb_event_join` (
  `sina_uid` bigint(20) NOT NULL COMMENT 'SINA　UID',
  `event_id` int(11) NOT NULL COMMENT '活動ID',
  `contact` varchar(200) default NULL COMMENT '聯繫方式',
  `notes` text COMMENT '備註',
  `join_time` int(11) default NULL COMMENT '參與時間',
  PRIMARY KEY  (`sina_uid`,`event_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='活動參與表';

/*Data for the table `xwb_event_join` */

LOCK TABLES `xwb_event_join` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_events` */

DROP TABLE IF EXISTS `xwb_events`;

CREATE TABLE `xwb_events` (
  `id` int(11) unsigned NOT NULL auto_increment COMMENT '自增ID',
  `title` varchar(200) default NULL COMMENT '標題',
  `addr` varchar(200) default NULL COMMENT '地址',
  `desc` text COMMENT '簡介',
  `cost` float default NULL COMMENT '費用',
  `sina_uid` bigint(20) default NULL COMMENT '發起人ID',
  `nickname` varchar(25) NOT NULL COMMENT '發起人昵稱',
  `realname` varchar(25) default NULL COMMENT '真實姓名',
  `phone` varchar(20) default NULL COMMENT '聯繫電話',
  `start_time` int(11) default NULL COMMENT '開始時間',
  `end_time` int(11) default NULL COMMENT '結束時間',
  `pic` varchar(200) default NULL COMMENT '圖片',
  `wb_id` bigint(20) default NULL COMMENT '微博ID',
  `join_num` int(11) default NULL COMMENT '參與人數',
  `view_num` int(11) default NULL COMMENT '查看次數',
  `comment_num` int(11) default NULL COMMENT '評論數',
  `state` tinyint(2) default '1' COMMENT '活動狀態：1正常，2用戶關閉，3，管理員封禁，4是推薦',
  `other` tinyint(2) default '1' COMMENT '是否要求參加填寫聯繫方式和備註：1是不用，2是要求',
  `modify_time` int(11) default NULL COMMENT '修改時間',
  `add_time` int(11) default NULL COMMENT '發起時間',
  `add_ip` varchar(30) default NULL COMMENT '發起人所在地IP',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='活動主表';

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
  `ask_id` bigint(20) unsigned NOT NULL COMMENT '提問微博ID',
  `answer_wb` bigint(20) unsigned NOT NULL default '0' COMMENT '第一條回答的微博ID;如果是點評的,ask_id=answer_wb',
  `interview_id` int(10) unsigned NOT NULL COMMENT '微訪談節目標識',
  `state` char(1) NOT NULL COMMENT 'P:待審;A:審核通過;刪除為物理刪除;主持人和嘉賓的微博不需要審核',
  `ask_uid` bigint(20) unsigned NOT NULL COMMENT '提問者uid',
  `answer_uid` bigint(20) unsigned default NULL COMMENT '第一個回答者uid',
  `weibo` text COMMENT 'json結構的微博內容',
  `answer_weibo` text COMMENT 'json結構的微博內容',
  PRIMARY KEY  (`ask_id`),
  KEY `interview_index` (`interview_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xwb_interview_wb` */

LOCK TABLES `xwb_interview_wb` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_interview_wb_atme` */

DROP TABLE IF EXISTS `xwb_interview_wb_atme`;

CREATE TABLE `xwb_interview_wb_atme` (
  `interview_id` int(10) NOT NULL COMMENT '微訪談節目ID',
  `ask_id` bigint(20) NOT NULL COMMENT '用戶提問微博ID',
  `at_uid` bigint(20) NOT NULL COMMENT '提問嘉賓UID',
  `answer_wb` bigint(20) NOT NULL default '0' COMMENT '回答的微博ID',
  `weibo` text COMMENT 'json結構後的微博內容',
  PRIMARY KEY  (`interview_id`,`ask_id`,`at_uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `xwb_interview_wb_atme` */

LOCK TABLES `xwb_interview_wb_atme` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_item_groups` */

DROP TABLE IF EXISTS `xwb_item_groups`;

CREATE TABLE `xwb_item_groups` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `group_id` int(10) unsigned NOT NULL COMMENT '分組ID 已定義的，1：分類用戶推薦 2：引導關注類別',
  `item_id` int(11) NOT NULL COMMENT '分組對象的ID',
  `item_name` varchar(25) default NULL COMMENT '分組名稱',
  `sort_num` int(11) default '0' COMMENT '排序ID，通常用於組內',
  PRIMARY KEY  (`id`),
  KEY `group_idx` (`group_id`,`sort_num`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用於存儲ID分組列表，如用戶分類';

/*Data for the table `xwb_item_groups` */

LOCK TABLES `xwb_item_groups` WRITE;
INSERT INTO `xwb_item_groups` VALUES (1,2,84,'首次登入引導關注',0);

UNLOCK TABLES;

/*Table structure for table `xwb_keep_userdomain` */

DROP TABLE IF EXISTS `xwb_keep_userdomain`;

CREATE TABLE `xwb_keep_userdomain` (
  `keep_domain` varchar(45) NOT NULL,
  PRIMARY KEY  (`keep_domain`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='保留一些個性功能變數名稱';

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
  `id` int(10) unsigned NOT NULL auto_increment COMMENT '標識ID',
  `soft` varchar(45) NOT NULL COMMENT '軟體名稱',
  `version` varchar(10) NOT NULL COMMENT '版本',
  `akey` varchar(45) NOT NULL COMMENT 'app key',
  `type` varchar(10) NOT NULL COMMENT '日誌類型，IO/DB/CACHE/API',
  `level` varchar(10) NOT NULL COMMENT '日誌等級 ,error、warning',
  `msg` varchar(500) NOT NULL COMMENT '日誌資訊',
  `extra` varchar(500) default NULL COMMENT '擴展資訊',
  `log_time` datetime NOT NULL COMMENT '記錄時間',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_log_error` */

LOCK TABLES `xwb_log_error` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_log_error_api` */

DROP TABLE IF EXISTS `xwb_log_error_api`;

CREATE TABLE `xwb_log_error_api` (
  `id` int(10) unsigned NOT NULL auto_increment COMMENT '標識ID',
  `soft` varchar(45) NOT NULL COMMENT '軟體名稱',
  `version` varchar(10) NOT NULL COMMENT '版本',
  `akey` varchar(45) NOT NULL COMMENT 'app key',
  `type` varchar(10) NOT NULL COMMENT '日誌類型，IO/DB/CACHE/API',
  `level` varchar(10) NOT NULL COMMENT '日誌等級 ,error、warning',
  `msg` varchar(500) NOT NULL COMMENT '日誌資訊',
  `extra` varchar(500) default NULL COMMENT '擴展資訊',
  `log_time` datetime NOT NULL COMMENT '記錄時間',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_log_error_api` */

LOCK TABLES `xwb_log_error_api` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_log_http` */

DROP TABLE IF EXISTS `xwb_log_http`;

CREATE TABLE `xwb_log_http` (
  `id` int(4) unsigned NOT NULL auto_increment,
  `url` varchar(500) default NULL COMMENT '請求url',
  `base_string` varchar(500) NOT NULL default '' COMMENT '加密的base_string',
  `key_string` varchar(500) NOT NULL default '' COMMENT '加密的key_string',
  `http_code` int(4) default NULL COMMENT 'http code',
  `ret` varchar(200) NOT NULL default '' COMMENT '返回結果',
  `post_data` text COMMENT 'post數據',
  `request_time` float default NULL COMMENT '請求時間',
  `total_time` float default NULL COMMENT '總執行時間',
  `s_ip` char(15) default NULL COMMENT '伺服器ip',
  `log_time` char(20) default NULL COMMENT '記錄時間',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_log_http` */

LOCK TABLES `xwb_log_http` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_log_info` */

DROP TABLE IF EXISTS `xwb_log_info`;

CREATE TABLE `xwb_log_info` (
  `id` int(10) unsigned NOT NULL auto_increment COMMENT '標識ID',
  `soft` varchar(45) NOT NULL COMMENT '軟體名稱',
  `version` varchar(10) NOT NULL COMMENT '版本',
  `akey` varchar(45) NOT NULL COMMENT 'app key',
  `type` varchar(10) NOT NULL COMMENT '日誌類型，IO/DB/CACHE/API',
  `level` varchar(10) NOT NULL COMMENT '日誌等級 ,error、warning',
  `msg` varchar(500) NOT NULL COMMENT '日誌資訊',
  `extra` varchar(500) default NULL COMMENT '擴展資訊',
  `log_time` datetime NOT NULL COMMENT '記錄時間',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_log_info` */

LOCK TABLES `xwb_log_info` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_log_info_api` */

DROP TABLE IF EXISTS `xwb_log_info_api`;

CREATE TABLE `xwb_log_info_api` (
  `id` int(10) unsigned NOT NULL auto_increment COMMENT '標識ID',
  `soft` varchar(45) NOT NULL COMMENT '軟體名稱',
  `version` varchar(10) NOT NULL COMMENT '版本',
  `akey` varchar(45) NOT NULL COMMENT 'app key',
  `type` varchar(10) NOT NULL COMMENT '日誌類型，IO/DB/CACHE/API',
  `level` varchar(10) NOT NULL COMMENT '日誌等級 ,error、warning',
  `msg` varchar(500) NOT NULL COMMENT '日誌資訊',
  `extra` varchar(500) default NULL COMMENT '擴展資訊',
  `log_time` datetime NOT NULL COMMENT '記錄時間',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_log_info_api` */

LOCK TABLES `xwb_log_info_api` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_micro_interview` */

DROP TABLE IF EXISTS `xwb_micro_interview`;

CREATE TABLE `xwb_micro_interview` (
  `id` int(10) NOT NULL auto_increment COMMENT '標識',
  `title` varchar(200) NOT NULL COMMENT '標題',
  `desc` text NOT NULL COMMENT '說明',
  `banner_img` varchar(200) NOT NULL COMMENT 'Banner圖片',
  `cover_img` varchar(200) NOT NULL COMMENT '封面圖片',
  `state` char(1) NOT NULL default 'N' COMMENT '默認N;X:已刪;',
  `wb_state` char(1) NOT NULL default 'A' COMMENT 'P:先審後發;A:直接發佈',
  `master` varchar(200) default NULL COMMENT '主持人新浪uid列表，json結構保存',
  `guest` text COMMENT '嘉賓新浪uid列表，json結構保存',
  `backgroup_img` varchar(200) default NULL COMMENT '背景圖片',
  `backgroup_color` varchar(20) default NULL COMMENT '外觀顏色',
  `start_time` int(11) NOT NULL COMMENT '開始時間',
  `end_time` int(11) NOT NULL COMMENT '結束時間',
  `add_time` int(11) NOT NULL COMMENT '添加時間',
  `backgroup_style` tinyint(2) unsigned default NULL COMMENT '背景圖方式,默認是1,1是平鋪，2是居中',
  `custom_color` varchar(20) default NULL COMMENT '自定義顏色',
  `notice_time` int(10) unsigned default NULL COMMENT '提醒時間，以秒為單位',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_micro_interview` */

LOCK TABLES `xwb_micro_interview` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_micro_live` */

DROP TABLE IF EXISTS `xwb_micro_live`;

CREATE TABLE `xwb_micro_live` (
  `id` int(11) unsigned NOT NULL auto_increment COMMENT '自增ID',
  `title` varchar(200) NOT NULL COMMENT '標題',
  `trends` varchar(200) NOT NULL COMMENT '微直播的話題',
  `desc` text NOT NULL COMMENT '簡介',
  `code` text COMMENT '直播視頻代碼',
  `start_time` int(11) NOT NULL COMMENT '開始時間',
  `end_time` int(11) NOT NULL COMMENT '結束時間',
  `master` varchar(200) NOT NULL COMMENT '主持人，json格式保存',
  `guest` text NOT NULL COMMENT '嘉賓，json格式保存',
  `banner_img` varchar(200) default NULL COMMENT '微直播的banner',
  `cover_img` varchar(200) default NULL COMMENT '封面圖',
  `backgroup_img` varchar(200) default NULL COMMENT '背景圖',
  `backgroup_style` tinyint(2) default NULL COMMENT '背景圖方式，默認是1，1是平鋪，2是居中',
  `backgroup_color` varchar(20) default NULL COMMENT '外觀樣式',
  `custom_color` varchar(20) default NULL COMMENT '自定義顏色',
  `state` char(1) NOT NULL default 'N' COMMENT '默認N，X:已刪',
  `wb_state` char(1) NOT NULL default 'A' COMMENT 'P:先審後發;A:直接發佈',
  `notice_time` int(11) default NULL COMMENT '提醒時間',
  `add_time` int(11) default NULL COMMENT '發起時間',
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
  `weibo` text COMMENT '微博內容',
  `type` tinyint(2) NOT NULL default '1' COMMENT '發微博人的類型，默認是1，1是網友，2是主持人，3是嘉賓',
  `state` tinyint(2) NOT NULL default '1' COMMENT '微博狀態，默認是1，1是正常，2是未審核，3是通過審核',
  `add_time` int(11) default NULL COMMENT '發佈微博時間',
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
  `isNative` tinyint(1) unsigned NOT NULL default '1' COMMENT '0:自定義;1:系統預設',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='頁面導航欄';

/*Data for the table `xwb_nav` */

LOCK TABLES `xwb_nav` WRITE;

insert  into `xwb_nav`(`id`,`name`,`parent_id`,`in_use`,`sort_num`,`page_id`,`is_blank`,`url`,`type`,`isNative`) values (142,'微博廣場',0,1,0,1,0,'',1,0);
insert  into `xwb_nav`(`id`,`name`,`parent_id`,`in_use`,`sort_num`,`page_id`,`is_blank`,`url`,`type`,`isNative`) values (158,'名人堂',0,1,0,3,0,NULL,2,0);
insert  into `xwb_nav`(`id`,`name`,`parent_id`,`in_use`,`sort_num`,`page_id`,`is_blank`,`url`,`type`,`isNative`) values (159,'活動',0,1,0,35,0,NULL,2,0);
insert  into `xwb_nav`(`id`,`name`,`parent_id`,`in_use`,`sort_num`,`page_id`,`is_blank`,`url`,`type`,`isNative`) values (21,'我的首頁',0,1,50,2,1,'',2,1);
insert  into `xwb_nav`(`id`,`name`,`parent_id`,`in_use`,`sort_num`,`page_id`,`is_blank`,`url`,`type`,`isNative`) values (149,'微直播',0,1,0,7,0,'',2,0);
insert  into `xwb_nav`(`id`,`name`,`parent_id`,`in_use`,`sort_num`,`page_id`,`is_blank`,`url`,`type`,`isNative`) values (147,'話題排行榜',0,1,0,6,0,'',1,0);
insert  into `xwb_nav`(`id`,`name`,`parent_id`,`in_use`,`sort_num`,`page_id`,`is_blank`,`url`,`type`,`isNative`) values (153,'微訪談',0,1,0,8,0,'',1,0);

UNLOCK TABLES;

/*Table structure for table `xwb_notice` */

DROP TABLE IF EXISTS `xwb_notice`;

CREATE TABLE `xwb_notice` (
  `notice_id` bigint(20) unsigned NOT NULL auto_increment COMMENT '通知ID',
  `sender_id` bigint(20) default '0' COMMENT '發送者的sina_uid，默認為0，表示系統發送',
  `title` varchar(100) default NULL COMMENT '通知標題',
  `content` text COMMENT '通知內容',
  `add_time` int(11) default NULL COMMENT '發佈時間',
  `available_time` int(11) default NULL COMMENT '生效時間',
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
  `recipient_id` bigint(20) unsigned NOT NULL default '0' COMMENT '接收者的sina_uid，為0表示全站用戶',
  PRIMARY KEY  (`kid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_notice_recipients` */

LOCK TABLES `xwb_notice_recipients` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_page_manager` */

DROP TABLE IF EXISTS `xwb_page_manager`;

CREATE TABLE `xwb_page_manager` (
  `page_id` int(11) NOT NULL COMMENT '預定義的頁面ID：如１：廣場。。',
  `component_id` int(11) default NULL COMMENT '使用到的組件ID',
  `title` varchar(45) default NULL,
  `position` int(11) NOT NULL default '0' COMMENT '擺放的位置 1:左邊　２：右側欄',
  `sort_num` int(11) default '0' COMMENT '擺放的順序',
  `in_use` tinyint(1) default '1' COMMENT '是否使用',
  `id` int(10) unsigned NOT NULL auto_increment,
  `isNative` int(1) unsigned NOT NULL default '1' COMMENT '1:系統自帶，不能刪除  0:用戶添加，可以刪除',
  `param` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='頁面設置';

/*Data for the table `xwb_page_manager` */

LOCK TABLES `xwb_page_manager` WRITE;

INSERT INTO `xwb22_page_manager` VALUES (1, 10, '今日話題', 1, 1, 1, 1, 0, '{\"show_num\":\"8\",\"source\":\"1\",\"topic\":\"Xweibo\"}');
INSERT INTO `xwb22_page_manager` VALUES (1, 3, '用戶推薦', 2, 6, 1, 8, 0, '{\"group_id\":\"84\",\"show_num\":\"3\"}');
INSERT INTO `xwb22_page_manager` VALUES (2, 3, '推薦用戶', 2, 3, 1, 9, 1, '{\"group_id\":\"84\"}');
INSERT INTO `xwb22_page_manager` VALUES (2, 6, '話題推薦列表', 2, 4, 1, 10, 1, '{\"topic_get\":\"2\",\"topics\":[\"\\u672c\\u62c9\\u767b\"],\"topic_id\":0,\"tid\":[\"\"]}');
INSERT INTO `xwb22_page_manager` VALUES (2, 7, '猜你喜歡', 2, 2, 1, 11, 1, '{\"show_num\":\"10\"}');
INSERT INTO `xwb22_page_manager` VALUES (1, 6, '推薦話題', 2, 3, 1, 15, 0, '{\"topic_get\":\"1\",\"topic_id\":0,\"show_num\":\"4\",\"source\":\"1\",\"topics\":[\"\\u63a8\\u8350\",\"test\",\"helloworld\"],\"tid\":[\"\",\"\",\"\"]}');
INSERT INTO `xwb22_page_manager` VALUES (1, 14, '本站最新微博', 1, 3, 1, 363, 0, '{\"show_num\":\"10\"}');
INSERT INTO `xwb22_page_manager` VALUES (4, 6, '話題推薦', 2, 2, 1, 194, 0, '{\"topic_get\":\"2\",\"topic_id\":0,\"show_num\":\"20\",\"topics\":[]}');
INSERT INTO `xwb22_page_manager` VALUES (5, 11, '多用戶組(tab)', 1, 0, 0, 213, 0, '[]');
INSERT INTO `xwb22_page_manager` VALUES (1, 9, '隨便看看', 1, 4, 1, 425, 0, '{\"show_num\":\"3\",\"source\":\"0\"}');
INSERT INTO `xwb22_page_manager` VALUES (1, 7, '可能感興趣', 2, 7, 1, 424, 0, '{\"show_num\":\"10\"}');
INSERT INTO `xwb22_page_manager` VALUES (1, 18, '推薦活動', 2, 5, 1, 303, 0, '{\"event_list_type\":\"1\",\"show_num\":\"3\"}');
INSERT INTO `xwb22_page_manager` VALUES (1, 19, '粉絲排行榜', 2, 2, 1, 304, 0, '{\"show_num\":\"10\"}');
INSERT INTO `xwb22_page_manager` VALUES (1, 15, '最新用戶', 2, 4, 1, 423, 0, '{\"show_num\":\"10\"}');
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='頁面原型';

/*Data for the table `xwb_page_prototype` */

LOCK TABLES `xwb_page_prototype` WRITE;

insert  into `xwb_page_prototype`(`id`,`name`,`desc`,`type`,`components`,`url`) values (2,'自定義頁面','自定義頁面原型',2,'','custom');
insert  into `xwb_page_prototype`(`id`,`name`,`desc`,`type`,`components`,`url`) values (1,'自定義頁面','自定義頁面原型',1,'','custom');

UNLOCK TABLES;

/*Table structure for table `xwb_pages` */

DROP TABLE IF EXISTS `xwb_pages`;

CREATE TABLE `xwb_pages` (
  `page_id` int(10) unsigned NOT NULL auto_increment COMMENT '頁面id',
  `page_name` varchar(20) default NULL COMMENT '頁面名稱',
  `desc` varchar(255) default NULL COMMENT '頁面描述',
  `native` tinyint(1) NOT NULL default '0' COMMENT '是否為內置頁',
  `url` varchar(45) default NULL,
  `prototype_id` int(10) unsigned default NULL,
  `type` int(11) default '0' COMMENT '頁面類型：專題、普通',
  `params` text,
  PRIMARY KEY  (`page_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `xwb_pages` */

LOCK TABLES `xwb_pages` WRITE;

insert  into `xwb_pages`(`page_id`,`page_name`,`desc`,`native`,`url`,`prototype_id`,`type`,`params`) values (1,'微博廣場','“微博廣場”是用戶免登入即可查看的頁面，包含了今日話題、隨便看看等組件。',1,'pub',0,0,NULL);
insert  into `xwb_pages`(`page_id`,`page_name`,`desc`,`native`,`url`,`prototype_id`,`type`,`params`) values (2,'我的首頁','“我的首頁”是登入用戶操作微博的頁面，包含了猜你喜歡、推薦話題等組件。',1,'index',0,0,NULL);
insert  into `xwb_pages`(`page_id`,`page_name`,`desc`,`native`,`url`,`prototype_id`,`type`,`params`) values (3,'名人堂','名人堂',1,'celeb',0,0,NULL);
insert  into `xwb_pages`(`page_id`,`page_name`,`desc`,`native`,`url`,`prototype_id`,`type`,`params`) values (4,'我的微博','我的微博',1,'index.profile',0,0,NULL);
insert  into `xwb_pages`(`page_id`,`page_name`,`desc`,`native`,`url`,`prototype_id`,`type`,`params`) values (35,'活動首頁','活動列表頁，包括最新活動和推薦活動',1,'event',0,0,NULL);
insert  into `xwb_pages`(`page_id`,`page_name`,`desc`,`native`,`url`,`prototype_id`,`type`,`params`) values (6,'話題排行榜','話題排行榜',1,'pub.topics',0,0,NULL);
insert  into `xwb_pages`(`page_id`,`page_name`,`desc`,`native`,`url`,`prototype_id`,`type`,`params`) values (37,'我的收藏','我的收藏',1,'index.favorites',2,0,NULL);
insert  into `xwb_pages`(`page_id`,`page_name`,`desc`,`native`,`url`,`prototype_id`,`type`,`params`) values (8,'微訪談','微訪談擴展工具',1,'interview',0,0,NULL);
insert  into `xwb_pages`(`page_id`,`page_name`,`desc`,`native`,`url`,`prototype_id`,`type`,`params`) values (7,'微直播','微直播擴展工具',1,'live',0,0,NULL);

UNLOCK TABLES;

/*Table structure for table `xwb_plugins` */

DROP TABLE IF EXISTS `xwb_plugins`;

CREATE TABLE `xwb_plugins` (
  `plugin_id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(20) default NULL COMMENT '名稱',
  `desc` varchar(255) default NULL COMMENT '簡介',
  `in_use` tinyint(1) default '1' COMMENT '是否開啟',
  PRIMARY KEY  (`plugin_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_plugins` */

LOCK TABLES `xwb_plugins` WRITE;

insert  into `xwb_plugins`(`plugin_id`,`title`,`desc`,`in_use`) values (2,'用戶首頁聚焦位','開啟該插件會將站長設定的內容以圖文的形式顯示於用戶首頁中。',1);
insert  into `xwb_plugins`(`plugin_id`,`title`,`desc`,`in_use`) values (3,'個人資料推廣位','開啟該插件會將站長設定的內容以文字鏈接的形式顯示於用戶的個人資訊的下方。',1);
insert  into `xwb_plugins`(`plugin_id`,`title`,`desc`,`in_use`) values (4,'登入後引導關注','開啟該插件後，用戶首次登陸會強制關注指定的用戶並且引導用戶其他推薦用戶。',1);
insert  into `xwb_plugins`(`plugin_id`,`title`,`desc`,`in_use`) values (5,'用戶回饋意見','左導航會出現一個意見回饋通道',1);
insert  into `xwb_plugins`(`plugin_id`,`title`,`desc`,`in_use`) values (6,'數據本地備份','本站備份一份微博數據',1);

UNLOCK TABLES;

/*Table structure for table `xwb_profile_ad` */

DROP TABLE IF EXISTS `xwb_profile_ad`;

CREATE TABLE `xwb_profile_ad` (
  `link_id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(50) NOT NULL COMMENT '標題',
  `link` varchar(255) NOT NULL COMMENT '鏈接',
  `add_time` int(11) default NULL COMMENT '添加的時間',
  PRIMARY KEY  (`link_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='個人資訊推廣位的廣告';

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
  `style_id` int(10) unsigned NOT NULL auto_increment COMMENT '範本分類ID',
  `style_name` varchar(15) NOT NULL COMMENT '分類名稱',
  `sort_num` int(11) NOT NULL default '0' COMMENT '顯示排序',
  PRIMARY KEY  (`style_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='皮膚類別表';

/*Data for the table `xwb_skin_groups` */

LOCK TABLES `xwb_skin_groups` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_skins` */

DROP TABLE IF EXISTS `xwb_skins`;

CREATE TABLE `xwb_skins` (
  `skin_id` int(10) unsigned NOT NULL auto_increment COMMENT '範本ID',
  `name` varchar(45) default NULL COMMENT '檔案名名稱',
  `directory` varchar(45) NOT NULL COMMENT '所在的目錄',
  `desc` varchar(255) default NULL COMMENT '範本說明',
  `state` tinyint(4) NOT NULL default '1' COMMENT '範本狀態　０正常（啟用）　１禁用　２檔不存在（不可用）',
  `style_id` int(11) NOT NULL default '0' COMMENT '範本分類ID',
  `sort_num` int(11) NOT NULL default '0' COMMENT '顯示排序',
  PRIMARY KEY  (`skin_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='範本列表';

/*Data for the table `xwb_skins` */

LOCK TABLES `xwb_skins` WRITE;

insert  into `xwb_skins`(`skin_id`,`name`,`directory`,`desc`,`state`,`style_id`,`sort_num`) values (185,'墨綠','skin_blackgreen','',0,0,1);
insert  into `xwb_skins`(`skin_id`,`name`,`directory`,`desc`,`state`,`style_id`,`sort_num`) values (186,'藍色','skin_blue','',0,0,2);
insert  into `xwb_skins`(`skin_id`,`name`,`directory`,`desc`,`state`,`style_id`,`sort_num`) values (187,'魅紫','skin_charmpurple','',0,0,3);
insert  into `xwb_skins`(`skin_id`,`name`,`directory`,`desc`,`state`,`style_id`,`sort_num`) values (188,'默認','skin_default','默認皮膚',0,0,4);
insert  into `xwb_skins`(`skin_id`,`name`,`directory`,`desc`,`state`,`style_id`,`sort_num`) values (189,'風景','skin_landscape','',0,0,5);
insert  into `xwb_skins`(`skin_id`,`name`,`directory`,`desc`,`state`,`style_id`,`sort_num`) values (190,'荷花','skin_lotus','',0,0,6);
insert  into `xwb_skins`(`skin_id`,`name`,`directory`,`desc`,`state`,`style_id`,`sort_num`) values (191,'節日','skin_newyear','',0,0,7);
insert  into `xwb_skins`(`skin_id`,`name`,`directory`,`desc`,`state`,`style_id`,`sort_num`) values (192,'冬雪','skin_snow','',0,0,8);
insert  into `xwb_skins`(`skin_id`,`name`,`directory`,`desc`,`state`,`style_id`,`sort_num`) values (193,'科技','skin_tech','',0,0,9);
insert  into `xwb_skins`(`skin_id`,`name`,`directory`,`desc`,`state`,`style_id`,`sort_num`) values (194,'旅行','skin_tour','',0,0,10);
insert  into `xwb_skins`(`skin_id`,`name`,`directory`,`desc`,`state`,`style_id`,`sort_num`) values (184,'沙灘','skin_beach','',0,0,0);

UNLOCK TABLES;

/*Table structure for table `xwb_subject` */

DROP TABLE IF EXISTS `xwb_subject`;

CREATE TABLE `xwb_subject` (
  `id` int(11) NOT NULL auto_increment,
  `sina_uid` bigint(20) NOT NULL COMMENT 'sina id',
  `subject` varchar(100) NOT NULL default '' COMMENT '話題名稱',
  `is_use` tinyint(1) NOT NULL default '1' COMMENT '是否啟用，默認啟用，如果用戶刪除該話題訂閱，只進行軟刪除',
  PRIMARY KEY  (`id`),
  KEY `sina_uid` (`sina_uid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用戶話題收藏記錄表，如果用戶取消收藏，使用is_use來標記，不刪除。';

/*Data for the table `xwb_subject` */

LOCK TABLES `xwb_subject` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_sys_config` */

DROP TABLE IF EXISTS `xwb_sys_config`;

CREATE TABLE `xwb_sys_config` (
  `key` varchar(40) NOT NULL,
  `value` text,
  `group_id` int(10) unsigned NOT NULL default '1' COMMENT '配置的分組ID',
  PRIMARY KEY  (`key`,`group_id`),
  KEY `idx_groupid` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='系統配置資訊';

/*Data for the table `xwb_sys_config` */

LOCK TABLES `xwb_sys_config` WRITE;

insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('rewrite_enable','0',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('logo','',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('login_way','1',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('third_code','',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('site_record','',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('address_icon','',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('head_link','[]',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('foot_link','{\"3\":{\"link_name\":\"\\u5e2e\\u52a9\\u4e2d\\u5fc3\",\"link_address\":\"http:\\/\\/x.weibo.com\\/help.php\"}}',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('authen_type','3',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('authen_big_icon','img/logo/big_auth_icon.png',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('authen_small_icon','img/logo/small_auth_icon.png',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('skin_default','188',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('ad_header','',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('guide_auto_follow','0',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('ad_footer','',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('title','Xweibo',2);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('text','Xweibo是新浪微博推出的開源微博系統，提供了豐富的運營手段，幫助廣大站長利用新浪微博的平臺，架設屬於自己網站的微博系統。',2);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('bg_pic','',2);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('oper','1',2);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('topic','xweibo',2);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('link','http://',2);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('btnTitle','瞭解更多',2);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('guide_auto_follow_id','3',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('authen_small_icon_title','Xweibo認證',1);
insert  into `xwb_sys_config`(`key`,`value`,`group_id`) values ('ad_setting','3333',1);
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
  `group_id` int(10) unsigned NOT NULL COMMENT '話題分組ID',
  `topic` varchar(45) NOT NULL COMMENT '話題內容',
  `effect_time` int(10) unsigned NOT NULL COMMENT '生效時間'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='今日話題的內容';

/*Data for the table `xwb_today_topics` */

LOCK TABLES `xwb_today_topics` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_user_action` */

DROP TABLE IF EXISTS `xwb_user_action`;

CREATE TABLE `xwb_user_action` (
  `id` int(11) NOT NULL auto_increment,
  `sina_uid` bigint(20) NOT NULL,
  `action_type` smallint(6) NOT NULL COMMENT '1、禁言 2、禁止用戶登入、3、清除用戶資訊（不刪除、僅是在任何情況不顯示） 4、恢復正常',
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
  `sina_uid` bigint(20) unsigned NOT NULL COMMENT '新浪用戶ID',
  `ban_time` int(11) default NULL COMMENT '封禁時間',
  `nick` varchar(20) default NULL COMMENT '封禁用戶的昵稱',
  PRIMARY KEY  (`id`),
  KEY `nick` (`nick`),
  KEY `sina_uid` (`sina_uid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='封禁用戶列表';

/*Data for the table `xwb_user_ban` */

LOCK TABLES `xwb_user_ban` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_user_config` */

DROP TABLE IF EXISTS `xwb_user_config`;

CREATE TABLE `xwb_user_config` (
  `id` int(4) unsigned NOT NULL auto_increment,
  `sina_uid` bigint(20) unsigned NOT NULL,
  `values` varchar(510) NOT NULL default '0' COMMENT '用戶自定義的配置',
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='保存用戶關注的話題';

/*Data for the table `xwb_user_focus` */

LOCK TABLES `xwb_user_focus` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_user_follow` */

DROP TABLE IF EXISTS `xwb_user_follow`;

CREATE TABLE `xwb_user_follow` (
  `friend_uid` bigint(20) NOT NULL COMMENT '被關注用戶ID',
  `fans_uid` bigint(20) NOT NULL COMMENT '粉絲用戶ID',
  `datetime` int(10) default NULL COMMENT '時間',
  PRIMARY KEY  (`friend_uid`,`fans_uid`),
  KEY `datetime_idx` (`datetime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='關注表';

/*Data for the table `xwb_user_follow` */

LOCK TABLES `xwb_user_follow` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_user_follow_copy` */

DROP TABLE IF EXISTS `xwb_user_follow_copy`;

CREATE TABLE `xwb_user_follow_copy` (
  `friend_uid` bigint(20) NOT NULL COMMENT '被關注用戶ID',
  `fans_uid` bigint(20) NOT NULL COMMENT '粉絲用戶ID',
  `datetime` int(10) default NULL COMMENT '時間',
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
  `sina_uid` bigint(20) unsigned NOT NULL COMMENT '新浪用戶ID',
  `nick` varchar(45) NOT NULL COMMENT '要加V的用戶',
  `reason` varchar(50) default NULL COMMENT '認證理由',
  `add_time` int(10) unsigned default NULL COMMENT '添加認證時間',
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
  `sina_uid` bigint(20) unsigned NOT NULL COMMENT '新浪用戶ID',
  `nickname` varchar(25) NOT NULL COMMENT '昵稱',
  `first_login` int(10) unsigned default NULL COMMENT '首次登陸時間',
  `access_token` varchar(50) default NULL COMMENT '授權後得到訪問API的token',
  `token_secret` varchar(50) default NULL COMMENT 'API伺服器生成的加密串',
  `uid` bigint(20) default NULL COMMENT '所捆綁的合作方的用戶ID',
  `domain_name` varchar(45) default NULL COMMENT '用戶設置的個性化功能變數名稱',
  `max_notice_time` int(11) default '0' COMMENT '用戶最後一次閱讀的起效的最新通知的時間戳',
  `followers_count` int(11) unsigned default NULL COMMENT '用戶的粉絲數，每次登陸時更新',
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
  `weibo` tinytext COMMENT '微博內容',
  `uid` bigint(20) unsigned default NULL,
  `nickname` varchar(45) default NULL COMMENT '作者',
  `addtime` int(11) default NULL COMMENT '發佈時間',
  `disabled` varchar(1) default NULL COMMENT '是否被遮罩',
  `pic` varchar(124) default NULL COMMENT '圖片url',
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
  `weibo` text NOT NULL COMMENT '微博內容',
  `picid` varchar(100) default NULL COMMENT '上傳圖片的id',
  `sina_uid` bigint(20) NOT NULL COMMENT '發微博的用戶id',
  `nickname` varchar(45) default NULL COMMENT '用戶昵稱',
  `retweeted_status` text COMMENT '轉發微博內容',
  `retweeted_wid` bigint(20) default NULL COMMENT '轉發微博id',
  `access_token` varchar(50) NOT NULL,
  `token_secret` varchar(50) NOT NULL,
  `dateline` int(10) NOT NULL COMMENT '發佈時間',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_weibo_delete` */

LOCK TABLES `xwb_weibo_delete` WRITE;

UNLOCK TABLES;

/*Table structure for table `xwb_weibo_verify` */

DROP TABLE IF EXISTS `xwb_weibo_verify`;

CREATE TABLE `xwb_weibo_verify` (
  `id` int(4) unsigned NOT NULL auto_increment,
  `weibo` text NOT NULL COMMENT '微博內容',
  `cwid` varchar(50) default NULL COMMENT '要評論的微博id',
  `picid` varchar(100) default NULL COMMENT '上傳圖片的id',
  `sina_uid` bigint(20) NOT NULL COMMENT '發微博的用戶id',
  `nickname` varchar(45) default NULL COMMENT '用戶昵稱',
  `retweeted_status` text COMMENT '轉發微博內容',
  `retweeted_wid` bigint(20) default NULL COMMENT '轉發微博id',
  `access_token` varchar(50) NOT NULL,
  `token_secret` varchar(50) NOT NULL,
  `type` varchar(20) default NULL COMMENT '類型,"live"微直播',
  `extend_id` int(4) default NULL COMMENT '擴展id',
  `extend_data` varchar(200) default NULL COMMENT '擴展數據',
  `dateline` int(10) NOT NULL COMMENT '發佈時間',
  PRIMARY KEY  (`id`),
  KEY `type` (`type`),
  KEY `sina_uid` (`sina_uid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*Data for the table `xwb_weibo_verify` */

LOCK TABLES `xwb_weibo_verify` WRITE;

UNLOCK TABLES;
