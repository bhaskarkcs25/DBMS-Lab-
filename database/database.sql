create database Bank;
use Bank;

create table branch(
branch_name varchar(20)primary key,
branchcity varchar(20),
assets int);

create table bank_account(
accno int primary key,
branch_name varchar(20),
balance int,
foreign key(branch_name)references branch(branch_name));

create table bank_customer(
customer_name varchar(20)primary key,
customer_street varchar(20),
city varchar(20)
);

create table depositer(
customer_name varchar(20),
accno int,
primary key(customer_name,accno),
foreign key(customer_name)references bank_customer(customer_name),
foreign key(accno)references bank_account(accno));

desc depositer;

create table loan(
loan_number int primary key,
branch_name varchar(20),
amount int,
foreign key(branch_name)references branch(branch_name));


use bank;


insert into branch values("SBI_Chamrajpet","Bangalore",50000);
insert into branch values("SBI_ResidencyRoad","Bangalore",10000);
insert into branch values("SBI_ShivajiRoad","Bombay",20000);
insert into branch values("SBI_ParliamentRoad","Delhi",10000);
insert into branch values("SBI_Jantarmantar","Delhi",20000);


insert into bank_account values(1,"SBI_Chamrajpet",2000);
insert into bank_account values(2,"SBI_ResidencyRoad",5000);
insert into bank_account values(3,"SBI_ShivajiRoad",6000);
insert into bank_account values(4,"SBI_ParliamentRoad",9000);
insert into bank_account values(5,"SBI_Jantarmantar",8000);
insert into bank_account values(6,"SBI_Chamrajpet",4000);
insert into bank_account values(7,"SBI_ResidencyRoad",4000);


insert into bank_customer values("Avinash","Bull_temple_Road","Bangalore");
insert into bank_customer values("Ruchitha","Kuvempu_nagar","Ballari");
insert into bank_customer values("Mohan","National_College","Bangalore");
insert into bank_customer values("Nikil","Akbar_Road","Delhi");
insert into bank_customer values("Ravi","Prithviraj_Road","Delhi");


insert into depositer values("Avinash",1);
insert into depositer values("Ruchitha",2);
insert into depositer values("Nikil",4);
insert into depositer values("Mohan",5);
insert into depositer values("Nikil",6);
insert into depositer values("Ruchitha",7);
insert into depositer values("Mohan",3);

insert into loan values(1,"SBI_Chamrajpet",1000);
insert into loan values(2,"SBI_ResidencyRoad",2000);
insert into loan values(3,"SBI_ShivajiRoad",3000);
insert into loan values(4,"SBI_ParliamentRoad",4000);
insert into loan values(5,"SBI_Jantarmantar",5000);

select*from branch;
select d.customer_name,a.branch_name
from depositer d 
	join bank_account a on d.accno=a.accno
group by
	d.customer_name,a.branch_name
having count(d.accno)>=2;



select branch_name,(assets/1000000)as "Assets in Lakhs"
from branch;


create view branch_loan_summary as 
select branch_name, sum(amount) as total_loan_ammount
from loan 
group by branch_name;

/*1 st question*/
SELECT d.customer_name
FROM depositer d
JOIN bank_account a ON d.accno = a.accno
JOIN branch b ON a.branch_name = b.branch_name
WHERE b.branchcity = 'Bangalore'
GROUP BY d.customer_name
HAVING COUNT(DISTINCT a.branch_name) = (
    SELECT COUNT(*)
    FROM branch
    WHERE branchcity = 'Bangalore'
);


/*4th question*/
SELECT branch_name
FROM branch
WHERE assets > (
    SELECT MAX(assets)
    FROM branch
    WHERE branchcity = 'Bangalore'
);


/*2nd question*/
select customer_name from bank_customer 
where customer_name not in 
(select distinct customer_name from depositer);


/*3rd question*/
SELECT DISTINCT bc.customer_name 
FROM bank_customer bc 
JOIN depositer d ON bc.customer_name = d.customer_name 
JOIN bank_account ba ON d.accno = ba.accno 
JOIN branch br ON ba.branch_name = br.branch_name 
JOIN loan l ON br.branch_name = l.branch_name WHERE br.branchcity = 'banglore';

/*6th question*/
UPDATE bank_account
SET balance = balance + (balance * 0.05);