use `ski`;

CREATE TABLE if not exists `user` (
	`user_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`domain_user_key`	VARCHAR(255)	NOT NULL,
	`domain_name`	ENUM('kakao')	NOT NULL,
	`user_name`	VARCHAR(20)	NOT NULL,
	`birth_date`	DATETIME(6)	NOT NULL,
	`phone_number`	VARCHAR(13)	NOT NULL CHECK (phone_number REGEXP '^[0-9]{3}-[0-9]{4}-[0-9]{4}$'),
	`profile_url`	VARCHAR(255)	NULL,
	`gender`	ENUM('MALE', 'FEMALE')	NOT NULL,
	`role`	ENUM('STUDENT', 'INSTRUCTOR', 'OWNER')	NOT NULL,
	`fcm_web`	VARCHAR(255)	NULL,
	`fcm_mobile`	VARCHAR(255)	NULL,
	`created_date`	DATETIME(6)	NOT NULL,
    `expired_date`  DATETIME(6)		NULL,
    CONSTRAINT `domain_unique` UNIQUE (`domain_user_key`, `domain_name`)
);

CREATE TABLE if not exists `instructor` (
	`instructor_id`	INT(11)	NOT NULL,
	`description`	VARCHAR(255)	NULL,
	`is_instruct_available`	ENUM('SKI', 'BOARD', 'ALL')	NULL,
	`dayoff`	INT	NOT NULL	DEFAULT 0
);

CREATE TABLE if not exists `team` (
	`team_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`user_id`	INT(11)	NOT NULL,
	`resort_id`	INT	NOT NULL,
	`team_name`	VARCHAR(30)	NOT NULL,
	`team_profile_url`	VARCHAR(255)	NOT NULL,
	`description`	VARCHAR(255)	NULL,
	`team_cost`	INT	NOT NULL,
	`dayoff`	INT	NOT NULL
);

CREATE TABLE if not exists `team_image` (
	`team_image_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`team_id`	INT(11)	NOT NULL,
	`image_url`	VARCHAR(255)	NOT NULL
);

CREATE TABLE if not exists `team_instructor` (
	`team_instructor_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`team_id`	INT(11)	NOT NULL,
	`user_id`	INT(11)	NOT NULL,
	`is_invite_accepted`	BIT(1)	NOT NULL DEFAULT FALSE
);

CREATE TABLE if not exists `ski_resort` (
	`resort_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`resort_name` varchar(50) DEFAULT NULL,
	`resort_location` varchar(255) DEFAULT NULL,
	`latitude` double NOT NULL,
	`longitude` double NOT NULL
);

CREATE TABLE if not exists `certificate` (
	`certificate_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`certificate_name`	VARCHAR(20)	NOT NULL,
	`certificate_type`	VARCHAR(10)	NOT NULL
);

CREATE TABLE if not exists `instructor_cert` (
	`inst_cert_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`user_id`	INT(11)	NOT NULL,
	`certificate_id`	INT(11)	NOT NULL,
	`certificate_image_url`	VARCHAR(255)	NOT NULL
);

CREATE TABLE if not exists `permission` (
	`team_instructor_id` int(11) NOT NULL,
	`invite_permission` bit(1) NOT NULL DEFAULT b'0',
	`add_permission` bit(1) NOT NULL DEFAULT b'0',
	`modify_permission` bit(1) NOT NULL DEFAULT b'0',
	`delete_permission` bit(1) NOT NULL DEFAULT b'0',
	`cost_permission` bit(1) NOT NULL DEFAULT b'0',
	`position` tinyint(1) NOT NULL DEFAULT 4,
	`designated_cost` int(11) NOT NULL DEFAULT 0
);

CREATE TABLE if not exists `lesson_time` (
	`lesson_time_id`	INT	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`resort_id`	INT(11)	NOT NULL,
	`lesson_time`	INT	NOT NULL
);

CREATE TABLE if not exists `level_option` (
	`team_id`	INT(11)	NOT NULL,
	`intermediate_fee`	VARCHAR(255)	NULL,
	`advanced_fee`	VARCHAR(255)	NULL
);

CREATE TABLE if not exists `one_to_n_option` (
	`team_id`	INT(11)	NOT NULL,
	`one_two_fee`	VARCHAR(255)	NULL,
	`one_three_fee`	VARCHAR(255)	NULL,
	`one_four_fee`	VARCHAR(255)	NULL,
	`one_n_fee`	VARCHAR(255)	NULL
);

CREATE TABLE if not exists `lesson` (
	`lesson_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`user_id`	INT(11)	NOT NULL,
	`team_id`	INT(11)	NOT NULL,
	`instructor_id`	INT(11) NULL,
	`is_own`	BIT(1)	NOT NULL,
	`representative_name`	VARCHAR(255)	NULL
);

CREATE TABLE if not exists `payment` (
	`payment_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`lesson_id` int(11) NOT NULL,
	`total_amount` int(11) NOT NULL,
	`payment_status` tinyint(1) NOT NULL DEFAULT 0,
	`charge_id` int(11) NOT NULL DEFAULT 0,
	`payment_date` datetime(6) NOT NULL,
	`tid` varchar(25) NOT NULL,
	`payback_date` datetime(6) DEFAULT NULL
);

CREATE TABLE if not exists `lesson_info` (
	`lesson_id` int(11) NOT NULL,
	`lesson_date` datetime(6) NOT NULL,
	`start_time` varchar(4) NOT NULL,
	`lesson_type` varchar(7) NOT NULL DEFAULT '1000000',
	`student_count` int(11) NOT NULL,
	`request_complain` text DEFAULT NULL,
	`lesson_status` tinyint(1) DEFAULT NULL,
	`duration` tinyint(1) NOT NULL
);

CREATE TABLE if not exists `lesson_payment_info` (
	`lesson_id`	INT(11)	NOT NULL,
	`basic_fee`	INT(11)	NOT NULL,
	`designated_fee`	INT(11)	NULL,
	`people_option_fee`	INT(11)	NULL,
	`level_option_fee`	INT(11)	NULL,
	`coupon_id`	INT(11)	NOT NULL
);

CREATE TABLE if not exists `settlement` (
	`settlement_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`user_id` int(11) NOT NULL,
	`settlement_amount` int(11) NOT NULL,
  	`balance` int(11) NOT NULL,
  	`settlement_date` datetime(6) NOT NULL,
  	`payload` varchar(50) DEFAULT NULL,
  	`deposit_status` tinyint(1) NOT NULL
);

CREATE TABLE if not exists `charge` (
	`charge_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`charge_name`	VARCHAR(30)	NOT NULL,
	`student_charge_rate`	TINYINT(3)	NOT NULL,
	`owner_charge_rate`	TINYINT(3)	NOT NULL,
	`system_charge_rate`	TINYINT(3)	NOT NULL
);

CREATE TABLE if not exists `review` (
	`review_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`lesson_id` int(11) NOT NULL,
	`contents` varchar(255) DEFAULT NULL,
	`rating` int(11) DEFAULT NULL,
	`created_at` datetime(6) DEFAULT current_timestamp(6)
);

CREATE TABLE if not exists `feedback` (
	`feedback_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`lesson_id`	INT(11)	NOT NULL,
	`content`	VARCHAR(255)	NULL
);

CREATE table if not exists  `feedback_media` (
	`feedback_media_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`feedback_id`	INT(11)	NOT NULL,
	`media_url`	VARCHAR(255)	NOT NULL
);

CREATE TABLE if not exists `tag_review` (
	`tag_review_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`tag_name`	VARCHAR(5)	NOT NULL
);

CREATE TABLE if not exists `tag_on_review` (
	`tag_on_review_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`review_id`	INT(11)	NOT NULL,
	`tag_review_id`	INT(11)	NOT NULL
);

CREATE TABLE if not exists `student_info` (
    `student_info_id`    INT(11)    NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `lesson_id`    INT(11)    NOT NULL,
    `height`    ENUM('HEIGHT_UNDER_140CM','HEIGHT_140CM_TO_149CM','HEIGHT_150CM_TO_159CM','HEIGHT_160CM_TO_169CM','HEIGHT_170CM_TO_179CM','HEIGHT_ABOVE_180CM')  NOT NULL,
    `weight`    ENUM('WEIGHT_UNDER_40KG','WEIGHT_40KG_TO_49KG','WEIGHT_50KG_TO_59KG','WEIGHT_60KG_TO_69KG','WEIGHT_70KG_TO_79KG','WEIGHT_80KG_TO_89KG','WEIGHT_90KG_TO_99KG','WEIGHT_ABOVE_100KG')   NOT NULL,
    `foot_size`    INT    NOT NULL,
    `age`  ENUM('PRESCHOOL_CHILD','ELEMENTARY','MIDDLE_HIGH','TWENTIES','THIRTIES','FORTIES','FIFTIES','SIXTIES_OVER') NOT NULL,
    `gender`   ENUM('MALE','FEMALE')  NOT NULL,
    `name`    VARCHAR(10)    NOT NULL
);

CREATE TABLE if not exists `notification` (
    `notification_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`notification_type` int(1) NOT NULL,
	`title` varchar(50) NOT NULL,
	`content` mediumtext DEFAULT NULL,
	`image_url` varchar(255) DEFAULT NULL,
	`is_read` bit(1) NOT NULL,
	`receiver_id` int(11) NOT NULL,
	`sender_id` int(11) DEFAULT NULL,
	`created_at` datetime(6) NOT NULL,
	`device_type` ENUM('WEB','MOBILE') NOT null,
	KEY `fk_notification_receiver_id` (`receiver_id`)
);

CREATE TABLE if not exists `notification_setting` (
  `notification_setting_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `notification_type_id` int(11) NOT NULL,
  `notification_status` bit(1) NOT NULL
);

CREATE TABLE if not exists `notification_type` (
  `notification_type_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `notification_type_name` varchar(50) NOT NULL
);


ALTER TABLE `instructor`
ADD CONSTRAINT `pk_instructor_user_id` PRIMARY KEY (`instructor_id`),
ADD CONSTRAINT `fk_instructor_user_id` FOREIGN KEY (`instructor_id`)
REFERENCES `user` (`user_id`) ON DELETE CASCADE;

ALTER TABLE `instructor_cert`
ADD CONSTRAINT `fk_instructor_cert_user_id` FOREIGN KEY (`user_id`)
REFERENCES `instructor` (`instructor_id`),
ADD CONSTRAINT `fk_instructor_cert_certificate_id` FOREIGN KEY (`certificate_id`)
REFERENCES `certificate` (`certificate_id`);

ALTER TABLE `feedback`
ADD CONSTRAINT `fk_feedback_lesson_id` FOREIGN KEY (`lesson_id`)
REFERENCES `lesson` (`lesson_id`);

ALTER TABLE `review`
ADD CONSTRAINT `fk_review_lesson_id` FOREIGN KEY (`lesson_id`)
REFERENCES `lesson` (`lesson_id`);

ALTER TABLE `feedback_media`
ADD CONSTRAINT `fk_feedback_media_feedback_id` FOREIGN KEY (`feedback_id`)
REFERENCES `feedback` (`feedback_id`);

ALTER TABLE `tag_on_review`
ADD CONSTRAINT `fk_tag_on_review_review_id` FOREIGN KEY (`review_id`)
REFERENCES `review` (`review_id`),
ADD CONSTRAINT `fk_tag_on_review_tag_review_id` FOREIGN KEY (`tag_review_id`)
REFERENCES `tag_review` (`tag_review_id`);

-- 레슨 테이블의 외래 키 제약 조건 수정
ALTER TABLE `lesson`
ADD CONSTRAINT `fk_lesson_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
ADD CONSTRAINT `fk_lesson_team_id` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`),
ADD CONSTRAINT `fk_lesson_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`instructor_id`);

-- 레슨 정보 테이블의 제약 조건 수정
ALTER TABLE `lesson_info`
ADD CONSTRAINT `pk_lesson_info_lesson_id` PRIMARY KEY (`lesson_id`),
ADD CONSTRAINT `fk_lesson_info_lesson_id` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`lesson_id`) ON DELETE CASCADE;

-- 인원 정보 테이블의 제약 조건 수정
ALTER TABLE `student_info`
ADD CONSTRAINT `fk_student_info_lesson_id` FOREIGN KEY (`lesson_id`) REFERENCES `lesson_info` (`lesson_id`);

-- 강습 결제 정보
ALTER TABLE `lesson_payment_info`
ADD CONSTRAINT `pk_lesson_payment_info_lesson_id` PRIMARY KEY (`lesson_id`),
ADD CONSTRAINT `fk_lesson_payment_info_lesson_id` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`lesson_id`) ON DELETE CASCADE;

-- 결제
ALTER TABLE `payment`
ADD CONSTRAINT `fk_payment_lesson_id` FOREIGN KEY (`lesson_id`) REFERENCES `lesson_payment_info` (lesson_id)
;

-- 정산
ALTER TABLE `settlement`
ADD CONSTRAINT `fk_settlement_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (user_id);

-- 강습 팀
ALTER TABLE `team`
ADD CONSTRAINT `fk_team_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
ADD CONSTRAINT `fk_team_resort_id` FOREIGN KEY (`resort_id`) REFERENCES `ski_resort` (`resort_id`)
;

-- 강습_팀_강사
ALTER TABLE `team_instructor`
ADD CONSTRAINT `fk_team_instructor_team` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`),
ADD CONSTRAINT `fk_team_instructor_instructor` FOREIGN KEY (`user_id`) REFERENCES `instructor` (`instructor_id`)
;

-- 강습 팀 이미지
ALTER TABLE `team_image`
ADD CONSTRAINT `fk_team_image_team_id` FOREIGN KEY (`team_id`) REFERENCES `team`(`team_id`)
;

-- 강습 시간 단위
ALTER TABLE `lesson_time`
ADD CONSTRAINT `fk_lesson_time_resort_id` FOREIGN KEY (`resort_id`) REFERENCES `ski_resort` (`resort_id`)
;

-- 초중고급옵션
ALTER TABLE `level_option`
ADD CONSTRAINT `pk_level_option_team_id` PRIMARY KEY (`team_id`),
ADD CONSTRAINT `fk_level_option_team_id` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`) ON DELETE CASCADE
;

-- 1:N 옵션
ALTER TABLE `one_to_n_option`
ADD CONSTRAINT `pk_one_to_n_option_team_id` PRIMARY KEY (`team_id`),
ADD CONSTRAINT `fk_one_to_n_option_team_id` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`) ON DELETE CASCADE
;

-- 권한
ALTER TABLE `permission`
ADD CONSTRAINT `pk_permission_team_id` PRIMARY KEY (`team_instructor_id`),
ADD CONSTRAINT `fk_permission_team_id` FOREIGN KEY (`team_instructor_id`) REFERENCES `team_instructor` (`team_instructor_id`) ON DELETE CASCADE
;