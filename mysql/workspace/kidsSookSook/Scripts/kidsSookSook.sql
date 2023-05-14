create database kids;
create table tbl_user(
	user_id bigint unsigned auto_increment primary key,
	user_identification varchar(300) unique not null,
	user_password varchar(300) not null,
	user_email varchar(300) unique not null,
	user_phoneNumber varchar(300),
	user_address varchar(300),
	user_register_date datetime default now()
);
create table tbl_member (
	user_id bigint unsigned,
	member_name varchar(300) not null,
	member_nickname varchar(300) /*not null*/,
	member_gender varchar(300), 
	constraint fk_member_id foreign key(user_id) references tbl_user(user_id) on delete cascade, 
	constraint primary key(user_id)
);
create table tbl_member_file(
	file_id int unsigned auto_increment primary key,
	user_id bigint unsigned,
	system_name varchar(300) not null,
	org_name varchar(300) not null,
	constraint fk_member_file foreign key(user_id) references tbl_member(user_id) on delete cascade
);
create table tbl_institution (
	user_id bigint unsigned,
	institution_name varchar(300),
	institution_business_number varchar(300),
	constraint fk_institution_id foreign key(user_id) references tbl_user(user_id) on delete cascade, 
	constraint primary key(user_id)
);
create table tbl_institution_file (
	institution_file_id int unsigned auto_increment primary key,
	user_id bigint unsigned,
	institution_system_name varchar(300) not null,
	institution_org_name varchar(300) not null,
	constraint fk_institution_file foreign key(user_id) references tbl_institution(user_id) on delete cascade
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
create table tbl_enquiry_file (
   enquiry_file_id int unsigned auto_increment primary key,
   enquiry_id bigint unsigned,
   enquiry_system_name varchar(300) not null,
   enquiry_org_name varchar(300) not null,
   constraint fk_enquiry_file foreign key(enquiry_id) references tbl_customer_enquiry(enquiry_id) on delete cascade
);
create table tbl_category(
	category_id int unsigned auto_increment primary key,
	category_name varchar(200) not null
);
create table tbl_field_trip (
	field_trip_id bigint unsigned auto_increment primary key,
	user_id bigint unsigned,
	category_id int unsigned,
	field_trip_name varchar(300),
	field_trip_registation_date datetime default now(),
	field_trip_deadline_date date,
	field_trip_program_date date,
	field_trip_place varchar(300),
	field_trip_price int default '0',
	field_trip_context_description varchar(800),
	constraint fk_field_trip_user_id foreign key(user_id) references tbl_user(user_id),
	constraint fk_field_trip_category_id foreign key(category_id) references tbl_category(category_id)
);
create table tbl_review (
   review_id bigint unsigned auto_increment primary key,
   user_id bigint unsigned,
   field_trip_id bigint unsigned,
   review_write_date datetime default now(),
   review_alter_date datetime default now(),
   review_context varchar(1000),
   constraint fk_review_user_id foreign key(user_id) references tbl_user(user_id),
   constraint fk_review_id foreign key(field_trip_id) references tbl_field_trip(field_trip_id)
);
create table tbl_field_trip_file (
	field_trip_file_id int unsigned auto_increment primary key,
	field_trip_id bigint unsigned,
	field_trip_system_name varchar(300) not null,
	field_trip_org_name varchar(300) not null,
	constraint fk_field_trip_file_fieldTrip_id foreign key(field_trip_id) references tbl_field_trip(field_trip_id) on delete cascade
);
create table tbl_field_trip_detail (
	field_trip_detail_id int unsigned auto_increment primary key,
	field_trip_id bigint unsigned,
	field_trip_detail_context varchar(300),
	field_trip_detail_institution_info varchar(300),
	field_trip_detail_use_time varchar(50),
	field_trip_detail_refund_policy varchar(1000),
	constraint fk_field_trip_detail foreign key(field_trip_id) references tbl_field_trip(field_trip_id) on delete cascade
);
create table tbl_field_trip_recommend (
	field_trip_recommend_id int unsigned auto_increment primary key,
	user_id bigint unsigned,
	field_trip_id bigint unsigned,
	constraint fk_field_trip_recommend_user_id foreign key(user_id) references tbl_user(user_id) on delete cascade,
 	constraint fk_field_trip_recommend_id foreign key(field_trip_id) references tbl_field_trip(field_trip_id) on delete cascade
);
create table tbl_payment (
	payment_id int unsigned auto_increment primary key,
	user_id bigint unsigned,
	field_trip_id bigint unsigned,
	payment_headcount int,
	payment_amount int default '0',
	payment_date datetime default now(),
	constraint payment_user_id foreign key(user_id) references tbl_member(user_id) on delete cascade,
	constraint payment_field_trip_id foreign key(field_trip_id) references tbl_field_trip(field_trip_id) on delete cascade
);
create table tbl_customer_notice (
   notice_id int unsigned auto_increment primary key,
   notice_title varchar(200) not null,
   notice_context varchar(1000) not null,
   notice_date date,
   notice_alter_date date
);
create table tbl_cash (
	cash_id bigint unsigned auto_increment primary key,
	user_id bigint unsigned,
	payment_cash int,
	review_cash int,
	cash_save_date datetime,
	review_save_date datetime,
	constraint cash_member_id foreign key(user_id) references tbl_member(user_id) on delete cascade
);
create view view_member_info as
select m1.user_id, member_name, member_nickname, member_gender, user_identification, 
user_password, user_email, user_phoneNumber, user_address, user_register_date,
mf.file_id, mf.system_name, mf.org_name
from
(
	select u.user_id, member_name, member_nickname, member_gender, user_identification, 
	user_password, user_email, user_phoneNumber, user_address, user_register_date
	from tbl_member m join tbl_user u 
	on m.user_id = u.user_id
)m1 left outer join tbl_member_file mf
on m1.user_id = mf.user_id;
create view view_institution_info as
select t1.user_id, institution_name , institution_business_number , user_identification, 
	user_password, user_email, user_phoneNumber, user_address, user_register_date,
	tf.institution_file_id, tf.institution_system_name, tf.institution_org_name
from 
(
	select t.user_id, institution_name , institution_business_number , user_identification, 
	user_password, user_email, user_phoneNumber, user_address, user_register_date
	from tbl_institution t join tbl_user u 
	on t.user_id = u.user_id
)t1 left outer join tbl_institution_file tf 
on t1.user_id = tf.user_id;
create view view_field_trip as
select d1.field_trip_id, category_id, category_name, user_id, field_trip_registation_date, field_trip_deadline_date,
field_trip_program_date, field_trip_place, field_trip_price, field_trip_context_description,
field_trip_system_name, field_trip_org_name, field_trip_name
from
(
select field_trip_id, c.category_id, category_name, user_id, field_trip_registation_date, field_trip_deadline_date,
field_trip_program_date, field_trip_place, field_trip_price, field_trip_context_description, field_trip_name
from tbl_category c join tbl_field_trip t
on c.category_id = t.category_id
) d1 left outer join tbl_field_trip_file tf
on d1.field_trip_id = tf.field_trip_id;
create view view_user_payment as
select d1.payment_id, d1.user_id, user_identification, d1.field_trip_id,payment_amount, payment_date
from
	(
	select payment_id, p.user_id, field_trip_id, payment_amount, payment_date, user_identification
	from tbl_payment p join tbl_user u 
	on p.user_id = u.user_id 
	) d1 join tbl_field_trip f 
on d1.field_trip_id = f.field_trip_id ;
create view view_field_tripDTO as
select f.field_trip_id, category_id, category_name, user_id, field_trip_name, field_trip_registation_date, field_trip_deadline_date,
field_trip_program_date, field_trip_place, field_trip_price, field_trip_context_description,
ifnull(d1.recommemd_count, 0) as recommend_count,
field_trip_system_name, field_trip_org_name
from view_field_trip f
left outer join
(
select r.field_trip_id , count(r.field_trip_recommend_id) as recommemd_count
from tbl_field_trip_recommend r
group by r.field_trip_id
) d1
on f.field_trip_id = d1.field_trip_id;
create view view_field_trip_top10 as
select d1.field_trip_id, user_id, category_id, field_trip_name, field_trip_registation_date,
field_trip_deadline_date, field_trip_program_date, field_trip_place, field_trip_price,
field_trip_context_description, field_trip_system_name, field_trip_org_name
from tbl_field_trip_file tftf right outer join
(
	select tft.field_trip_id, tft.user_id, category_id, field_trip_name, field_trip_registation_date,
	field_trip_deadline_date, field_trip_program_date, field_trip_place, field_trip_price,
	field_trip_context_description
	from tbl_field_trip tft join tbl_payment tp
	on tft.field_trip_id = tp.field_trip_id and payment_date > date_add(now(), interval -7 day)
	group by field_trip_id
	order by count(payment_headcount) desc
	limit 10
) d1
on tftf.field_trip_id = d1.field_trip_id;