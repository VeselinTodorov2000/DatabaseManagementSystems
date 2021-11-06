SET SCHEMA DB2SAMPLE;

-- Task 1
-- List those employees that have a salary which is greater than or equal to the
-- average salary of all employees plus $5,000.
-- Display department number, employee number, last name, and salary. Sort the list
-- by the department number and employee number.
SELECT WORKDEPT, EMPNO, LASTNAME, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) + 5000
                FROM EMPLOYEE)
ORDER BY WORKDEPT, EMPNO;

-- Task 2
-- List employee number and last name of all employees not assigned to any projects.
-- This means that table EMP_ACT does not contain a row with their employee
-- number.
SELECT EMPNO, LASTNAME
FROM EMPLOYEE
WHERE EMPNO NOT IN (SELECT DISTINCT EMPNO
                    FROM EMPACT);

-- Task 3
-- List project number and duration (in days) of the project with the shortest duration.
-- Name the derived column DAYS.
SELECT PROJNO, DAYS(PRENDATE)-DAYS(PRSTDATE) AS DAYS
FROM PROJECT
WHERE DAYS(PRENDATE)-DAYS(PRSTDATE) = (SELECT MIN(DAYS(PRENDATE)-DAYS(PRSTDATE))
                                       FROM PROJECT);

-- Task 4
-- List department number, department name, last name, and first name of all those
-- employees in departments that have only male employees.
SELECT D.DEPTNO, D.DEPTNAME, E.LASTNAME, E.FIRSTNME
FROM EMPLOYEE E, DEPARTMENT D
WHERE D.DEPTNO NOT IN (SELECT DISTINCT WORKDEPT
                       FROM EMPLOYEE
                       WHERE SEX = 'F');

-- Task 5
-- We want to do a salary analysis for people that have the same job and education
-- level as the employee Stern. Show the last name, job, edlevel, the number of years
-- they've worked as of January 1, 2000, and their salary.
-- Name the derived column YEARS.
-- Sort the listing by highest salary first.
SELECT LASTNAME, JOB, EDLEVEL, YEAR('01-01-2000' - HIREDATE), SALARY
FROM EMPLOYEE
WHERE (JOB, EDLEVEL) IN
(SELECT JOB, EDLEVEL
FROM EMPLOYEE
WHERE LASTNAME = 'STERN')
ORDER BY SALARY;

-- Task 6
-- Retrieve all employees who are not involved in a project. Not involved in a project
-- are those employees who have no row in the EMP_ACT table. Display employee
-- number, last name, and department name.
SELECT EMPNO, LASTNAME, WORKDEPT
FROM EMPLOYEE
WHERE EMPNO NOT IN (SELECT DISTINCT EMPNO
                    FROM EMP_ACT);