drop table if exists photos;

create table photos(
    id int identity primary key,
    image varbinary(max)
);

insert into photos 
select * from openrowset(
    BULK '/sqlfiles/lesson-2/homework/files/apple.png', single_blob
) as image;

