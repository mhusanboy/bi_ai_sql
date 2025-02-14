drop table if exists account;

create table account(
    account_id integer PRIMARY KEY,
    balance decimal,
    account_type varchar(10),
    CONSTRAINT check_balance CHECK(balance>=0),
    CONSTRAINT check_account_type CHECK(account_type in ('Checking', 'Saving'))
);

alter table account 
drop CONSTRAINT check_balance;


alter table account 
drop CONSTRAINT check_account_type;


alter table account 
add CONSTRAINT check_balance CHECK(balance>=0);


alter table account 
add CONSTRAINT check_account_type CHECK(account_type in ('Checking', 'Saving'));