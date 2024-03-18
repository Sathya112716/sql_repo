-- 1.Create the table email_signup
CREATE TABLE email_signup (
    id INT,
    email_id VARCHAR(50),
    signup_date DATE
);
-- 2.Insert the values into the email_signup table
INSERT INTO email_signup (id, email_id, signup_date) VALUES
(1, 'Rajesh@Gmail.com', '2022-02-01'),
(2, 'Rakesh_gmail@rediffmail.com', '2023-01-22'),
(3, 'Hitest@Gmail.com', '2020-09-08'),
(4, 'Salil@Gmmail.com', '2019-07-05'),
(5, 'Himanshu@Yahoo.com', '2023-05-09'),
(6, 'Hitesh@Twitter.com', '2015-01-01'),
(7, 'Rakesh@facebook.com', null);
-- 3.To find Gmail accounts with the latest and first signup date
SELECT 
    COUNT(CASE WHEN email_id LIKE '%@gmail.com' THEN 1 END) AS count_gmail_account,
    MAX(CASE WHEN email_id LIKE '%@gmail.com' THEN signup_date END) AS latest_signup_date,
    MIN(CASE WHEN email_id LIKE '%@gmail.com' THEN signup_date END) AS first_signup_date
FROM 
    email_signup;

-- 4.Calculate the difference in days between the latest and first signup dates

SELECT 
    COUNT(CASE WHEN email_id LIKE '%@gmail.com' THEN 1 END) AS count_gmail_account,
    MAX(CASE WHEN email_id LIKE '%@gmail.com' THEN signup_date END) AS latest_signup_date,
    MIN(CASE WHEN email_id LIKE '%@gmail.com' THEN signup_date END) AS first_signup_date,
    DATEDIFF(MAX(CASE WHEN email_id LIKE '%@gmail.com' THEN signup_date END), MIN(CASE WHEN email_id LIKE '%@gmail.com' THEN signup_date END)) AS diff_in_days
FROM 
    email_signup;
-- 5.Replace null values with '1970-01-01' for the signup_date column
UPDATE email_signup
SET signup_date = '1970-01-01'
WHERE signup_date IS NULL;



