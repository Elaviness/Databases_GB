-- Транзакции, переменные, представления

-- №1 Переместить запись id=1 из таблицы shop.users (в прошлом задании этой базе было иное имя)
-- используя транзакции запись в таблицу sample.users
use sample;

START TRANSACTION;
INSERT INTO sample.users SELECT * FROM lesson7.users WHERE id = 1;
COMMIT;

-- №2 Создайте представление, которое выводит название товарной позиции
-- из таблицы products и соответствующее название каталога из таблицы catalogs

use lesson7;

create or replace view name_and_catalog as
    select p.name as product, c.name as catalog from products p,catalogs c
    where p.catalog_id = c.id;

-- Хранимые процедуры и функции, триггеры

-- №1 Создайте хранимую функцию hello(), которая будет возвращать приветствие,
-- в зависимости от текущего времени суток. (на свое усмотрение изменила диапазон вечера)
DROP PROCEDURE IF EXISTS hello;

CREATE PROCEDURE hello()
BEGIN
	CASE
		WHEN CURTIME() BETWEEN '06:00:00' AND '12:00:00' THEN
			SELECT 'Доброе утро';
		WHEN CURTIME() BETWEEN '12:00:00' AND '18:00:00' THEN
			SELECT 'Добрый день';
		WHEN CURTIME() BETWEEN '18:00:00' AND '23:00:00' THEN
			SELECT 'Добрый вечер';
		ELSE
			SELECT 'Доброй ночи';
	END CASE;
END;


CALL hello();

-- №2 В таблице products есть два текстовых поля:
-- name с названием товара и description с его описанием.
-- Допустимо присутствие обоих полей или одно из них.
-- Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема.
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.
alter table products add column description varchar(255);

DROP TRIGGER IF EXISTS nullTrigger;

CREATE TRIGGER nullTrigger BEFORE INSERT ON lesson7.products
FOR EACH ROW
BEGIN
	IF(ISNULL(NEW.name) AND ISNULL(NEW.description)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Trigger Warning! NULL in both fields!';
	END IF;
END;
