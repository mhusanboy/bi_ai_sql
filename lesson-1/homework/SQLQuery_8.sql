drop table if exists books;

create table books(
    book_id integer IDENTITY(1,1) primary key,
    title text not null,
    price decimal CHECK (price>=0),
    genre varchar(127) constraint df_genre DEFAULT 'Unknown'
);

insert into books(title, price, genre)
values('Harry Potter', 50, 'Fiction'),('Ufq', 10, 'Romance');

insert into books(title, price)
values('The Little Prince', 20);




select * from books;