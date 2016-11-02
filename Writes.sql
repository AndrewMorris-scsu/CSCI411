CREATE OR REPLACE PROCEDURE Write (PERSONID IN INTEGER, write_pid in INTEGER)
AS
isAlreadyAuthor integer;
BEGIN
  IF personExists(personid) = 'F' then
    DBMS_OUTPUT.PUT_LINE('The author does not exist.');
  ELSIF bookExists(write_pid) = 'F' then
    DBMS_OUTPUT.PUT_LINE('The Publication does not exist.');
  ELSE
    Select MAX(W.pid) INTO isAlreadyAuthor
    FROM Writes W
    WHERE W.pid = write_pid AND W.perid = PERSONID;
    if isAlreadyAuthor IS NULL THEN
      INSERT INTO writes (PID, PERID) VALUES (PERSONID, WRITE_PID);
      DBMS_OUTPUT.PUT_LINE('Value inserted successfully');
    ELSE
      DBMS_OUTPUT.PUT_LINE('This author already exist for this book.');
    END IF;
  END IF;
  COMMIT;
END;
