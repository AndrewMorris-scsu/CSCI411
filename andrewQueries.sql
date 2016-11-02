create or replace PROCEDURE getBook(personID in INTEGER, get_pid in INTEGER)
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
          AND A.perid = personID
          AND W.pid = get_pid;

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


--Function that returns a T if the book exists, otherwise
--it will return an 'F'
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



-- 1. Name of the author
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

-- 2. List Name of Person and Title of Book for the latest n retrieved records
create or replace PROCEDURE GetLatestRetrievals(numberOfEntries IN INTEGER)
  AS
  personName CHAR(30);
  pubTitle CHAR(30);
  numOfRows INTEGER;
  CURSOR LogEntries
        IS
        Select *
        FROM (
          Select * FROM RetrieveLog
          ORDER BY dateviewed DESC) temp1
        WHERE ROWNUM <= numberOfEntries;
  BEGIN
    Select COUNT(*) INTO numOfRows
    FROM RetrieveLog temp1
    WHERE ROWNUM <= numberOfEntries;

    DBMS_OUTPUT.PUT_LINE('Requested the latest ' || numberOfEntries || ' Retrievals From logs.');
    DBMS_OUTPUT.PUT_LINE(numOfRows || ' rows exist: ');
    DBMS_OUTPUT.PUT_LINE('NAME           TITLE           DATE');

    FOR TempEntry
    IN LogEntries
    LOOP
      Select p.name INTO personName
      FROM Persons p
      WHERE TempEntry.perid = p.perid;

      Select P.title INTO pubTitle
      FROM Publications P
      WHERE TempEntry.pid = P.pid;

      DBMS_OUTPUT.PUT_LINE(personName || ' ' ||
                            pubTitle || ' ' ||
                            TempEntry.dateviewed);
    END LOOP;
END;

-- LIST REFERENCE TRACE FOR A PUBLICATION ---
create or replace procedure findCircle (
      p_start_with IN integer,
      childsParent IN integer,
      grandpa IN number,
      returnVal IN number)
    as
    newReturnVal NUMBER;
    begin

    if p_start_with IS NULL THEN
      DBMS_OUTPUT.PUT_LINE(childsParent);
      RETURN;
    elsif returnVal < 0 THEN
      DBMS_OUTPUT.PUT_LINE('WARNING: YOU HAVE A CIRCULAR REFERENCE');
      DBMS_OUTPUT.PUT_LINE(childsParent || ' references ' || grandpa);
      DBMS_OUTPUT.PUT_LINE('--------------------------------------');
      RETURN;
    END IF;

    if (p_start_with != grandpa) then
      DBMS_OUTPUT.PUT_LINE(childsParent || ' references ' || p_start_with);
    End if;
    for c in ( select * from Refers R
                where p_start_with = R.pid )
    loop
    if c.rid = grandpa THEN
      newReturnVal := -1;
      findCircle( c.rid, p_start_with ,grandpa , newReturnVal);
      EXIT;
    ELSE
      --DBMS_OUTPUT.PUT_LINE('CHILD :'|| c.pid);
      newReturnVal := 0;
      findCircle( c.rid, p_start_with, grandpa , newReturnVal);
    END IF;
    end loop;

  end findCircle;
