use app;

create table tbl_file (
	file_id int unsigned auto_increment primary key,
	file_system_name varchar(500) not null,
	file_original_name varchar(500) not null,
	board_id int unsigned not null,
	constraint fk_file_board foreign key(board_id) references tbl_board(board_id)
);