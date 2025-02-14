drop table if exists product;

create table product(
    product_id integer,
    product_name varchar(100),
    age int
    CONSTRAINT unique_product_id UNIQUE(product_id)
);

ALTER TABLE product
drop CONSTRAINT unique_product_id;

alter table product 
add CONSTRAINT unique_product_id unique(product_id, product_name);


