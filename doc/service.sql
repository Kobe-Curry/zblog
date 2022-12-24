/*Table structure for table `article_category` */
DROP TABLE IF EXISTS `article_category`;
CREATE TABLE `article_category` (
  `ID` BIGINT(64) UNSIGNED NOT NULL,
  `PID` BIGINT(64) DEFAULT NULL COMMENT '上级类别编号',
  `NAME` VARCHAR(50) NOT NULL COMMENT '类别名称',
  `IMAGE_URL` VARCHAR(1000) NOT NULL DEFAULT '' COMMENT '分类预览图',
  `DESC` VARCHAR(1000) NOT NULL DEFAULT '' COMMENT '分类描述',
  `SORT` INT(11) NOT NULL DEFAULT 99999 COMMENT '排序字段',
  `ENABLED` TINYINT(1) DEFAULT 1 COMMENT '是否启用',
  `DELETED` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  `VERSION` INT(11) NOT NULL DEFAULT 1 COMMENT '乐观锁',
  `CREATE_USER` VARCHAR(20) NOT NULL COMMENT '创建用户',
  `CREATE_TIME` VARCHAR(20) NOT NULL COMMENT '创建时间',
  `CREATE_DATE` VARCHAR(20) NOT NULL COMMENT '创建日期',
  `UPDATE_USER` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新用户',
  `UPDATE_TIME` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新时间',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `INDEX_KEY_PID` (`PID`),
  KEY `INDEX_KEY_NAME` (`NAME`),
  KEY `INDEX_KEY_ENABLED` (`ENABLED`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文章分类表';

/*Data for the table `article_category` */
INSERT INTO article_category (ID, PID, NAME, IMAGE_URL, `DESC`, SORT, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (1, null, '技术总结', '', '', 1, 1, 0, 1, 'admin', '2021-02-28 21:29:11', '2021-02-28', '', '');
INSERT INTO article_category (ID, PID, NAME, IMAGE_URL, `DESC`, SORT, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (2, 1, '后端技术', '', '', 10, 1, 0, 1, 'admin', '2021-02-28 21:29:11', '2021-02-28', '', '');
INSERT INTO article_category (ID, PID, NAME, IMAGE_URL, `DESC`, SORT, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3, 1, '前端技术', '', '', 11, 1, 0, 1, 'admin', '2021-02-28 21:29:11', '2021-02-28', '', '');
INSERT INTO article_category (ID, PID, NAME, IMAGE_URL, `DESC`, SORT, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (4, 1, '工具运维', '', '', 12, 1, 0, 1, 'admin', '2021-02-28 21:29:11', '2021-02-28', '', '');
INSERT INTO article_category (ID, PID, NAME, IMAGE_URL, `DESC`, SORT, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (5, 1, '数据库', '', '', 13, 1, 0, 1, 'admin', '2021-02-28 21:29:11', '2021-02-28', '', '');
INSERT INTO article_category (ID, PID, NAME, IMAGE_URL, `DESC`, SORT, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (6, null, '学习笔记', '', '', 2, 1, 0, 1, 'admin', '2021-02-28 21:29:11', '2021-02-28', '', '');
INSERT INTO article_category (ID, PID, NAME, IMAGE_URL, `DESC`, SORT, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (7, 6, '问题记录', '', '', 20, 1, 0, 1, 'admin', '2021-02-28 21:29:11', '2021-02-28', '', '');
INSERT INTO article_category (ID, PID, NAME, IMAGE_URL, `DESC`, SORT, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (8, 6, '源码学习', '', '', 21, 1, 0, 1, 'admin', '2021-02-28 21:29:11', '2021-02-28', '', '');
INSERT INTO article_category (ID, PID, NAME, IMAGE_URL, `DESC`, SORT, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (9, 6, '力扣笔记', '', '', 22, 1, 0, 1, 'admin', '2021-02-28 21:29:11', '2021-02-28', '', '');
INSERT INTO article_category (ID, PID, NAME, IMAGE_URL, `DESC`, SORT, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (10, null, '生活记录', '', '', 3, 1, 0, 1, 'admin', '2021-02-28 21:29:11', '2021-02-28', '', '');
INSERT INTO article_category (ID, PID, NAME, IMAGE_URL, `DESC`, SORT, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (11, 10, '散文随笔', '', '', 31, 1, 0, 1, 'admin', '2021-02-28 21:29:11', '2021-02-28', '', '');
INSERT INTO article_category (ID, PID, NAME, IMAGE_URL, `DESC`, SORT, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (12, 10, '旅游杂记', '', '', 32, 1, 0, 1, 'admin', '2021-02-28 21:29:11', '2021-02-28', '', '');

/*Table structure for table `article_tag` */
DROP TABLE IF EXISTS `article_tag`;
CREATE TABLE `article_tag` (
  `ID` BIGINT(64) UNSIGNED NOT NULL,
  `NAME` VARCHAR(50) NOT NULL COMMENT '标签名称',
  `TYPE` TINYINT(1) NOT NULL COMMENT '标签类型',
  `ENABLED` TINYINT(1) DEFAULT 1 COMMENT '是否启用',
  `DELETED` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  `VERSION` INT(11) NOT NULL DEFAULT 1 COMMENT '乐观锁',
  `CREATE_USER` VARCHAR(20) NOT NULL COMMENT '创建用户',
  `CREATE_TIME` VARCHAR(20) NOT NULL COMMENT '创建时间',
  `CREATE_DATE` VARCHAR(20) NOT NULL COMMENT '创建日期',
  `UPDATE_USER` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新用户',
  `UPDATE_TIME` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新时间',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `INDEX_KEY_TYPE` (`TYPE`),
  KEY `INDEX_KEY_NAME` (`NAME`),
  KEY `INDEX_KEY_ENABLED` (`ENABLED`),
  KEY `INDEX_KEY_CREATE_USER` (`CREATE_USER`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文章标签表';

/*Data for the table `article_tag` */
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940736, 'Java', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940737, 'Python', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940738, 'Shell', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940739, 'Spring', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940740, 'SpringBoot', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940741, 'SpringCloud', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940742, '多线程', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940743, '并发', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940744, '反射', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940745, '集合', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940746, 'JVM', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940747, 'IO', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940748, 'MySQL', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940749, '达梦', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940750, 'Oracle', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940751, 'Redis', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940752, 'AWT', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940753, 'Swing', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940754, 'Linux', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940755, 'Html', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940756, 'Css', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940757, 'JavaScript', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940758, 'Vue', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940759, 'Vue2', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940760, 'Vue3', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940761, 'JQuery', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940762, 'Bootstrap', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940763, 'Tomcat', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940764, 'Echarts', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940765, 'Java关键字', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940766, 'LeeCode', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940767, '算法', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940768, '数据结构', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940769, '数学', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940770, '面试题', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940771, '工具', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940772, '旅游', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940773, '随笔', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940774, '散文', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');
INSERT INTO article_tag (ID, NAME, TYPE, ENABLED, DELETED, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3538598210605940775, '笔记', 1, 1, 0, 1, 'admin', '2021-03-01 00:58:53', '2021-03-01', '', '');

/*Table structure for table `article_tag_relation` */
DROP TABLE IF EXISTS `article_tag_relation`;
CREATE TABLE `article_tag_relation` (
  `ID` BIGINT(64) UNSIGNED NOT NULL,
  `ARTICLE_ID` BIGINT(64) NOT NULL COMMENT '文章编号',
  `TAG_ID` BIGINT(64) NOT NULL COMMENT '标签编号',
  `VERSION` INT(11) NOT NULL DEFAULT 1 COMMENT '乐观锁',
  `CREATE_USER` VARCHAR(20) NOT NULL COMMENT '创建用户',
  `CREATE_TIME` VARCHAR(20) NOT NULL COMMENT '创建时间',
  `CREATE_DATE` VARCHAR(20) NOT NULL COMMENT '创建日期',
  `UPDATE_USER` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新用户',
  `UPDATE_TIME` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新时间',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `KEY_ARTICLE_TAG` (`ARTICLE_ID`, `TAG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文章标签关联表';

/*Table structure for table `article_column` */
DROP TABLE IF EXISTS `article_column`;
CREATE TABLE `article_column` (
  `ID` BIGINT(64) UNSIGNED NOT NULL,
  `NAME` VARCHAR(50) NOT NULL COMMENT '栏目名称',
  `IMAGE_URL` VARCHAR(1000) NOT NULL DEFAULT '' COMMENT '栏目预览图',
  `DESC` VARCHAR(1000) NOT NULL DEFAULT '' COMMENT '栏目描述',
  `SORT` INT(11) NOT NULL DEFAULT 99999 COMMENT '排序字段',
  `ENABLED` TINYINT(1) DEFAULT 1 COMMENT '是否启用',
  `VERSION` INT(11) NOT NULL DEFAULT 1 COMMENT '乐观锁',
  `CREATE_USER` VARCHAR(20) NOT NULL COMMENT '创建用户',
  `CREATE_TIME` VARCHAR(20) NOT NULL COMMENT '创建时间',
  `CREATE_DATE` VARCHAR(20) NOT NULL COMMENT '创建日期',
  `UPDATE_USER` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新用户',
  `UPDATE_TIME` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新时间',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `INDEX_KEY_NAME` (`NAME`),
  KEY `INDEX_KEY_ENABLED` (`ENABLED`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文章栏目表';

/*Table structure for table `article_column_relation` */
DROP TABLE IF EXISTS `article_column_relation`;
CREATE TABLE `article_column_relation` (
  `ID` BIGINT(64) UNSIGNED NOT NULL,
  `ARTICLE_ID` BIGINT(64) NOT NULL COMMENT '文章编号',
  `COLUMN_ID` BIGINT(64) NOT NULL COMMENT '栏目编号',
  `VERSION` INT(11) NOT NULL DEFAULT 1 COMMENT '乐观锁',
  `CREATE_USER` VARCHAR(20) NOT NULL COMMENT '创建用户',
  `CREATE_TIME` VARCHAR(20) NOT NULL COMMENT '创建时间',
  `CREATE_DATE` VARCHAR(20) NOT NULL COMMENT '创建日期',
  `UPDATE_USER` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新用户',
  `UPDATE_TIME` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新时间',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `KEY_ARTICLE_COLUMN` (`ARTICLE_ID`, `COLUMN_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文章栏目关联表';

/*Table structure for table `article_img_relation` */
DROP TABLE IF EXISTS `article_img_relation`;
CREATE TABLE `article_img_relation` (
  `ID` BIGINT(64) UNSIGNED NOT NULL,
  `ARTICLE_ID` BIGINT(64) NOT NULL COMMENT '文章编号',
  `FILE_ID` BIGINT(64) NOT NULL COMMENT '文件编号',
  `VERSION` INT(11) NOT NULL DEFAULT 1 COMMENT '乐观锁',
  `CREATE_USER` VARCHAR(20) NOT NULL COMMENT '创建用户',
  `CREATE_TIME` VARCHAR(20) NOT NULL COMMENT '创建时间',
  `CREATE_DATE` VARCHAR(20) NOT NULL COMMENT '创建日期',
  `UPDATE_USER` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新用户',
  `UPDATE_TIME` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新时间',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `KEY_ARTICLE_TAG` (`ARTICLE_ID`, `FILE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文章封面关联表';

/*Table structure for table `article_like_recode` */
DROP TABLE IF EXISTS `article_like_recode`;
CREATE TABLE `article_like_recode` (
  `ID` BIGINT(64) UNSIGNED NOT NULL,
  `ARTICLE_ID` BIGINT(64) NOT NULL COMMENT '文章编号',
  `SOURCE` TINYINT(1) NOT NULL COMMENT '来源，1：系统内用户；2：匿名',
  `ACCESS_IP` VARCHAR(200) NOT NULL COMMENT '点赞用户访问IP',
  `ACCESS_ADDRESS` VARCHAR(500) NOT NULL DEFAULT '' COMMENT '点赞用户访问地址',
  `ACCESS_USER` VARCHAR(50) NOT NULL DEFAULT '' COMMENT '点赞用户：匿名/系统用户名',
  `ACCESS_TIME` VARCHAR(50) NOT NULL COMMENT '点赞时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文章点赞记录表';

/*Table structure for table `article_view_recode` */
DROP TABLE IF EXISTS `article_view_recode`;
CREATE TABLE `article_view_recode` (
  `ID` BIGINT(64) UNSIGNED NOT NULL,
  `ARTICLE_ID` BIGINT(64) NOT NULL COMMENT '文章编号',
  `ACCESS_IP` VARCHAR(200) NOT NULL COMMENT '用户访问IP',
  `ACCESS_ADDRESS` VARCHAR(500) NOT NULL DEFAULT '' COMMENT '用户访问地址',
  `ACCESS_TIME` VARCHAR(50) NOT NULL COMMENT '访问时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文章访问记录表';

/*Table structure for table `article` */
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `ID` BIGINT(64) UNSIGNED NOT NULL,
  `TITLE` VARCHAR(100) NOT NULL COMMENT '文章标题',
  `REMARK` VARCHAR(250) NOT NULL DEFAULT '' COMMENT '文章概要',
  `CONTENT` TEXT NOT NULL COMMENT '文章内容',
  `CONTENT_MD` TEXT COMMENT '文章内容_Markdown',
  `KEYWORDS` VARCHAR(200) NOT NULL DEFAULT '' COMMENT '文章关键字',
  `REPRINT_LINK` VARCHAR(1000) DEFAULT NULL COMMENT '原文地址',
  `REPRINT_DESC` VARCHAR(1000) NOT NULL DEFAULT '' COMMENT '转载说明',
  `COVER_IMAGE_TYPE` INT(2) NOT NULL COMMENT '封面类型',
  `ARTICLE_TYPE` INT(2) NOT NULL COMMENT '文章类型',
  `ARTICLE_STATUS` INT(2) NOT NULL COMMENT '文章状态',
  `ARTICLE_PERM` INT(2) NOT NULL COMMENT '文章权限',
  `CATEGORY_ID` BIGINT(64) NOT NULL COMMENT '文章分类',
  `AUTHOR_ID` BIGINT(64) NOT NULL COMMENT '文章作者',
  `COMMENT_FLAG` TINYINT(1) DEFAULT 1 COMMENT '是否允许评论',
  `DELETED` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  `VERSION` INT(11) NOT NULL DEFAULT 1 COMMENT '乐观锁',
  `CREATE_USER` VARCHAR(20) NOT NULL COMMENT '创建用户',
  `CREATE_TIME` VARCHAR(20) NOT NULL COMMENT '创建时间',
  `CREATE_DATE` VARCHAR(20) NOT NULL COMMENT '创建日期',
  `UPDATE_USER` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新用户',
  `UPDATE_TIME` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新时间',
  `EXTEND1` VARCHAR(200) DEFAULT NULL COMMENT '扩展字段一',
  `EXTEND2` VARCHAR(200) DEFAULT NULL COMMENT '扩展字段二',
  `EXTEND3` VARCHAR(200) DEFAULT NULL COMMENT '扩展字段三',
  `EXTEND4` VARCHAR(200) DEFAULT NULL COMMENT '扩展字段四',
  `EXTEND5` VARCHAR(200) DEFAULT NULL COMMENT '扩展字段五',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `INDEX_KEY_TITLE` (`TITLE`),
  KEY `INDEX_KEY_CATEGORY_ID` (`CATEGORY_ID`),
  KEY `INDEX_KEY_ARTICLE_TYPE` (`ARTICLE_TYPE`),
  KEY `INDEX_KEY_ARTICLE_STATUS` (`ARTICLE_STATUS`),
  KEY `INDEX_KEY_ARTICLE_PERM` (`ARTICLE_PERM`),
  KEY `INDEX_KEY_AUTHOR_ID` (`AUTHOR_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文章表';

/*Table structure for table `friend_link` */
DROP TABLE IF EXISTS `friend_link`;
CREATE TABLE `friend_link` (
  `ID` BIGINT(64) UNSIGNED NOT NULL,
  `NAME` VARCHAR(50) NOT NULL COMMENT '链接名称',
  `HEAD_URL` VARCHAR(1000) NOT NULL DEFAULT '' COMMENT '头像地址',
  `LINK_URL` VARCHAR(1000) NOT NULL COMMENT '链接地址',
  `LINK_REMARK` VARCHAR(200) NOT NULL DEFAULT '' COMMENT '链接介绍',
  `VALID` TINYINT(1) DEFAULT 1 COMMENT '是否有效',
  `DELETED` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  `VERSION` INT(11) NOT NULL DEFAULT 1 COMMENT '乐观锁',
  `CREATE_USER` VARCHAR(20) NOT NULL COMMENT '创建用户',
  `CREATE_TIME` VARCHAR(20) NOT NULL COMMENT '创建时间',
  `CREATE_DATE` VARCHAR(20) NOT NULL COMMENT '创建日期',
  `UPDATE_USER` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新用户',
  `UPDATE_TIME` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新时间',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `INDEX_KEY_NAME` (`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='友链表';

/*Table structure for table `website_config` */
DROP TABLE IF EXISTS `website_config`;
CREATE TABLE `website_config` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(50) NOT NULL COMMENT '配置名称',
  `CONFIG` TEXT NOT NULL COMMENT '配置信息',
  `VERSION` INT(11) NOT NULL DEFAULT 1 COMMENT '乐观锁',
  `CREATE_USER` VARCHAR(20) NOT NULL COMMENT '创建用户',
  `CREATE_TIME` VARCHAR(20) NOT NULL COMMENT '创建时间',
  `CREATE_DATE` VARCHAR(20) NOT NULL COMMENT '创建日期',
  `UPDATE_USER` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新用户',
  `UPDATE_TIME` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='网站配置信息表';

/*Data for the table `website_config` */
INSERT INTO website_config (ID, NAME, CONFIG, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (1, '网站信息', '', 1, 'admin', '2022-12-08 17:06:00', '2022-12-08', '', '');
INSERT INTO website_config (ID, NAME, CONFIG, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (2, '社交信息', '', 1, 'admin', '2022-12-08 17:06:00', '2022-12-08', '', '');
INSERT INTO website_config (ID, NAME, CONFIG, VERSION, CREATE_USER, CREATE_TIME, CREATE_DATE, UPDATE_USER, UPDATE_TIME) VALUES (3, '其他设置', '', 1, 'admin', '2022-12-08 17:06:00', '2022-12-08', '', '');

/*Table structure for table `visitor` */
DROP TABLE IF EXISTS `visitor`;
CREATE TABLE `visitor` (
  `ID` VARCHAR(32) NOT NULL,
  `ADDRESS_IP` VARCHAR(50) NOT NULL COMMENT '访问地址',
  `OS_NAME` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '操作系统',
  `BROWSER_NAME` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '浏览器名称',
  `PROVINCE` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '省份',
  `AREA_CODE` VARCHAR(50) NOT NULL DEFAULT '' COMMENT '地域编码',
  `VERSION` INT(11) NOT NULL DEFAULT 1 COMMENT '乐观锁',
  `CREATE_USER` VARCHAR(20) NOT NULL COMMENT '创建用户',
  `CREATE_TIME` VARCHAR(20) NOT NULL COMMENT '创建时间',
  `CREATE_DATE` VARCHAR(20) NOT NULL COMMENT '创建日期',
  `UPDATE_USER` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新用户',
  `UPDATE_TIME` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='访客表';

/*Table structure for table `visitor_area` */
DROP TABLE IF EXISTS `visitor_area`;
CREATE TABLE `visitor_area` (
  `AREA` VARCHAR(50) NOT NULL COMMENT '访问地域',
  `AREA_COUNT` INT(11) NOT NULL DEFAULT 1 COMMENT '访问量',
  `CREATE_TIME` VARCHAR(20) NOT NULL COMMENT '创建时间',
  `UPDATE_TIME` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新时间',
  UNIQUE KEY `KEY_AREA` (`AREA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='访客地域表';

/*Table structure for table `visitor_count` */
DROP TABLE IF EXISTS `visitor_count`;
CREATE TABLE `visitor_count` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `WEB_COUNT` INT(11) NOT NULL DEFAULT 1 COMMENT '访问量',
  `DATA_DATE` VARCHAR(20) COMMENT '数据日期: YYYY-MM-DD',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `KEY_DATA_DATE` (`DATA_DATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='访客数统计表';

/*Data for the table `visitor_count` */
INSERT INTO visitor_count (ID, WEB_COUNT, DATA_DATE) VALUES (1, 0, NULL);

/*Table structure for table `talk` */
DROP TABLE IF EXISTS `talk`;
CREATE TABLE `talk` (
  `ID` BIGINT(64) UNSIGNED NOT NULL,
  `CONTENT` TEXT NOT NULL COMMENT '说说内容',
  `IMAGES` VARCHAR(1000) NOT NULL DEFAULT '' COMMENT '图片列表',
  `STATUS` INT(2) NOT NULL COMMENT '说说状态',
  `IS_TOP` TINYINT(1) DEFAULT 0 COMMENT '是否置顶',
  `DELETED` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  `VERSION` INT(11) NOT NULL DEFAULT 1 COMMENT '乐观锁',
  `CREATE_USER` VARCHAR(20) NOT NULL COMMENT '创建用户',
  `CREATE_TIME` VARCHAR(20) NOT NULL COMMENT '创建时间',
  `CREATE_DATE` VARCHAR(20) NOT NULL COMMENT '创建日期',
  `UPDATE_USER` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新用户',
  `UPDATE_TIME` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新时间',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `INDEX_KEY_IS_TOP` (`IS_TOP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='说说';

/*Table structure for table `page` */
DROP TABLE IF EXISTS `page`;
CREATE TABLE `page` (
  `ID` BIGINT(64) UNSIGNED NOT NULL,
  `PAGE_NAME` VARCHAR(20) NOT NULL COMMENT '页面名称',
  `PAGE_LABEL` VARCHAR(50) NOT NULL COMMENT '页面标签',
  `PAGE_COVER` VARCHAR(500) NOT NULL COMMENT '页面封面',
  `PAGE_SORT` INT(11) NOT NULL DEFAULT 99999 COMMENT '页面排序',
  `VERSION` INT(11) NOT NULL DEFAULT 1 COMMENT '乐观锁',
  `CREATE_USER` VARCHAR(20) NOT NULL COMMENT '创建用户',
  `CREATE_TIME` VARCHAR(20) NOT NULL COMMENT '创建时间',
  `CREATE_DATE` VARCHAR(20) NOT NULL COMMENT '创建日期',
  `UPDATE_USER` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新用户',
  `UPDATE_TIME` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新时间',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `KEY_PAGE_LABEL` (`PAGE_LABEL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='页面配置';

/*Table structure for table `album` */
DROP TABLE IF EXISTS `album`;
CREATE TABLE `album` (
  `ID` BIGINT(64) UNSIGNED NOT NULL,
  `ALBUM_NAME` VARCHAR(20) NOT NULL COMMENT '相册名称',
  `ALBUM_DESC` VARCHAR(50) NOT NULL COMMENT '相册描述',
  `ALBUM_COVER` VARCHAR(500) NOT NULL COMMENT '相册封面',
  `STATUS` INT(2) NOT NULL COMMENT '相册状态',
  `DELETED` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  `VERSION` INT(11) NOT NULL DEFAULT 1 COMMENT '乐观锁',
  `CREATE_USER` VARCHAR(20) NOT NULL COMMENT '创建用户',
  `CREATE_TIME` VARCHAR(20) NOT NULL COMMENT '创建时间',
  `CREATE_DATE` VARCHAR(20) NOT NULL COMMENT '创建日期',
  `UPDATE_USER` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新用户',
  `UPDATE_TIME` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新时间',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `KEY_STATUS` (`STATUS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='相册';

/*Table structure for table `album_photo` */
DROP TABLE IF EXISTS `album_photo`;
CREATE TABLE `album_photo` (
  `ID` BIGINT(64) UNSIGNED NOT NULL,
  `ALBUM_ID` BIGINT(64) NOT NULL COMMENT '所属相册',
  `FILE_ID` BIGINT(64) NOT NULL COMMENT '图片ID',
  `PHOTO_NAME` VARCHAR(20) NOT NULL COMMENT '照片名称',
  `PHOTO_DESC` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '照片描述',
  `PHOTO_LINK` VARCHAR(500) NOT NULL COMMENT '照片地址',
  `IS_DELETED` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  `VERSION` INT(11) NOT NULL DEFAULT 1 COMMENT '乐观锁',
  `CREATE_USER` VARCHAR(20) NOT NULL COMMENT '创建用户',
  `CREATE_TIME` VARCHAR(20) NOT NULL COMMENT '创建时间',
  `CREATE_DATE` VARCHAR(20) NOT NULL COMMENT '创建日期',
  `UPDATE_USER` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新用户',
  `UPDATE_TIME` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '更新时间',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `KEY_DELETED` (`IS_DELETED`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='照片';