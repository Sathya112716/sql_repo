
INSERT INTO product_details (sell_date, product) VALUES
('2020-05-30', 'Headphones'),
('2020-06-01', 'Pencil'),
('2020-06-02', 'Mask'),
('2020-05-30', 'Basketball'),
('2020-06-01', 'Book'),
('2020-06-02', 'Mask'),
('2020-05-30', 'T-Shirt');
SELECT sell_date, COUNT(DISTINCT product) AS num_products, GROUP_CONCAT(DISTINCT product ORDER BY product ASC SEPARATOR ', ') AS product_names
FROM product_details
GROUP BY sell_date;