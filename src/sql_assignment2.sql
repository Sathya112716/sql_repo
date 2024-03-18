-- 1.create table product_details
CREATE TABLE product_details (
    sell_date DATE,
    product VARCHAR(50)
);
-- 2.Insert data into product_details table
INSERT INTO product_details (sell_date, product) VALUES
('2020-05-30', 'Headphones'),
('2020-06-01', 'Pencil'),
('2020-06-02', 'Mask'),
('2020-05-30', 'Basketball'),
('2020-06-01', 'Book'),
('2020-06-02', 'Mask'),
('2020-05-30', 'T-Shirt');
-- 3.Query to find the number of different products sold and their names for each date
SELECT sell_date, COUNT(DISTINCT product) AS num_products, GROUP_CONCAT(DISTINCT product ORDER BY product ASC SEPARATOR ', ') AS product_names
FROM product_details
GROUP BY sell_date;