create database employee;
use employee;

create table Dept(DeptNo int primary key, Dname varchar(30), Dloc varchar(30));
Insert into Dept Values
(10,'HR','Bengaluru'),
(20,'Finance','Bengaluru'),
(30,'IT','Bengaluru'),
(40,'Marketing','Chennai'),
(50,'Operations','Delhi');

create table Employee(EmpNo int primary key, Ename varchar(30), Mgr_no int, Hiredate Date, Sal decimal(10,2), DeptNo int, foreign key(DeptNo) references Dept(DeptNo));
Insert Into Employee Values
(1001,'Asha', Null, '2020-05-12', 55000, 10),
(1002,'Rahul', 1001, '2021-01-18', 48000, 20),
(1003,'Sneha', 1001, '2019-08-21', 60000, 30),
(1004,'Kiran', 1003, '2022-04-15', 40000, 40),
(1005,'Vikram', 1002, '2020-09-12', 52000, 50),
(1006,'Neha', 1003, '2023-03-10', 47000, 30);

create table Project( PNo int Primary key, PName Varchar(30), PLoc varchar(30));
Insert into Project Values
(501,'ERP Upgrade','Bengaluru'),
(502,'Payrole Automation','Hyderabad'),
(503,'AI Chatbot','Mysuru'),
(504,'Market Survey','Delhi'),
(505,'Data Migration','Chennai');

create table Assigned_To(EmpNo int, PNo int, Job_Role varchar(30), Primary Key(EmpNo,PNo), foreign key(EmpNo) references Employee(EmpNo), foreign key(PNo) references Project(PNo));
Insert into Assigned_To Values
(1001, 501, 'Manager'),
(1002, 502, 'Analyst'),
(1003, 503, 'Developer'),
(1004, 505, 'Executive'),
(1005, 504, 'Coordinator'),
(1006, 503, 'Tester'),
(1003, 501, 'Consultant');

create table Incentives(EmpNo int, Incentivedate date, Incentive_Amount Decimal(10,2), foreign key(EmpNo) references Employee(EmpNo));
insert into Incentives values
(1001, '2023-12-10', 5000),
(1003, '2024-01-20', 7000),
(1005, '2024-03-15', 6000),
(1006, '2024-04-25', 3000),
(1002, '2023-10-05', 4000);

select * from project;
select * from Employee;
select * from Assigned_To;
select * from Incentives;
select * from Dept;

select distinct a.EmpNo from Assigned_To a Join Project p on a.PNo = p.PNo where p.PLoc in ('Bengaluru','Hyderabad','Mysuru');

select EmpNo from Employee where EmpNo not in (select EmpNo from Incentives);

SELECT
    e.Ename,
    e.EmpNo,
    d.Dloc AS Dept_Location,
    p.PLoc AS Project_Location
FROM
    Employee e
JOIN
    Dept d ON e.DeptNo = d.DeptNo
JOIN
    Assigned_To a ON e.EmpNo = a.EmpNo
JOIN
    Project p ON a.PNo = p.PNo
WHERE
    d.Dloc = p.PLoc;