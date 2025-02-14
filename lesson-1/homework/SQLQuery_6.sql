drop table if EXISTS customer;

create table customer(
    customer_id integer,
    name text,
    city text constraint df_city DEFAULT 'Unknown'
);

alter table customer
drop CONSTRAINT df_city;

alter TABLE customer
add CONSTRAINT df_city DEFAULT 'Unknown' for city;

