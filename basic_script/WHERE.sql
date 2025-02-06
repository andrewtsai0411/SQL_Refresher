-- Logical Operators: AND / OR / NOT
SELECT *
FROM employee_demographics
WHERE (birth_date >= '1985-07-26' AND employee_id > 3)
OR NOT gender = 'Male'

-- Wildcard
-- % 表示任意零、一、多字元
-- _ 表示任意一字元
SELECT *
FROM employee_demographics
WHERE first_name Like 'A__%' -- A之後兩字元接任意長度皆符合