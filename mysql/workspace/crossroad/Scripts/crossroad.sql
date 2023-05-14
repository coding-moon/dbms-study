create database crossroads;
drop database crossroads;
use crossroads;

create table tbl_member
(
 member_id int unsigned auto_increment primary key,
 member_identification varchar(500) not null,
 member_password varchar(500) not null,
 member_name varchar(500) not null,
 member_phone varchar(500) not null,
 member_email varchar(500) not null,
 member_file_system_name varchar(500),
 member_type char(1) default 0 not null,
 member_drive_register_date date not null,
 member_point int unsigned not null
);
UPDATE tbl_member 
SET member_identification = 'new identification', member_password = 'new password', member_name = 'new name', member_phone = 'new phone', member_email = 'new email', member_file_system_name = '002.jpg', member_type = '1' 
WHERE member_id = 23;


alter table tbl_member modify member_point int default 0;
drop table tbl_member;

INSERT INTO crossroads.tbl_member
(member_identification, member_password, member_name, member_phone, member_email, member_file_system_name, member_type, member_drive_register_date, member_point)
VALUES('asdf1234@', 'asdf1234', '테스트3', '01032345678', 'test1@test3.com', 'tiger', '3', '20220101', 0);

INSERT INTO crossroads.tbl_member
(member_identification, member_password, member_name, member_phone, member_email, member_file_system_name, member_type, member_drive_register_date, member_point)
VALUES('test6', 'test6', '테스트6', '01052345678', 'test1@test6.com', '002.jpg', '2', '20220101', 0);


select * from tbl_member;

update tbl_member 
set member_point = 250000000
where member_id = 3;


create table tbl_review
(
review_id int unsigned auto_increment primary key,
member_id int unsigned not null,
review_register_date datetime default current_timestamp,
review_update_date datetime default current_timestamp on update current_timestamp,
review_title varchar(500) not null,
review_content varchar(500) not null,
review_file_system_name varchar(500) not null,
review_grade varchar(500) not null,
apply_id int unsigned,
constraint foreign key (member_id) references tbl_member (member_id),
constraint foreign key (apply_id) references tbl_apply (apply_id)
);
drop table tbl_review;
set FOREIGN_KEY_CHECKS = 1;
select *from tbl_review ;
alter table tbl_review change review_contents review_content varchar(500);
ALTER table tbl_review  MODIFY review_file_system_name varchar(500);

INSERT INTO crossroads.tbl_review
(member_id, review_register_date, review_update_date, review_title, review_content, review_file_system_name, review_grade, apply_id)
VALUES(1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'test5', '테스트입니다5', '002.jpg', '5',1);

INSERT INTO crossroads.tbl_review
(member_id, review_register_date, review_update_date, review_title, review_content, review_file_system_name, review_grade, apply_id)
VALUES(6, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'test6', '테스트입니다6', '001.jpg', '3',6);

INSERT INTO crossroads.tbl_review
(member_id, review_register_date, review_update_date, review_title, review_content, review_file_system_name, review_grade, apply_id)
VALUES(7, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'test7', '테스트입니다7', 'tiger.jpg', '5',7);

INSERT INTO crossroads.tbl_review
(member_id, review_register_date, review_update_date, review_title, review_content, review_file_system_name, review_grade, apply_id)
VALUES(8, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'test8', '테스트입니다8', '002.jpg', '4',8);

INSERT INTO crossroads.tbl_apply
(apply_course, apply_location, apply_date, apply_register_date, starter_member_id, veteran_member_id, apply_status)
VALUES('djfkdfj', 'adkfj', '2020-01-02', CURRENT_TIMESTAMP, 1, 1, '1');


select * from tbl_review;
select * from tbl_board;
select * from tbl_apply;
DELETE FROM tbl_review WHERE review_id = 47;
truncate table tbl_review; 

alter table tbl_review add column review_file_original_name varchar(500);
alter table tbl_review add column review_file_uuid varchar(500);
alter table tbl_review add column review_file_path varchar(500);
alter table tbl_review add column review_file_size varchar(100);
alter table tbl_review add column review_file_type char(1) default 0;

update tbl_review
set apply_id = 2
where review_id = 53;

update tbl_apply
set starter_member_id = 23
where apply_id = 1;


SELECT r.review_id, r.review_title, r.review_content, r.review_grade, r.review_register_date,
       r.review_update_date, r.review_file_system_name, m.member_name, m.member_phone,
       m.member_email, m.member_file_system_name, a.apply_course, a.apply_location,
       a.apply_date, a.apply_register_date, a.starter_member_id, a.veteran_member_id,
       a.apply_status
FROM tbl_review r
INNER JOIN tbl_member m ON r.member_id = m.member_id
INNER JOIN tbl_apply a ON r.apply_id = a.apply_id;

 CREATE table tbl_board
(
board_id int unsigned auto_increment primary key,
board_title varchar(500) not null,
board_content varchar(500) not null,
member_id int unsigned not null,
board_register_date datetime default current_timestamp,
board_update_date datetime default current_timestamp on update current_timestamp,
board_read_count int unsigned not null,
constraint foreign key (member_id) references tbl_member (member_id)
);


select * from tbl_board;

      SELECT B.board_id, B.board_title, B.board_content,B.board_register_date,B.board_update_date,B.board_read_count,
             M.member_name, F.file_uuid, F.file_path
      FROM tbl_board B
      LEFT JOIN tbl_member M ON B.member_id = M.member_id
      LEFT JOIN tbl_board_file F ON B.board_id = F.board_id
      ORDER BY B.board_register_date desc;

create table tbl_board_file(
   file_id int unsigned auto_increment primary key,
   file_original_name varchar(500) not null,
   file_uuid varchar(500) not null,
   file_path varchar(500) not null,
   file_size varchar(100) not null,
   board_id int unsigned not null,
constraint foreign key (board_id) references tbl_board (board_id)
);

ALTER TABLE tbl_file RENAME TO tbl_board_file;

 create table tbl_reply
(
reply_id int unsigned auto_increment primary key,
board_id int unsigned,
member_id int unsigned not null,
reply_content varchar(500) not null,
reply_register_date datetime default current_timestamp,
reply_update_date datetime default current_timestamp on update current_timestamp,
constraint foreign key (member_id) references tbl_member (member_id),
constraint foreign key (board_id) references tbl_board (board_id)
);

SELECT member_id, member_identification, member_password, member_name, member_phone, member_email, member_file_system_name, member_type, member_drive_register_date, member_point
FROM crossroads.tbl_member
where member_id in (1, 2, 3);


 create table tbl_apply
(
apply_id int unsigned auto_increment primary key,
apply_course varchar(500) not null,
apply_location varchar(500) not null,
apply_date datetime not null,
apply_register_date datetime default current_timestamp,
starter_member_id int unsigned,
veteran_member_id int unsigned,
apply_status varchar(500) not null,
constraint foreign key (starter_member_id) references tbl_member (member_id),
constraint foreign key (veteran_member_id) references tbl_member (member_id)
);

select * from tbl_member;
select * from tbl_apply;

INSERT INTO tbl_apply
(apply_course, apply_location, apply_date, apply_register_date, starter_member_id, veteran_member_id, apply_status)
VALUES('A', '서울시 송파구 잠실', '2023-03-28', CURRENT_TIMESTAMP, 2, 0, '승인');
       
select m.member_id, member_identification, member_password, member_name, member_phone, member_email, member_file_system_name, member_type, member_drive_register_date, member_point,
        a.apply_id, apply_course, apply_location, apply_date, apply_register_date, starter_member_id, veteran_member_id, apply_status,
        review_id, r.member_id, review_register_date, review_update_date, review_title, review_content, review_file_system_name, review_grade, r.apply_id
        from tbl_member m join tbl_review r on m.member_id = r.member_id
       join tbl_apply a on r.apply_id = a.apply_id
       order by review_id desc;
      
  
  select * from tbl_review ;
 select * from tbl_member tm ;
select * from tbl_apply ta ;
  


INSERT INTO crossroads.tbl_apply
(apply_course, apply_location, apply_date, apply_register_date, starter_member_id, apply_status)
VALUES('A', '서울특별시 송파구', '20230326', CURRENT_TIMESTAMP, 2, '0');

INSERT INTO crossroads.tbl_apply
(apply_course, apply_location, apply_date, apply_register_date, starter_member_id, apply_status)
VALUES('B', '서울특별시 동작구', '20230403', CURRENT_TIMESTAMP, 7, '0');

INSERT INTO crossroads.tbl_apply
(apply_course, apply_location, apply_date, apply_register_date, starter_member_id, apply_status)
VALUES('A', '경기도 성남시 분당구', '20230401', '20230322', 5, '0');

INSERT INTO crossroads.tbl_apply
(apply_course, apply_location, apply_date, apply_register_date, starter_member_id, apply_status)
VALUES('A', '경기도 평택시', '20230328', '20230325', 6, '0');

INSERT INTO crossroads.tbl_apply
(apply_course, apply_location, apply_date, apply_register_date, starter_member_id, apply_status)
VALUES('B', '경기도 안양시', '20230330', CURRENT_TIMESTAMP, 2, '0');


INSERT INTO crossroads.tbl_apply
(apply_course, apply_location, apply_date, apply_register_date, starter_member_id, veteran_member_id, apply_status)
VALUES('A', '서울특별시 송파구', '20230326', CURRENT_TIMESTAMP, 2, 1, '1');

INSERT INTO crossroads.tbl_apply
(apply_course, apply_location, apply_date, apply_register_date, starter_member_id, veteran_member_id, apply_status)
VALUES('B', '서울특별시 동작구', '20230328', CURRENT_TIMESTAMP, 4, 7, '1');


create table tbl_point
(
point_id int unsigned auto_increment primary key,
member_id int unsigned not null,
point_status int unsigned not null,
point_update_date date not null,
point_point int unsigned not null,
constraint foreign key (member_id) references tbl_member (member_id)
);
drop table tbl_board;
select * from tbl_board; 