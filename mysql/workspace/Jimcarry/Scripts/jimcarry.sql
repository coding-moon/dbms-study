create database jimCarry;
use jimCarry;
/*회원*/
create table tbl_user (
user_id bigint unsigned auto_increment primary key,
user_identification varchar(100) not null,
user_password varchar(100) not null,
user_name varchar(50) not null,
user_email varchar(100) not null,
user_phone varchar(100) not null,
user_address varchar(100) not null,
user_address_detail varchar(100) not null,
user_gender varchar(100) check(user_gender in('남','여', '선택 안함')),
user_birth varchar(50),
user_random_key varchar(50) default null,
user_status tinyint default 0
);

 /*창고등록하기*/
create table tbl_storage(
storage_id bigint unsigned auto_increment primary key,
user_id bigint unsigned not null,
storage_name varchar(50) not null,
storage_phone varchar(80) not null,
storage_title varchar(80) not null,
storage_size varchar(50) not null /*check(storage_size in(‘소’, ‘중’, ‘대’, ‘특대’))*/,
storage_price int default 0,
storage_address varchar(300) not null,
storage_address_detail varchar(300) not null,
storage_use_date varchar(50) not null,
storage_end_date varchar(50) not null,
storage_address_number int,
constraint fk_storage_user foreign key(user_id) references tbl_user(user_id) on delete cascade
);

/*문의하기*/
create table tbl_inquiry(
inquiry_id int unsigned auto_increment primary key,
user_id bigint unsigned not null,
inquiry_title varchar(500) not null,
inquiry_content varchar(1000) not null,
inquiry_regist date default (current_date),
inquiry_answer tinyint default 1,
constraint fk_inquiry_user foreign key(user_id) references tbl_user(user_id) on delete cascade
);
 /*창고등록 파일*/
create table tbl_file (
file_id bigint unsigned auto_increment primary key,
storage_id bigint unsigned,
file_path varchar(500) not null,
file_org_name varchar(500) not null,
file_uuid varchar(500) unique not null,
constraint fk_file_storage foreign key(storage_id) references tbl_storage(storage_id) on delete cascade
);

/*공지사항*/
create table tbl_notice (
notice_id int unsigned auto_increment primary key,
notice_title varchar(80) not null,
notice_content varchar(1000) not null,
notice_writer varchar(50),
notice_regist date default (current_date),
notice_update date default (current_date)
);

/*결제하기*/
create table tbl_payment (
pay_id bigint unsigned auto_increment primary key,
user_id bigint unsigned not null,
storage_id bigint unsigned not null,
payment_amount int default 0,
payment_date datetime default current_timestamp(),
constraint fk_payment_user foreign key(user_id) references tbl_user(user_id) on delete cascade,
constraint fk_payment_storage foreign key(storage_id) references tbl_storage(storage_id) on delete cascade
);

drop table tbl_payment;
drop table tbl_storage;
select * from tbl_storage;
select * from tbl_user;
truncate table tbl_user; 


/*리뷰*/
create table tbl_review (
review_id bigint unsigned auto_increment primary key,
user_id bigint unsigned,
storage_id bigint unsigned,
review_title varchar(30) not null,
review_context varchar(1000) not null,
review_write_date datetime default current_timestamp(),
review_edit_date datetime default current_timestamp(),
constraint fk_review_user foreign key(user_id) references tbl_user(user_id) on delete cascade,
constraint fk_review_storage foreign key(storage_id) references tbl_storage(storage_id) on delete cascade
);

/*리뷰 파일*/
create table tbl_review_file (
review_file_id bigint unsigned auto_increment primary key,
review_id bigint unsigned,
review_file_path varchar(500) not null,
review_org_name varchar(500) not null,
review_file_uuid varchar(500) unique not null,
constraint fk_file_review_id foreign key(review_id) references tbl_review(review_id) on delete cascade
);
/*문의 등록 파일 */
create table tbl_inquiry_file (
inquiry_file_id bigint unsigned auto_increment primary key,
inquiry_id int unsigned,
inquiry_file_path varchar(500) not null,
inquiry_org_name varchar(500) not null,
inquiry_file_uuid varchar(500) unique not null,
constraint fk_file_inquiry_id foreign key(inquiry_id) references tbl_inquiry(inquiry_id) on delete cascade
);

INSERT INTO jimcarry.tbl_review
(user_id, storage_id, review_title, review_context, review_write_date, review_edit_date)
VALUES(1, 1, '메롱', '바보', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO jimcarry.tbl_storage
(user_id, storage_name, storage_phone, storage_title, storage_size, storage_price, storage_address, storage_address_detail, storage_use_date, storage_end_date)
VALUES(1, 'ㅇㄹ', 'ㅁㄴㅇㄹ', 'ㄷㄷㄷ', 'ㅇㅇㅇ', 8000, 'ㅇㅇㅇㅇ', '1', 'ㅇㄹ', 'ㅁㄴㅇㄹ');

