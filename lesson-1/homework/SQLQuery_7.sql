drop table if EXISTS invoice;

create table invoice(
    invoice_id integer IDENTITY(1,1) PRIMARY KEY,
    amount decimal,
);

insert into invoice(amount)
values(1.1), (1.2), (1.3), (1.4), (1.5);

set IDENTITY_INSERT invoice on;

insert into invoice(invoice_id, amount) values(100, 1.6);
set IDENTITY_INSERT invoice off;

select * from invoice;