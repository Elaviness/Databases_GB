use lesson7;

-- выборка покупателей совершивших хотя бы один заказ
SELECT
	u.id AS user_id, u.name,
	o.id AS order_id
FROM
	users AS u
RIGHT JOIN
	orders AS o
ON
	u.id = o.user_id;

insert into orders (id, user_id, created_at, updated_at) VALUE (1,2,now(),now());

SELECT
	u.id AS user_id, u.name,
	o.id AS order_id
FROM
	users AS u
RIGHT JOIN
	orders AS o
ON
	u.id = o.user_id;

-- вывести список товаров и ращделов, соответсвующих товару

SELECT
	p.id, p.name, p.price,
	c.name AS 'название каталога'
FROM
	products AS p
JOIN
	catalogs AS c
ON
	p.catalog_id = c.id;