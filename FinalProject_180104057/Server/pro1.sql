clear screen;
drop table Customer1 CASCADE CONSTRAINTS;
drop table Product1 CASCADE CONSTRAINTS;
drop table Invoice1 CASCADE CONSTRAINTS;
drop table Technicians1 CASCADE CONSTRAINTS;

create table Technicians1(
	tech_id int,
	t_name varchar2(20),
	t_type varchar2(20),
	t_number number,
	total_products int,
	branch_name varchar2(20),
	avail_status varchar2(20),
	PRIMARY KEY (tech_id)
	);
	
create table Product1(
    product_id int,
	product_model VARCHAR2(50),
    category VARCHAR2(50),
    branch_name varchar2(20),
    issue	varchar2(20),
	tech_id int,
	PRIMARY KEY (product_id),
	FOREIGN KEY (tech_id) REFERENCES Technicians1  (tech_id));
	
create table Customer1(
	customer_id int,
	customer_name VARCHAR2(50),
    customer_number number,	
	branch_name varchar2(20),
	PRIMARY KEY (customer_id)
	);
	
create table Invoice1(
	invoice_id int,
	customer_id int,
	tech_id int,
	product_id int,
	status varchar2(20),
	branch_name varchar2(20),
	bill number,
	date_of_issue varchar2(20),
	delivery_date varchar2(20),
	PRIMARY KEY (invoice_id),
	FOREIGN KEY (customer_id) REFERENCES Customer1 (customer_id),
	FOREIGN KEY (product_id) REFERENCES  Product1 (product_id),
	FOREIGN KEY (tech_id) REFERENCES Technicians1  (tech_id));
	
	
	
insert into Technicians1 values( 1 , 'karim', 'laptop' , 01713057113 , 1 , 'Mohammadpur' , 'free' );

insert into Technicians1 values ( 2 , 'Rahim', 'mobile' , 01713057114 , 2 , 'Mohammadpur' , 'free' );

insert into Technicians1 values ( 3 , 'Nuha',  'tablet' , 01713057115 , 1 , 'Mohammadpur' , 'free' );

insert into Technicians1  values( 4 , 'Farhab', 'laptop' , 01713057116 , 3 , 'Mohammadpur' , 'free' );

insert into Technicians1 values ( 5 , 'Rumman', 'moblie' , 01713057117 , 2 , 'Mohammadpur' , 'free' );

insert into Technicians1 values ( 11 , 'Tamanna', 'laptop' , 01713057118 , 1 , 'Mohammadpur' , 'free' );

insert into Technicians1 values ( 12 , 'Sadia', 'tablet' , 01713057119 , 1 , 'Mohammadpur' , 'free' );




insert into  product1 values (101,'ASUS-TUF', 'LAPTOP','Mohammadpur','charger port',4);

insert into  product1 values (102,'HP-11', 'LAPTOP','Mohammadpur','speaker',1);

insert into  product1 values (103,'VIVO-12', 'MOBILE','Mohammadpur','display',5);

insert into  product1 values (104,'SAMSUNG note10', 'MOBILE','Mohammadpur','battery',2);

insert into  product1 values (105,'SAMSUNG', 'TABLET','Mohammadpur','display',3);

insert into  product1 values (111,'SAMSUNG NOTE8', 'MOBILE','Mohammadpur','display',5);

insert into  product1 values (112,'DELL-12', 'LAPTOP','Mohammadpur','display',11);

insert into  product1 values (113,'SAMSUNG-7', 'TABLET','Mohammadpur','display',12);

insert into  product1 values (114,'OPPO-10', 'MOBILE','Mohammadpur','display',2);

insert into  product1 values (115,'lenovo-3', 'LAPTOP','Mohammadpur','display',4);




insert into Customer1 values (201 , 'Asim'  , 0182206312  , 'Mohammadpur' );

insert into Customer1 values (202 , 'Razim'  , 0182206313  , 'Mohammadpur' );

insert into Customer1 values (203 , 'Hasib'  , 0182206314 , 'Mohammadpur' );

insert into Customer1 values (204 , 'Maisha'  , 0182206315  , 'Mohammadpur' );

insert into Customer1 values (205 , 'Rafi'  , 0182206316 , 'Mohammadpur' );

insert into Customer1 values (211 , 'Abdur'  , 0182206317  , 'Mohammadpur' );

insert into Customer1 values (212 , 'Shafi'  , 0182206318  , 'Mohammadpur' );

insert into Customer1 values (213 , 'Arhan'  , 0182206319  , 'Mohammadpur' );

insert into Customer1 values (214 , 'Shafia'  , 0182206320  , 'Mohammadpur' );

insert into Customer1 values (215 , 'Tawsif'  , 0182206321  , 'Mohammadpur' );



insert into Invoice1 values (301,201,4,101,'non-repairable','Mohammadpur',400,'01/03/2022','07/03/2022');	

insert into Invoice1 values (302,202,1,102,'repaired','Mohammadpur',450,'02/03/2022','06/03/2022');	

insert into Invoice1 values (303,203,5,103,'repaired','Mohammadpur',500,'03/03/2022','09/03/2022');
	
insert into Invoice1 values (304,204,2,104,'repaired','Mohammadpur',800,'04/03/2022','10/03/2022');	

insert into Invoice1 values (305,205,3,105,'repaired','Mohammadpur',1000,'05/03/2022','11/03/2022');

insert into Invoice1 values (311,211,5,111,'non-repairable','Mohammadpur',2000,'05/03/2022','12/03/2022');

insert into Invoice1 values (312,212,11,112,'repaired','Mohammadpur',520,'05/03/2022','11/03/2022');

insert into Invoice1 values (313,213,12,113,'repaired','Mohammadpur',1400,'06/03/2022','14/03/2022');

insert into Invoice1 values (314,214,2,114,'repaired','Mohammadpur',1500,'7/03/2022','15/03/2022');

insert into Invoice1 values (315,215,4,115,'repaired','Mohammadpur',1200,'5/03/2022','9/03/2022');

	

commit;

select * from Technicians1;

select * from Product1;

select * from Customer1;

select * from Invoice1;








 
 


