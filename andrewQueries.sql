CREATE OR REPLACE PROCEDURE getBook(personID in INTEGER, get_pid in INTEGER)
AS 
book integer;
person integer;
isAuthor CHAR;
hasPayed CHAR;
isBook CHAR;

BEGIN
  --Check that the book exists
    isAuthor := bookExists( 1, 2);
  if bookExists(get_pid) = 'F' then
    DBMS_OUTPUT.PUT_LINE('The Book does not exist...');
    RETURN;
  else
    if personExists(personID) = 'F' then
        DBMS_OUTPUT.PUT_LINE('The Person does not exist...');
        RETURN; 
    else
        DBMS_OUTPUT.PUT_LINE('Continue');
    END IF; 
     
        
  END IF;  

END;
--Function that returns a T if the book exists, otherwise
--it will return an 'F'
CREATE OR REPLACE FUNCTION bookExists(book_pid in INTEGER)
RETURN CHAR(1)
  IS
    book integer; 
  BEGIN
    Select MAX(p.pid) INTO book
    FROM Publications P
    WHERE P.pid = book_pid;
    
    IF book IS NULL THEN
       return 'F'
    ELSE
       return 'T'
    END IF;
END bookExists;

--Function that returns a T of the person exists, otherwise
--it will return an ''
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



