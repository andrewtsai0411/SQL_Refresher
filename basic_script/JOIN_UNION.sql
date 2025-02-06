-- INNER JOIN
SELECT d.employee_id, occupation
FROM employee_demographics d
INNER JOIN employee_salary s
    on d.employee_id = s.employee_id

-- LEFT JOIN
SELECT *
FROM employee_demographics d
LEFT JOIN employee_salary s
    on d.employee_id = s.employee_id

-- Joining multiple tables
SELECT d.employee_id AS ID,
       d.age,
       pd.department_name AS Dept,
       occupation
FROM employee_demographics d
INNER JOIN employee_salary s
    ON d.employee_id = s.employee_id
INNER JOIN parks_departments pd
    ON s.dept_id = pd.department_id

-- UNION 為垂直合併SELECT statement，欄位數量、資料型態要一樣
-- 預設為UNION DISTINCT, 會移除重複，如果要全顯示用UNION ALL
SELECT first_name, last_name
FROM employee_demographics

UNION

SELECT first_name, last_name
FROM employee_salary
