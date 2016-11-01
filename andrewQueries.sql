CREATE OR REPLACE PROCEDURE getBook(personID in INTEGER, get_pid in INTEGER)
AS 
book integer;
person integer;
author integer; 
hasPayed integer;
isAuthor integer; 
isBook CHAR;

BEGIN
  --Check that the book exists
  if bookExists(get_pid) = 'F' then
    DBMS_OUTPUT.PUT_LINE('The Book does not exist...');
    RETURN;
  else
    if personExists(personID) = 'F' then
        DBMS_OUTPUT.PUT_LINE('The Person does not exist...');
        RETURN; 
    else
        DBMS_OUTPUT.PUT_LINE('Continue');
        SELECT MAX(A.perid) INTO isAuthor
        FROM Authors A, Writes W
        WHERE A.perid = W.perid 
          AND A.perid = personID;
        
        if isAuthor IS NULL THEN
            --We know the person is a consumer 
            --The person has to have bought in order to retrieve
            Select MAX(C.perid) INTO hasPayed
            FROM Customer C, paysFor P
            WHERE C.perid = personID
            AND C.perid = P.perid
            AND P.pid = get_pid;
            
            if hasPayed is NULL THEN 
                DBMS_OUTPUT.PUT_LINE('Customer has not paid for this book');
                RETURN;
            else
                DBMS_OUTPUT.PUT_LINE('Customer has paid for this book');
                INSERT INTO RetrieveLog (perid, pid, dateviewed)
                VALUES (personID, get_pid, SYSDATE());
            END IF;
        else
            --The person wrote the book and should be able to retrieve freely
            DBMS_OUTPUT.PUT_LINE('The Author can access his/her work freely');
            INSERT INTO RetrieveLog (perid, pid, dateviewed)
            VALUES (personID, get_pid, SYSDATE());
        END IF;
    END IF; 
  END IF;  
END;

SELECT * FROM WRITES;


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



-- 1. Author who published "x" book
create or replace PROCEDURE getAuthor (auth IN CHAR)                
AS
AuthorID integer;                                                   
AuthorName Char;                                                    
BEGIN
Select A.perid into AuthorID                                        
  FROM Authors A
  WHERE A.perid = auth;
  IF AuthorID is NULL THEN
    DBMS_OUTPUT.PUT_LINE('Im sorry, the author does not exist');   
  ELSE 
    Select P.name into AuthorName
    FROM Persons P
    WHERE P.perid = AuthorID;                                       
    
    DBMS_OUTPUT.PUT_LINE('The authors name is: '|| AuthorName);
  END IF;
END;                                                        

-- 2. List the 10 latest