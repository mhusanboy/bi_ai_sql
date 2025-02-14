drop table if exists orders;

create table orders(
    order_id integer,
    customer_name text, 
    order_date date,
    constraint pk_order_id PRIMARY KEY(order_id)
);

alter table orders
drop CONSTRAINT pk_order_id;

alter table orders
add CONSTRAINT pk_order_id PRIMARY KEY(order_id);