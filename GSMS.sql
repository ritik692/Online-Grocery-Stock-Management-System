create database GSMS;
use GSMS;

create table Supplier(
Supplier_ID VARCHAR(8) NOT NULL,
Sname VARCHAR(15) NOT NULL,
Semail VARCHAR(40) NOT NULL,
Sphone char(10) NOT NULL,
PRIMARY KEY(Supplier_ID)
);

create table purchase_order(
Purchase_order_ID char(5) not null,
Supplier_ID char(8) not null,
Order_date Date not null,
Expected_delievery Date not null,
Purchase_total_cost int not null,
Primary key(Purchase_order_ID),
Foreign key(Supplier_id) references supplier(supplier_id)
);

create table customer(
Customer_ID char(5) not null,
Cname varchar(30),
Cphone char(10) not null,
Cmail varchar(50) not null,
primary key(Customer_ID)
);
create table Sales_order(
Sales_ID char(5) not null,
Sales_total int not null,
Sales_order_date Date not null,
Customer_ID char(5) not null,
Primary key(Sales_ID),

Foreign key(Customer_ID) references Customer(Customer_id)

);

create table Staff(
	SID int not null,
    Stname varchar(60),
    Job_tittle varchar(30),
    primary key(SID)
    
);

create table Packs(
Sales_ID char(5) not null,
SID int not null,
primary key(Sales_ID,SID),
foreign key(Sales_id) references Sales_order(Sales_ID),
foreign key(SID) references Staff(SID)

);





create table Product(
Product_ID int NOT NULL,
Pname VARCHAR(15) NOT NULL,
Pcategory VARCHAR(15) NOT NULL,
Curr_stock int NOT NULL,
Min_stock int NOT NULL,
Price_per_unit int NOT NULL,
Purchase_order_ID char(5) NOT NULL,
Sales_ID char(5) NOT NULL,
PRIMARY KEY(Product_ID)

);


insert into staff(SID,Stname,Job_tittle)
values 
(1827678,"Rugung","Worker"),
( 8718782,"Ritik","Worker"),
(1897891,"Rajnish","Worker"),
(8123789,"Rishabh","Worker"),
(8231979,"Anushka","Manager"),
(3218738,"Suresh","Guard"),
(8171783,"Ramesh","Guard");

insert into customer(Customer_ID,Cname,Cphone,Cmail)
values
(18768,"Umesh",9356723672,"umesh12@gmail.com"),
(12178,"Ayushi",8717617162,"ayushi569@gmail.com"),
(71868,"Ashutosh",9712678171,"ashu1234@gmail.com"),
(78382,"Shiya",9178618677,"shiya143@gmail.com");


insert into Packs(Sales_ID,SID)
Values
("76895",1827678),
("45398",8718782),
("98187",1897891),
("45343",8123789);


insert into purchase_order values("38918","41897891",'2023-02-11','2023-02-13',10000);
insert into purchase_order values("89127","41897891",'2023-02-10','2023-02-12',25000);
insert into purchase_order values("21989","41897891",'2023-02-16','2023-02-18',30000);
insert into purchase_order values("32719","41897891",'2023-02-15','2023-02-17',28000);
insert into purchase_order values("29173","41897891",'2023-02-09','2023-02-11',50000);
insert into purchase_order values("29198","41897891",'2023-02-20','2023-02-22',35000);
insert into purchase_order values("87463","41897891",'2023-03-01','2023-03-03',40000);
insert into purchase_order values("12877","41897891",'2023-02-28','2023-03-02',45000);
insert into purchase_order values("21871","41897891",'2023-03-03','2023-03-05',25000);
insert into purchase_order values("82711","41897891",'2023-02-12','2023-02-14',60000);
insert into purchase_order values("28711","41897891",'2023-03-02','2023-03-04',55000);
insert into purchase_order values("71787","41897891",'2023-02-19','2023-02-21',45000);


insert into sales_order values("76895",1500,"2023-02-15","18768"); 
insert into sales_order values("45398",400,"2023-02-18","12178"); 
insert into sales_order values("98187",800,"2023-02-12","71868"); 
insert into sales_order values("45343",1800,"2023-02-28","78382"); 



insert into Product values(923841,"Oreo","Biscuit",500,50,10,"38918","76895");
insert into Product values(298719,"Lays","Munchies",400,40,20,"89127","45392");
insert into Product values(291881,"Bourbon","Biscuit",500,50,30,"21989","45343");
insert into Product values(287382,"Maggi","InstantFood",300,30,14,"32791","76895");
insert into Product values(239481,"Tide","Detergent",200,20,58,"29198","98187");
insert into Product values(928192,"Kurkure","Munchies",500,50,20,"29173","76895");
insert into Product values(912898,"Banana","Fruits",360,36,60,"87463","98187");
insert into Product values(912828,"Egg","Dairy",360,36,8,"12877","45343");
insert into Product values(238901,"Sprite","ColdDrink",200,20,40,"21871","76895");
insert into Product values(400192,"Closeup","Toothpaste",100,10,100,"82711","98187");
insert into Product values(782139,"Dettol","Soap",200,20,60,"28711","98187");
insert into Product values(982133,"Kissan","Ketchup",200,20,110,"71787","45398");

insert into Supplier values("41897891","Agrawal","agrawalsupplies1234@gmail.com","8791567122");


select * from product,sales_order as S,customer as C
where Cname="Ayushi" and S.Customer_ID = C.Customer_id and S.Sales_ID=Product.Sales_ID;

select * from customer as C,Sales_order as S
where Sales_total=(select max(sales_total) from sales_order) and C.Customer_ID=S.Customer_ID;

select count(*) from staff,packs,sales_order 
where Stname="Ritik" and staff.SID=packs.SID and packs.sales_id=sales_order.sales_id;

SELECT Stname, Job_tittle
FROM staff 
WHERE (Stname, Job_tittle) NOT IN (
  SELECT Stname, Job_tittle
  FROM staff 
  INNER JOIN packs ON staff.SID = packs.SID 
  INNER JOIN sales_order ON sales_order.sales_ID = packs.sales_ID
);

select * from product where purchase_order_id="32719";

select count(*),job_tittle from staff group by job_tittle;

select * from purchase_order where purchase_total_cost=(select min(purchase_total_cost) from purchase_order)
UNION
select * from purchase_order where purchase_total_cost=(select max(purchase_total_cost) from purchase_order);





