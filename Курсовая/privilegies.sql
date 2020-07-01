CREATE USER 'customer'@'localhost' IDENTIFIED BY '123';
CREATE USER 'manager'@'localhost' IDENTIFIED BY '123';


GRANT SELECT ON BookStore.orders TO 'customer'@'localhost';
GRANT SELECT ON BookStore.books_has_orders TO 'customer'@'localhost';
GRANT SELECT ON BookStore.cheque TO 'customer'@'localhost';
GRANT SELECT ON BookStore.books TO 'customer'@'localhost';


GRANT UPDATE ON BookStore.clients to 'customer'@'localhost';

GRANT INSERT ON BookStore.orders TO 'customer'@'localhost';


GRANT SELECT ON BookStore.orders TO 'manager'@'localhost';
GRANT SELECT ON BookStore.books_has_orders TO 'manager'@'localhost';
GRANT SELECT ON BookStore.cheque TO 'manager'@'localhost';
GRANT SELECT ON BookStore.books TO 'manager'@'localhost';
GRANT SELECT ON BookStore.supplies TO 'manager'@'localhost';
GRANT SELECT ON BookStore.requests TO 'manager'@'localhost';
GRANT SELECT ON BookStore.report_month TO 'manager'@'localhost';


GRANT UPDATE ON BookStore.orders TO 'manager'@'localhost';
