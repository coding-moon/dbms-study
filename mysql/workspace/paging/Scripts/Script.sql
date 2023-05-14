create database paging;
use paging;

create tbl_board(
	board_id int unsigned auto_increment primary key,
	board_title varchar(500),
	board_content varchar(500),
	board_grade_star tinyint default 0,
	board_status char(1) default 0 /*게시중, 블라인드*/
	member_id int unsigned auto_increment,
	constarint fk_board_member foreign key(member_id)
	references tbl_member(member_id)
);