use spring;

create table tbl_board(
   board_id int unsigned auto_increment primary key,
   board_title varchar(500) not null,
   board_writer varchar(500) not null,
   board_content varchar(500) not null,
   board_register_date datetime default current_timestamp,
   board_update_date datetime default current_timestamp
);

create table tbl_file(
   file_id int unsigned auto_increment primary key,
   file_original_name varchar(500) not null,
   file_uuid varchar(500) not null,
   file_path varchar(500) not null,
   file_size varchar(100) not null,
   file_type char(1) default 0,
   board_id int unsigned not null,
   constraint fk_file_board foreign key(board_id) 
   references tbl_board(board_id)
);

select * from tbl_file;
