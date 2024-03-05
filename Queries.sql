--use EmployeeDemo;
--create table Employee(EmployeeId int Identity(1,1) primary key,EmployeeName varchar(30),EmployeeAge int ,
--EmployeeSalary int ,EmployeeAddress varchar(50));

--create Proc spInsertEmployeeDetails
--@name varchar(30),@age int,@salary int,@address varchar(50)
--As
--Begin
--Insert into Employee(EmployeeName,EmployeeAge,EmployeeSalary,EmployeeAddress) values (@name,@age,@salary,@address)
--End

--create Proc spUpdateEmployeeDetailsById
--@id int,@name varchar(30),@age int,@salary int,@address varchar(50)
--As
--Begin
--update Employee set EmployeeName= @name,EmployeeAge=@age,EmployeeSalary=@salary,EmployeeAddress=@address where EmployeeId=@id
--End

--create Proc spGetEmployeeDetails
--As
--Begin
--select * from Employee
--End

sp_helptext spDeleteEmployeeDetailsById

--====================================================
select * from Employee order by EmployeeSalary;
select e.EmployeeSalary from employee e where (select count(distinct e1.EmployeeSalary)from employee e1
where e.EmployeeSalary<=e1.EmployeeSalary)in(2,4)
union all
select e.EmployeeSalary from employee e where (select count(distinct e1.EmployeeSalary)from employee e1
where e.EmployeeSalary>=e1.EmployeeSalary)in(5,1);
select * from Employee order by EmployeeSalary desc;

select * from employee;
select * from employee 
order by EmployeeId
offset 1 rows
fetch first 1 rows only;
--alter table employee Rename column EmployeeSal to EmployeeSalary;
exec sp_rename 'Employee.EmployeeSalary','EmployeeSal','column';


--=========================================================================
create database FourthReview;
use FourthReview;
create table Employee(EmployeeId int Identity(1,1) primary key,EmployeeName varchar(30),EmployeeAge int ,
EmployeeDept varchar(50));
insert into Employee values('Prabhu',27,'Testing',45000);

--alter table Employee Add EmployeeSalary int;
--select * from Employee;
--exec sp_rename 'Employee.EmployeeDept','EmployeeDpt','COLUMN';
--insert into Employee values('Raghu',29,'Developer',45000);
--update Employee set EmployeeSalary=55000 where EmployeeId=1;
--Delete table EMployee where EMployeeAge<25;
-------------------------------------------
select EmployeeName from Employee order by EmployeeName;
select top 5 EmployeeName,EmployeeSalary from Employee order by EmployeeSalary desc;
select EmployeeName from EMployee where EmployeeName like 'a%';
select * from EMployee order by EmployeeId offset 2 rows;

create table Department(DepartmentId int Identity(1,1) primary key,DepartmentName varchar(30));
insert into Department values('Developer');

--select * from EMployee e Inner Join Department d on e.EmployeeDpt = d.DepartmentName;

create Proc spGetEmployeeDetailsByName
@name varchar(1)
As
Begin
select * from Employee where EmployeeName like @name+'%'
End

create Proc spGetEmployeeDetailsById
@id int
As
Begin	
select * from Employee where EmployeeId=@id
End

select e.EmployeeSal from employee e where (select count(distinct e1.EmployeeSal)from employee e1 where e.EmployeeSal<=e1.EmployeeSal)=2;
-------------------------------------------------------------------------------------
select * from employee;
create table Product(
product_Id int identity(1,1) primary key,
product_Name varchar(30),
brand_Id int,
product_Price dec(10,2));
select * from product;

CREATE TABLE product_audits(
    change_id INT IDENTITY PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(30),
    brand_id INT ,
    product_Price DEC(10,2),
    updated_at DATETIME NOT NULL,
    operation CHAR(3) NOT NULL,
    CHECK(operation = 'INS' or operation='DEL')
);
select * from product_audits;
-----------------------------------------------------
create Trigger trg_Product_audits
on Product
After insert,delete
as
begin
insert into product_audits(product_Id,product_Name,brand_Id,product_Price,updated_at,operation)
    SELECT i.product_Id,product_Name,brand_Id,i.product_Price,GETDATE(),'INS'
    FROM inserted i
    UNION ALL
    SELECT d.product_Id,product_Name,brand_Id,d.product_Price,GETDATE(),'DEL'
    FROM deleted d;
END
--====================================================
insert into product values('Vivo',1001,34333.99);
delete from product where product_Id=2;



==================================================================





CREATE TABLE ContactDetails (
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    PhoneNo BIGINT PRIMARY KEY,
    Email NVARCHAR(100),
    Address NVARCHAR(255),
    City NVARCHAR(100),
    State NVARCHAR(50),
    Zip INT
);
select * from ContactDetails;
select FirstName from ContactDetails;
--=============================================
create database payroll_service;
use payroll_service;

create table Employee_payroll(empId int primary key identity(1,1),
empName varchar(30) not null,empSalary decimal,empStartDate date);
select * from Employee_payroll;

insert into Employee_payroll values('Anbu',49800,'2009-10-04');

select * from Employee_payroll where empName='Kumar'; 
select * from Employee_payroll where empStartDate >=('2016-05-21') And empStartDate<=GETDATE();

Alter table Employee_payroll add empGender varchar(6);

update EMployee_payroll set empGender='female' where empName in ('poonkodi');
update Employee_payroll set empName='Poonkodi' where empName = 'Kumar';

select * from Employee_payroll;

select empGender,sum(empSalary)as sumOfEachGenderSal from EMployee_payroll group by empGender;
select empGender,Avg(empSalary)as AvgOfEachGenderSal from EMployee_payroll group by empGender;
select empGender,min(empSalary)as MinOfEachGenderSal from EMployee_payroll group by empGender;
select empGender,max(empSalary)as MaxOfEachGenderSal from EMployee_payroll group by empGender;
select empGender,count(empSalary)as CountOfEachGenderSal from EMployee_payroll group by empGender;

create table EmployeePayroll (empId int primary key identity(1,1),
empName varchar(30) not null,empContact Bigint,empSalary decimal,empStartDate date);

insert into EmployeePayroll (empId,empName,empContact,empSalary,empStartDate)
select empId,empName,Null as NewColumn,empSalary,empStartDate from Employee_payroll;

drop table Employeepayroll;
select * from Employeepayroll;

use AddressBook;
select * from Address;

--=================================
create table department(deptId int primary key,deptName varchar,deptLoc varchar);

create table emp(empId int primary key,firstName varchar,lastName varchar,deptId int
foreign key references dept(deptId));

insert into dept values(101,'sales','tamilnadu');
insert into emp values(1001,'prem','kumar',101);
select * from dept;






=================================================






create database ED;
use ED;
CREATE TABLE College ( CollegeID INT PRIMARY KEY,CollegeName VARCHAR(100) NOT NULL,
    CollegeLocation VARCHAR(50));
CREATE TABLE University ( UniversityID INT PRIMARY KEY,UniversityName VARCHAR(100) NOT NULL,
    UniversityLoc VARCHAR(50));
CREATE TABLE Student ( StudentID INT PRIMARY KEY, StudentName VARCHAR(50) NOT NULL,
    CollegeID INT FOREIGN KEY REFERENCES College(CollegeID),
    UniversityID INT FOREIGN KEY REFERENCES University(UniversityID));
CREATE TABLE Professor (ProfessorID INT PRIMARY KEY, ProfessorName VARCHAR(50) NOT NULL,
    CollegeID INT FOREIGN KEY REFERENCES College(CollegeID),
    UniversityID INT FOREIGN KEY REFERENCES University(UniversityID));
CREATE TABLE HOD (HodID INT PRIMARY KEY, HodName VARCHAR(50) NOT NULL,HodDepartment VARCHAR(50) NOT NULL,
    CollegeID INT FOREIGN KEY REFERENCES College(CollegeID),
    UniversityID INT FOREIGN KEY REFERENCES University(UniversityID));

insert into College values (1001,'Saratha','Goa');
insert into College values (1002,'Mahendhra','TamilNadu');
insert into College values (1003,'Moonlight', 'Chennai');
select * from college;

insert into University values(101,'AnnaUniversity','India');
insert into University values(102, 'Oxford University', 'England');
select * from University;

INSERT INTO Student (StudentID, StudentName, CollegeID, UniversityID) VALUES (501, 'Prem', 1001, 101);
INSERT INTO Student (StudentID, StudentName, CollegeID, UniversityID) VALUES (502, 'Kumar', 1002, 101);
INSERT INTO Student (StudentID, StudentName, CollegeID, UniversityID) VALUES (503, 'Emily', 1002, 101);
INSERT INTO Student (StudentID, StudentName, CollegeID, UniversityID) VALUES (504, 'Anbu', 1001, 101);
INSERT INTO Student (StudentID, StudentName, CollegeID, UniversityID) VALUES (505, 'Johnson', 1002, 101);
INSERT INTO Student (StudentID, StudentName, CollegeID, UniversityID) VALUES (506, 'Raghu', 1003, 101);
INSERT INTO Student (StudentID, StudentName, CollegeID, UniversityID) VALUES (507, 'sagar', 1003, 101);
select * from student;

INSERT INTO Professor (ProfessorID, ProfessorName, CollegeID, UniversityID) VALUES (301, 'Dr. Robert', 1001, 101);
INSERT INTO Professor (ProfessorID, ProfessorName, CollegeID, UniversityID) VALUES (302, 'Dr. Prabu', 1002, 101);
INSERT INTO Professor (ProfessorID, ProfessorName, CollegeID, UniversityID) VALUES (303, 'Dr. Soundhar', 1001, 101);
INSERT INTO Professor (ProfessorID, ProfessorName, CollegeID, UniversityID) VALUES (304, 'Dr. Kumar', 1003, 101);
INSERT INTO Professor (ProfessorID, ProfessorName, CollegeID, UniversityID) VALUES (305, 'Dr. aj', 1003, 101);
select * from professor;

INSERT INTO HOD (HodID, HodName, HodDepartment, CollegeID, UniversityID) VALUES (701, 'Dr. John', 'ComputerScience', 1003, 101);
INSERT INTO HOD (HodID, HodName, HodDepartment, CollegeID, UniversityID) VALUES (704, 'Dr. Thara', 'English', 1001, 101);
INSERT INTO HOD (HodID, HodName, HodDepartment, CollegeID, UniversityID) VALUES (702, 'Dr. Kannan', 'Business', 1002, 101);
INSERT INTO HOD (HodID, HodName, HodDepartment, CollegeID, UniversityID) VALUES (705, 'Dr. Ramana', 'IT', 1002, 101);
INSERT INTO HOD (HodID, HodName, HodDepartment, CollegeID, UniversityID) VALUES (707, 'Dr. Sumi', 'Physics', 1001, 101);
select * from hod;
--===============================
SELECT
    Student.StudentID, 
	Student.StudentName, 
	College.CollegeName AS StudentCollege,
    University.UniversityName AS StudentUniversity,
	Professor.ProfessorID,Professor.ProfessorName,
    HOD.HodID,HOD.HodName,HOD.HodDepartment,
    College.CollegeLocation AS HodCollegeLocation,
	University.UniversityLoc AS HodUniversityLocation
FROM 
    Student INNER JOIN College
	ON Student.CollegeID = College.CollegeID
	 INNER JOIN University 
	ON Student.UniversityID = University.UniversityID
	LEFT JOIN Professor 
	ON Student.CollegeID = Professor.CollegeID AND Student.UniversityID = Professor.UniversityID
    LEFT JOIN HOD 
	ON Student.CollegeID = HOD.CollegeID AND Student.UniversityID = HOD.UniversityID
	order by Student.StudentName desc;

--===================================



















use Practice;
create table employee (empID int identity(1,1) primary key,empName varchar(20) NOT NULL ,empsal int not null);
--======================================
create procedure insertemp
@name varchar(20),@sal int
as
begin
insert into employee (empName,empsal) values (@name,@sal)
end;
exec insertemp @name='PREM',@sal=120;
--=======================================
create procedure selectemp
as
begin 
select * from employee
end;

exec selectemp;
--== =======================

create procedure updateemp 
@id int,@name varchar(20) 
as 
begin 
update employee set empName=@name where empID=@id
end;

select * from employee;










