REATE OR REPLACE PROCEDURE pay (perid in INTEGER, buy_pid in INTEGER)
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
