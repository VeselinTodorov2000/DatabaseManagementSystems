SET SCHEMA DB2SAMPLE;

--Task 1
-- For employees whose salary, increased by 5 percent, is less than or equal to
-- $20,000, list the following:
--  • Last name
--  • Current Salary
--  • Salary increased by 5 percent
--  • Monthly salary increased by 5 percent
-- Use the following column names for the two generated columns:
-- INC-Y-SALARY and INC-M-SALARY Use the proper conversion function to display
-- the increased salary and monthly salary with two of the digits to the right of the
-- decimal point. Sort the results by annual salary.
SELECT LASTNAME,
       SALARY,
       DECIMAL((SALARY * 1.05), 9, 2)      AS INC_Y_SALARY,
       DECIMAL((SALARY * 1.05 / 12), 9, 2) AS INC_M_SALARY
FROM EMPLOYEE
WHERE SALARY * 1.05 <= 20000
ORDER BY SALARY;

--Task 2
-- All employees with an education level of 18 or 20 will receive a salary increase of
-- $1,200 and their bonus will be cut in half. List last name, education level, new salary,
-- and new bonus for these employees. Display the new bonus with two digits to the
-- right of the decimal point.
-- Use the column names NEW-SALARY and NEW-BONUS for the generated
-- columns.
-- Employees with an education level of 20 should be listed first. For employees with
-- the same education level, sort the list by salary.
SELECT LASTNAME, EDLEVEL, (SALARY + 1200) AS NEW_SALARY, DECIMAL((BONUS / 2), 9, 2) AS NEW_BONUS
FROM EMPLOYEE
WHERE EDLEVEL IN (18, 20)
ORDER BY EDLEVEL DESC, SALARY;

--Task 3
-- The salary will be decreased by $1,000 for all employees matching the following
-- criteria:
--  • They belong to department D11
--  • Their salary is more than or equal to 80 percent of $20,000
--  • Their salary is less than or equal to 120 percent of $20,000
-- Use the name DECR-SALARY for the generated column.
-- List department number, last name, salary, and decreased salary. Sort the result by
-- salary.
SELECT WORKDEPT, LASTNAME, SALARY, (SALARY - 1000) AS DECR_SALARY
FROM EMPLOYEE
WHERE WORKDEPT = 'D11'
  AND SALARY >= (0.8 * 20000)
  AND SALARY <= (1.2 * 20000)
ORDER BY SALARY;

--Task 4
-- Produce a list of all employees in department D11 that have an income (sum of
-- salary, commission, and bonus) that is greater than their salary increased by 10
-- percent.
-- Name the generated column INCOME.
-- List department number, last name, and income. Sort the result in descending order
-- by income.
-- For this problem assume that all employees have non-null salaries, commissions,
-- and bonuses.
SELECT WORKDEPT, LASTNAME, (SALARY + COMM + BONUS) AS INCOME
FROM EMPLOYEE
WHERE WORKDEPT = 'D11'
  AND SALARY IS NOT NULL
  AND (SALARY + COMM + BONUS) > SALARY * 1.1;

--Task 5
-- List all departments that have no manager assigned. List department number,
-- department name, and manager number. Replace unknown manager numbers with
-- the word UNKNOWN and name the column MGRNO.
SELECT DEPTNO, DEPTNAME, 'UNKNOWN' AS MGRNO
FROM DEPARTMENT
WHERE MGRNO IS NULL;

--Task 6
-- List the project number and major project number for all projects that have a project
-- number beginning with MA. If the major project number is unknown, display the text
-- 'MAIN PROJECT.'
-- Name the derived column MAJOR PROJECT.
-- Sequence the results by PROJNO.
SELECT PROJNO, COALESCE(MAJPROJ, 'MAIN PROJECT') AS "MAJOR PROJECT"
FROM PROJECT
WHERE PROJNO LIKE 'MA%'
ORDER BY PROJNO;

-- Task 7
-- List all employees who were younger than 25 when they joined the company.
-- List their employee number, last name, and age when they joined the company.
-- Name the derived column AGE.
-- Sort the result by age and then by employee number
SELECT EMPNO, LASTNAME, YEAR(CURRENT_DATE - HIREDATE) AS AGE
FROM EMPLOYEE
WHERE YEAR(CURRENT_DATE - HIREDATE) < 25
ORDER BY AGE, EMPNO;

-- Task 8
-- List the project number and duration, in weeks, of all projects that have a project
-- number beginning with MA. The duration should be rounded and displayed with one
-- decimal position.
-- Name the derived column WEEKS.
-- Order the list by the project number.
SELECT PROJNO, (DAYS(PRENDATE) - DAYS(PRSTDATE)) / 7.0 AS WEEKS
FROM PROJECT
WHERE PROJNO LIKE 'MA%'
ORDER BY PROJNO;

--Task 9
-- Produce a report listing all employees whose last name ends with 'N'. List the
-- employee number, the last name, and the last character of the last name used to
-- control the result. The LASTNAME column is defined as VARCHAR. There is a
-- function which provides the length of the last name.
SELECT EMPNO, LASTNAME, SUBSTR(LASTNAME, LENGTH(LASTNAME), 1) AS VARCHAR
FROM EMPLOYEE
WHERE LASTNAME LIKE '%N';

--Task 10
-- For each project, display the project number, project name, department number, and
-- project number of its associated major project (COLUMN = MAJPROJ). If the value
-- in MAJPROJ is NULL, show a literal of your choice instead of displaying a null value.
-- List only projects assigned to departments D01 or D11. The rows should be listed in
-- project number sequence.
SELECT PROJNO, PROJNAME, DEPTNO, COALESCE(MAJPROJ, 'MAJPROJECT') AS MAJPROJ
FROM PROJECT
WHERE DEPTNO IN ('D01', 'D11')
ORDER BY PROJNO;

--Task 11
-- The salaries of the employees in department E11 will be increased by 3.75 percent.
-- What will be the increase in dollars? Display the last name, actual yearly salary, and
-- the salary increase rounded to the nearest dollar. Do not show any cents.
SELECT LASTNAME, SALARY, DECIMAL(ROUND(SALARY * 0.0375, 0), 9, 0) AS SAL_INCR
FROM EMPLOYEE
WHERE WORKDEPT = 'E11';