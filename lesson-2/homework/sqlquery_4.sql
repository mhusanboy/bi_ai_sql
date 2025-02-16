drop table if exists student;

create table student(
    student_id integer primary key IDENTITY,
    classes integer,
    tuition_per_class float,
    total_tution as (tuition_per_class * classes)
);

insert into student
values (4, 200.0), (5,155.5), (6, 205);

select * from student;