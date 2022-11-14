set serveroutput on;
set verify off;


CREATE OR REPLACE PROCEDURE CusP(C1 IN Customer1.customer_name%TYPE)
IS
 
    TT Customer1.customer_id%TYPE;
	TF invoice1.delivery_date%TYPE;
	T1 invoice1.bill%TYPE;
	
	BEGIN
		FOR G IN (SELECT delivery_date,bill FROM invoice1 where customer_id=(select customer_id from customer1 where customer_name=C1)) LOOP
		     
			   
			   
			   TF := G.delivery_date;
			   T1 := G.Bill;
			   
			   dbms_output.put_line('Delivery date-   ' || TF );
			   dbms_output.put_line('Bill-  ' || T1 );
			   
						
			  
		END LOOP;
		
 
    

END CusP;
/



ACCEPT  X     Char PROMPT    "Do you want know your details?(1/0)  "
ACCEPT CName  Char PROMPT   "Enter customer name=  "
ACCEPT  Y    Char PROMPT    "Do you want change delivery Branch?(1/0)  "

declare 

 A Customer1.customer_name%TYPE;
 X number;
 Y number;
 exceptiond exception;

begin

  A := '&CName';
  X := '&X';
  Y := '&Y';
  
if X=1 then
  CusP(A);
  
elsif Y=1 then
  dbms_output.put_line(' Delivery Shifted ');

else 
   raise exceptiond;
end if;


exception
  when exceptiond then
  dbms_output.put_line('OKAY DONE');

end;
/
commit;