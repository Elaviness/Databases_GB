use bookstore;

create or replace view not_enough_books as
    select spaces_id,ISBN,title,count_in_space from spaces_has_books,books
    where count_in_space <10 and books_ISBN=ISBN;

create or replace view not_paid_orders as
    select orders.id from orders
        left join cheque on orders.id=orders_id
    where orders_id is null;

create or replace view report_month as
    select books_ISBN,SUM(book_count) as count from books_has_orders
    where orders_id in (select orders.id from orders,cheque
    where orders.id=orders_id and orders_id is not null and month(purshase_time)=month(now()))
    group by books_ISBN;

create or replace view all_orders as
    select clients.id,full_name,sum(total_price) as total_sum from clients,orders
    where clients.id = clients_id
    group by full_name;

create or replace view short_order_info as
    select orders_id,books_ISBN,book_count,employees.spaces_id from orders
        left join books_has_orders on orders.id = books_has_orders.orders_id
        inner join employees on employees_id = employees.id;

