/* window_function_name([expression]) OVER (
     [PARTITION BY expression]
     [ORDER BY expression [ASC|DESC]]
     [ROWS or RANGE frame_clause]
) */

-- 聚合函數+OVER(ORDER BY)會回傳逐行進行聚合的結果
SELECT d.employee_id,gender, SUM(salary) OVER(
    PARTITION BY gender
    ORDER BY d.employee_id)  AS Rolling_Total
FROM employee_demographics d
JOIN employee_salary s
    ON d.employee_id = s.employee_id

SELECT d.first_name,d.last_name,gender, salary,
ROW_NUMBER() OVER(
    PARTITION BY gender
    ORDER BY salary DESC
)
FROM employee_demographics d
JOIN employee_salary s
    ON d.employee_id = s.employee_id

-- 值相同排名平手，RANK()下一個排名為下個位置(5-5-7)，DENSE_RANK()下一個排名為下個數字(5-5-6)
SELECT d.employee_id,d.first_name,d.last_name,gender, salary,
DENSE_RANK() OVER(
    PARTITION BY gender
    ORDER BY salary DESC
)
FROM employee_demographics d
JOIN employee_salary s
    ON d.employee_id = s.employee_id