update spaces_has_books set count_in_space = 5 where id = 2;

insert into orders
    (clients_id, employees_id, delivery_address, delivery_date, delivery_cost, order_cost, delivery_status, total_count, total_price)
    value (10,13,'Студенческая Ул., дом 23/А',now(),0.00,500.00,3,1,500.00);
insert into books_has_orders (books_ISBN, orders_id, book_count, position_cost) VALUE
    (9785498075808,8,1,500.00);

insert into cheque (purshase_time, orders_id, tax) VALUE (now(),8,10);

USE bookstore;

select orders_id, sum(book_count) as summary from books_has_orders group by orders_id order by summary desc limit 1;-- group by orders_id having max(book_count);


create database if not exists dekanate;
use dekanate;

create table `groups` (
    `group_code` int not null,
    `kurs` int,
    `stud_count` int,
    `hours` int,
    PRIMARY KEY (`group_code`)
);

create table if not exists `discipline` (
    `id` int not null ,
    `name` varchar(30),
    `category` varchar(30),
    `hours` int,
    PRIMARY KEY (`id`)
);

create table if not exists `attestation` (
    `id` int not null ,
    `FIO_prep` varchar(100),
    `att_type` bool,
    `att_date` datetime,
    `group_id` int NOT NULL,
    `disc_id` int NOT NULL ,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`group_id`) references `groups` (`group_code`),
    FOREIGN KEY (`disc_id`) references `discipline` (`id`)
);

INSERT INTO `groups` (`group_code`, `kurs`, `stud_count`, `hours`) VALUES (0, 5, 26, 143);
INSERT INTO `groups` (`group_code`, `kurs`, `stud_count`, `hours`) VALUES (1, 5, 20, 157);
INSERT INTO `groups` (`group_code`, `kurs`, `stud_count`, `hours`) VALUES (2, 2, 23, 132);
INSERT INTO `groups` (`group_code`, `kurs`, `stud_count`, `hours`) VALUES (3, 2, 29, 104);
INSERT INTO `groups` (`group_code`, `kurs`, `stud_count`, `hours`) VALUES (4, 3, 14, 156);
INSERT INTO `groups` (`group_code`, `kurs`, `stud_count`, `hours`) VALUES (5, 4, 13, 91);
INSERT INTO `groups` (`group_code`, `kurs`, `stud_count`, `hours`) VALUES (6, 1, 22, 134);
INSERT INTO `groups` (`group_code`, `kurs`, `stud_count`, `hours`) VALUES (7, 3, 17, 164);
INSERT INTO `groups` (`group_code`, `kurs`, `stud_count`, `hours`) VALUES (8, 2, 27, 178);
INSERT INTO `groups` (`group_code`, `kurs`, `stud_count`, `hours`) VALUES (9, 4, 22, 178);

INSERT INTO `discipline` (`id`, `name`, `category`, `hours`) VALUES (0, 'eius', 'molestias', 98);
INSERT INTO `discipline` (`id`, `name`, `category`, `hours`) VALUES (1, 'iste', 'non', 117);
INSERT INTO `discipline` (`id`, `name`, `category`, `hours`) VALUES (9995, 'autem', 'sit', 150);
INSERT INTO `discipline` (`id`, `name`, `category`, `hours`) VALUES (48912, 'consequuntur', 'ut', 113);
INSERT INTO `discipline` (`id`, `name`, `category`, `hours`) VALUES (57329, 'autem', 'asperiores', 121);
INSERT INTO `discipline` (`id`, `name`, `category`, `hours`) VALUES (95782, 'similique', 'maxime', 98);
INSERT INTO `discipline` (`id`, `name`, `category`, `hours`) VALUES (907382, 'ea', 'incidunt', 108);
INSERT INTO `discipline` (`id`, `name`, `category`, `hours`) VALUES (4117754, 'laboriosam', 'quidem', 93);
INSERT INTO `discipline` (`id`, `name`, `category`, `hours`) VALUES (9844238, 'sit', 'facilis', 87);
INSERT INTO `discipline` (`id`, `name`, `category`, `hours`) VALUES (460041473, 'accusantium', 'iure', 118);

INSERT INTO `attestation` (`id`, `FIO_prep`, `att_type`, `att_date`, `group_id`, `disc_id`) VALUES (126, 'Jayne Hilpert', 0, '2004-06-11 13:11:21', 1, 1);
INSERT INTO `attestation` (`id`, `FIO_prep`, `att_type`, `att_date`, `group_id`, `disc_id`) VALUES (493, 'Ms. Mara Greenholt', 1, '2009-08-01 23:58:14', 0, 0);
INSERT INTO `attestation` (`id`, `FIO_prep`, `att_type`, `att_date`, `group_id`, `disc_id`) VALUES (4916, 'Antonia Johnston', 0, '1999-02-24 23:59:48', 2, 9995);
INSERT INTO `attestation` (`id`, `FIO_prep`, `att_type`, `att_date`, `group_id`, `disc_id`) VALUES (2244, 'Miss Stephanie Torp', 1, '2004-04-13 14:03:45', 1, 57329);
INSERT INTO `attestation` (`id`, `FIO_prep`, `att_type`, `att_date`, `group_id`, `disc_id`) VALUES (1830, 'Murray Erdman', 0, '2017-03-09 19:53:53', 5, 95782);
INSERT INTO `attestation` (`id`, `FIO_prep`, `att_type`, `att_date`, `group_id`, `disc_id`) VALUES (323, 'Chloe Corwin', 1, '2016-12-05 10:19:07', 1, 460041473);
INSERT INTO `attestation` (`id`, `FIO_prep`, `att_type`, `att_date`, `group_id`, `disc_id`) VALUES (3125, 'Prof. Alverta Streich', 0, '2011-07-03 22:27:56', 7, 4117754);
INSERT INTO `attestation` (`id`, `FIO_prep`, `att_type`, `att_date`, `group_id`, `disc_id`) VALUES (5381, 'Dr. Petra O\'Conner', 1, '2004-04-06 08:48:42', 1, 9844238);
INSERT INTO `attestation` (`id`, `FIO_prep`, `att_type`, `att_date`, `group_id`, `disc_id`) VALUES (26294, 'Cydney Gutmann MD', 0, '2006-03-06 13:28:20', 6, 907382);
INSERT INTO `attestation` (`id`, `FIO_prep`, `att_type`, `att_date`, `group_id`, `disc_id`) VALUES (47540, 'Destinee Gorczany', 1, '1993-12-09 06:03:30', 1, 48912);

select group_id,att_date from attestation group by group_id,att_date order by group_id,att_date;

select group_id, DATEDIFF(max(att_date),min(att_date)) from attestation group by group_id;

select FIO_prep,sum(stud_count) as summary from attestation join `groups` g on attestation.group_id = g.group_code where att_type = 1 group by FIO_prep order by summary desc limit 1;

select name, count(name) as cnt from discipline join attestation a on discipline.id = a.disc_id where group_id = 1 group by name;