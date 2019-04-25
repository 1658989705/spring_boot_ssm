
-- --------------------------------------------------
-- Spring boot 2.1.4 + MySQL 5.7.18
-- newersms: Newer Student Manager System
-- 牛耳学员管理系统
-- Create by SONG 2019-04-21 14:20
-- --------------------------------------------------

-- Open CMD: mysql -uroot -p

-- 查询已有数据库
-- show databases;
-- 创建数据库
-- create database if not exists employee;



-- 系统表 ---------------------------------------------
-- 菜单信息表
create table SYS_MENUS
(
  ID        BIGINT AUTO_INCREMENT NOT NULL, -- 菜单序号,主键
  PARENT_ID BIGINT,                         -- 父级序号
  SEQ       BIGINT,                         -- 菜单排序
  NAME      VARCHAR(50),                    -- 菜单名称
  DESCN     VARCHAR(400),                   -- 菜单说明
  LINK_URL  VARCHAR(200),                   -- 链接地址
  STATUS    VARCHAR(20),                    -- 是否可用
  CONSTRAINT PK_SYS_MENUS PRIMARY KEY (ID),
  CONSTRAINT FK_SYS_MENUS_1 FOREIGN KEY (PARENT_ID) REFERENCES SYS_MENUS (ID)
);



-- 角色信息表
create table SYS_ROLES
(
  ID    BIGINT AUTO_INCREMENT NOT NULL, -- 角色序号,主键
  NAME  VARCHAR(50),                    -- 角色名称
  CODE  VARCHAR(50),                    -- 角色编号 ROLE_XXX
  DESCN VARCHAR(400),                   -- 角色说明
  CONSTRAINT PK_SYS_ROLES PRIMARY KEY (ID)
);



-- 菜单角色对应表
create table SYS_MENU_ROLE
(
  MENU_ID BIGINT, -- 菜单编号
  ROLE_ID BIGINT, -- 角色编号
  constraint FK_SYS_MENUS_2 foreign key (MENU_ID) references SYS_MENUS (ID),
  constraint FK_SYS_ROLES_1 foreign key (ROLE_ID) references SYS_ROLES (ID)
);



-- 系统用户信息表
create table SYS_USERS
(
  ID         BIGINT AUTO_INCREMENT NOT NULL, -- 系统用户序号,主键
  USERNAME   VARCHAR(50) not null,           -- 用户名
  PASSWORD   VARCHAR(100) not null,           -- 用户密码
  email      varchar(100),                   -- 用户电子邮箱
  STATUS     VARCHAR(20),                    -- 用户状态 (1 启用 0 禁用)
  last_password_reset_date datetime,         -- 用户最后修改密码日期
  campus     VARCHAR(20),                    -- 校区 (W:五一 L:林科大 S:涉外)
  PHOTO_PATH VARCHAR(200),                   -- 用户照片路径
  constraint PK_SYS_USERS primary key (ID)
);



-- 系统用户角色对应表
create table SYS_USER_ROLE
(
  USER_ID BIGINT, -- 用户编号
  ROLE_ID BIGINT, -- 角色编号
  constraint FK_SYS_ROLES_2 foreign key (ROLE_ID) references SYS_ROLES (ID),
  constraint FK_SYS_USERS foreign key (USER_ID) references SYS_USERS (ID)
);



-- 初始化数据 ----------------------------------------------
-- 菜单 ---------------------------------------------------
-- 管理员
insert into SYS_MENUS (id, parent_id, seq, name, descn, link_url, status)
values (1, null, 100, '系统管理', '系统管理', null, '1');
insert into SYS_MENUS (id, parent_id, seq, name, descn, link_url, status)
values (2, 1, 103, '菜单管理', '菜单管理', 'menulist.html', '1');
insert into SYS_MENUS (id, parent_id, seq, name, descn, link_url, status)
values (3, 1, 102, '角色管理', '角色管理', 'rolelist.html', '1');
insert into SYS_MENUS (id, parent_id, seq, name, descn, link_url, status)
values (4, 1, 101, '用户管理', '用户管理', 'userlist.html', '1');

-- 市场管理
insert into SYS_MENUS (id, parent_id, seq, name, descn, link_url, status)
values (5, null, 200, '市场管理', '市场管理', null, '1');

-- 学工管理
insert into SYS_MENUS (id, parent_id, seq, name, descn, link_url, status)
values (6, null, 210, '学工管理', '学工管理', null, '1');

-- 财务管理
insert into SYS_MENUS (id, parent_id, seq, name, descn, link_url, status)
values (7, null, 220, '财务管理', '财务管理', null, '1');

-- 财务管理 二级菜单
insert into SYS_MENUS (id, parent_id, seq, name, descn, link_url, status)
values (8, 7, 221, '缴费管理', '缴费管理', 'finance/finance_record.html', '1');

-- 市场管理 二级菜单
insert into SYS_MENUS (id, parent_id, seq, name, descn, link_url, status)
values (9, 5, 201, '市场数据备案', '市场数据备案', 'market/market_register_list.html', '1');
insert into SYS_MENUS (id, parent_id, seq, name, descn, link_url, status)
values (10, 5, 202, '上门市场数据备案', '上门市场数据备案', 'market/market_onside_register_list.html', '1');
insert into SYS_MENUS (id, parent_id, seq, name, descn, link_url, status)
values (11, 5, 203, '备案跟踪记录', '备案跟踪记录', 'market/market_record_list.html', '1');
insert into SYS_MENUS (id, parent_id, seq, name, descn, link_url, status)
values (12, 5, 204, '预科班查询页面', '预科班查询页面', 'market/pre_class_list.html', '1');

-- 学工管理 二级菜单
insert into SYS_MENUS (parent_id, seq, name, descn, link_url, status)
values (6, 211, '学员档案管理', '学员档案管理', 'stu_work/stu_list.html', '1');
insert into SYS_MENUS (parent_id, seq, name, descn, link_url, status)
values (6, 212, '学员日常管理', '学员日常管理', 'stu_work/stu_daily.html', '1');
insert into SYS_MENUS (parent_id, seq, name, descn, link_url, status)
values (6, 213, '学员异动查询', '学员异动查询', 'stu_work/stu_exception.html', '1');
insert into SYS_MENUS (parent_id, seq, name, descn, link_url, status)
values (6, 214, '学员谈话一览表', '学员谈话一览表', 'stu_work/interview.html', '1');
insert into SYS_MENUS (parent_id, seq, name, descn, link_url, status)
values (6, 215, '班级资料管理', '班级资料管理', 'stu_work/opening_campus_list.html', '1');
insert into SYS_MENUS (parent_id, seq, name, descn, link_url, status)
values (6, 216, '班级运营报表', '班级运营报表', 'stu_work/class_operation_report.html', '1');
insert into SYS_MENUS (parent_id, seq, name, descn, link_url, status)
values (6, 217, '考试成绩列表', '考试成绩列表', 'stu_work/exam_result_list.html', '1');
insert into SYS_MENUS (parent_id, seq, name, descn, link_url, status)
values (6, 218, '学员宿舍管理', '学员宿舍管理', 'stu_work/dormitory_management_list.html', '1');
insert into SYS_MENUS (parent_id, seq, name, descn, link_url, status)
values (6, 219, '宿舍到期查询', '宿舍到期查询', 'stu_work/expiry_domitories_list.html', '1');
commit;



-- 角色 -------------------------------------------------
insert into SYS_ROLES (id, name, code, descn)
values (1, '系统管理员', 'ROLE_ADMIN', '系统管理员');
insert into SYS_ROLES (id, name, code, descn)
values (2, '校长', 'ROLE_PRESIDENT', '校长');
insert into SYS_ROLES (id, name, code, descn)
values (3, '副校长', 'ROLE_MANAGER', '副校长');
insert into SYS_ROLES (id, name, code, descn)
values (4, '市场主管', 'ROLE_DIRECTOR_MARKET', '市场主管');
insert into SYS_ROLES (id, name, code, descn)
values (5, '学工主管', 'ROLE_DIRECTOR_STUWORK', '学工主管');
insert into SYS_ROLES (id, name, code, descn)
values (6, '市场办事员', 'ROLE_CLERK_MARKET', '市场办事员');
insert into SYS_ROLES (id, name, code, descn)
values (7, '学工办事员', 'ROLE_CLERK_STUWORK', '学工办事员');
commit;



-- 菜单角色 ----------------------------------------------
-- 管理员
insert into SYS_MENU_ROLE (menu_id, role_id)
values (1, 1);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (2, 1);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (3, 1);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (4, 1);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (5, 1);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (6, 1);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (7, 1);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (8, 1);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (9, 1);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (10, 1);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (11, 1);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (12, 1);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (13, 1);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (14, 1);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (15, 1);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (16, 1);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (17, 1);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (18, 1);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (19, 1);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (20, 1);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (21, 1);

-- 校长
insert into SYS_MENU_ROLE (menu_id, role_id)
values (5, 2);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (6, 2);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (7, 2);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (8, 2);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (9, 2);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (10, 2);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (11, 2);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (12, 2);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (13, 2);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (14, 2);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (15, 2);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (16, 2);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (17, 2);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (18, 2);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (19, 2);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (20, 2);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (21, 2);

-- 副校长
insert into SYS_MENU_ROLE (menu_id, role_id)
values (5, 3);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (6, 3);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (7, 3);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (8, 3);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (9, 3);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (10, 3);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (11, 3);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (12, 3);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (13, 3);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (14, 3);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (15, 3);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (16, 3);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (17, 3);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (18, 3);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (19, 3);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (20, 3);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (21, 3);

-- 市场主管
insert into SYS_MENU_ROLE (menu_id, role_id)
values (5, 4);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (7, 4);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (8, 4);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (9, 4);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (10, 4);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (11, 4);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (12, 4);

-- 学工主管
insert into SYS_MENU_ROLE (menu_id, role_id)
values (6, 5);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (7, 5);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (8, 5);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (13, 5);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (14, 5);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (15, 5);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (16, 5);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (17, 5);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (18, 5);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (19, 5);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (20, 5);
insert into SYS_MENU_ROLE (menu_id, role_id)
values (21, 5);
commit;



-- 系统用户 --------------------------------------------
-- neweradmin - 系统管理员的密码
insert into SYS_USERS (id, USERNAME, password, email, status, last_password_reset_date, campus, photo_path)
values (1, 'neweradmin', '$2a$10$IXMGgdVaatJkIaSgYaCQRelG2BSjf0g/lFI7rMsXSlK1aZAWNKufu','songxowe@qq.com', '1', now(),'W,L,S','82117791.jpg');

-- newer666 -- 这是下面的用户的初始化密码
insert into SYS_USERS (id, USERNAME, password, email, status, last_password_reset_date, campus, photo_path)
values (2, 'huping', '$2a$10$hKcJ7UQ55uPHxen01nKrausGdRkysXcx1yw/2N9UAtNu.rhV5XFpa','songxowe@qq.com', '1', now(),'W,L,S','胡平.jpg');

insert into SYS_USERS (id, USERNAME, password, email, status, last_password_reset_date, campus, photo_path)
values (3, 'jiangyiming', '$2a$10$hKcJ7UQ55uPHxen01nKrausGdRkysXcx1yw/2N9UAtNu.rhV5XFpa','songxowe@qq.com', '1', now(),'W','蒋义铭.jpg');
insert into SYS_USERS (id, USERNAME, password, email, status, last_password_reset_date, campus, photo_path)
values (4, 'lihongfang', '$2a$10$hKcJ7UQ55uPHxen01nKrausGdRkysXcx1yw/2N9UAtNu.rhV5XFpa','songxowe@qq.com', '1', now(),'W','李宏芳.jpg');
insert into SYS_USERS (id, USERNAME, password, email, status, last_password_reset_date, campus, photo_path)
values (5, 'chenjiulong', '$2a$10$hKcJ7UQ55uPHxen01nKrausGdRkysXcx1yw/2N9UAtNu.rhV5XFpa','songxowe@qq.com', '1', now(),'L,S','陈九龙.jpg');
insert into SYS_USERS (id, USERNAME, password, email, status, last_password_reset_date, campus, photo_path)
values (6, 'zoubin', '$2a$10$hKcJ7UQ55uPHxen01nKrausGdRkysXcx1yw/2N9UAtNu.rhV5XFpa','songxowe@qq.com', '1', now(),'S','邹斌.jpg');

insert into SYS_USERS (id, USERNAME, password, email, status, last_password_reset_date, campus, photo_path)
values (7, 'fumeili', '$2a$10$hKcJ7UQ55uPHxen01nKrausGdRkysXcx1yw/2N9UAtNu.rhV5XFpa','songxowe@qq.com', '1', now(),'W','付美丽.jpg');
insert into SYS_USERS (id, USERNAME, password, email, status, last_password_reset_date, campus, photo_path)
values (8, 'lihuimin', '$2a$10$hKcJ7UQ55uPHxen01nKrausGdRkysXcx1yw/2N9UAtNu.rhV5XFpa','songxowe@qq.com', '1', now(),'L','黎慧敏.jpg');
insert into SYS_USERS (id, USERNAME, password, email, status, last_password_reset_date, campus, photo_path)
values (9, 'yangcune', '$2a$10$hKcJ7UQ55uPHxen01nKrausGdRkysXcx1yw/2N9UAtNu.rhV5XFpa','songxowe@qq.com', '1', now(),'S','杨存娥.jpg');

insert into SYS_USERS (id, USERNAME, password, email, status, last_password_reset_date, campus, photo_path)
values (10, 'suyang', '$2a$10$hKcJ7UQ55uPHxen01nKrausGdRkysXcx1yw/2N9UAtNu.rhV5XFpa','songxowe@qq.com', '1', now(),'W','苏杨.jpg');
insert into SYS_USERS (id, USERNAME, password, email, status, last_password_reset_date, campus, photo_path)
values (11, 'wujia', '$2a$10$hKcJ7UQ55uPHxen01nKrausGdRkysXcx1yw/2N9UAtNu.rhV5XFpa','songxowe@qq.com', '1', now(),'W','吴佳.jpg');
insert into SYS_USERS (id, USERNAME, password, email, status, last_password_reset_date, campus, photo_path)
values (12, 'zhangzongying', '$2a$10$hKcJ7UQ55uPHxen01nKrausGdRkysXcx1yw/2N9UAtNu.rhV5XFpa','songxowe@qq.com', '1', now(),'L','张棕樱.jpg');
commit;



-- 用户角色 -----------------------------------------
insert into SYS_USER_ROLE (user_id, role_id)
values (1, 1);
insert into SYS_USER_ROLE (user_id, role_id)
values (2, 2);

insert into SYS_USER_ROLE (user_id, role_id)
values (3, 3);
insert into SYS_USER_ROLE (user_id, role_id)
values (4, 3);
insert into SYS_USER_ROLE (user_id, role_id)
values (5, 3);
insert into SYS_USER_ROLE (user_id, role_id)
values (6, 3);

insert into SYS_USER_ROLE (user_id, role_id)
values (11, 4);

insert into SYS_USER_ROLE (user_id, role_id)
values (7, 5);
insert into SYS_USER_ROLE (user_id, role_id)
values (8, 5);
insert into SYS_USER_ROLE (user_id, role_id)
values (9, 5);
insert into SYS_USER_ROLE (user_id, role_id)
values (10, 5);
insert into SYS_USER_ROLE (user_id, role_id)
values (12, 5);
commit;