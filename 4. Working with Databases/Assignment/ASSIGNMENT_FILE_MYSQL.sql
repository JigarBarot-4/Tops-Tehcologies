use assignment;
#1.write a SQL query to find customers who are either from the city 'NewYork' or who do not have a grade greater than 100. Return customer_id, cust_name, city, grade, and salesman_id.
#ans
select * from customer where city="New York"  or not grade>100;

-- Retrieve customers from New York or those with not grade ≤ 100

#2.write a SQL query to find all the customers in ‘New York’ city who have agradevalue above 100. Return customer_id, cust_name, city, grade, and salesman_id.
#ans
select * from customer where city="New York" and grade>100;
SELECT * FROM customer where city like "N%" and grade>100;
-- Get customers in New York with a grade above 100

#3.Write a SQL query that displays order number, purchase amount, and the achieved and unachieved percentage (%) for those orders that exceed 50%of thetarget value of 6000.
#ans
select 
    ord_no,
    purch_amt,
    ROUND((purch_amt / 6000.0) * 100, 2) AS achieved_percentage,
    ROUND(100 - (purch_amt / 6000.0) * 100, 2) AS unachieved_percentage
from 
    orders
where 
    purch_amt > (6000 * 0.5);
    -- Show orders with purch\_amt > 50% of 6000 and their achieved/unachieved percentages


#4.write a SQL query to calculate the total purchase amount of all orders. Returntotal purchase amount.
#ans
select SUM(purch_amt) AS total_purch_amt from orders;
-- Get calculat total purchase amount from orders


#5.write a SQL query to find the highest purchase amount ordered by each customer. Return customer ID, maximum purchase amount.
#ans
select customer_id, MAX(purch_amt) as max_purch_amt from orders group by customer_id;
-- Retrieve the maximum purchase amount for each customer by grouping orders by customer ID.

#6.write a SQL query to calculate the average product price. Return average product price.
#ans
select avg(pro_price) as average_pro_price from item_mast;
-- Calculate the average price of all products from the item\_mast table.


use assi;
#7..write a SQL query to find those employees whose department is located at ‘Toronto’. Return first name, last name, employee ID, job ID.


-- for above query view is already provided as emp_details_view

CREATE VIEW emp_details_view AS SELECT e.employee_id,
	e.job_id,e.manager_id,e.department_id,d.location_id,l.country_id,
	e.first_name,e.last_name,e.salary,e.commission_pct,d.department_name,j.job_title,
	l.city,l.state_province,c.country_name,r.region_name
FROM employees e,
	departments d,jobs j,locations l,countries c,regions r
WHERE e.department_id = d.department_id
	AND d.location_id = l.location_id
	AND l.country_id = c.country_id
	AND c.region_id = r.region_id
	AND j.job_id = e.job_id;

SELECT * FROM emp_details_view WHERE city = "Toronto";


/* 8.write a SQL query to find those employees whose salary is lower than that of employees whose job title 
   is "MK_MAN". Exclude employees of the Jobtitle‘MK_MAN’. Return employee ID, first name, last name, job ID.*/
#ans
SELECT employee_id, first_name, last_name,job_id FROM employees WHERE 
salary < 
(
SELECT min(salary) FROM employees WHERE job_id = "MK_MAN"
) AND job_id != "MK_MAN";
-- Get employees earning less than the lowest "MK\_MAN" salary and not having "MK\_MAN" job.


#9.write a SQL query to find all those employees who work in department ID80or40. Return first name, last name, department number and department name.
#ans
SELECT first_name,last_name,department_id, department_name FROM emp_details_view 
WHERE department_id = 80 or department_id = 40;
-- Retrieve employee first name, last names and department id info for departments 80 or 40.


#10.write a SQL query to calculate the average salary, the number of employees receiving commissions in that department. Return department name, averagesalary and number of employees. 
#ans
SELECT d.department_name, avg(salary) as Avg_Sal, count(e.commission_pct) AS com_emp 
FROM employees e JOIN departments d ON e.department_id = d.department_id GROUP BY d.department_name;
-- Retrieve each department's name, the average salary of its employees, and the number of employees who receive a commission.


#11.write a SQL query to find out which employees have the same designationas theemployee whose ID is 169. Return first name, last name, department IDandjobID
#ans
SELECT first_name,last_name, department_id, job_id FROM emp_details_view WHERE
job_title = (
SELECT job_title FROM emp_details_view WHERE employee_id = 169
);
-- Retrieve first name, last name, department ID, and job ID of employees whose job title matches that of the employee with ID 169.

#12.write a SQL query to find those employees who earn more than the averagesalary. Return employee ID, first name, last name.
#ans
SELECT employee_id, first_name, last_name FROM emp_details_view WHERE salary > (
SELECT avg(salary) FROM emp_details_view
);
-- Retrieve employee ID, first name, and last name of those whose salary is greater than the overall average salary from emp_details_view.

#13.write a SQL query to find all those employees who work in the Finance department. Return department ID, name (first), job ID and department name.
#ans 
SELECT department_id, first_name, job_id, department_name FROM emp_details_view WHERE department_name = "Finance";
-- Retrieve department ID, employee's first name, job ID, and department name for employees who work in the "Finance" department

#14.From the following table, write a SQL query to find the employees whoearnlessthan the employee of ID 182. Return first name, last name and salary.
#ans
SELECT first_name, last_name, salary FROM emp_details_view WHERE salary <  
(
    SELECT salary FROM emp_details_view WHERE employee_id = 182
);
ChatGPT said:
-- Retrieve the first name, last name, and salary of employees whose salary is less than that of the employee with ID 182

#15.Create a stored procedure CountEmployeesByDept that returns the number of employees in each department
#ans
DELIMITER //
CREATE PROCEDURE CountEmployeesByDept()
BEGIN
    SELECT department_id,department_name, COUNT(*) AS EmployeeCount
    FROM emp_details_view
    GROUP BY department_id;
END //
DELIMITER ;CountEmployeesByDeptCountEmployeesByDept
-- Define a stored procedure CountEmployeesByDept that retrieves each department's ID, name, and total number of employees by grouping data from emp_details_view

#16.Create a stored procedure AddNewEmployee that adds a new employee tothedatabase.
#ans
DELIMITER //
CREATE PROCEDURE AddNewEmployee(
	IN employee_id int, IN first_name text,IN last_name text, IN email Text, 
    IN phone_number text, in hire_date date, in job_id int , in salary float, in commission_pct int,
    in manager_id int, in department_id int
)
BEGIN
		INSERT INTO employees VALUES 
        (employee_id, first_name, last_name, email, phone_number, 
        hire_date, job_id, salary, commission_pct, manager_id, department_id);
END //
DELIMITER ;
-- Creates a stored procedure AddNewEmployee that inserts a new employee record into the employees table using input parameters 
-- for all employee details like ID, name, contact info, job, salary, and department.

#17.Create a stored procedure DeleteEmployeesByDept that removes all employeesfrom a specific department
#ans
DELIMITER //
CREATE PROCEDURE DeleteEmployeesByDept(IN p_DepartmentID INT)
BEGIN
    DELETE FROM Employees
    WHERE DepartmentID = p_DepartmentID;
END //
DELIMITER ;
-- Create a stored procedure DeleteEmployeesByDept that deletes all employees from the Employees table who belong to a specified department ID passed as a parameter.

#18.Create a stored procedure GetTopPaidEmployees that retrieves the highest-paidemployee in each department.
#ans
DELIMITER //
CREATE PROCEDURE GetTopPaidEmployees()
BEGIN
    SELECT *
    FROM emp_details_view el
    WHERE salary = (
        SELECT MAX(salary)
        FROM emp_details_view
        WHERE department_id = e.department_id
    );
END //
DELIMITER ;
-- Create a procedure to fetch employees with the highest salary in their respective departments

#19.Create a stored procedure PromoteEmployee that increases an employee’s salaryand changes their job role.
#ans
DELIMITER //
CREATE PROCEDURE PromoteEmployee(
    IN p_EmployeeID INT,
    IN p_NewSalary DECIMAL(10,2),
    IN p_NewJobID VARCHAR(10)
)
BEGIN
    UPDATE Employees
    SET salary = p_NewSalary,
        job_id = p_NewJobID
    WHERE employee_id = p_EmployeeID;
END //
DELIMITER ;
-- Create a procedure to promote an employee by updating their salary and job ID.

#20.Create a stored procedure AssignManager To Department that assigns a newmanager to all employees in a specific department. 
#ans

DELIMITER //

CREATE PROCEDURE AssignManagerToDepartment(
    IN department_id INT,
    IN manager_id INT
)
BEGIN
    UPDATE Employees
    SET manager_id = manager_id
    WHERE department_id = department_id;
END  //
DELIMITER  ;
-- Create a procedure to update the manager for all employees in a specific department.



    