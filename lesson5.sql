create database if not exists lesson5;
use lesson5;
drop table if exists my_users;
create table my_users  -- создание таблицы пользователей для второго задания
(
    id serial primary key,
    name varchar(25),
    birthday date,
    created_at varchar(20),
    updated_at varchar(20)
);

-- пользователи были сгенерированы при помощи fildb.info
INSERT INTO `my_users` VALUES ('1','Keely','2004-02-06','21.08.2004 21:34:17','08.12.2004 11:06:29'),
('2','Roxanne','1977-10-17','28.02.1995 05:09:03','28.01.2000 12:36:55'),
('3','Jayme','2018-12-30','27.09.2019 15:04:54','13.10.2019 06:21:53'),
('4','Syble','1970-04-18','09.01.2006 09:43:03','11.02.2008 14:54:55'),
('5','Giuseppe','1991-04-18','05.07.2006 20:45:58','10.03.2009 06:40:51');

select * from my_users;

update my_users set created_at = str_to_date(created_at, '%d.%m.%Y %k:%i:%j'),
                    updated_at = str_to_date(updated_at, '%d.%m.%Y %k:%i:%j');

select * from my_users;
describe my_users;

alter table my_users change created_at created_at datetime;
alter table my_users change updated_at updated_at datetime;

select * from my_users;
describe my_users;

-- задание 2 по агрегатным функциям
select date_format(date(concat_ws('-',YEAR(NOW()), month(birthday), day(birthday))), '%W') as week_day,
       count(*) as day_count
from my_users group by week_day order by day_count;

-- выполнение первого задания
update my_users set created_at = NULL,
                    updated_at = NULL;

select * from my_users;

update my_users set created_at = now(),
                    updated_at = now();

select * from my_users;

-- выполнение третьего задания
DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

-- наполнение сгенерировано
INSERT INTO `storehouses_products` VALUES ('1','4','2','0','1977-03-04 00:44:41','2017-03-05 22:51:50'),
('2','9','7','1314','1978-04-13 06:24:54','2000-04-24 19:51:42'),
('3','2','5','580','1972-04-01 11:13:31','1995-09-07 09:32:17'),
('4','1','5','1863','2013-09-10 11:27:08','1977-07-16 07:18:32'),
('5','2','8','00','1984-02-29 06:18:48','2000-07-30 20:32:34'),
('6','0','1','1814','1978-02-02 00:03:48','1997-04-26 16:30:26'),
('7','3','1','1558','1981-07-13 19:09:46','2013-01-04 12:53:51'),
('8','8','5','1825','1970-12-02 17:08:55','2013-04-26 02:51:50'),
('9','9','4','570','2019-05-03 22:58:00','1996-06-10 07:00:45'),
('10','0','7','367','1984-06-14 00:17:35','1994-12-28 08:04:28');

select * from storehouses_products order by if(value > 0,0,1), value;


-- агрегатные функции
-- среднее значение возраста пользователей
select avg(timestampdiff(year, birthday,now())) as avg_age from my_users;

-- дни недели дней рождений пользователей в текущем году (корректно используются ранее)
select date_format(date(concat_ws('-',YEAR(NOW()), month(birthday), day(birthday))), '%W') as week_day
from my_users;
