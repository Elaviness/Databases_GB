select distinct full_name,spaces_id from employees left join orders o on employees.id = o.employees_id
    where o.id = ( select orders_id from short_order_info where orders_id = (
            select sum(book_count) from short_order_info group by orders_id order by sum(book_count) desc limit 1
        )
    );

/* select orders_id from books_has_orders having sum(bho.book_count) >= ALl(
            select sum(bho.book_count) from books_has_orders group by bho.orders_id */