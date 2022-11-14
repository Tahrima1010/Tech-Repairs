--customer part--

set serveroutput on;
set verify off;

create or replace view myview2(ID,Name, Expert,Branch,Availability) as
select Q.tech_id,Q.t_name, Q.t_type, Q.branch_name,Q.avail_status from technicians1 Q union
select Q1.tech_id,Q1.t_name, Q1.t_type, Q1.branch_name,Q1.avail_status from technicians2@site_VM Q1;
select * from myview2;


CREATE OR REPLACE FUNCTION ProductF(w1 IN product1.product_id%type,w2 IN product1.product_model%type,w3 IN product1.category%type,w4 IN product1.branch_name%type,
    w5 IN product1.issue%type,w6 IN technicians1.tech_id%type)
	RETURN product1.product_id%type
	IS
	XS product1.product_id%type;
	tt product1.product_id%type;

	BEGIN
	FOR new_Tr IN (SELECT product_id FROM product1) LOOP
		    IF new_Tr.product_id = w1 THEN
			
			tt:=new_Tr.product_id;
			XS:=tt+1;
	     end if;
	END loop;
       INSERT INTO Product1(product_id,product_model,category,branch_name,issue,tech_id) VALUES (XS,w2,w3,w4,w5,w6);	
		
	RETURN XS;


END ProductF;
/
	
CREATE OR REPLACE PROCEDURE InsertC(CCid IN customer1.customer_id%type,CCName IN Customer1.customer_name%TYPE,CCnum in Customer1.customer_number%TYPE ,CCbname in Customer1.branch_name%TYPE)
IS
BEGIN 

 
    INSERT INTO Customer1(customer_id,customer_name, customer_number,branch_name) VALUES (CCid+1,CCName,CCNum,CCbname);

END InsertC;
/

CREATE OR REPLACE PROCEDURE InvoiceP(A1 IN invoice1.invoice_id%type,A2 IN invoice1.customer_id%TYPE,
A3 in invoice1.tech_id%TYPE ,A4 in invoice1.product_id%TYPE,A5 in invoice1.branch_name%TYPE)
IS

BEGIN 

    INSERT INTO Invoice1(invoice_id,customer_id,tech_id, product_id,status ,branch_name,bill,date_of_issue,delivery_date) 
	VALUES (A1+1,A2+1,A3,A4+1,'repaired',A5,2500,'03/03/2022','14/03/2022');

END InvoiceP;
/

CREATE OR REPLACE FUNCTION dateF(d1 IN invoice1.tech_id%type)
	RETURN invoice1.tech_id%type
	IS
	
	A invoice1.delivery_date%type;
	D invoice1.delivery_date%type;
	ww invoice1.tech_id%type;
	

	BEGIN
		
			A := TO_CHAR(SYSDATE,'DD/MM/YYYY');
			FOR T in (select tech_id,delivery_date from invoice1 where tech_id=d1) LOOP
			
				D := T.delivery_date;
				ww :=T.tech_id;
		        IF(D=A) THEN
				  
				update technicians1 set total_products=total_products-1 where tech_id=d1;
				end if;
			
			
		END LOOP;
		
	RETURN ww;


END dateF;	
/

CREATE OR REPLACE PROCEDURE TechP( PTID IN Technicians1.tech_id%type)
IS
 
    TT Technicians1.total_products%TYPE;
	TF Technicians1.total_products%TYPE;
	
	
	BEGIN
		FOR new_T IN (SELECT total_products,tech_id FROM Technicians1) LOOP
		    IF new_T.tech_id = PTID THEN
			   
			   TT := new_T.total_products;
			   TF := TT+1;
			   
			   update Technicians1 set total_products=TF where tech_id=PTID;
						
			END IF;   
		END LOOP;
		
 
    

END TechP;
/


CREATE OR REPLACE FUNCTION F1(Q IN technicians1.tech_id%type)
	RETURN technicians1.tech_id%type
	IS
	
	A technicians1.tech_id%type;
    B technicians1.total_products%type;
	

	BEGIN
		
			
			FOR NN in (select tech_id,total_products from technicians1 where tech_id=Q) LOOP
			
				A := NN.tech_id;
				B := NN.total_products;
		        IF(B>3) THEN
				  
				update technicians1 set avail_status='Busy' where tech_id=Q;
				end if;
			
			
		END LOOP;
		
	RETURN A;


END F1;	
/

ACCEPT CName  Char PROMPT   "Enter customer name=  "
ACCEPT CNum   Number PROMPT "Enter customer number=  "
ACCEPT BName  Char PROMPT   "Enter the Branchname you want to take service from =  "
ACCEPT TID    number PROMPT "Any choice for technician(0-7)=  "
ACCEPT PName  Char PROMPT   "Enter product category=  "
ACCEPT PModel  Char PROMPT   "Enter product model=  "
ACCEPT Pissue  Char PROMPT   "Enter your device problem=  "


declare 
 A Customer1.customer_name%TYPE;
 B Customer1.customer_number%TYPE;
 D Customer1.branch_name%TYPE;
 E technicians1.tech_id%type;
 n customer1.customer_id%type;
 branchexception exception;
 n1 product1.product_id%type;
C  product1.category%type;
C1 product1.product_model%type;
C2 product1.issue%type;
functioncall product1.product_id%type;
functioncall1 invoice1.tech_id%type;
 n2 invoice1.invoice_id%type;
functioncall2 technicians1.tech_id%type;
R number; 
AB technicians1.tech_id%type;
BB technicians1.t_name%type;
NB technicians1.t_number%type;
SB technicians1.avail_status%type;


begin

A := '&CName';
B := '&CNum';
D := '&Bname';
E := '&TID';
C := '&Pname';
C1:= '&PModel';
C2:= '&Pissue';

if (D!='Mohammadpur' and D!='Badda') then 
   raise branchexception;
   
 elsif D='Badda' then
   DBMS_OUTPUT.PUT_LINE('List of the available technicians of Badda  ');
   
  FOR R IN (SELECT * FROM technicians2@site_VM  ) LOOP
		AB := R.tech_id;
		BB := R.t_name;
		NB := R.t_number;
		SB := R.avail_status;
		
		IF  SB  = 'free' then 
			DBMS_OUTPUT.PUT_LINE( AB || '  ' ||  BB  || '  ' || NB );
		end if;
	END LOOP;

else  
 
 if  (E>0) then
   TechP(E);
 end if;

select customer_id into n from customer1 where customer_id=(select max (customer_id) as p from customer1);

dbms_output.put_line(n);

InsertC(n,A,B,D);

select product_id into n1 from product1 where product_id=(select max (product_id) as p1 from product1);
 dbms_output.put_line(n1); 

 functioncall := ProductF(n1,C1,C,D,C2,E);
 
 select invoice_id into n2 from invoice1 where invoice_id=(select max (invoice_id) as p2 from invoice1);
 dbms_output.put_line(n2); 
 InvoiceP(n2,n,E,n1,D);
 
 functioncall1 := dateF(E);
 functioncall2 := F1(E);
 
end if;
exception

   WHEN branchexception THEN
   
   dbms_output.put_line('----Visit another branch site----');
   

end;
/



CREATE OR REPLACE TRIGGER T2 
AFTER Insert
ON Customer1
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('INSERT TRIGGERED');
END;
/
commit;