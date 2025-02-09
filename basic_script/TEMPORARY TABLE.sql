-- TEMPORARY TABLE可作為資料處理或較複雜的查詢的中繼站
CREATE TEMPORARY TABLE temp_table(
    first_name varchar(10),
    last_name varchar(10),
    character varchar(10)
)
INSERT INTO temp_table
VALUES('Bruce','Wayne','Batman'),
      ('Tim', 'Drake', 'Robin'),
      ('Selina', 'Kyle', 'Catwonam')

SELECT *
FROM temp_table

TRUNCATE temp_table

DROP TABLE temp_table

-- 直接把資料填入
CREATE TEMPORARY TABLE salary_over_50k
SELECT *
FROM employee_salary
WHERE salary > 50000

SELECT * FROM salary_over_50k