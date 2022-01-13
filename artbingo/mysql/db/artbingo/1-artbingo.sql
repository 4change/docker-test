DROP DATABASE IF EXISTS `artbingo`;

CREATE DATABASE `artbingo` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

SET NAMES utf8;

-- SET FOREIGN_KEY_CHECKS = 0;

USE `artbingo`;

DROP TABLE IF EXISTS `sys_tenant`;
DROP TABLE IF EXISTS `sys_tenant_menu`;
DROP TABLE IF EXISTS `sys_dept`;
DROP TABLE IF EXISTS `sys_dept_relation`;
DROP TABLE IF EXISTS `sys_dict`;
DROP TABLE IF EXISTS `sys_dict_item`;
DROP TABLE IF EXISTS `sys_log`;
DROP TABLE IF EXISTS `sys_menu`;
DROP TABLE IF EXISTS `sys_oauth_client_details`;
DROP TABLE IF EXISTS `sys_role`;
DROP TABLE IF EXISTS `sys_role_menu`;
DROP TABLE IF EXISTS `sys_user`;
DROP TABLE IF EXISTS `sys_user_role`;
DROP TABLE IF EXISTS `sys_params`;

-- ----------------------------
-- Table structure for sys_tenant
-- ----------------------------
CREATE TABLE `sys_tenant` (
      `id` VARCHAR(32) NOT NULL COMMENT '租户id，平台使用id=1,不可占用',
      `name` VARCHAR(255)  COMMENT '租户名称',
      `code` VARCHAR(64)  COMMENT '租户编号',
      `type` CHAR(1) NOT NULL DEFAULT '0' COMMENT '数据字典:tnt_type',
      `start_time` DATE NULL  COMMENT '开始时间',
      `end_time` DATE NULL  COMMENT '结束时间',
      `status` CHAR(1) NOT NULL DEFAULT '0' COMMENT '0-正常 9-冻结',
      `del_flag` CHAR(1) DEFAULT '0' COMMENT '删除标记0-正常，1-删除',
      `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建',
      `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
      PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='租户表';

BEGIN;
INSERT INTO `sys_tenant` VALUES ('1', 'zeus', '1','1', '2020-01-01', '2999-12-30', '0', '0', now(), now());
COMMIT;


-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
CREATE TABLE `sys_dept` (
  `dept_id` VARCHAR(32) NOT NULL COMMENT '机构主键',
  `code` VARCHAR(20)  COMMENT '机构编号',
  `short_name` VARCHAR(50)  COMMENT '机构简称',
  `all_name` VARCHAR(256)  COMMENT '机构全称',
  `usci_code` VARCHAR(32)  COMMENT '统一社会信用证代码',
  `cert_name` VARCHAR(64)  COMMENT '证书名称(目录名)',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` CHAR(1) DEFAULT '0' COMMENT '是否删除  1：已删除  0：正常',
  `parent_id` VARCHAR(32)  COMMENT '上级编号,无上级为0',
  `tenant_id` VARCHAR(32)  COMMENT '所属租户',
  PRIMARY KEY (`dept_id`),
  INDEX idx_sys_dept_0 (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='机构管理';


-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept` VALUES ('1','1001', 'XX机构','XX机构',null,null, 0, now(), now(), '0', '0','1');
COMMIT;

-- ----------------------------
-- Table structure for sys_dept_relation
-- ----------------------------
CREATE TABLE `sys_dept_relation` (
  `ancestor` VARCHAR(32) NOT NULL COMMENT '祖先节点',
  `descendant` VARCHAR(32) NOT NULL COMMENT '后代节点',
  PRIMARY KEY (`ancestor`,`descendant`),
  KEY `idx1` (`ancestor`),
  KEY `idx2` (`descendant`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='机构关系表';

-- ----------------------------
-- Records of sys_dept_relation
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept_relation` VALUES ('1', '1');
COMMIT;

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
CREATE TABLE `sys_dict` (
  `id` VARCHAR(32) NOT NULL COMMENT '编号',
  `type` VARCHAR(100) ,
  `description` VARCHAR(100) ,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `remarks` VARCHAR(255) ,
  `system_in` CHAR(1)  COMMENT '系统数据字典0-否|1-是',
  `del_flag` CHAR(1) DEFAULT '0' COMMENT '是否删除 1：已删除  0：正常',
  `tenant_id` VARCHAR(32)  COMMENT '所属租户',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sys_dict_del_flag` (`del_flag`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='字典表';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict` VALUES ('1', 'dict_type','字典类型',now(),now(), '系统类不能修改', '1', '0','1');
INSERT INTO `sys_dict` VALUES ('2', 'log_type', '日志类型', now(), now(), '0-正常 1 异常', '1', '0','1');
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_item
-- ----------------------------
CREATE TABLE `sys_dict_item` (
  `id` VARCHAR(32) NOT NULL COMMENT '编号',
  `dict_id` VARCHAR(32) NOT NULL COMMENT '字典编号',
  `value` VARCHAR(100)  ,
  `label` VARCHAR(100) ,
  `type` VARCHAR(100) ,
  `description` VARCHAR(100) ,
  `sort` int(10) NOT NULL DEFAULT '0' COMMENT '排序（升序）',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `remarks` VARCHAR(255)  COMMENT '说明',
  `del_flag` CHAR(1)  DEFAULT '0' COMMENT '是否删除 1：已删除  0：正常',
  `tenant_id` VARCHAR(32)  COMMENT '所属租户',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sys_dict_value` (`value`) USING BTREE,
  KEY `sys_dict_label` (`label`) USING BTREE,
  KEY `sys_dict_del_flag` (`del_flag`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='字典项';

-- ----------------------------
-- Records of sys_dict_item
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_item` VALUES ('1', '1', '1', '系统类', 'dict_type', '系统类字典', 0, now(), now(), '不能修改删除', '0','1');
INSERT INTO `sys_dict_item` VALUES ('2', '1', '0', '业务类', 'dict_type', '业务类字典', 0, now(), now(), '可以修改', '0','1');
INSERT INTO `sys_dict_item` VALUES ('3', '2', '0', '正常', 'log_type', '正常', 0, now(), now(), '正常', '0','1');
INSERT INTO `sys_dict_item` VALUES ('4', '2', '9', '异常', 'log_type', '异常', 1, now(), now(), '异常', '0','1');
COMMIT;

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
CREATE TABLE `sys_log` (
  `id` VARCHAR(32) NOT NULL COMMENT '编号',
  `type` CHAR(1) DEFAULT '1' COMMENT '日志类型',
  `title` VARCHAR(255) DEFAULT '' COMMENT '日志标题',
  `service_id` VARCHAR(32)  COMMENT '服务ID',
  `create_by` VARCHAR(64)  COMMENT '创建者',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `remote_addr` VARCHAR(255)  COMMENT '操作IP地址',
  `user_agent` VARCHAR(1000)  COMMENT '用户代理',
  `request_uri` VARCHAR(255)  COMMENT '请求URI',
  `method` VARCHAR(10)  COMMENT '操作方式',
  `params` text COMMENT '操作提交的数据',
  `time` int(11) COMMENT '执行时间',
  `del_flag` CHAR(1) DEFAULT '0' COMMENT '删除标记',
  `exception` text COMMENT '异常信息',
  `tenant_id` VARCHAR(32)  COMMENT '所属租户',
  PRIMARY KEY (`id`),
  KEY `sys_log_create_by` (`create_by`),
  KEY `sys_log_request_uri` (`request_uri`),
  KEY `sys_log_type` (`type`),
  KEY `sys_log_create_date` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='日志表';

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
CREATE TABLE `sys_menu` (
  `menu_id` VARCHAR(32)  NOT NULL COMMENT '菜单ID',
  `name` VARCHAR(32) NOT NULL COMMENT '菜单名称',
  `permission` VARCHAR(32)  COMMENT '菜单权限标识',
  `path` VARCHAR(128)  COMMENT '前端URL',
  `parent_id` VARCHAR(32)  COMMENT '父菜单ID',
  `icon` VARCHAR(32)  COMMENT '图标',
  `component` VARCHAR(64)  COMMENT 'VUE页面',
  `sort` int(11) DEFAULT '1' COMMENT '排序值',
  `keep_alive` CHAR(1) DEFAULT '0' COMMENT '0-开启，1- 关闭',
  `type` CHAR(1)  COMMENT '菜单类型 （0菜单 1按钮）',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` CHAR(1) DEFAULT '0' COMMENT '逻辑删除标记(0--正常 1--删除)',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu` VALUES ('0001', '平台管理', NULL, '/platform', '-1', 'icon-msnui-supervise', NULL, 0, '0', '0', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('1200', '菜单管理', NULL, '/admin/menu/index', '0001', 'icon-caidanguanli', NULL, 1, '0', '0', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('1201', '菜单新增', 'sys_menu_add', NULL, '1200', NULL, NULL, NULL, '0', '1', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('1202', '菜单修改', 'sys_menu_edit', NULL, '1200', NULL, NULL, NULL, '0', '1', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('1203', '菜单删除', 'sys_menu_del', NULL, '1200', NULL, NULL, NULL, '0', '1', now(), now(), '0');

INSERT INTO `sys_menu` VALUES ('2200', '字典管理', NULL, '/admin/dict/index', '0001', 'icon-navicon-zdgl', NULL, 3, '0', '0', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('2201', '字典删除', 'sys_dict_del', NULL, '2200', NULL, NULL, NULL, '0', '1', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('2202', '字典新增', 'sys_dict_add', NULL, '2200', NULL, NULL, NULL, '0', '1', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('2203', '字典修改', 'sys_dict_edit', NULL, '2200', NULL, NULL, NULL, '0', '1', now(), now(), '0');


INSERT INTO `sys_menu` VALUES ('1000', '权限管理', NULL, '/admin', '-1', 'icon-quanxianguanli', NULL, 0, '0', '0', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('1100', '用户管理', NULL, '/admin/user/index', '1000', 'icon-yonghuguanli', NULL, 1, '0', '0', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('1101', '用户新增', 'sys_user_add', NULL, '1100', NULL, NULL, NULL, '0', '1', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('1102', '用户修改', 'sys_user_edit', NULL, '1100', NULL, NULL, NULL, '0', '1', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('1103', '用户注销', 'sys_user_del', NULL, '1100', NULL, NULL, NULL, '0', '1', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('1104', '用户密码重置', 'sys_user_reset', NULL, '1100', NULL, NULL, NULL, '0', '1', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('1105', '用户启用/暂停', 'sys_user_switch', NULL, '1100', NULL, NULL, NULL, '0', '1', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('1106', '用户解锁', 'sys_user_unlock', NULL, '1100', NULL, NULL, NULL, '0', '1', now(), now(), '0');

INSERT INTO `sys_menu` VALUES ('1300', '角色管理', NULL, '/admin/role/index', '1000', 'icon-jiaoseguanli', NULL, 3, '0', '0', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('1301', '角色新增', 'sys_role_add', NULL, '1300', NULL, NULL, NULL, '0', '1', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('1302', '角色修改', 'sys_role_edit', NULL, '1300', NULL, NULL, NULL, '0', '1', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('1303', '角色删除', 'sys_role_del', NULL, '1300', NULL, NULL, NULL, '0', '1', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('1304', '分配权限', 'sys_role_perm', NULL, '1300', NULL, NULL, NULL, '0', '1', now(), now(), '0');

INSERT INTO `sys_menu` VALUES ('1400', '机构管理', NULL, '/admin/dept/index', '1000', 'icon-web-icon-', NULL, 4, '0', '0', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('1401', '机构新增', 'sys_dept_add', NULL, '1400', NULL, NULL, NULL, '0', '1', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('1402', '机构修改', 'sys_dept_edit', NULL, '1400', NULL, NULL, NULL, '0', '1', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('1403', '机构删除', 'sys_dept_del', NULL, '1400', NULL, NULL, NULL, '0', '1', now(), now(), '0');


INSERT INTO `sys_menu` VALUES ('2000', '系统管理', NULL, '/setting', '-1', 'icon-xitongguanli', NULL, 1, '0', '0', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('2100', '日志管理', NULL, '/admin/log/index', '2000', 'icon-rizhiguanli', NULL, 5, '0', '0', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('2101', '日志删除', 'sys_log_del', NULL, '2100', NULL, NULL, NULL, '0', '1', now(), now(), '0');

INSERT INTO `sys_menu` VALUES ('2500', '参数管理', NULL, '/admin/param/index', '2000', 'icon-canshu', NULL, 11, '0', '0', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('2501', '参数修改', 'sys_params_edit', NULL, '2500', NULL, NULL, 1, '0', '1', now(), now(), '0');

INSERT INTO `sys_menu` VALUES ('2300', '令牌管理', NULL, '/admin/token/index', '2000', 'icon-denglvlingpai', NULL, 11, '0', '0', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('2301', '令牌删除', 'sys_token_del', NULL, '2300', NULL, NULL, 1, '0', '1', now(), now(), '0');


INSERT INTO `sys_menu` VALUES ('3000', '开发平台', NULL, '/gen', '-1', 'icon-shejiyukaifa-', NULL, 3, '1', '0', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('3100', '数据源管理', NULL, '/gen/datasource', '3000', 'icon-mysql', NULL, 1, '1', '0', now(), now(), '0');

INSERT INTO `sys_menu` VALUES ('3200', '代码生成', NULL, '/gen/index', '3000', 'icon-weibiaoti46', NULL, 2, '0', '0', now(), now(), '0');

INSERT INTO `sys_menu` VALUES ('3300', '表单管理', NULL, '/gen/form', '3000', 'icon-record', NULL, 3, '1', '0', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('3301', '表单新增', 'gen_form_add', NULL, '3300', '', NULL, 0, '0', '1', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('3302', '表单修改', 'gen_form_edit', NULL, '3300', '', NULL, 1, '0', '1', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('3303', '表单删除', 'gen_form_del', NULL, '3300', '', NULL, 2, '0', '1', now(), now(), '0');

INSERT INTO `sys_menu` VALUES ('3400', '表单设计', NULL, '/gen/design', '3000', 'icon-biaodanbiaoqian', NULL, 4, '1', '0', now(), now(), '0');

INSERT INTO `sys_menu` VALUES ('3500', '终端管理', '', '/admin/client/index', '3000', 'icon-shouji', NULL, 5, '0', '0', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('3501', '客户端新增', 'sys_client_add', NULL, '3500', '1', NULL, NULL, '0', '1', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('3502', '客户端修改', 'sys_client_edit', NULL, '3500', NULL, NULL, NULL, '0', '1', now(), now(), '0');
INSERT INTO `sys_menu` VALUES ('3503', '客户端删除', 'sys_client_del', NULL, '3500', NULL, NULL, NULL, '0', '1', now(), now(), '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_oauth_client_details
-- ----------------------------
CREATE TABLE `sys_oauth_client_details` (
  `client_id` VARCHAR(32) NOT NULL,
  `resource_ids` VARCHAR(256) ,
  `client_secret` VARCHAR(256) ,
  `scope` VARCHAR(256) ,
  `authorized_grant_types` VARCHAR(256) ,
  `web_server_redirect_uri` VARCHAR(256) ,
  `authorities` VARCHAR(256) ,
  `access_token_validity` int(11) ,
  `refresh_token_validity` int(11) ,
  `additional_information` VARCHAR(4096) ,
  `autoapprove` VARCHAR(256) ,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='终端信息表';

-- ----------------------------
-- Records of sys_oauth_client_details
-- ----------------------------
BEGIN;
INSERT INTO `sys_oauth_client_details` VALUES ('gen', NULL, 'gen', 'server', 'password,refresh_token', NULL, NULL, NULL, NULL, NULL, 'true');
INSERT INTO `sys_oauth_client_details` VALUES ('bap', NULL, 'bap', 'server', 'password,refresh_token,authorization_code,client_credentials', NULL, NULL, NULL, NULL, NULL, 'true');
INSERT INTO `sys_oauth_client_details` VALUES ('test', null, 'test', 'server', 'password,refresh_token', null, null, null, null, null, 'true');
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
CREATE TABLE `sys_role` (
  `role_id` VARCHAR(32) NOT NULL,
  `role_name` VARCHAR(64)  NOT NULL,
  `role_code` VARCHAR(64) NOT NULL,
  `role_desc` VARCHAR(255) ,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `del_flag` CHAR(1) DEFAULT '0' COMMENT '删除标识（0-正常,1-删除）',
  `tenant_id` VARCHAR(32) COMMENT '所属租户',
  PRIMARY KEY (`role_id`),
  KEY `sys_role_role_code` (`role_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='系统角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` VALUES ('1', '管理员', 'ROLE_ADMIN', '管理员', now(), now(), '0','1');
COMMIT;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
CREATE TABLE `sys_role_menu` (
  `role_id` VARCHAR(32) NOT NULL COMMENT '角色ID',
  `menu_id` VARCHAR(32) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='角色菜单表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_menu` VALUES ('1','0001');
INSERT INTO `sys_role_menu` VALUES ('1','1000');
INSERT INTO `sys_role_menu` VALUES ('1','1100');
INSERT INTO `sys_role_menu` VALUES ('1','1101');
INSERT INTO `sys_role_menu` VALUES ('1','1102');
INSERT INTO `sys_role_menu` VALUES ('1','1103');
INSERT INTO `sys_role_menu` VALUES ('1','1104');
INSERT INTO `sys_role_menu` VALUES ('1','1105');
INSERT INTO `sys_role_menu` VALUES ('1','1106');
INSERT INTO `sys_role_menu` VALUES ('1','1200');
INSERT INTO `sys_role_menu` VALUES ('1','1201');
INSERT INTO `sys_role_menu` VALUES ('1','1202');
INSERT INTO `sys_role_menu` VALUES ('1','1203');
INSERT INTO `sys_role_menu` VALUES ('1','1300');
INSERT INTO `sys_role_menu` VALUES ('1','1301');
INSERT INTO `sys_role_menu` VALUES ('1','1302');
INSERT INTO `sys_role_menu` VALUES ('1','1303');
INSERT INTO `sys_role_menu` VALUES ('1','1304');
INSERT INTO `sys_role_menu` VALUES ('1','1400');
INSERT INTO `sys_role_menu` VALUES ('1','1401');
INSERT INTO `sys_role_menu` VALUES ('1','1402');
INSERT INTO `sys_role_menu` VALUES ('1','1403');
INSERT INTO `sys_role_menu` VALUES ('1','2000');
INSERT INTO `sys_role_menu` VALUES ('1','2100');
INSERT INTO `sys_role_menu` VALUES ('1','2101');
INSERT INTO `sys_role_menu` VALUES ('1','2200');
INSERT INTO `sys_role_menu` VALUES ('1','2201');
INSERT INTO `sys_role_menu` VALUES ('1','2202');
INSERT INTO `sys_role_menu` VALUES ('1','2203');
INSERT INTO `sys_role_menu` VALUES ('1','2300');
INSERT INTO `sys_role_menu` VALUES ('1','2301');
INSERT INTO `sys_role_menu` VALUES ('1','2400');
INSERT INTO `sys_role_menu` VALUES ('1','2401');
INSERT INTO `sys_role_menu` VALUES ('1','2402');
INSERT INTO `sys_role_menu` VALUES ('1','2403');
INSERT INTO `sys_role_menu` VALUES ('1','2500');
INSERT INTO `sys_role_menu` VALUES ('1','2501');
INSERT INTO `sys_role_menu` VALUES ('1','3000');
INSERT INTO `sys_role_menu` VALUES ('1','3100');
INSERT INTO `sys_role_menu` VALUES ('1','3200');
INSERT INTO `sys_role_menu` VALUES ('1','3300');
INSERT INTO `sys_role_menu` VALUES ('1','3301');
INSERT INTO `sys_role_menu` VALUES ('1','3302');
INSERT INTO `sys_role_menu` VALUES ('1','3303');
INSERT INTO `sys_role_menu` VALUES ('1','3400');
INSERT INTO `sys_role_menu` VALUES ('1','3500');
INSERT INTO `sys_role_menu` VALUES ('1','3501');
INSERT INTO `sys_role_menu` VALUES ('1','3502');
INSERT INTO `sys_role_menu` VALUES ('1','3503');
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
CREATE TABLE `sys_user` (
  `user_id` VARCHAR(32) NOT NULL COMMENT '主键ID',
  `username` VARCHAR(64) NOT NULL COMMENT '用户名',
  `password` VARCHAR(255) NOT NULL,
  `salt` VARCHAR(255)  COMMENT '随机盐',
  `phone` VARCHAR(20)  COMMENT '简介',
  `avatar` VARCHAR(255)  COMMENT '头像',
  `dept_id` VARCHAR(32)  COMMENT '机构ID',
  `lst_access_tm` DATETIME comment '上次成功登录时间',
  `lst_pwdchg_tm` DATETIME comment '上次密码修改时间',
  `pwd_err_cnt` int DEFAULT 0 comment '密码输入错次数',
  `pwd_err_totcnt` int DEFAULT 0 comment '密码连续错误次数',
  `create_time` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `lock_flag` CHAR(1) DEFAULT '0' COMMENT '0-正常，9-锁定',
  `lock_reason` VARCHAR(255) COMMENT '锁定原因',
  `status` CHAR(1) NOT NULL DEFAULT '0' COMMENT '0-启用（有效） 1-暂停（无效）',
  `del_flag` CHAR(1) DEFAULT '0' COMMENT '0-正常，1-删除（注销）',
  `tenant_id` VARCHAR(32) COMMENT '所属租户',
  PRIMARY KEY (`user_id`),
  CONSTRAINT `idx_sys_user_0` UNIQUE (username, tenant_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` VALUES ('1', 'admin', '{sha256}f4c9e997e016b68aa1d078f92062f4694991cb00d5317509f3fb652231bd213ceccd3c4af45b3de1', NULL, '13000000000', '', '1',NULL,NULL,0,0, now(), now(), '0','','0', '0','1');
COMMIT;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
CREATE TABLE `sys_user_role` (
  `user_id` VARCHAR(32) NOT NULL COMMENT '用户ID',
  `role_id` VARCHAR(32) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci  COMMENT='用户角色表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_role` VALUES ('1', '1');
COMMIT;


-- ----------------------------
-- Table structure for sys_tenant_menu
-- ----------------------------
CREATE TABLE `sys_tenant_menu` (
  `tenant_id` VARCHAR(32) NOT NULL COMMENT '租户ID',
  `menu_id` VARCHAR(32) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`tenant_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='租户菜单表';

-- ----------------------------
-- Records of sys_tenant_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_tenant_menu` VALUES ('1','0001');
INSERT INTO `sys_tenant_menu` VALUES ('1','1000');
INSERT INTO `sys_tenant_menu` VALUES ('1','1100');
INSERT INTO `sys_tenant_menu` VALUES ('1','1101');
INSERT INTO `sys_tenant_menu` VALUES ('1','1102');
INSERT INTO `sys_tenant_menu` VALUES ('1','1103');
INSERT INTO `sys_tenant_menu` VALUES ('1','1104');
INSERT INTO `sys_tenant_menu` VALUES ('1','1105');
INSERT INTO `sys_tenant_menu` VALUES ('1','1106');
INSERT INTO `sys_tenant_menu` VALUES ('1','1200');
INSERT INTO `sys_tenant_menu` VALUES ('1','1201');
INSERT INTO `sys_tenant_menu` VALUES ('1','1202');
INSERT INTO `sys_tenant_menu` VALUES ('1','1203');
INSERT INTO `sys_tenant_menu` VALUES ('1','1300');
INSERT INTO `sys_tenant_menu` VALUES ('1','1301');
INSERT INTO `sys_tenant_menu` VALUES ('1','1302');
INSERT INTO `sys_tenant_menu` VALUES ('1','1303');
INSERT INTO `sys_tenant_menu` VALUES ('1','1304');
INSERT INTO `sys_tenant_menu` VALUES ('1','1400');
INSERT INTO `sys_tenant_menu` VALUES ('1','1401');
INSERT INTO `sys_tenant_menu` VALUES ('1','1402');
INSERT INTO `sys_tenant_menu` VALUES ('1','1403');
INSERT INTO `sys_tenant_menu` VALUES ('1','2000');
INSERT INTO `sys_tenant_menu` VALUES ('1','2100');
INSERT INTO `sys_tenant_menu` VALUES ('1','2101');
INSERT INTO `sys_tenant_menu` VALUES ('1','2200');
INSERT INTO `sys_tenant_menu` VALUES ('1','2201');
INSERT INTO `sys_tenant_menu` VALUES ('1','2202');
INSERT INTO `sys_tenant_menu` VALUES ('1','2203');
INSERT INTO `sys_tenant_menu` VALUES ('1','2300');
INSERT INTO `sys_tenant_menu` VALUES ('1','2301');
INSERT INTO `sys_tenant_menu` VALUES ('1','2400');
INSERT INTO `sys_tenant_menu` VALUES ('1','2401');
INSERT INTO `sys_tenant_menu` VALUES ('1','2402');
INSERT INTO `sys_tenant_menu` VALUES ('1','2403');
INSERT INTO `sys_tenant_menu` VALUES ('1','2500');
INSERT INTO `sys_tenant_menu` VALUES ('1','2501');
INSERT INTO `sys_tenant_menu` VALUES ('1','3000');
INSERT INTO `sys_tenant_menu` VALUES ('1','3100');
INSERT INTO `sys_tenant_menu` VALUES ('1','3200');
INSERT INTO `sys_tenant_menu` VALUES ('1','3300');
INSERT INTO `sys_tenant_menu` VALUES ('1','3301');
INSERT INTO `sys_tenant_menu` VALUES ('1','3302');
INSERT INTO `sys_tenant_menu` VALUES ('1','3303');
INSERT INTO `sys_tenant_menu` VALUES ('1','3400');
INSERT INTO `sys_tenant_menu` VALUES ('1','3500');
INSERT INTO `sys_tenant_menu` VALUES ('1','3501');
INSERT INTO `sys_tenant_menu` VALUES ('1','3502');
INSERT INTO `sys_tenant_menu` VALUES ('1','3503');
COMMIT;

-- ----------------------------
-- Table structure for sys_params
-- ----------------------------
CREATE TABLE `sys_params`(
    `param_id` VARCHAR(32) NOT NULL COMMENT '主键',
    `param_key` VARCHAR(32) NOT NULL COMMENT '参数编号',
    `param_value` VARCHAR(255) COMMENT '参数值',
    `param_desc` VARCHAR(255) COMMENT '参数描述',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    `tenant_id` VARCHAR(32) NOT NULL COMMENT '所属租户',
    PRIMARY KEY (`param_id`)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8 DEFAULT COLLATE=utf8_general_ci COMMENT='系统参数表';

BEGIN;
INSERT INTO `sys_params` VALUES ('101', 'PWD.DEF_PWD', '123456', '新增及重置用户默认初始密码', now(),now(), '1');
INSERT INTO `sys_params` VALUES ('102', 'PWD.LIMIT', '6', '密码最小长度,默认6', now(),now(), '1');
INSERT INTO `sys_params` VALUES ('103', 'PWD.MAX_ERR_CNT', '5', '密码输入最大允许错误次数，其中-1表示无穷大，默认为5', now(),now(), '1');
INSERT INTO `sys_params` VALUES ('104', 'PWD.LOCKING_TIME', '30', '锁定时间（单位：分钟），其中-1表示无穷大，默认为30', now(),now(), '1');
INSERT INTO `sys_params` VALUES ('105', 'PWD.EFFECTIVE_DAY', '60', '密码有效时间间隔（单位：天），超过此天数则强制更改密码，其中-1表示无穷大，默认为60', now(),now(), '1');
INSERT INTO `sys_params` VALUES ('106', 'PWD.COMPLEXITY', '0000', '密码复杂度,4位数字,4位分别表示是否要求包含特殊字符,小写字母,大写字母,数字', now(),now(), '1');
INSERT INTO `sys_params` VALUES ('107', 'PWD.USER_CLOSE', '90', '用户登录设置天数不登录将自动无效 0 表示不生效,若填写非0内容最小限制为7 单位（天）', now(),now(), '1');
INSERT INTO `sys_params` VALUES ('108', 'PWD.ENCRYPT_ALGO', 'sha256', '密码加密算法，支持md5/sha256/bcrypt/scrypt/pbkdf2,安全级别依次提高', now(),now(), '1');
INSERT INTO `sys_params` VALUES ('120', 'SYS.DEPT_FLAG', 'true', '是否允许多级机构，默认为true,关闭后将只能添加1级机构', now(),now(), '1');
COMMIT;


SET FOREIGN_KEY_CHECKS = 1;
