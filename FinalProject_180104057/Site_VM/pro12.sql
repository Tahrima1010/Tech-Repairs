set serveroutput on;
set verify off;



CREATE OR REPLACE FUNCTION ProductF1(w1 IN product2.product_id%type,w2 IN product2.product_model%type,w3 IN product2.category%type,w4 IN product2.branch_name%type,
   w5 IN product2.issue%type,w6 IN technicians2.tech_id%type)
	RETURN product2.product_id%type
	IS
	XS product2.product_id%type;
	tt product2.product_id%type;

	BEGIN
	FOR new_Tr IN (SELECT product_id FROM product2) LOOP
		    IF new_Tr.product_id = w1 THEN
			
			tt:=new_Tr.product_id;
			XS:=tt+1;
	     end if;
	END loop;
       INSERT INTO Product2(product_id,product_model,category,branch_name,issue,tech_id) VALUES (XS,w2,w3,w4,w5,w6);	
		
	RETURN XS;


END ProductF1;
/
	
CREATE OR REPLACE PROCEDURE InsertC1(CCid IN customer2.customer_id%type,CCName IN Customer2.customer_name%TYPE,CCnum in Customer2.customer_number%TYPE ,CCbname in Customer2.branch_name%TYPE)
IS
BEGIN 

 
    INSERT INTO Customer2(customer_id,customer_name, customer_number,branch_name) VALUES (CCid+1,CCName,CCNum,CCbname);

END InsertC1;
/

CREATE OR REPLACE PROCEDURE InvoiceP1(A1 IN invoice2.invoice_id%type,A2 IN invoice2.customer_id%TYPE,
A3 in invoice2.tech_id%TYPE ,A4 in invoice2.product_id%TYPE,A5 in invoice2.branch_name%TYPE)
IS
BEGIN 

 
    INSERT INTO Invoice2(invoice_id,customer_id,tech_id, product_id,status ,branch_name,bill,date_of_issue,delivery_date) 
	VALUES (A1+1,A2+1,A3,A4+1,'repaired',A5,2500,'3-march-2021','4-feb-2022');

END InvoiceP1;
/

CREATE OR REPLACE PROCEDURE TechP1( PTID IN Technicians2.tech_id%type)
IS
 
    TT Technicians2.total_products%TYPE;
	TF Technicians2.total_products%TYPE;
	
	
	BEGIN
		FOR new_T IN (SELECT total_products,tech_id FROM Technicians2) LOOP
		    IF new_T.tech_id = PTID THEN
			   
			   TT := new_T.total_products;
			   TF := TT+1;
			   
			   update Technicians2 set total_products=TF where tech_id=PTID;
						
			END IF;   
		END LOOP;
		
 
    

END TechP1;
/


ACCEPT CName  Char PROMPT   "Enter customer name=  "
ACCEPT CNum   Number PROMPT "Enter customer number=  "
ACCEPT BName  Char PROMPT   "Enter the Branchname you want to take service from =  "
ACCEPT TID    number PROMPT "Any choice for technician(0-7)=  "
ACCEPT PName  Char PROMPT   "Enter product category=  "
ACCEPT PModel  Char PROMPT   "Enter product model=  "
ACCEPT Pissue  Char PROMPT   "Enter your device problem=  "


declare 
 A Customer2.customer_name%TYPE;
 B Customer2.customer_number%TYPE;
 D Customer2.branch_name%TYPE;
 E technicians2.tech_id%type;
 n customer2.customer_id%type;
 branchexception exception;
 n1 product2.product_id%type;
C  product2.category%type;
C1 product2.product_model%type;
C2 product2.issue%type;
functioncall product2.product_id%type;
functioncall1 customer2.customer_id%type;
 n2 invoice2.invoice_id%type; 
 
 begin

A := '&CName';
B := '&CNum';
D := '&Bname';
E := '&TID';
C := '&Pname';
C1:= '&PModel';
C2:= '&Pissue';

if D!='Badda' then 
   raise branchexception;

end if; 

if  (E>0) then
   TechP1(E);
end if;

select customer_id into n from customer2 where customer_id=(select max (customer_id) as p from customer2);

dbms_output.put_line(n);

InsertC1(n,A,B,D);

select product_id into n1 from product2 where product_id=(select max (product_id) as p1 from product2);
 dbms_output.put_line(n1); 

 functioncall := ProductF1(n1,C1,C,D,C2,E);
 
 select invoice_id into n2 from invoice2 where invoice_id=(select max (invoice_id) as p2 from invoice2);
 dbms_output.put_line(n2); 
 InvoiceP1(n2,n,E,n1,D);
 
 exception

   WHEN branchexception THEN
   
   dbms_output.put_line('----Visit another branch site----');
   

end;
/
commit;

 