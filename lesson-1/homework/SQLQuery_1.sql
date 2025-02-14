drop table if exists students;

create table students(
    id integer,
    name text, 
    age int
);

ALTER TABLE students
alter column id integer not null;
