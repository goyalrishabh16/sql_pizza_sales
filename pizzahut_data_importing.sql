create database pizzahut;

create table orders (
order_id int not null,
order_date date not null,
order_time time not null,
primary key(order_id));

select @@secure_file_priv;

Load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Data/pizzahut/order_details.csv"
into table order_details
fields terminated by ','
ignore 1 lines;

Load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Data/pizzahut/orders.csv"
into table orders
fields terminated by ','
ignore 1 lines;

Load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Data/pizzahut/pizzas.csv"
into table pizzas
fields terminated by ','
ignore 1 lines;
