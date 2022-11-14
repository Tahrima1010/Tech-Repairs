
--changing total_products after delivery
set serveroutput on;
set verify off;


CREATE OR REPLACE PACKAGE mypack AS

	FUNCTION dateF(d1 IN invoice1.tech_id%type)
	RETURN invoice1.tech_id%type;

END mypack;
/

CREATE OR REPLACE PACKAGE BODY mypack AS
    FUNCTION dateF(d1 IN invoice1.tech_id%type)
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

END mypack;
/

 
ACCEPT TID    number PROMPT "Enter Technician ID=  "

declare
E technicians1.tech_id%type;
functioncall1 invoice1.tech_id%type;
exception1 exception;

begin
E := '&TID';


if  E<0 then 
   raise exception1;
else
  functioncall1 := mypack.dateF(E);
end if;

 
 
exception

   WHEN exception1 THEN
   
   dbms_output.put_line('ID not found');
end;
/

CREATE OR REPLACE TRIGGER T1 
AFTER UPDATE 
OF total_products
ON technicians1
FOR EACH ROW
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('UPDATE TRIGGERED');
END;
/
commit;