CREATE DATABASE ecommerce;
USE ecommerce;
CREATE TABLE gold_member_users (
    userid INT,
    user_name VARCHAR(50),
    signup_date DATE
);

CREATE TABLE users (
    userid INT,
    user_name VARCHAR(50),
    signup_date DATE
);

CREATE TABLE sales (
    userid INT,
    user_name VARCHAR(50),
    created_date DATE,
    product_id INT
);

CREATE TABLE product (
    product_id INT,
    product_name VARCHAR(50),
    price DECIMAL(10, 2)
);

INSERT INTO gold_member_users VALUES
(001,'John','2017-09-22'), (002,'Mary','2017-04-21');

INSERT INTO users VALUES
(001,'John','2014-09-02'), (003,'Michel','2015-01-15'), (002,'Mary','2014-04-11');

INSERT INTO sales VALUES
(001,'John','2017-04-19',2), (002,'Mary','2019-12-18',1), (003,'Michel','2020-07-20',3),
(001,'John','2019-10-23',2), (001,'John','2018-03-19',3), (002,'Mary','2016-12-20',2),
(001,'John','2016-11-09',1), (001,'John','2016-05-20',3), (002,'Michel','2017-09-24',1),
(001,'John','2017-03-11',2), (001,'John','2016-03-11',1), (002,'Mary','2016-11-10',1),
(002,'Mary','2017-12-07',2), (003,'Michel','2020-05-20',1), (003,'Michel','2020-01-20',3);

INSERT INTO product VALUES
(1,'Mobile',980), (2,'Ipad',870), (3,'Laptop',330);
SHOW TABLES;
SELECT 'gold_member_users' AS table_name, COUNT(*) AS record_count FROM gold_member_users
UNION ALL
SELECT 'users' AS table_name, COUNT(*) AS record_count FROM users
UNION ALL
SELECT 'sales' AS table_name, COUNT(*) AS record_count FROM sales
UNION ALL
SELECT 'product' AS table_name, COUNT(*) AS record_count FROM product;
SELECT users.userid, users.user_name, SUM(product.price) AS total_spent
FROM users
JOIN sales ON users.userid = sales.userid
JOIN product ON sales.product_id = product.product_id
GROUP BY users.userid, users.user_name;
SELECT DISTINCT created_date AS date, user_name AS customer_name
FROM sales;
SELECT u.user_name, p.product_name
FROM users u
JOIN sales s ON u.userid = s.userid
JOIN product p ON s.product_id = p.product_id
GROUP BY u.user_name
ORDER BY MIN(s.created_date);
SELECT u.user_name, p.product_name, COUNT(*) AS item_count
FROM users u
JOIN sales s ON u.userid = s.userid
JOIN product p ON s.product_id = p.product_id
GROUP BY u.user_name, p.product_name
ORDER BY u.user_name, item_count DESC
LIMIT 1;
SELECT *
FROM users u
WHERE userid NOT IN (SELECT userid FROM gold_member_users);
SELECT u.user_name, SUM(p.price) AS total_spent
FROM gold_member_users g
JOIN sales s ON g.userid = s.userid
JOIN product p ON s.product_id = p.product_id
JOIN users u ON g.userid = u.userid
GROUP BY u.user_name;
SELECT user_name
FROM users
WHERE user_name LIKE 'M%';
SELECT DISTINCT userid, user_name
FROM users;
ALTER TABLE product CHANGE price price_value DECIMAL(10, 2);
SET SQL_SAFE_UPDATES = 0;
UPDATE product
SET product_name = 'Iphone'
WHERE product_name = 'Ipad' AND product_id = 2;
ALTER TABLE gold_member_users RENAME TO gold_membership_users;
ALTER TABLE gold_membership_users ADD COLUMN Status ENUM('Yes', 'No') DEFAULT 'No';
START TRANSACTION;
DELETE FROM users WHERE userid = 1;
-- ROLLBACK; -- Uncomment this line to rollback changes
DELETE FROM users WHERE userid = 2;
INSERT INTO product VALUES (3, 'Laptop', 330);
SELECT product_id, product_name, COUNT(*)
FROM product
GROUP BY product_id, product_name
HAVING COUNT(*) > 1;