

-- three tables (employees, orders, products) were created as in ddl statement in the task description.


select Case
    when Status in ('Shipped', 'Delivered') then 'Completed'
    else Status
end as OrderStatus,  sum(TotalAmount) as TotalRevenue from orders
where OrderDate between '2023-01-01' and '2023-12-31'
group by Case
    when Status in ('Shipped', 'Delivered') then 'Completed'
    else Status
end
having sum(TotalAmount) > 5000
order by TotalRevenue desc