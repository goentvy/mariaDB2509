-- ---<   >---
USE exdb;
SHOW TABLES;

SELECT orderID, CustomerID, OrderDate FROM orders;
SELECT CustomerID, CustomerName, ContactName, Country FROM customers;

-- inner join two table
SELECT o.OrderId, c.CustomerID, c.CustomerName 고객이름, o.OrderDate
FROM orders AS o
INNER JOIN customers AS c
ON o.CustomerId = c.CustomerID;

SELECT * FROM orders; -- 구매내역
SELECT * FROM customers; -- 고객정보
SELECT * FROM shippers; -- 배송업체

-- inner join three table
SELECT o.OrderID, c.CustomerID, c.CustomerName, s.ShipperID, s.ShipperName
FROM ((orders AS o
INNER JOIN customers AS c
	ON o.CustomerID = c.CustomerID)
INNER JOIN shippers AS s
	ON o.ShipperID = s.ShipperID);
	
-- left join two table
SELECT c.CustomerID, c.CustomerName, o.OrderID
FROM customers c
LEFT JOIN orders o
	ON c.CustomerID = o.CustomerID
	ORDER BY c.CustomerName;
	

SELECT * FROM orders;
SELECT * FROM employees;

-- right join two table
SELECT o.OrderID, e.EmployeeID, e.FirstName
FROM orders AS o
RIGHT JOIN employees AS e
	ON o.EmployeeID = e.EmployeeID
	ORDER BY o.EmployeeID;
	
SELECT * FROM customers;
SELECT * FROM orders;

-- cross join two table
SELECT c.CustomerID, c.CustomerName, o.OrderID
FROM customers c
CROSS JOIN orders o
WHERE c.CustomerID = o.CustomerID;

-- self join one table
SELECT c1.CustomerID, c1.CustomerName AS 'c1 고객이름', c1.City AS 'c1 도시',
			c2.CustomerID, c2.CustomerName AS 'c2 고객이름', c2.City AS 'c2 도시'
FROM customers c1, customers c2
WHERE c1.CustomerID <> c2.CustomerID
	AND c1.City = c2.City
	ORDER BY c1.City;

-- union
SELECT * FROM customers;
SELECT * FROM suppliers;

SELECT city FROM customers
UNION
SELECT city FROM suppliers
ORDER BY city;

-- union where
SELECT city, country FROM customers
WHERE country='germany'
UNION
SELECT city, country FROM suppliers
WHERE country='germany'
ORDER BY city;

-- union 모든 고객과 공급업체 나열
SELECT 'customer' AS TYPE, contactname, city, country
FROM customers
UNION
SELECT 'supplier', contactname, city, country
FROM suppliers;