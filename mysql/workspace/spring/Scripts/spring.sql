create database spring;
use spring;

create table product(
	product_id int unsigned auto_increment primary key,
	product_name varchar(500) not null,
	product_price int default 0,
	product_stock int default 0
);

select * from product;



alter table product rename to tbl_product;

create table tbl_order(
	order_id int unsigned auto_increment primary key,
	product_id int unsigned,
	product_count int default 1,
	order_date datetime default current_timestamp(),
	constraint fk_order_product foreign key(product_id)
	references tbl_product(product_id)
);

