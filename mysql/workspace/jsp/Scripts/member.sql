create database jsp;
use jsp;

create table tbl_member(
	member_id int unsigned auto_increment primary key,
	member_name varchar(500),
	member_birth date_format(datetime, '%y-%m-%d')
);