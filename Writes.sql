CREATE OR REPLACE PROCEDURE Write (PERSONID IN INTEGER, write_pid in INTEGER) 
AS 

BEGIN
  IF personExists(personid) = 'F' then
    DBMS_OUTPUT.PUT_LINE('The author does not exist.');
  ELSIF bookExists(write_pid) = 'F' then
    DBMS_OUTPUT.PUT_LINE('The Publication does not exist.');  
  ELSE 
    INSERT INTO writes (PID, PERID) VALUES (PERSONID, WRITE_PID);
    DBMS_OUTPUT.PUT_LINE('Value inserted successfully'); 
  END IF;
  COMMIT;
END;