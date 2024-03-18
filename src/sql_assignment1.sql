-- 1. create database as ecommerce
CREATE DATABASE ecommerce;
USE ecommerce;
-- 2.Create a tables(old_member_users,users,sales,product)under the above database(ecommerce)
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
-- 3.Insert the values provided above with respective datatypes
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
-- 4.Show all the tables in the same database(ecommerce)
SHOW TABLES;
-- 5.Count all the records of all the four tables using single query
SELECT 'gold_member_users' AS table_name, COUNT(*) AS record_count FROM gold_member_users
UNION ALL
SELECT 'users' AS table_name, COUNT(*) AS record_count FROM users
UNION ALL
SELECT 'sales' AS table_name, COUNT(*) AS record_count FROM sales
UNION ALL
SELECT 'product' AS table_name, COUNT(*) AS record_count FROM product;
-- 6. The total amount each customer spent on ecommerce company
SELECT users.userid, users.user_name, SUM(product.price) AS total_spent
FROM users
JOIN sales ON users.userid = sales.userid
JOIN product ON sales.product_id = product.product_id
GROUP BY users.userid, users.user_name;
-- 7.Finding the distinct dates of each customer visited the website
SELECT DISTINCT created_date AS date, user_name AS customer_name
FROM sales;
-- 8.To find the first product purchased by each customer using 3 tables(users,sales,product)
SELECT u.user_name, p.product_name
FROM users u
JOIN sales s ON u.userid = s.userid
JOIN product p ON s.product_id = p.product_id
GROUP BY u.user_name
ORDER BY MIN(s.created_date);
-- 9.The most purchased item of each customer and how many times the customer has purchased it.
SELECT u.user_name, p.product_name, COUNT(*) AS item_count
FROM users u
JOIN sales s ON u.userid = s.userid
JOIN product p ON s.product_id = p.product_id
GROUP BY u.user_name, p.product_name
ORDER BY u.user_name, item_count DESC
LIMIT 1;
-- 10.To Find out the customer who is not the gold_member_user
SELECT *
FROM users u
WHERE userid NOT IN (SELECT userid FROM gold_member_users);
-- 11.The amount spent by each customer when he was the gold_member user
SELECT u.user_name, SUM(p.price) AS total_spent
FROM gold_member_users g
JOIN sales s ON g.userid = s.userid
JOIN product p ON s.product_id = p.product_id
JOIN users u ON g.userid = u.userid
GROUP BY u.user_name;
-- 12.Find the Customers names whose name starts with M
SELECT user_name
FROM users
WHERE user_name LIKE 'M%';
-- 13.Find the Distinct customer Id of each customer
SELECT DISTINCT userid, user_name
FROM users;
-- 14.Change the Column name from product table as price_value from price
ALTER TABLE product CHANGE price price_value DECIMAL(10, 2);
-- 15.Change the column value product_name -IPad to Iphone from product_table
SET SQL_SAFE_UPDATES = 0;
-- 16.Change the table name of gold_member_users to gold_membership_users
UPDATE product
SET product_name = 'Iphone'
WHERE product_name = 'Ipad' AND product_id = 2;
-- 16.Change the table name of gold_member_users to gold_membership_users
ALTER TABLE gold_member_users RENAME TO gold_membership_users;
-- 17.Create a new column as Status in the table create above gold_membership_users the Status values should be 2 Yes and No if the user is goldmember,then status should be Yes else No.
ALTER TABLE gold_membership_users ADD COLUMN Status ENUM('Yes', 'No') DEFAULT 'No';
-- 18.Delete the users_ids 1,2 from users table and roll the back changes once both the rows are deleted one by one mention the result
START TRANSACTION;
DELETE FROM users WHERE userid = 1;
-- ROLLBACK; -- Uncomment this line to rollback changes
DELETE FROM users WHERE userid = 2;
-- ROLLBACK; -- Uncomment this line to rollback changes
-- 19.Insert one more record as same(3,'Laptop',330) as producttable
INSERT INTO product VALUES (3, 'Laptop', 330);
-- 20.Write a query to find the duplicates in product_table
SELECT product_id, product_name, COUNT(*)
FROM product
GROUP BY product_id, product_name
HAVING COUNT(*) > 1;