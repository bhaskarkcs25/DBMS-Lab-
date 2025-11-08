create database Insurance;

show databases;

use Insurance;

CREATE TABLE Person (
driver_id varchar(10),
name varchar(20), 
address varchar(30),
primary key(driver_id));

DESC Person;

create table car(reg_num varchar(10),model varchar(10),year int, primary key(reg_num));
desc car;

create table accident(report_num int, accident_date date, location varchar(20),primary key(report_num));
desc accident;

create table owns(driver_id varchar(10),reg_num varchar(10),
primary key(driver_id, reg_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num));
desc owns;

create table participated(driver_id varchar(10),reg_num varchar(10),
 report_num int, damage_amount int, primary key(driver_id, reg_num, report_num),
 foreign key(driver_id) references person(driver_id),
 foreign key(reg_num) references car(reg_num), foreign key(report_num)
 references accident(report_num));
 
 desc participated;
 
 insert into Person (driver_id, name, address)
 values ("A01", "Richard", "Srinivas nagar");
 insert into Person (driver_id, name, address)
 values ("A02", "Pradeep", "Rajaji nagar");
 insert into Person (driver_id, name, address)
 values ("A03", "Smith", "Ashok nagar");
 insert into Person (driver_id, name, address)
 values ("A04", "Venu", "N R Colony");
 insert into Person (driver_id, name, address)
 values ("A05", "John", "Hanumanth nagar");
select * from Person;

insert into car (reg_num, model, year)
 values ("KA052250", "Indica", 1990);
insert into car (reg_num, model, year)
 values ("KA031181", "Ferrari", 2000);
insert into car (reg_num, model, year)
 values ("KA095477", "Lambo", 2010);
insert into car (reg_num, model, year)
 values ("KA053408", "Hyundai", 2020);
insert into car (reg_num, model, year)
 values ("KA041627", "Toyota", 2025);
 select * from car;
 
 insert into owns(driver_id, reg_num)
 value ("A01","KA052250");
  insert into owns(driver_id, reg_num)
 value ("A02","KA031181");
  insert into owns(driver_id, reg_num)
 value ("A03","KA095477");
  insert into owns(driver_id, reg_num)
 value ("A04","KA053408"); 
  insert into owns(driver_id, reg_num)
 value ("A05","KA041627");
 select * from owns;
 
INSERT INTO accident (report_num, accident_date, location)
VALUES (11, '2025-01-01', 'Mysuru Road');
 insert into accident (report_num,accident_date, location)
 value (12, '2025-02-02',"South end Circle");
 insert into accident (report_num,accident_date, location)
 value (13, '2025-03-01',"Bull Temple Road");
 insert into accident (report_num,accident_date, location)
 value (14, '2025-04-01',"Mysuru Road");
 insert into accident (report_num,accident_date, location)
 value (15, '2025-05-01',"KanakPura Road");
 select * from accident;

insert into participated(driver_id, reg_num, report_num, damage_amount)
values("A01","KA052250",11,10000);
insert into participated(driver_id, reg_num, report_num, damage_amount)
values("A02","KA031181",12,50000);
insert into participated(driver_id, reg_num, report_num, damage_amount)
values("A03","KA095477",13,25000);
insert into participated(driver_id, reg_num, report_num, damage_amount)
values("A04","KA053408",14,3000);
insert into participated(driver_id, reg_num, report_num, damage_amount)
values("A05","KA041627",15,5000);
select * from participated;

select accident_date, location 
from ACCIDENT;

select driver_id
from PARTICIPATED
where damage_amount >=25000;


#WEEK 2------------------->
#LIST THE ENTIRE PARTICIPATED RELATION IN THE DESCENDING ORDER OF DAMAGE AMOUNT.
SELECT * 
FROM Participated 
ORDER BY damage_amount DESC;

#FIND THE AVERAGE DAMAGE AMOUNT
SELECT AVG(damage_amount) AS average_damage 
FROM Participated;

#DELETE THE TUPLE WHOSE DAMAGE AMOUNT IS BELOW THE AVERAGE DAMAGE AMOUNT

#LIST THE NAME OF DRIVERS WHOSE DAMAGE IS GREATER THAN THE AVERAGE DAMAGE AMOUNT.
select driver_id  
from Participated
where damage_amount > (select AVG(damage_amount)from participated );

#with join method for driver name
SELECT name 
FROM Person
WHERE driver_id IN (
    SELECT driver_id 
    FROM Participated 
    WHERE damage_amount > (
        SELECT AVG(damage_amount) FROM Participated
    )
);

#Find the maximum damage amount
SELECT MAX(damage_amount) AS max_damage 
FROM Participated;