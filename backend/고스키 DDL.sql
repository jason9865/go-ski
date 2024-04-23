CREATE DATABASE ski;
USE ski;

CREATE TABLE `user` (
	`user_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`domain_user_key`	VARCHAR(255)	NOT NULL,
	`domain_name`	ENUM('kakao')	NOT NULL,
	`user_name`	VARCHAR(20)	NOT NULL,
	`birth_date`	TIMESTAMP	NOT NULL,
	`phone_number`	VARCHAR(13)	NOT NULL,
	`profile_url`	VARCHAR(255)	NULL,
	`gender`	ENUM('MALE', 'FEMALE')	NOT NULL,
	`role`	ENUM('STUDENT', 'INSTRUCTOR', 'OWNER')	NOT NULL,
	`fcm_web`	VARCHAR(255)	NULL,
	`fcm_mobile`	VARCHAR(255)	NULL,
	`created_date`	DATETIME(6)	NOT NULL,
    `expired_date`  DATETIME(6)		NULL
);

CREATE TABLE `instructor` (
	`user_id`	INT(11)	NOT NULL,
	`description`	VARCHAR(255)	NULL,
	`is_instruct_available`	ENUM('SKI', 'BOARD', 'ALL')	NULL,
	`dayoff`	INT	NOT NULL	DEFAULT 0
);

CREATE TABLE `team` (
	`team_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`user_id`	INT(11)	NOT NULL,
	`resort_id`	INT	NOT NULL,
	`team_name`	VARCHAR(30)	NOT NULL,
	`team_profile_url`	VARCHAR(255)	NOT NULL,
	`description`	VARCHAR(255)	NULL,
	`team_cost`	INT	NOT NULL,
	`dayoff`	INT	NOT NULL
);

CREATE TABLE `team_image` (
	`team_image_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`team_id`	INT(11)	NOT NULL,
	`image_url`	VARCHAR(255)	NOT NULL
);

CREATE TABLE `team_instructor` (
	`team_instructor_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`team_id`	INT(11)	NOT NULL,
	`user_id`	INT(11)	NOT NULL,
	`is_invite_accepted`	BIT(1)	NOT NULL	DEFAULT FALSE
);

CREATE TABLE `ski_resort` (
	`resort_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`resort_name`	VARCHAR(50)	NULL,
	`resort_location`	VARCHAR(255)	NULL
);

CREATE TABLE `certificate` (
	`certificate_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`certificate_name`	VARCHAR(20)	NOT NULL,
	`certificate_type`	VARCHAR(10)	NOT NULL
);

CREATE TABLE `instructor_cert` (
	`inst_cert_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`user_id`	INT(11)	NOT NULL,
	`certificate_id`	INT(11)	NOT NULL,
	`certificate_image_url`	VARCHAR(255)	NOT NULL
);

CREATE TABLE `permission` (
	`team_instructor_id`	INT(11)	NOT NULL,
	`invite_permission`	BIT(1)	NOT NULL	DEFAULT FALSE,
	`add_permission`	BIT(1)	NOT NULL	DEFAULT FALSE,
	`modify_permission`	BIT(1)	NOT NULL	DEFAULT FALSE,
	`delete_permission`	BIT(1)	NOT NULL	DEFAULT FALSE,
	`cost_permission`	BIT(1)	NOT NULL	DEFAULT FALSE,
	`position`	TINYINT(1)	NOT NULL	DEFAULT 4,
	`designated_cost`	INT(11)	NOT NULL	DEFAULT 0
);

CREATE TABLE `lesson_time` (
	`lesson_time_id`	INT	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`resort_id`	INT(11)	NOT NULL,
	`lesson_time`	INT	NOT NULL
);

CREATE TABLE `level_option` (
	`team_id`	INT(11)	NOT NULL,
	`intermediate_fee`	VARCHAR(255)	NULL,
	`advanced_fee`	VARCHAR(255)	NULL
);

CREATE TABLE `one_to_n_option` (
	`team_id`	INT(11)	NOT NULL,
	`one_two_fee`	VARCHAR(255)	NULL,
	`one_three_fee`	VARCHAR(255)	NULL,
	`one_four_fee`	VARCHAR(255)	NULL,
	`one_n_fee`	VARCHAR(255)	NULL
);

CREATE TABLE `lesson` (
	`lesson_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`user_id`	INT(11)	NOT NULL,
	`team_id`	INT(11)	NOT NULL,
	`instructor_id`	INT(11) NULL,
	`is_own`	BIT(1)	NOT NULL,
	`representative_name`	VARCHAR(255)	NULL
);

CREATE TABLE `payment` (
	`payment_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`lesson_id`	INT(11)	NOT NULL,
	`total_amount`	INT(11)	NOT NULL,
	`payment_status`	TINYINT(1)	NOT NULL	DEFAULT 0,
	`charge_id`	INT(11)	NOT NULL	DEFAULT 0,
	`payment_date`	DATETIME(6)	NOT NULL
);

CREATE TABLE `lesson_info` (
	`lesson_id`	INT(11)	NOT NULL,
	`lesson_date`	DATETIME(6)	NOT NULL,
	`start_time`	VARCHAR(4)	NOT NULL,
	`duration`	TINYINT(1)	NOT NULL,
	`lesson_type`	ENUM('SKI', 'BOARD', 'DAYOFF')	NOT NULL,
	`student_count`	INTEGER	NOT NULL
);

CREATE TABLE `lesson_payment_info` (
	`lesson_id`	INT(11)	NOT NULL,
	`basic_fee`	INT(11)	NOT NULL,
	`designated_fee`	INT(11)	NULL,
	`people_option_fee`	INT(11)	NULL,
	`level_option_fee`	INT(11)	NULL,
	`duration`	TINYINT(1)	NULL,
	`coupon_id`	INT(11)	NOT NULL
);

CREATE TABLE `settlement` (
	`settlement_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`user_id`	INT(11)	NOT NULL,
	`settlement_amount`	INT(11)	NOT NULL,
	`bank`	VARCHAR(20)	NOT NULL,
	`depositor_name`	VARCHAR(10)	NOT NULL,
	`account_number`	VARCHAR(30)	NOT NULL,
	`balance`	INT(11)	NOT NULL,
	`settlement_date`	DATETIME(6)	NOT NULL
);

CREATE TABLE `charge` (
	`charge_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`charge_name`	VARCHAR(30)	NOT NULL,
	`student_charge_rate`	TINYINT(3)	NOT NULL,
	`owner_charge_rate`	TINYINT(3)	NOT NULL,
	`system_charge_rate`	TINYINT(3)	NOT NULL
);

CREATE TABLE `review` (
	`review_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`lesson_id`	INT(11)	NOT NULL,
	`contents`	VARCHAR(255)	NULL,
	`rating`	INT(11)	NULL
);

CREATE TABLE `feedback` (
	`feedback_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`lesson_id`	INT(11)	NOT NULL,
	`content`	VARCHAR(255)	NULL
);

CREATE TABLE `feedback_media` (
	`feedback_media_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`feedback_id`	INT(11)	NOT NULL,
	`media_url`	VARCHAR(255)	NOT NULL
);

CREATE TABLE `tag_review` (
	`tag_review_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`tag_name`	VARCHAR(5)	NOT NULL
);

CREATE TABLE `tag_on_review` (
	`tag_on_review_id`	INT(11)	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`review_id`	INT(11)	NOT NULL,
	`tag_review_id`	INT(11)	NOT NULL
);

CREATE TABLE `student_info` (
    `student_info_id`    INT(11)    NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `lesson_id`    INT(11)    NOT NULL,
    `height`    ENUM('140cm 미만', '140cm~150cm', '150cm~160cm', '160cm~170cm','170cm~180cm','180cm 이상')    NOT NULL,
    `weight`    ENUM('40kg 미만', '40kg~49kg','50kg~59kg', '60kg~69kg', '70kg~79kg','80kg~89kg','90kg~99kg','100kg 초과')   NOT NULL,
    `foot_size`    INT    NOT NULL,
    `age`  ENUM("미취학 아동", "초등", "중고등", "20대", "30대", "40대", "50대", "60대 이상")    NOT NULL,
    `gender`    ENUM('남자','여자')    NOT NULL,
    `name`    VARCHAR(10)    NOT NULL
);



ALTER TABLE `instructor`
ADD CONSTRAINT `pk_instructor_user_id` PRIMARY KEY (`user_id`),
ADD CONSTRAINT `fk_instructor_user_id` FOREIGN KEY (`user_id`)
REFERENCES `user` (`user_id`) ON DELETE CASCADE;

ALTER TABLE `instructor_cert`
ADD CONSTRAINT `fk_instructor_cert_user_id` FOREIGN KEY (`user_id`)
REFERENCES `instructor` (`user_id`),
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
ADD CONSTRAINT `fk_lesson_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`user_id`);

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
-- ADD CONSTRAINT `fk_lesson_payment_info_coupon_id` FOREIGN KEY (`coupon_id`) REFERENCES `coupon` (`coupon_id`);

-- 결제
ALTER TABLE `payment`
ADD CONSTRAINT `fk_payment_lesson_id` FOREIGN KEY (`lesson_id`) REFERENCES `lesson_payment_info` (lesson_id);

-- 정산
ALTER TABLE `settlement`
ADD CONSTRAINT `fk_settlement_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (user_id);

-- 강습 팀
ALTER TABLE `team`
ADD CONSTRAINT `fk_team_user_id` FOREIGN KEY (`user_id`) REFERENCES `user`,
ADD CONSTRAINT `fk_team_resort_id` FOREIGN KEY (`resort_id`) REFERENCES `ski_resort`
;

-- 강습_팀_강사
ALTER TABLE `team_instructor`
ADD CONSTRAINT `fk_team_instructor_team` FOREIGN KEY (`team_id`) REFERENCES `team`,
ADD CONSTRAINT `fk_team_instructor_instructor` FOREIGN KEY (`user_id`) REFERENCES `instructor`
;

-- 강습 팀 이미지
ALTER TABLE `team_image`
ADD CONSTRAINT `fk_team_image_team_id` FOREIGN KEY (`team_id`) REFERENCES `team`
;

-- 강습 시간 단위
ALTER TABLE `lesson_time`
ADD CONSTRAINT `fk_lesson_time_resort_id` FOREIGN KEY (`resort_id`) REFERENCES `ski_resort`
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
