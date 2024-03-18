-- 1.create table dept_tbl
CREATE TABLE dept_tbl (
    id_deptname VARCHAR(20),
    emp_name VARCHAR(50),
    salary INT
);
-- 2.Insert the values in dept_tbl table
INSERT INTO dept_tbl (id_deptname, emp_name, salary) VALUES
('1111-MATH', 'RAHUL', 10000),
('1111-MATH', 'RAKESH', 20000),
('2222-SCIENCE', 'AKASH', 10000),
('222-SCIENCE', 'ANDREW', 10000),
('22-CHEM', 'ANKIT', 25000),
('3333-CHEM', 'SONIKA', 12000),
('4444-BIO', 'HITESH', 2300),
('44-BIO', 'AKSHAY', 10000);
-- 3.To find the total salary of each department
SELECT
    dept_name,
    total_salary
FROM (
    SELECT
        CASE 
            WHEN SUBSTRING_INDEX(id_deptname, '-', 1) = 'BIO' THEN 'BIO'
            WHEN SUBSTRING_INDEX(id_deptname, '-', 1) = 'CHEM' THEN 'CHEM'
            WHEN SUBSTRING_INDEX(id_deptname, '-', 1) = 'MATH' THEN 'Math'
            WHEN SUBSTRING_INDEX(id_deptname, '-', 1) = 'SCIENCE' THEN 'Science'
        END AS dept_name,
        SUM(salary) AS total_salary
    FROM 
        dept_tbl
    GROUP BY 
        dept_name
) AS dept_summary
ORDER BY 
    FIELD(dept_name, 'BIO', 'CHEM', 'Math', 'Science');



