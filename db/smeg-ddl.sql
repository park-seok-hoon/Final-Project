DROP DATABASE IF EXISTS smeg;
CREATE DATABASE IF NOT EXISTS smeg;

USE smeg;

CREATE TABLE `member` (
	`me_id`	varchar(15)	PRIMARY KEY,
	`me_pw`	varchar(255)	NOT	NULL,
	`me_gender`	varchar(2)	NOT	NULL,
	`me_birth`	datetime	NOT	NULL,
<<<<<<< HEAD
  `me_calendar` varchar(2)	NOT	NULL,
=======
    `me_calendar` varchar(2)	NOT	NULL,
>>>>>>> osn_gnb
	`me_email`	varchar(30)	NOT	NULL,
	`me_authority`	varchar(5)	NOT	NULL DEFAULT "USER",
	`me_postcode`	int	NOT	NULL,
	`me_address`	longtext NOT NULL,
<<<<<<< HEAD
  `me_detail_address`	longtext NOT NULL,
=======
    `me_detail_address`	longtext NOT NULL,
>>>>>>> osn_gnb
	`me_phone`	varchar(14)	NOT	NULL,
	`me_name`	varchar(10)	NOT	NULL,
	`me_cookie` varchar(255) NULL,
	`me_cookie_limit` datetime NULL
);

CREATE TABLE `product` (
	`pr_code`	varchar(20)	PRIMARY KEY,
	`pr_name`	varchar(30)	NOT NULL,
	`pr_price`	varchar(20)	NOT NULL,
	`pr_explain`	longtext	NOT NULL,
	`pr_pic`	varchar(100)	NOT NULL,
	`pr_kc`	varchar(20)	NOT NULL,
	`pr_elec`	varchar(30)	NOT NULL,
	`pr_energy` varchar(10) NOT NULL,
	`pr_date`	varchar(10)	NOT NULL,
	`pr_maker`	varchar(100)	NOT NULL,
	`pr_nation`	varchar(100)	NOT NULL,
	`pr_size`	varchar(100)	NOT NULL,
	`pr_guarantee`	varchar(10)	NOT NULL,
	`pr_AS`	varchar(30)	NOT NULL,
	`pr_extraprice`	varchar(20)	NOT NULL,
	`pr_ca_num`	int	NOT NULL,
	`pr_ps_state`	varchar(10)	NOT NULL
);

CREATE TABLE `group` (
	`gr_num`	int	PRIMARY KEY AUTO_INCREMENT,
	`gr_name`	varchar(30)	NOT NULL
);

CREATE TABLE `product_state` (
	`ps_state`	varchar(10)	PRIMARY KEY
);

CREATE TABLE `slide_pics` (
	`sp_num`	int	PRIMARY KEY AUTO_INCREMENT,
	`sp_name`	varchar(150)	NOT NULL,
	`sp_ori_name`	varchar(50)	NOT NULL,
	`sp_pr_code`	varchar(20)	NOT NULL
);

CREATE TABLE `category` (
	`ca_num`	int	PRIMARY KEY AUTO_INCREMENT,
	`ca_gr_num`	int	NOT NULL,
	`ca_name`	varchar(10)	NOT NULL,
    `ca_explain` longtext NOT NULL
);

CREATE TABLE `basket` (
	`ba_num`	int	PRIMARY KEY AUTO_INCREMENT,
	`ba_amount`	int	NOT NULL DEFAULT 1,
	`ba_me_id`	varchar(15)	NOT NULL,
	`ba_pr_code`	varchar(20)	NOT NULL
);

CREATE TABLE `order` (
	`or_num`	int	PRIMARY KEY AUTO_INCREMENT,
	`or_date`	datetime NOT NULL,
	`or_state`	varchar(10)	NOT NULL,
	`or_total_price`	int	NOT NULL,
	`or_me_id`	varchar(15)	NOT NULL
);

CREATE TABLE `notice` (
	`no_num`	int	PRIMARY KEY AUTO_INCREMENT,
	`no_title`	varchar(20)	NOT NULL,
	`no_content`	longtext NOT NULL,
	`no_date`	datetime NOT NULL,
	`no_view`	int	NOT NULL DEFAULT 0,
	`no_me_id`	varchar(15)	NOT NULL,
	`no_nc_num`	int	NOT NULL
);

CREATE TABLE `noticeCategory` (
	`nc_num`	int	PRIMARY KEY AUTO_INCREMENT,
	`nc_name`	varchar(10)	NOT NULL
);

CREATE TABLE `orderlist` (
	`orlist_num`	int	PRIMARY KEY AUTO_INCREMENT,
	`or_num`	int	NOT NULL,
	`pr_code`	varchar(20)	NOT NULL,
	`orlist_amount`	int	NOT NULL
);

CREATE TABLE `FAQ` (
	`fa_num`	int	PRIMARY KEY AUTO_INCREMENT,
	`fa_me_id`	varchar(15)	NOT NULL,
	`fa_q`	varchar(100)	NOT NULL,
	`fa_a`	longtext	NOT NULL
);

CREATE TABLE `file` (
	`fi_num`	int	PRIMARY KEY AUTO_INCREMENT,
	`fi_name`	varchar(150) NOT NULL,
	`fi_ori_name`	varchar(150)	NOT NULL,
	`fi_no_num`	int	NOT NULL
);

## 외래키 설정
ALTER TABLE `product` ADD CONSTRAINT `FK_group_TO_product_1` FOREIGN KEY (
	`pr_ca_num`
)
REFERENCES `category` (
	`ca_num`
);

ALTER TABLE `product` ADD CONSTRAINT `FK_product_state_TO_product_1` FOREIGN KEY (
	`pr_ps_state`
)
REFERENCES `product_state` (
	`ps_state`
);

ALTER TABLE `slide_pics` ADD CONSTRAINT `FK_product_TO_slide_pics_1` FOREIGN KEY (
	`sp_pr_code`
)
REFERENCES `product` (
	`pr_code`
);

ALTER TABLE `category` ADD CONSTRAINT `FK_category_TO_category_1` FOREIGN KEY (
	`ca_gr_num`
)
REFERENCES `group` (
	`gr_num`
);

ALTER TABLE `basket` ADD CONSTRAINT `FK_member_TO_basket_1` FOREIGN KEY (
	`ba_me_id`
)
REFERENCES `member` (
	`me_id`
);

ALTER TABLE `basket` ADD CONSTRAINT `FK_product_TO_basket_1` FOREIGN KEY (
	`ba_pr_code`
)
REFERENCES `product` (
	`pr_code`
);

ALTER TABLE `order` ADD CONSTRAINT `FK_member_TO_order_1` FOREIGN KEY (
	`or_me_id`
)
REFERENCES `member` (
	`me_id`
);

ALTER TABLE `notice` ADD CONSTRAINT `FK_member_TO_notice_1` FOREIGN KEY (
	`no_me_id`
)
REFERENCES `member` (
	`me_id`
);

ALTER TABLE `notice` ADD CONSTRAINT `FK_noticeCategory_TO_notice_1` FOREIGN KEY (
	`no_nc_num`
)
REFERENCES `noticeCategory` (
	`nc_num`
);

ALTER TABLE `orderlist` ADD CONSTRAINT `FK_order_TO_orderlist_1` FOREIGN KEY (
	`or_num`
)
REFERENCES `order` (
	`or_num`
);

ALTER TABLE `orderlist` ADD CONSTRAINT `FK_product_TO_orderlist_1` FOREIGN KEY (
	`pr_code`
)
REFERENCES `product` (
	`pr_code`
);

ALTER TABLE `FAQ` ADD CONSTRAINT `FK_member_TO_FAQ_1` FOREIGN KEY (
	`fa_me_id`
)
REFERENCES `member` (
	`me_id`
);

ALTER TABLE `file` ADD CONSTRAINT `FK_notice_TO_file_1` FOREIGN KEY (
	`fi_no_num`
)
REFERENCES `notice` (
	`no_num`
);

