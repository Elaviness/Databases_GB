use bookstore;

drop trigger decrease_count;
create trigger decrease_count before insert on cheque for each row begin
    declare finished int default 0;
    declare curr_count int;
    declare curr_ISBN varchar(13);
    declare curr_space int;
    declare curr_order int;
    declare row_cursor cursor for
        select orders_id,books_ISBN, spaces_id, book_count
                    from short_order_info where short_order_info.orders_id = new.orders_id;
    DECLARE continue HANDLER FOR NOT FOUND SET finished = 1;
    OPEN row_cursor;
    while finished = 0 do
        FETCH row_cursor into curr_order,curr_ISBN,curr_space,curr_count;
        update spaces_has_books set count_in_space = count_in_space - curr_count
        where spaces_has_books.spaces_id = curr_space and
              books_ISBN = curr_ISBN and
              curr_order = new.orders_id;
        end while;
end;

drop trigger update_total_count;
create trigger update_total_count before update on spaces_has_books for each row
    if new.count_in_space is not null then
        update books set count = count - OLD.count_in_space + new.count_in_space
        where new.books_ISBN = ISBN;
    end if;

drop trigger discount_status;
create trigger discount_status after insert on cheque for each row begin
    declare client_sum decimal(10,2);
    declare curr_id int;
    select all_orders.total_sum, all_orders.id into client_sum, curr_id
        from all_orders where id =
                              (select clients_id from orders where orders.id = new.orders_id);
        if client_sum < 5000
            then update clients set discount_status = 0 where clients.id = curr_id;
        elseif client_sum = 5000 or client_sum > 5000 and client_sum <10000
            then update clients set discount_status = 5 where clients.id = curr_id;
        elseif client_sum = 5000 or client_sum > 10000 and client_sum < 20000
            then update clients set discount_status = 10 where clients.id = curr_id;
        elseif client_sum = 10000 or client_sum > 20000 and client_sum < 50000
            then update clients set discount_status = 15 where clients.id = curr_id;
        else update clients set discount_status = 25 where clients.id = curr_id;
    end if;
end;



