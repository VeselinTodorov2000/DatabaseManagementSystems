SET SCHEMA DB2SAMPLE;

-- Task 1
-- List employee number, last name, date of birth, and salary for all employees who
-- make more than $30,000 a year. Sequence the results in descending order by
-- salary
SELECT EMPNO, LASTNAME, BIRTHDATE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 30000
ORDER BY SALARY DESC;

--Task 2
-- List last name, first name, and the department number for all employees. The listing
-- should be ordered by descending department numbers. Within the same
-- department, the last names should be sorted in descending order.
SELECT E.LASTNAME, E.FIRSTNME, D.DEPTNO
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.WORKDEPT = D.DEPTNO
ORDER BY D.DEPTNO DESC, LASTNAME DESC;

--Task 3
-- List the different education levels in the company in descending order. List only one
-- occurrence of duplicate result rows.
SELECT DISTINCT EDLEVEL
FROM EMPLOYEE
ORDER BY EDLEVEL DESC;

--Task 4
-- List employees, by employee number, and their assigned projects, by project
-- number. Display only those employees with an employee number less than or equal
-- to 100. List only one occurrence of duplicate rows. Sort the result rows by employee
-- number.
SELECT DISTINCT EMPNO, PROJNO
FROM EMP_ACT
WHERE EMPNO < '000100'
ORDER BY EMPNO;

--Task 5
-- List last name, salary, and bonus of all male employees.
SELECT LASTNAME, SALARY, BONUS
FROM EMPLOYEE
WHERE SEX = 'M';

--Task 6
-- List last name, salary, and commission for all employees with a salary greater than
-- $20,000 and hired after 1979.
SELECT LASTNAME, SALARY, COMM
FROM EMPLOYEE
WHERE SALARY > 20000 AND YEAR(HIREDATE) > 1979;

--Task 7
-- List last name, salary, bonus, and commission for all employees with a salary
-- greater than $22,000 and a bonus of $400, or for all employees with a bonus of
-- $500 and a commission lower than $1,900. The list should be ordered by last name.
SELECT LASTNAME, SALARY, BONUS, COMM
FROM EMPLOYEE
WHERE (SALARY > 22000 AND BONUS = 400)
OR (BONUS = 500 AND COMM < 1900)
ORDER BY LASTNAME;

--Task 8
-- List last name, salary, bonus, and commission for all employees with a salary
-- greater than $22,000, a bonus of $400 or $500, and a commission less than $1,900.
-- The list should be ordered by last name.
SELECT LASTNAME, SALARY, BONUS, COMM
FROM EMPLOYEE
WHERE SALARY > 22000 AND (BONUS = 400 OR BONUS = 500) AND COMM < 1900
ORDER BY LASTNAME;

--Task 9
-- Using the EMP_ACT table, for all projects that have a project number beginning with
-- AD and have activities 10, 80, and 180 associated with them, list the following:
--  • Project number
--  • Activity number
--  • Starting date for activity
--  • Ending date for activity
-- Order the list by activity number within project number.
SELECT PROJNO, ACTNO, EMSTDATE, EMENDATE
FROM EMP_ACT
WHERE PROJNO LIKE 'AD%' AND ACTNO IN (10, 80, 180)
ORDER BY PROJNO;

-- Task 10
-- List manager number and department number for all departments to which a
-- manager has been assigned.
-- The list should be ordered by manager number.
SELECT MGRNO, DEPTNO
FROM DEPARTMENT
WHERE MGRNO IS NOT NULL
ORDER BY MGRNO;

-- Task 11
-- List employee number, last name, salary, and bonus for all employees that have a
-- bonus ranging from $800 to $1,000.
-- Sort the report by employee number within bonus, lowest bonus first.
SELECT EMPNO, LASTNAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS BETWEEN 800 AND 1000
ORDER BY BONUS, EMPNO;

-- Task 12
-- List employee number, last name, salary, and department number for all employees
-- in departments A00 through C01 (inclusive).
-- Order the results alphabetically by last name and employee number.
SELECT E.EMPNO, E.LASTNAME, E.SALARY, E.WORKDEPT
FROM EMPLOYEE E
WHERE E.WORKDEPT BETWEEN 'A00' AND 'C01'
ORDER BY LASTNAME, EMPNO;

-- Task 13
-- List all projects that have SUPPORT as part of the project name. Order the results
-- by project number.
SELECT PROJNO
FROM PROJECT
WHERE PROJNAME LIKE '%SUPPORT%'
ORDER BY PROJNO;

-- Task 14
-- List all departments that have a 1 as the middle character in the department number.
-- Order the results by department number.
SELECT DEPTNAME
FROM DEPARTMENT
WHERE DEPTNO LIKE '_1_'
ORDER BY DEPTNO DESC;

-- Task 15
-- List the last name, first name, middle initial, and salary of the five highest paid
-- non-manager, non-president employees.
-- Order the results by highest salary first.
SELECT LASTNAME, FIRSTNME, MIDINIT, SALARY
FROM EMPLOYEE
WHERE JOB NOT IN ('PRES', 'MANAGER')
ORDER BY SALARY DESC
FETCH FIRST 5 ROWS ONLY;

-- Task 1
-- Produce a report that lists employees' last names, first names, and department
-- names. Sequence the report on first name within last name, within department
-- name.
SELECT LASTNAME E, FIRSTNME E, D.DEPTNAME
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.WORKDEPT = D.DEPTNO
ORDER BY WORKDEPT, LASTNAME, FIRSTNME;

-- Task 2
-- Modify the previous query to include job. Also, list data for only departments
-- between A02 and D22, and exclude managers from the list. Sequence the report on
-- first name within last name, within job, within department name.
SELECT LASTNAME E, FIRSTNME E, D.DEPTNAME, E.JOB
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.WORKDEPT = D.DEPTNO AND E.WORKDEPT BETWEEN 'A02' AND 'D22' AND JOB != 'MANAGER'
ORDER BY WORKDEPT, LASTNAME, FIRSTNME;

-- Task 3
-- List the name of each department and the lastname and first name of its manager.
-- Sequence the list by department name. Use the EMPNO and MGRNO columns to
-- relate the two tables. Sequence the result rows by department name.
SELECT D.DEPTNAME, E.LASTNAME, E.FIRSTNME
FROM DEPARTMENT D, EMPLOYEE E
WHERE D.MGRNO = E.EMPNO
ORDER BY D.DEPTNAME;

-- Task 4
-- Try the following: modify the previous query using WORKDEPT and DEPTNO as the
-- join predicate. Include a local predicate that looks for people whose job is manager.
SELECT D.DEPTNAME, E.LASTNAME, E.FIRSTNME
FROM DEPARTMENT D, EMPLOYEE E
WHERE D.DEPTNO = E.WORKDEPT AND E.JOB = 'MANAGER'
ORDER BY D.DEPTNAME;

-- Task 5
-- For all projects that have a project number beginning with AD, list project number,
-- project name, and activity number. List identical rows once. Order the list by project
-- number and then by activity number.
SELECT DISTINCT proj.PROJNO, proj.PROJNAME, ACTNO
FROM PROJACT act, PROJECT proj
WHERE PROJNO LIKE 'AD%' AND proj.PROJNO = act.PROJNO
ORDER BY PROJNO, ACTNO;

-- Task 6
-- Which employees are assigned to project number AD3113? List employee number,
-- last name, and project number. Order the list by employee number and then by
-- project number. List only one occurrence of duplicate result rows.
SELECT DISTINCT A.EMPNO, LASTNAME, PROJNO
FROM EMPLOYEE E,
EMP_ACT A
WHERE A.EMPNO = E.EMPNO
AND A.PROJNO = 'AD3113'
ORDER BY A.EMPNO, PROJNO;