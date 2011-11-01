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

/* 专题数据增加 */
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (20,'專題介紹','專題介紹',10,1,1,'topicDesc','專題介紹',NULL,'topic');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (21,'專題發佈框','專題發佈框',1,1,1,'topicPub','專題發佈框',NULL,'topic');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (22,'專題介紹','專題介紹',10,1,2,'topicDesc','專題介紹',NULL,'topic');
insert  into `xwb_components`(`component_id`,`name`,`title`,`type`,`native`,`component_type`,`symbol`,`desc`,`preview_img`,`component_cty`) values (23,'相關視頻','相關視頻',10,1,2,'topicVideo','相關視頻',NULL,'topic');