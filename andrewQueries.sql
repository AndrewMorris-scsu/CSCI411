create or replace FUNCTION bookExists(book_pid in INTEGER)
RETURN CHAR
  IS
    book integer; 
  BEGIN
    Select MAX(p.pid) INTO book
    FROM Publications P
    WHERE P.pid = book_pid;
    
    IF book IS NULL THEN
       return 'F';
    ELSE
       return 'T';
    END IF;
END bookExists;

create or replace FUNCTION personExists(person_perid in INTEGER)
RETURN CHAR
  IS
    person integer; 
  BEGIN
    Select MAX(p.perid) INTO person
    FROM Persons P
    WHERE P.perid = person_perid;
    
    IF person IS NULL THEN
       return 'F';
    ELSE
       return 'T';
    END IF;
END personExists;

CREATE OR REPLACE PROCEDURE pay (perid in INTEGER, buy_pid in INTEGER)
AS 
book integer;
BEGIN
  SELECT MAX(p.pid) INTO book
  FROM Publications p
  WHERE p.pid = buy_pid;
  IF book IS NULL then
    DBMS_OUTPUT.PUT_LINE('The book does not exist');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Value inserted successfully');
  END IF;
END;



