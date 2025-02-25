drop table if exists pq;

create table pq(
    id int, 
    name varchar(10),
    typed varchar(10)
);


insert into pq
VALUes(1, 'P', null), (1, null, 'Q');

select * from generate_series(1, 100);
