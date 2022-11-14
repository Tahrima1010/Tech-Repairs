clear screen;

drop table Customer2 CASCADE CONSTRAINTS;
drop table Product2 CASCADE CONSTRAINTS;
drop table Invoice2 CASCADE CONSTRAINTS;
drop table Technicians2 CASCADE CONSTRAINTS;

create table Technicians2(
	tech_id int,
	t_name varchar2(20),
	t_type varchar2(20),
	t_number number,
	total_products int,
	branch_name varchar2(20),
	avail_status varchar2(20),
	PRIMARY KEY (tech_id)
	);
	
create table Product2(
    product_id int,
	product_model VARCHAR2(50),
    category VARCHAR2(50),
    branch_name varchar2(20),
    issue	varchar2(20),
	tech_id int,
	PRIMARY KEY (product_id),
	FOREIGN KEY (tech_id) REFERENCES Technicians2  (tech_id));
	
create table Customer2(
	customer_id int,
	customer_name VARCHAR2(50),
    customer_number number,	
	branch_name varchar2(20),
	PRIMARY KEY (customer_id));
	
create table Invoice2(
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
	FOREIGN KEY (customer_id) REFERENCES Customer2 (customer_id),
	FOREIGN KEY (product_id) REFERENCES  Product2 (product_id),
	FOREIGN KEY (tech_id) REFERENCES Technicians2  (tech_id));
	
	
	
insert into Technicians2 values( 6 , 'Ria', 'laptop' , 01913057113 , 1 , 'Badda' , 'free' );

insert into Technicians2 values ( 7 , 'Rifah', 'laptop' , 01913057114 , 3, 'Badda' , 'free' );

insert into Technicians2 values ( 8 , 'Nishi',  'tablet' , 01913057115 , 1 , 'Badda' , 'free' );

insert into Technicians2  values( 9 , 'Nishat', 'mobile' , 01913057116 , 1 , 'Badda' , 'free' );

insert into Technicians2 values ( 10 , 'Ayon', 'moblie' , 01913057117 , 1 , 'Badda' , 'free' );


insert into  product2 values (161,'ASUS-22', 'LAPTOP','Badda','keyboard',6);

insert into  product2 values (162,'HP-11', 'LAPTOP','Badda','speaker',7);

insert into  product2 values (163,'VIVO-PRO', 'MOBILE','Badda','display',9);

insert into  product2 values (164,'SAMSUNG note20', 'MOBILE','Badda','display',10);

insert into  product2 values (165,'HUAWEI', 'TABLET','Badda','battery',8);


insert into Customer2 values (261 , 'Asma'  , 0162206312  , 'Badda' );

insert into Customer2 values (262 , 'Rafa'  , 0162206313  , 'Badda' );

insert into Customer2 values (263 , 'Nafi'  , 0162206314  , 'Badda' );

insert into Customer2 values (264 , 'Wana'  , 0162206315  , 'Badda' );

insert into Customer2 values (265 , 'Farhad'  , 0162206316  , 'Badda' );


insert into Invoice2 values (361,261,6,161,'repaired','Badda',1000,'02/03/2022','14/03/2022');	

insert into Invoice2 values (362,262,7,162,'non-repairable','Badda',430,'04/03/2022','20/03/2022');	

insert into Invoice2 values (363,263,9,163,'repaired','Badda',510,'05/03/2022','19/03/2022');
	
insert into Invoice2 values (364,264,10,164,'repaired','Badda',700,'01/03/2022','16/03/2022');	

insert into Invoice2 values (365,265,8,165,'non-repairable','Badda',200,'03/03/2022','13/03/2022');	

commit;

