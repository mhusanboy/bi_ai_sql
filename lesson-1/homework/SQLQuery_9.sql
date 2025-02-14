
create table book(
    book_id integer identity primary key,
    title text,
    author text,
    published_year integer
);

create table member(
    member_id integer IDENTITY primary KEY,
    name text,
    email text,
    phone_number text
);

create table loan(
    loan_id INTEGER IDENTITY PRIMARY KEY,
    book_id INTEGER FOREIGN KEY REFERENCES book(book_id),
    member_id integer FOREIGN KEY REFERENCES member(member_id),
    loan_date date,
    return_date date null
);


insert into book(title, author, published_year)
values
(
    'Harry Potter',
    'J. K. Rowling',
    1999
),
(
    'The Little Prince',
    'Ekzyuperi',
    1980
);

insert into member(name, email, phone_number)
values
(
    'Husanboy Mansuraliyev',
    'mansuraliyev@ransom.com',
    '+998941234567'
),
(
    'Hasanboy Mansuraliyev',
    'mansuraliev_h@ransom.com',
    '+998931234567'
);



insert into loan(book_id, member_id, loan_date)
values(
    1, 1, GETDATE()
),
(
    1, 2, GETDATE()
);

select * from book;
select * from member;
select * from loan;