-- WHERE 篩選row level, HAVING 篩選聚合函數
SELECT occupation,AVG(salary)
FROM employee_salary
WHERE occupation Like '%Manager'
GROUP BY occupation
HAVING AVG(salary) > 65000