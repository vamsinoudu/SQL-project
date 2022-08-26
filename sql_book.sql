CREATE DATABASE company_db;
use company_db;
CREATE TABLE employee(
fname varchar(30),
mint char(1),
lname varchar(30),
ssn char(9),
bdate date,
address varchar(30),
sex char(1),
salary float(10,2),
super_ssn char(9),
dno smallint(6),
constraint Pk_employee primary key (ssn)
);

create table department(
dname varchar(30),
dnumber smallint,
mgr_ssn char(9),
mgr_start_date date,
constraint pk_department primary key (dnumber)
);
create table dept_location(
dnumber smallint,
dlocation varchar(20),
constraint pk_department primary key(dnumber)
);
create table project(
pname varchar(30),
pnumber smallint,
plocation varchar(30),
dnum smallint,
constraint pk_project primary key (pnumber)
);
create table works_on(
essn char(9),
pno smallint,
hours float(4,2),
constraint pk_works_on primary key(essn,pno)
);
create table dependent(
essn char(9),
dependent_name varchar(30),
sex char(1),
bdate date,
relationship 
varchar(20),
constraint pk_dependent primary key(essn,dependent_name)
);
insert into employee(fname,mint,lname,ssn,bdate,address,sex,salary,super_ssn,dno)values
('John','B','Smith','123456789','1965-01-09','731 foudren,Houston. TX','M',30000,'333344555',5),
('sunny','T','leo','123456790','1965-02-11','732 foudren,Houston. TX','F',42000,'333344555',4),
('mark','V','Zucken','123456791','1965-02-13','733 foudren,Houston. TX','M',45000,'333344555',4),
('Suresh','S','Rama','123456792','1965-02-15','734 foudren,Houston. TX','F',47000,'333344555',5),
('Ramesh','G','Rao','123456793','1965-02-17','735 foudren,Houston. TX','M',50000,'333344555',4),
('cue','U','lay','123456794','1965-02-19','736 foudren,Houston. TX','F',47000,NULL,1);

insert into department(dname,dnumber,mgr_ssn,mgr_start_date)values
('Research',5,'333443333','1988-05-22'),
('Administration',4,'987654321','1995-05-22'),
('Headquarters',1,'88665555','1981-05-22');

insert into dept_location(dnumber,dlocation)values
(1,'Houston'),
(2,'Stafford'),
(3,'Bellaire'),
(4,'Sugarand'),
(5,'Houston');
insert into works_on(essn,pno,hours)values
('123456789',1,32.5),
('123456789',2,7.5),
('666884444',3,40.0),
('453453453',1,20.0),
('453453453',2,20.0),
('333445555',2,10.0),
('333445555',3,10.0),
('333445555',10,10.0),
('333445555',20,10.0),
('999887777',30,30.0),
('999887777',10,10.0),
('987987987',10,35.0),
('987987987',30,5.0),
('987654321',30,20.0),
('987654321',20,15.0),
('888665555',20,NULL);
insert into project (pname,pnumber,plocation,dnum)values
('ProductX',1,'Bellaire',5),
('ProductY',2,'Sugarland',5),
('ProductZ',3,'Houston',5),
('Computerization',10,'Stafford',4),
('Reorganization',20,'Houston',1),
('Newbenefits',30,'Stafford',4);

insert into dependent(essn,dependent_name,sex,bdate,relationship)values
('333445555','Alice','F','1986-04-05','Daughter'),
('333445555','Theodore','M','1983-04-05','Son'),
('333445555','Joy','F','1958-04-05','spouse'),
('987654321','Abner','M','1942-04-05','spouse'),
('123456789','Michael','M','1988-04-05','son'),
('123456789','Alice','M','1988-04-05','Daughter'),
('123456789','Elizabeth','M','1967-04-05','spouse');

ALTER TABLE employee
ADD constraint fk_super_ssn foreign key (super_ssn) references employee(ssn);

#we canot add a foreign key to referencing the same table.

ALTER TABLE employee
ADD constraint fk_dno foreign key (dno) references department(dnumber);

ALTER TABLE department
ADD constraint fk_dnumber foreign key(dnumber) references dept_location(dnumber);

ALTER TABLE project
ADD constraint fk_dnum foreign key(dnum) references department(dnumber);

ALTER TABLE works_on    
ADD constraint fk_essn foreign key(essn) references employee(ssn);

ALTER TABLE works_on
ADD constraint fk_pno foreign key(pno) references project(pnumber);

ALTER TABLE dependent  
ADD constraint fk_essn foreign key(essn) references employee(ssn);

# SQL queries on the database company_bd:

#inner join
select * from dependent join employee 
on dependent.essn=employee.ssn;

select *from employee;



SELECT * from employee;
select min(salary) from employee;
select distinct concat(fname,'  ',lname) as fullName from employee;
select distinct fname from employee;


SELECT *from department;

SELECT fname,lname from employee; 

SELECT fname AS first_name ,lname AS last_name from employee;

SELECT distinct dno,sex from employee;

SELECT *from employee
where dno=5;

SELECT *from employee
where salary >=30000;


select *from dependent;

select * from dept_location
where dlocation='Houston'AND dnumber=1;

select * from dept_location
where dlocation='Houston'OR dnumber=1;

select * from employee
where sex='M' AND salary>35000 AND dno=5;

select * from employee limit 5;
SELECT *
 FROM employee;
 select * from employee limit 1;
 
 #DML #Update:
 
 SET SQL_SAFE_UPDATES=0;
 
 UPDATE employee
 SET sex='F'
 WHERE fname='John';
 
  UPDATE employee
 SET lname='william'
 WHERE fname='John';
 
 SELECT *FROM employee;
 SELECT * FROM dependent;
#DELETE:
delete from dependent
where dependent_name='Alice';
 SELECT * FROM dependent;
 #Insert same value:
 insert into dependent(essn,dependent_name,sex,bdate,relationship)values
('333445555','Alice','F','1986-04-05','Daughter');
 SELECT * FROM dependent;
 #NOT
 SELECT * FROM employee
 where salary>25000 AND NOT sex='F' AND NOT dno='1';

#like operator example:
select * from employee
where fname like'_a%';
 
 #IN Operator:
 SELECT *FROM employee
 WHERE dno IN (5,1);
 # NOT
  SELECT *FROM employee
 WHERE dno NOT IN (5,1);
 
 # Between :
 SELECT *FROM employee
 WHERE salary between 30000 AND 50000;
 
 #mulitple condition alongwith between operator:
 SELECT*FROM workS_on
 WHERE hours BETWEEN 10 AND 30
 AND pno=2;
 
 #isnotNULL operator
 
 SELECT *FROM employee
 WHERE salary IS NULL;
 
  SELECT *FROM employee
 WHERE salary IS NOT NULL;
 
 #Orderby
 
 SELECT * FROM employee
 ORDER BY salary desc;
 
 #min()operator:
 SELECT MIN(salary) FROM employee
 WHERE SEX='M';
 
 #max()operator:
 SELECT MAX(salary) FROM employee
 WHERE SEX='M';
 
 #sum()operator:
 SELECT SUM(salary) FROM employee
 WHERE SEX='M';
 
#COUNT()operator:
 SELECT COUNT(salary) FROM employee
 WHERE SEX='M';
 
 #AVG()operator:
 SELECT AVG(salary) FROM employee
 WHERE SEX='M';
 
 #Limit
 SELECT *FROM employee
 ORDER BY salary DESC
 LIMIT 3;

#Group BY:
SELECT sex,AVG(salary) FROM employee
GROUP BY sex
ORDER BY AVG(salary) DESC;

#Having:

#Store procedure:
Delimiter //
CREATE procedure sp_selectAllEmployee()
begin
 SELECT * FROM employee;
END //
CALL  sp_selectAllEmployee();

#UNION:
 
SELECT * FROM employee
where sex='M'
UNION 
SELECT * FROM employee;

# ALL:
SELECT * FROM employee
where sex='M'
UNION ALL 
SELECT * FROM employee;

#DATE FUNCTION:
SELECT CURDATE() AS DATE;
SELECT YEAR(CURDATE() )AS YEAR;
SELECT MONTH(CURDATE())AS MONTH;
SELECT DAY(CURDATE() )AS DAY;

#DATE MANIPULATION:
SELECT CURDATE()+1 AS TOMMOROW;

#EXTRACTING THE DATE PART:
SELECT DATE('2022-08-24')AS DATE;
SELECT DATE ('2022-07-07 09:15:00')AS DATE;

# GETTING CURRENT TIME:
SELECT CURTIME() AS NOW;

#INDEXES:
SHOW INDEXES FROM employee;

CREATE INDEX super_ssn_index ON employee(super_ssn);

SHOW INDEXES FROM employee;

# DROPPING INDEX:
DROP INDEX super_ssn_index ON employee

SELECT * FROM employee
where salary >40000;

SELECT *FROM employee
where fname like '_A%'
SELECT *FROM dept_location;
SELECT *FROM employee;
SELECT *FROM department;
SELECT *FROM dependent;
#joins:

SELECT E.fname, E.lname, D.dlocation
FROM employee E
join dept_location D ;

SELECT e.address,e.salary,e.super_ssn,d.relationship
FROM employee e
JOIN dependent d on e.sex=d.sex;

#Group By:

SELECT * FROM employee;

SELECT fname ,sum(salary)
from employee
GROUP BY fname;

#Aggregation function:

SELECT sum(salary),Avg(salary),min(salary),max(salary)
from employee;

#group by and joins:

SELECT * FROM DEPT_LOCATION;
SELECT d.dlocation ,sum(salary),Avg(salary),min(salary),max(salary)
FROM employee e
join dept_location d on d.dnumber=e.dno
group by d.dlocation;



