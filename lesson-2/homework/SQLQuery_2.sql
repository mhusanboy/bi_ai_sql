drop table if EXISTS data_types_demo;

create table data_types_demo(
    t_id UNIQUEIDENTIFIER primary key DEFAULT NEWID(),
    t_tinyint TINYINT,
    t_smallint SMALLINT,
    t_int int,
    t_bigint bigint,
    t_decimal DECIMAL (10, 3),
    t_float float, 
    t_char char(5),
    t_nchar nchar(6),
    t_varchar VARCHAR(10),
    t_nvarchar nvarchar(15),
    t_date DATE,
    t_time TIME,
    t_datetime DATETIME,
    t_varbinary varbinary(MAX)
);  

insert into data_types_demo(t_tinyint, t_smallint, t_int, t_bigint, t_decimal, t_float, t_char, t_nchar, t_varchar, t_nvarchar, t_date, t_time, t_datetime, t_varbinary)
select 
    0,
    -32768,
    -2147483648,
    -9223372036854775808,
    1234564.121,
    1.21,
    'char5',
    'nchar6',
    'varvhar10',
    'nvarchar10',
    '2025-02-14',
    '22:00:17.150',
    GETDATE(),
    * from openrowset(bulk '/sqlfiles/lesson-2/homework/files/words.docx', single_blob) as word_document;

select * from data_types_demo;