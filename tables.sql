create database olist;
use olist;
######## customer table
create table customers
(customer_id VARCHAR(200),
customer_zip_code_prefix bigint,
customer_city VARCHAR(100),
customer_state VARCHAR(50),
constraint cust_pk primary key(customer_id)
);
select * from customers;
####### orders table
create table orders
(order_id VARCHAR(200),
customer_id	VARCHAR(200),
order_status VARCHAR(100),
order_purchase_timestamp VARCHAR(100),
order_delivered_customer_date VARCHAR(100),
constraint order_pk primary key(order_id),
constraint cust_o_fk foreign key(customer_id) references customers(customer_id)
);
select order_delivered_customer_date,cust_delivery_date from orders;
alter table orders drop column cust_delivery_date;
alter table orders add column cust_purchase_date datetime;
alter table orders add column cust_delivery_date datetime;
SET SQL_SAFE_UPDATES = 0;
update orders
set cust_purchase_date = str_to_date(order_purchase_timestamp,'%m/%d/%Y %H:%i');
update orders
set cust_delivery_date = str_to_date(order_delivered_customer_date,'%m/%d/%Y %H:%i');

drop table orders;
select count(customer_id) from customers;
######## product translation table
create table product_trans
(product_category_name VARCHAR(200),
product_category_name_english VARCHAR(200),
constraint prod_name_pk primary key(product_category_name)
);

######### products table
create table products
(product_id VARCHAR(200),
product_category_name VARCHAR(200),
product_weight_g INT,
product_length_cm INT,
product_height_cm INT,
product_width_cm INT,
constraint product_pk primary key(product_id),
constraint prod_name_fk foreign key(product_category_name) references product_trans(product_category_name)
);


######## Seller table
create table sellers
(
seller_id VARCHAR(200),
seller_zip_code_prefix bigint,
seller_city VARCHAR(100),
seller_state VARCHAR(50),
constraint seller_pk primary key(seller_id)
);

######## Order Items table
create table order_items
(
order_id VARCHAR(200),
product_id VARCHAR(200),
seller_id VARCHAR(200),
shipping_limit_date VARCHAR(200),
price float,
freight_value float,
constraint order_oi_fk foreign key(order_id) references orders(order_id),
constraint product_oi_fk foreign key(product_id) references products(product_id),
constraint seller_oi_fk foreign key(seller_id) references sellers(seller_id)
);
select shipping_limit_date,shipping_date from order_items;
alter table order_items drop column shipping_date;
alter table order_items add column shipping_date datetime;
update order_items
set shipping_date = str_to_date(shipping_limit_date,'%m/%d/%Y %H:%i');

# Payment table
create table order_payment
(order_id VARCHAR(200),
payment_sequential INT,
payment_type VARCHAR(100),
payment_installments INT,
payment_value float,
constraint order_op_fk foreign key(order_id) references orders(order_id)
);

# reviews table
create table order_review
(
review_id VARCHAR(200),
order_id VARCHAR(200),
review_score INT,
review_creation_date VARCHAR(200),
review_answer_timestamp VARCHAR(200),
constraint review_pk primary key(review_id),
constraint order_or_fk foreign key(order_id) references orders(order_id)
);

alter table order_review add column creation_date datetime;
update order_review
set creation_date = str_to_date(review_creation_date,'%m/%d/%Y %H:%i');

alter table order_review add column answer_timestamp datetime;
update order_review
set answer_timestamp = str_to_date(review_answer_timestamp,'%m/%d/%Y %H:%i');
