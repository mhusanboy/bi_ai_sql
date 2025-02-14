
drop table if exists item;
drop table if exists category;

create table category(
    category_id integer,
    category_name text,
    CONSTRAINT pk_category_id PRIMARY KEY(category_id)
);

create table item(
    item_id integer,
    item_name text,  
    category_id integer,
    constraint fk_category_id FOREIGN KEY(category_id) REFERENCES category(category_id),
    CONSTRAINT pk_item_id PRIMARY KEY(item_id)
);

alter table item
drop CONSTRAINT fk_category_id;

alter table item
add CONSTRAINT fk_category_id FOREIGN KEY(category_id) REFERENCES category(category_id);