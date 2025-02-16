drop table if exists test_identity;

create table test_identity(
    test_id integer primary key identity(1,1),
    test_name nvarchar(127)
);

insert into test_identity values('name1'), ('name2'), ('name3'), ('name4'), ('name5'), ('name6');
select * from test_identity;

drop table test_identity;

select * from test_identity -- gives an error because the table is removed from the database;

--same table creation step after drop

drop table if exists test_identity;

create table test_identity(
    test_id integer primary key identity(1,1),
    test_name nvarchar(127)
);

insert into test_identity values('name1'), ('name2'), ('name3'), ('name4'), ('name5'), ('name6');
select * from test_identity;

TRUNCATE table test_identity;
select * from test_identity; -- table exists but emptied
insert into test_identity values('name1'); -- identity is reset to initial value
select * from test_identity; -- to see if id starts from 1 (yes it started from 1)

--same table creation step after drop

drop table if exists test_identity;

create table test_identity(
    test_id integer primary key identity(1,1),
    test_name nvarchar(127)
);

insert into test_identity values('name1'), ('name2'), ('name3'), ('name4'), ('name5'), ('name6');
select * from test_identity;

delete from test_identity; --table is emptied. but identity is not reset.
insert into test_identity values('name1') -- identity starts from 7
select * from test_identity; -- test_id started from 7

select name from sys.databases;