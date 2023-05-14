create database kidza;
use kidza;

create table tbl_user(
	user_id bigint unsigned auto_increment primary key,
	user_identification varchar(300) unique not null,
	user_password varchar(300) not null,
	user_email varchar(300) not null,
	user_phoneNumber varchar(300),
	user_address varchar(300),
	user_register_date datetime default now()
);

create table tbl_enquiry_file (
	enquiry_file_id int unsigned auto_increment primary key,
	enquiry_id bigint unsigned,
	enquiry_system_name varchar(300) not null,
	enquiry_org_name varchar(300) not null,
	constraint fk_enquiry_file foreign key(enquiry_id) references tbl_customer_enquiry(enquiry_id) on delete cascade
);

create table tbl_customer_notice (
	notice_id int unsigned auto_increment primary key,
	notice_title varchar(200) not null,
	notice_context varchar(1000) not null,
	notice_date date,
	notice_alter_date date
);


create table tbl_customer_enquiry (
	enquiry_id bigint unsigned auto_increment primary key,
	user_id bigint unsigned,
	user_email varchar(300),
	enquiry_title varchar(300) not null,
	enquiry_content varchar(300) not null,
	enquiry_date datetime not null,
	enquiry_confirm boolean,
	constraint fk_customer_enquiry foreign key(user_id) references tbl_user(user_id) on delete cascade
);