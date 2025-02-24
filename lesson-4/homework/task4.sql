
create table letters
(letter char(1));

insert into letters
values ('a'), ('a'), ('a'), 
  ('b'), ('c'), ('d'), ('e'), ('f');


--b comes first

select * from letters
order by CASE
    when letter = 'b' then 1
    else 2
    end,
    letter


-- b comes last
select * from letters
order by CASE
    when letter = 'b' then 2
    else 1
    end,
    letter

-- b comes third

select * from letters
order by case
    when letter = 'b' then 2.5
    else row_number() over (order by letter)
    end;
