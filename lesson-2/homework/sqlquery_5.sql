drop table if exists worker;

create table worker(
    id integer primary key,
    name nvarchar(50)
);

BULK INSERT worker
from '/sqlfiles/lesson-2/homework/files/worker.csv'
with(
    firstrow=2,
    fieldterminator=',',
    rowterminator='\n'
);

select * from worker;