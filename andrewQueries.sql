
-- Function that returns 'T' if the person exists, otherwise 'F'
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

-- Function that returns 'T' if the person exists, otherwise 'F'
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

-- Procedure to getBook for a person
CREATE OR REPLACE PROCEDURE getBook(personID in INTEGER, get_pid in INTEGER)
AS 
book integer;
person integer;
isAuthor CHAR(1);
hasPayed CHAR(1);

BEGIN
  --Check that the book exists
  Select p.pid into book
  FROM Publications P
  WHERE P.pid = get_pid;
  
  IF book is null THEN
    DBMS_OUTPUT.PUT_LINE('The book does not exist!!');
    EXIT;
  ELSIF 
  end if;

END;

