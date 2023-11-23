-- -----------------------------------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------- FIRST 1 ASSIGNMENT ---------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Database Name: HR
use hr;
select * from employees;

-- 1. Display all information in the tables EMP and DEPT.

select * from employees inner join departments on employees.department_id = departments.department_id;

-- 2. Display only the hire date and employee name for each employee.

select * from employees;
select hire_date as Hire_Date,concat_ws('  ', first_name,last_name) Employee_Name from employees;

/* 3. Display the ename concatenated with the job ID, separated by a comma and space, and
name the column Employee and Title   */

select * from employees;
select concat(first_name,' ,  ',job_id) Employee_and_title from employees;

-- 4. Display the hire date, name and department number for all clerks.

select * from employees;        -- hire_date,first_name
select * from departments;      -- department_id,department_name

select e.hire_date,e.first_name,e.department_id,d.department_name from employees e
join
departments d on e.department_id = d.department_id where d.department_name = 'clerks' group by d.department_name;

/* 5. Create a query to display all the data from the EMP table. Separate each column by a
comma. Name the column THE OUTPUT    */

select concat_ws(' , ',employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
 THE_OUTPUT from employees;

-- 6. Display the names and salaries of all employees with a salary greater than 2000.

select * from employees;
select first_name,salary from employees where salary > 2000;

-- 7. Display the names and dates of employees with the column headers "Name" and "Start Date"

select * from employees;
select first_name Name ,hire_date Start_Date from employees;

-- 8. Display the names and hire dates of all employees in the order they were hired.

select first_name Name ,hire_date Start_Date from employees order by hire_date;

-- 9. Display the names and salaries of all employees in reverse salary order.

select first_name , salary from employees order by salary desc;

-- 10. Display 'ename" and "deptno" who are all earned commission and display salary in reverse order.

select * from employees;
select * from departments;

select first_name ename , department_id deptno,salary from employees where commission_pct order by salary desc;

-- 11. Display the last name and job title of all employees who do not have a manager

select last_name , job_id , manager_id from employees where  manager_id is null;

/* 12. Display the last name, job, and salary for all employees whose job is sales representative
or stock clerk and whose salary is not equal to $2,500, $3,500, or $5,000 */

select * from employees;
select * from departments;

SELECT e.last_name, e.job_id, e.salary, d.department_name
FROM employees e 
JOIN departments d ON e.department_id = d.department_id
WHERE (d.department_name = 'sales representative' OR d.department_name = 'stock clerk') 
AND e.salary NOT IN ( 2500 , 3500 , 5000 );






-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------SECOND 2 ASSIGNMENT--------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------

/* 
Module 4 (SQL)
Database Name: HR
*/
use hr;

-- 1) Display the maximum, minimum and average salary and commission earned.

SELECT MAX(salary) max_salary,MIN(salary) min_salary,AVG(salary) avg_salary,
MAX(commission_pct) max_commission,MIN(commission_pct) min_commission,AVG(commission_pct)avg_commission
FROM employees;

-- 2) Display the department number, total salary payout and total commission payout for each department.

select * from employees;
select department_id,sum(salary),commission_pct from employees group by department_id;

-- 3) Display the department number and number of employees in each department.
select * from employees;
select * from departments;

select e.department_id Department_Number,count(job_id) Number_jobID,d.department_name from employees e 
join
departments d on e.department_id = d.department_id group by e.department_id;

-- 4) Display the department number and total salary of employees in each department.
select * from employees;
select * from departments;

select e.department_id,sum(salary),d.department_name from employees e
join
departments d on e.department_id = d.department_id group by d.department_name;

/* 5) Display the employee's name who doesn't earn a commission. Order the result set
without using the column name
*/
select * from employees;
select first_name as  ' ' , commission_pct as ' '  from employees where commission_pct is null;

/*
6) Display the employees name, department id and commission. If an Employee doesn't
earn the commission, then display as 'No commission'. Name the columns appropriately
*/

SELECT first_name,department_id, CASE 
WHEN commission_pct IS NULL THEN 'No commission'
else commission_pct
end as commission_pct
from employees;

/*
7) Display the employee's name, salary and commission multiplied by 2. If an Employee
doesn't earn the commission, then display as 'No commission. Name the columns
appropriately
*/

select commission_pct from employees;

SELECT 
    first_name as Employee_Name,
    salary,
    CASE 
        WHEN commission_pct IS NULL THEN 'No Commission'
        ELSE  2 * commission_pct 
    END AS Commission_Multiplied
FROM employees;



/* 8) Display the employee's name, department id who have the first name same as another
employee in the same department      */

select e1.first_name , e1.department_id from employees e1 join employees e2 on e1.first_Name = e2.first_Name
AND e1.department_id = e2.department_id 
AND e1.employee_id <> e2.employee_id order by e1.department_id, e1.first_name;

-- 9) Display the sum of salaries of the employees working under each Manager.

select * from employees;
select sum(salary),manager_id from employees where manager_id group by manager_id;

-- 10) Select the Managers name, the count of employees working under and the department ID of the manager.
SELECT * FROM DEPARTMENTS;
select manager_name,count(department_id) Department_ID from employees group by manager_id;

alter table employees add column manager_name varchar(25);


/* 
11) Select the employee name, department id, and the salary. Group the result with the
 manager name and the employee last name should have second letter 'a!
*/

select * from employees;
select first_name , department_id , salary from employees  group by manager_id, last_name like '_a!';


/* 
12) Display the average of sum of the salaries and group the result with the department id.
Order the result with the department id.
*/
select * from employees;
select * from departments;
-- select avg((select sum(salary) from employees)), department_id  from employees group by department_id  ;
-- select sum(salary), department_id  from employees group by department_id ;
-- select avg(sum(salary)),department_id from employees group by department_id;

SELECT department_id, AVG(total_salary) AS average_salary
FROM (
    SELECT department_id, SUM(salary) as total_salary
    FROM employees
    GROUP BY department_id
) AS department_salaries
GROUP BY department_id
ORDER BY department_id;

-- 13) Select the maximum salary of each department along with the department id

select department_id , max(salary) from employees group by department_id;

-- 14) Display the commission, if not null display 10% of salary, if null display a default value 1

select * from employees;
SELECT 
    CASE 
        WHEN commission_pct IS NULL THEN 1
        ELSE  salary*10/100
    END AS salary_mul
FROM employees order by salary_mul desc;





-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------THIRD 3 ASSIGNMENT--------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------

-- Database Name: HR

/* 1. Write a query that displays the employee's last names only from the string's 2-5th
position with the first letter capitalized and all other letters lowercase, Give each column an
appropriate label. */

select * from employees;
select last_name , concat(upper(substring(last_name,1,1)),lower(substring(last_name,2,5))) slicing from employees;

/*
2. Write a query that displays the employee's first name and last name along with a " in
between for e.g.: first name : Ram; last name : Kumar then Ram-Kumar. Also displays the
month on which the employee has joined.
*/
select* from employees;
select concat(first_name,' - ',last_name) Full_Name ,monthname(hire_date) Hire_Month from employees;

/*
3. Write a query to display the employee's last name and if half of the salary is greater than
ten thousand then increase the salary by 10% else by 11.5% along with the bonus amount of
1500 each. Provide each column an appropriate label.
*/

select * from employees;
select concat_ws(' - ',first_name,last_name) Full_Name,
	case
		when salary / 2 > 10000 then salary + (salary*10/100)
        else salary + (salary * 11.5/100) + 1500
	end as New_Salary_With_Bonus
from employees;


/*
4. Display the employee ID by Appending two zeros after 2nd digit and 'E' in the end,
department id, salary and the manager name all in Upper case, if the Manager name
consists of 'z' replace it with '$!
*/

select * from employees;

SELECT
  CONCAT(SUBSTRING(employee_id, 1, 2), '00E') AS formatted_employee_id,
  department_id,
  salary,
  UPPER(
    REPLACE(manager_name, 'z', '$!')
  ) AS formatted_manager_name
FROM
  employees;
        


/*
5. Write a query that displays the employee's last names with the first letter capitalized and
all other letters lowercase, and the length of the names, for all employees whose name
starts with J, A, or M. Give each column an appropriate label. Sort the results by the
employees' last names
*/

SELECT 
    CONCAT(UPPER(SUBSTRING(last_name, 1, 1)), LOWER(SUBSTRING(last_name, 2))) AS Formatted_Last_Name,
    LENGTH(last_name) AS Name_Length
FROM employees
WHERE last_name LIKE 'J%' OR last_name LIKE 'K%' OR last_name LIKE 'M%'
ORDER BY last_name;

/*
6. Create a query to display the last name and salary for all employees. Format the salary to
be 15 characters long, left-padded with $. Label the column SALARY
*/

select * from employees;
SELECT 
    last_name,
    LPAD(CONCAT('$', CAST(salary AS CHAR)), 15, '$') AS SALARY
FROM employees;


-- 7. Display the employee's name if it is a palindrome.

select * from employees;

SELECT first_name AS 'Palindrome Names'
FROM employees
WHERE first_name = REVERSE(first_name);


-- 8. Display First names of all employees with initcaps.

-- Note:- INITCAPE() Function only for Oracle NOT WORKING IN MYSQL I WILL DO SAME THING IN MYSQL USING BELOW QUERY !!!!!.

SELECT
  CONCAT(UCASE(SUBSTRING_INDEX(first_name, ' ', 1)), LCASE(SUBSTRING_INDEX(first_name, ' ', -1))) AS initcap_first_name
FROM
  employees;



-- 9. From LOCATIONS table, extract the word between first and second space from the STREET ADDRESS column.

select * from locations;
SELECT street_address, SUBSTRING_INDEX(SUBSTRING_INDEX(STREET_ADDRESS, ' ', 2), ' ', -1) AS 'Word_between_1st_2nd_space' FROM LOCATIONS;


/*10. Extract first letter from First Name column and append it with the Last Name. Also add "@systechusa.com" at the end. 
Name the column as e-mail address. All characters should be in lower case. Display this along with their First Name.*/

select First_name,lower(concat(lower(substring(first_name,1,1)),last_name,"@systechusa.com" )) 'e-mail address'  from employees;


-- 11. Display the names and job titles of all employees with the same job as Trenna.

 select * from employees;
 select * from departments;
 
select  e.first_name ,
	case
		when d.department_name is not null then 'Trenna'
        else d.department_name
	end as Department_Name
from employees e join departments d on e.department_id = d.department_id;



-- 12. Display the names and department name of all employees working in the same city as Trenna.
 select * from employees;
 select * from departments;
 select * from locations;

select  e.first_name Names, d.department_name,
	case
		when l.city is not null then 'Trenna'
        else l.city
	end as City_Name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id group by department_name;

-- 13. Display the name of the employee whose salary is the lowest.

select first_name,salary from employees where salary = (select min(salary) from employees);


-- 14. Display the names of all employees except the lowest paid.

SELECT first_name
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);


       



-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------FOUR 4 ASSIGNMENT--------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------

-- Database Name: HR
use hr;
-- 1. Write a query to display the last name, department number, department name for all employees.

select * from employees;
select e.last_name , e.department_id , d.department_name from employees e join departments d on e.department_id = d.department_id 
group by d.department_name order by department_id;

-- 2. Create a unique list of all jobs that are in department 4. Include the location of the department in the output.
select * from departments;
select * from locations;

SELECT DISTINCT d.department_name, l.city,d.department_id
FROM departments d
JOIN locations l ON d.location_id = l.location_id
WHERE d.department_id = 4;


-- 3. Write a query to display the employee last name,department name,location id and city of all employees who earn commission.

select * from departments;
select * from employees;
select * from locations;

select distinct e.last_name , d.department_name , l.location_id , l.city , e.commission_pct
from employees e 
join departments d on e.department_id = d.department_id 
join locations l on d.location_id = l.location_id where e.commission_pct group by commission_pct order by commission_pct;


-- 4. Display the employee last name and department name of all employees who have an 'a' in their last name.

select e.last_name , d.department_name from employees e join departments d on e.department_id = d.department_id where e.last_name like '%a';

-- 5. Write a query to display the last name,job,department number and department name for all employees who work in ATLANTA.

select * from departments;
select * from employees;
select * from locations;

select e.last_name , d.department_name , d.department_id , l.city from employees e 
join departments d on e.department_id = d.department_id
join locations l on l.location_id = d.location_id where l.city = 'atlanta' group by department_id;

-- 6. Display the employee last name and employee number along with their manager's last name and manager number.

select * from employees;

select manager_name , last_name , phone_number from employees group by manager_id order by manager_id;

-- 7. Display the employee last name and employee number along with their manager's last name and manager number 
-- (including the employees who have no manager).

select e.last_name , e.phone_number , e.manager_name from employees e;

-- 8. Create a query that displays employees last name,department number,and all the employees who work in the same department as a given employee.

SELECT e.last_name AS "Employee Last Name", e.department_id AS "Department Number",
       ee.last_name AS "Colleague Last Name"
FROM employees e
JOIN employees ee ON e.department_id = ee.department_id
WHERE e.employee_id = ee.employee_id;

-- 9. Create a query that displays the name,job,department name,salary,grade for all
-- employees. Derive grade based on salary(>=50000=A, >=30000=B,<30000=C)

SELECT e.last_name AS "Employee Name",
       e.job_id,
       d.department_name AS "Department Name",
       e.salary AS "Salary",
       CASE
           WHEN e.salary >= 50000 THEN 'A'
           WHEN e.salary >= 30000 THEN 'B'
           ELSE 'C'
       END AS "Grade"
FROM employees e
JOIN departments d ON e.department_id = d.department_id order by grade;

/*10. Display the names and hire date for all employees who were hired before their
managers along withe their manager names and hire date. Label the columns as Employee
name, emp_hire_date,manager name,man_hire_date */

select * from employees;

SELECT e1.last_name AS "Employee name",
       e1.hire_date AS "emp_hire_date",
       e2.manager_name AS "Manager name"
FROM employees e1
JOIN employees e2 ON e1.manager_id = e2.employee_id ;







-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------FIVE 5 ASSIGNMENT--------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------





/*
Database Name: AdventureWorks
*/

-- 1. Write a query to display employee numbers and employee name (first name, last name)
-- of all the sales employees who received an amount of 2000 in bonus.

SELECT e.employee_id, CONCAT(e.first_name, ' ', e.last_name) AS "Employee Name" , b.bonus_amount
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN bonuses b ON e.employee_id = b.employee_id
WHERE d.department_name = 'Sales' AND b.bonus_amount = 2000;	


-- 2. Fetch address details of employees belonging to the state CA. If address is null, provide default value N/A.

select * from employees;
select * from departments;
select * from locations;

select l.street_address , e.first_name ,
case when l.country_id is null then 'N/A'
else l.country_id 
end as country_id
from employees e
 join departments d on e.department_id= d.department_id 
 join locations l on d.location_id = l.location_id where l.country_id = 'CA';


-- 3. Write a query that displays all the products along with the Sales OrderID even if an order has never been placed for that product.

use classicmodels;
select * from customers;
select * from orderdetails;

SELECT p.productName, COALESCE(o.orderNumber, 'No Order') AS SalesOrderID
FROM products p
LEFT JOIN orderdetails o ON p.productCode = o.productCode group by SalesOrderID;

-- 4. Find the subcategories that have at least two different prices less than $15.
SELECT * FROM classicmodels.products;

SELECT productLine, COUNT(DISTINCT MSRP) AS price_count
FROM products
WHERE MSRP < 15.00
GROUP BY productLine
HAVING COUNT(DISTINCT MSRP) >= 2;

-- 5. 
-- A. Write a query to display employees and their manager details. Fetch employee id, employee first name, and manager id, manager name.

use hr;
select * from employees;

SELECT 
    e.employee_id AS "Employee ID",
    e.first_name AS "Employee First Name",
    e.manager_id AS "Manager ID",
    m.manager_name AS "Manager Name"
FROM 
    employees e
LEFT JOIN 
    employees m ON e.manager_id = m.employee_id group by e.manager_id;



-- B. Display the employee id and employee name of employees who do not have manager.

select employee_id,first_name,manager_id from employees where manager_id is null;


-- 6.
--  A. Display the names of all products of a particular subcategory 15 and the names of their vendors.
use classicmodels;

SELECT productLine, productVendor
FROM products
WHERE MSRP < 15.00
GROUP BY productLine
HAVING productLine >= 15; 
 
 -- B. Find the products that have more than one vendor.
 
 select count(productLine) Vendor ,productVendor from products group by productVendor having count(productLine) > 2 order by count(productLine);
 
 
 -- 7. Find all the customers who do not belong to any store.
 
  select * from customers;
 
 SELECT c.customerNumber, c.customerName, c.salesRepEmployeeNumber Store_ID
FROM customers c where c.salesRepEmployeeNumber is null;

-- 8. Find sales prices of product 718 that are less than the list price recommended for that product.

select * from products;

SELECT MSRP
FROM products
WHERE productCode = 'S10_1678' 
AND MSRP < buyPrice;


-- 9. Display product number, description and sales of each product in the year 2001.

/*
10. Build the logic on the above question to extract sales for each category by year. Fetch
Product Name, Sales_2001, Sales_2002, Sales_2003.

Hint: For questions 9 & 10 (From Sales.SalesOrderHeader, sales. SalesOrderDetail,
Production. Product. Use ShipDate of SalesOrderHeader to extract shipped year.
Calculate sales using QTY and unitprice from Sales OrderDetail.)
*/








-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------SIX 6 ASSIGNMENT--------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------




-- Database Name: HR

-- 1. Write a query to display the last name and hire date of any employee in the same department as SALES.

use hr;
select * from employees;
select * from departments;

 select e.last_name , e.hire_date,d.department_name,d.department_id from employees e join departments d on e.department_id = d.department_id 
group by d.department_id having d.department_name = 'sales';

-- 2. Create a query to display the employee numbers and last names of all employees who earn more than the average salary.
-- Sort the results in ascending order of salary.

select * from employees;
select * from departments;

SELECT employee_id, last_name,salary FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
) ORDER BY salary ASC;


-- 3. Write a query that displays the employee numbers and last names of all employees who
-- work in a department with any employee whose last name contains a 'u'.

select e.employee_id , e.last_name  from employees e where e.last_Name like '%u%';


-- 4. Display the last name, department number, and job ID of all employees whose department location is ATLANTA.

select * from departments;
select * from employees;
select * from locations;

select e.last_name , e.department_id , e.job_id,l.city from employees e 
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id
where l.city = 'atlanta' group by l.city;

-- 5. Display the last name and salary of every employee who reports to FILLMORE.

SELECT e.last_name, e.salary
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
WHERE m.manager_name = 'FILLMORE';

select * from employees;

-- 6. Display the department number, last name, and job ID for every employee in the OPERATIONS department.
select * from departments;

select e.department_id,e.last_name,e.job_id from employees e join departments d on e.department_id = d.department_id
where d.department_name = 'OPERATIONS';


/* 7. Modify the above query to display the employee numbers, last names, and salaries of all
employees who earn more than the average salary and who work in a department with any
employee with a 'u'in their name. */

select employee_id , last_name , salary from employees where salary > (select avg(salary) from employees ) and last_name like '%u%';


-- 8. Display the names of all employees whose job title is the same as anyone in the sales dept.

select * from departments;
select * from employees;

select e.first_name,d.department_name from employees e join departments d on e.department_id = d.department_id where d.department_name = 'sales'
and d.department_id = e.department_id;


/*9. Write a compound query to produce a list of employees showing raise percentages,
employee IDs, and salaries. Employees in department 1 and 3 are given a 5% raise,
employees in department 2 are given a 10% raise, employees in departments 4 and 5 are
given a 15% raise, and employees in department 6 are not given a raise.*/

select * from departments;
select * from employees;

SELECT 
    employee_id, 
    salary,
    CASE 
        WHEN department_id IN (10, 30) THEN '5%'
        WHEN department_id = 20 THEN '10%'
        WHEN department_id IN (40, 50) THEN '15%'
        ELSE 'No raise'
    END AS raise_percentage
FROM employees group by department_id ;

-- 10. Write a query to display the top three earners in the EMPLOYEES table. Display their last names and salaries.

select last_name , max(salary) from employees;
select max(salary) from employees where salary < (select max(salary) from employees); 
select max(salary) from employees where salary < (select max(salary) from employees where salary < (select max(salary) from employees));

-- ANS BELOW

SELECT last_name, salary FROM ( select last_name, salary, ROW_NUMBER() OVER (ORDER BY salary DESC) AS salary_rank FROM employees)
ranked_employees WHERE salary_rank <= 3;


-- 11. Display the names of all employees with their salary and commission earned. Employees with a null commission 
-- should have O in the commission column
select * from employees;

select first_name , salary , 
case when commission_pct is null then 0
else commission_pct
end as commission_pct
from employees order by first_name;


-- 12. Display the Managers (name) with top three salaries along with their salaries and department information.

select * from employees;
SELECT  manager_id ,department_id,last_name,salary FROM 
( select department_id,last_name,manager_id, salary,ROW_NUMBER() OVER (ORDER BY salary DESC) AS salary_rank FROM employees)
ranked_employees WHERE salary_rank <= 3;





-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------SEVEN 7 ASSIGNMENT--------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------

/*
1) Find the date difference between the hire date and resignation_date for all the
employees. Display in no. of days, months and year(1 year 3 months 5 days).
Emp_ID Hire Date Resignation_Date

1 1/1/2000 7/10/2013
2 4/12/2003 3/8/2017
3 22/9/2012 21/6/2015
4 13/4/2015 NULL
5 03/06/2016 NULL
6 08/08/2017 NULL
7 13/11/2016 NULL
*/

use hr;
select * from employees;
describe employees;

SELECT e.employee_id,e.Hire_Date,j.end_date,
    CONCAT(
        FLOOR(DATEDIFF(j.end_date,e.hire_date) / 365), ' years ',
        FLOOR((DATEDIFF(j.end_date, e.Hire_Date) % 365) / 30), ' months ',
        DATEDIFF(j.end_date, e.Hire_Date) % 30, ' days'
    ) AS Duration
FROM  employees e join job_history j on e.employee_id = j.employee_id; 

select * from employees;
SELECT * FROM job_history;

-- 2) Format the hire date as mm/dd/yyyy(09/22/2003) and resignation_date as mon dd, yyyy(Aug 12th, 2004). Display the null as (DEC, 01th 1900)

SELECT
    e.hire_date,
    j.end_date,
    CASE
        WHEN e.hire_date IS NULL THEN 'DEC, 01th 1900'
        ELSE DATE_FORMAT(e.hire_date, '%m/%d/%Y') -- Format as mm/dd/yyyy (09/22/2003)
    END AS formatted_hire_date,
    CASE
        WHEN j.end_date IS NULL THEN 'DEC, 01th 1900'
        ELSE DATE_FORMAT(j.end_date, '%b %D, %Y') -- Format as mon dd, yyyy (Aug 12th, 2004)
    END AS formatted_end_date
FROM  employees e join job_history j on e.employee_id = j.employee_id; 

-- 3) Calcuate experience of the employee till date in Years and months(example 1 year and 3 months)

select * from job_history;

select e.employee_id , e.hire_date ,  
		concat(
			FLOOR(datediff(now(),e.hire_date) / 365), ' Years And ',
			FLOOR(MOD(DATEDIFF(NOW(), hire_date), 365) / 30.5), ' months'
            )
AS Experience from employees e join job_history j on e.employee_id = j.employee_id;

-- Use Getdate() as input date for the below three questions.

/*
NOTED = > In MySQL, there is no direct GetDate() function like in some other database systems.
 Instead, you can use the CURRENT_DATE() function to get the current date. Here's an example of how you can display the count
 of days in the previous quarter:
*/

-- 4) Display the count of days in the previous quarter

SELECT
  DATEDIFF(LAST_DAY(CURRENT_DATE()), DATE_SUB(LAST_DAY(CURRENT_DATE()), INTERVAL 2 QUARTER)) + 1 AS days_in_previous_quarter;

-- Use Getdate() as input date for the below three questions.
-- 5) Fetch the previous Quarter's second week's first day's date

SELECT
  DATE_ADD(DATE_SUB(LAST_DAY(CURRENT_DATE()), INTERVAL 2 QUARTER), INTERVAL 1 DAY) AS first_day_of_second_week;


-- Use Getdate() as input date for the below three questions.
-- 6) Fetch the financial year's 15th week's dates (Format: Mon DD YYYY)

SET @financial_year_start = '2023-04-01';

SELECT
  DATE_FORMAT(DATE_ADD(@financial_year_start, INTERVAL (15 - 1) WEEK), '%a %b %d %Y') AS start_date,
  DATE_FORMAT(DATE_ADD(@financial_year_start, INTERVAL 15 WEEK), '%a %b %d %Y') AS end_date;




-- 7) Find out the date that corresponds to the last Saturday of January, 2015 using with clause.

-- Use Airport database for the below two question:
-- 8) Find the number of days elapsed between first and last flights of a passenger.

create database Airport;
use Airport;
create table Flights (
flight_id int primary key auto_increment,
flight_date date,
departure_city varchar(25),
arrival_city varchar(25),
duration time,
passenger_id int);

select * from Flights;

SELECT
    passenger_id,
    DATEDIFF(MAX(flight_date), MIN(flight_date)) AS days_elapsed
FROM
    flights;


-- 9) Find the total duration in minutes and in seconds of the flight from Rostov to Moscow.

SELECT
    SUM(TIME_TO_SEC(duration)) AS total_duration_seconds,
    SEC_TO_TIME(SUM(TIME_TO_SEC(duration))) AS total_duration_formatted
FROM
    Flights
WHERE
    departure_city = 'Rostov' and arrival_city = 'Moscow';














