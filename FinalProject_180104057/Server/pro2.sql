--Technicians part

set serveroutput on;
set verify off;

create or replace view INVOICEView(Branch,Bill) as
select P.branch_name,P.bill  from invoice1 P union select P1.branch_name,P1.bill from Invoice2@site_VM P1;
select * from INVOICEView;

create or replace view CustomerView(Branch,customer_id) as
select Y.branch_name,Y.customer_id  from customer1 Y union select Y1.branch_name,Y1.customer_id from customer2@site_VM Y1;
select * from CustomerView;

create or replace view ProductView(Branch,product_id,category) as
select Z.branch_name,Z.product_id,Z.category  from product1 Z union select Z1.branch_name,Z1.product_id,Z1.category from Product2@site_VM z1;
select * from ProductView;

DECLARE
  A INVOICEView.bill%TYPE;
  B INVOICEView.bill%TYPE :=0;
  
BEGIN
	FOR R IN (SELECT bill FROM INVOICEView) LOOP
		A := R.bill;
		B :=B+A;
		
		
	END LOOP;
	DBMS_OUTPUT.PUT_LINE( 'Total Income ' || B);
END;
/

DECLARE
  A INVOICEView.bill%TYPE;
  B INVOICEView.bill%TYPE :=0;
  C INVOICEView.branch%TYPE;
  D INVOICEView.bill%TYPE :=0;
BEGIN
   
	FOR R IN (SELECT bill,branch FROM INVOICEView ) LOOP
		A := R.bill;
		C := R.branch;
		if C='Mohammadpur' then
		  B:=B+A;
		elsif C='Badda' then
		  D:=D+A;  
		END IF;
		
	END LOOP;
	DBMS_OUTPUT.PUT_LINE( 'Total Income of Mohammadpur Branch ' || B);
	DBMS_OUTPUT.PUT_LINE( 'Total Income of Badda Branch ' || D);
END;
/

DECLARE
  F customer1.customer_id%type;
  T customer1.customer_id%type;
  
BEGIN
	select count(customer_id) into F from CustomerView;
	DBMS_OUTPUT.PUT_LINE( 'Total Customers ' || F);
END;
/


DECLARE
  FE product1.product_id%type;
  
  
BEGIN
	select count(product_id) into FE from ProductView;
	DBMS_OUTPUT.PUT_LINE( 'Total Products ' || FE);
END;
/

DECLARE
  FF product1.product_id%type;
  FX product1.product_id%type;
  
  FF1 product1.product_id%type;
  FX1 product1.product_id%type;
  
  
BEGIN
	select count(product_id) into FF from ProductView where category='LAPTOP' and branch='Mohammadpur';
	DBMS_OUTPUT.PUT_LINE( 'Total laptops in Mohammadpur ' || FF);
	
	select count(product_id) into FX from ProductView where category='MOBILE' and branch='Mohammadpur';
	DBMS_OUTPUT.PUT_LINE( 'Total mobiles in Mohammadpur ' || FX);
	
	select count(product_id) into FF1 from ProductView where category='LAPTOP' and branch='Badda';
	DBMS_OUTPUT.PUT_LINE( 'Total laptops in Badda  ' || FF1);
	
	select count(product_id) into FX1 from ProductView where category='MOBILE' and branch='Badda';
	DBMS_OUTPUT.PUT_LINE( 'Total   mobiles in Badda ' || FX1);
END;
/

DECLARE
  F1 customer1.customer_id%type;
  T1 customer1.customer_id%type;
  
BEGIN

	select count(customer_id) into F1 from Customer1;
	DBMS_OUTPUT.PUT_LINE( 'Total Customers of Mohammadpur  ' || F1);
	
	select count(customer_id) into T1 from Customer2@site_VM;
	DBMS_OUTPUT.PUT_LINE( 'Total Customers Badda  ' || T1);
	
END;
/

commit;