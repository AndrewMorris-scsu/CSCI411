-- 1. Author who published "x" book
CREATE OR REPLACE PROCEDURE getAuthor (auth IN CHAR)
AuthorID integer;
AuthorName Char;
AS
BEGIN
Select A.perid into AuthorID
  FROM Authors A
  WHERE A.perid = auth;
  IF AuthorID is NULL THEN
    DBMS_OUTPUT.PUT_LINE("I'm sorry, the author does not exist");
  ELSE
    Select P.name into AuthorName
    WHERE P.perid = AuthorID;

    DBMS_OUTPUT.PUT_LINE('The authors name is: '|| AuthorName);
END;

-- 2. Find the users who retrieved a given type of publication.
create or replace PROCEDURE findUsers(PublicationType IN CHAR) AS
s CHAR(30);
cursor find is SELECT DISTINCT S.name
                FROM Publications P, RetrieveLog R, Persons S
                WHERE P.type = PublicationType AND P.pid = R.pid AND R.perid = S.perid;
BEGIN
  DBMS_OUTPUT.PUT_LINE('The names of users who viewed '|| PublicationType ||' are :');
open find;
  loop fetch find INTO s;
    if(find%NOTFOUND) then
      exit;
    end if;
    DBMS_OUTPUT.PUT_LINE(s);
  end loop;
close find;
END;

-- 3. Retrieves a book for a given user and pid. After determining of the user can
--    retrieve the book, the transaction is logged in RetrieveLog.
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

-- 4. List Name of Person and Title of Book for the latest 'N' retrieved records
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

-- 5. LIST REFERENCE TRACE FOR A PUBLICATION ---
--TODO: Clean up output.
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

  --#6 List the perid of the Author who has max number of publications
--NOT WORKING
--TODO: Add a temp table and load to get max number of publications.
  Select A.perid, P.name, count(*) AS "Number of Publications"
    from Authors A, Persons P, Writes Wr
  Where
    A.perid = P.perid and
    A.perid = Wr.perid
    Group by A.PERID, P.name  Order by "Number of Publications" desc fetch first 1 ROWS only;

-- 7. List the names of Authors who live in the same city

SELECT P.name, A.city
FROM Persons P, Authors A, Authors B
WHERE P.perid = A.perid AND A.city = B.city AND A.perid<>B.perid
GROUP BY (A.city, P.name);

-- 8. List the most expensive publications

SELECT Per.name, P.title, P.price
FROM Persons Per, Publications P, Authors A, Writes W
WHERE A.perid=Per.perid AND W.perid=A.perid AND W.pid = P.pid AND
      P.price = (SELECT MAX (P2.price) FROM Publications P2)
GROUP BY (P.price,P.title,Per.name);

-- 9. List name, id & cost of publications that are of type journals and magazines
-- Perhaps a little trivial.
SELECT P.pid,P.title,P.type
FROM Publications P
Where P.type ='Journal' OR P.TYPE='Magazine'
ORDER BY P.type;

--10. Inserts an entry in "PaysFor" for the given pid and perid if it passes a series of checks.
--Also, if the user is not in customers, as soon as they buy a Pulication for the first time, they
--become a customer.

create or replace PROCEDURE pay (buyerPerid in INTEGER, buy_pid in INTEGER)
AS
bookwriter integer;
checkp integer;
amount real;
isCustomer integer;
BEGIN
  --Check that the book and the person exists
  if (bookExists(buy_pid)) = 'T' and (personExists(BuyerPerid)) = 'T' THEN


    -- Check to make sure the person is not the author of this
    --particular article.
    Select MAX(A.perid) INTO bookwriter
    FROM Writes W, Publications P, Persons Per, Authors A
    WHERE Per.perid = A.perid AND A.perid = W.perid AND W.pid = P.pid
          AND P.pid = buy_pid AND buyerPerid = P.perid;

    if bookwriter IS NOT NULL THEN
      DBMS_OUTPUT.PUT_LINE('The author of the book does not need to pay!');
    else

      --Check that the person has not already bought the publication
      Select MAX(C.perid) INTO checkp
      FROM Persons P, Customer C, PaysFor PF
      WHERE buyerPerid = P.perid AND P.perid = C.perid and C.perid = PF.perid AND PF.pid = buy_pid;

      if checkp IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('This user has previously bought this publication!');
      else
        -- insert into customers if they have not yet bought a publication
        Select MAX(Cust.perid) INTO isCustomer
        FROM Customer Cust
        WHERE Cust.perid = buyerPerid;

        if isCustomer IS NULL THEN
          DBMS_OUTPUT.PUT_LINE('First time buyer, insert record into Customer. ');
          INSERT INTO Customer (perid) VALUES (buyerPerid);
        END IF;

        Select MAX(P.price) INTO amount
        FROM Publications P
        WHERE P.pid = buy_pid;

        INSERT INTO paysFor (perid, pid, cost) VALUES (buyerPerid, buy_pid, amount);
        DBMS_OUTPUT.PUT_LINE('Value was inserted successfully.');
      END IF;
    END IF;
  END IF;
END;

-- 11. What is the Average cost that each Author charges for there books. Please print
--out the Author's Name as well as the Average cost of thier books for each of them.

SELECT DISTINCT S.name, AVG(P.price)
FROM Persons S, Authors A, Writes W, Publications P
WHERE S.perid = A.perid AND  A.perid = W.perid AND W.pid = P.pid
GROUP BY S.name;

-- 12. Whats the name of each book that the user X payed to view. Where X is a input parameter.

create or replace PROCEDURE bookName(X IN CHAR) AS
n CHAR(30);
cursor books is SELECT DISTINCT P.Title
FROM Persons S, Customer C, paysFor F, Publications P
WHERE S.name = X AND S.perid = C.perid AND C.perid = F.perid AND F.pid = P.pid;
BEGIN
  DBMS_OUTPUT.PUT_LINE('the Publications the user saw was/were named:');
  open books;
  loop
  fetch books INTO n;
    if(books%NOTFOUND) then
      exit;
    end if;
  DBMS_OUTPUT.PUT_LINE(n);
end loop;
close books;
END;

-- 13. For each Author find the Average rating give for each of their books. Print the Authors Name and the Average rating
--TODO: Can have 2 DISTINCT authors with the same name.
SELECT DISTINCT S.name, AVG(R.rating)
FROM Persons S, Authors A, Writes W, Publications P, Rates R
WHERE S.perid = A.perid AND A.perid = W.perid AND W.pid = P.pid AND P.pid = R.pid
GROUP BY S.name;

-- 14. For Book X find each date for which the book was viewed. where X is a input parameter
CREATE OR REPLACE PROCEDURE datesviewed(X IN CHAR) AS
d CHAR(30);
cursor viewed is SELECT DISTINCT L.dateViewed
FROM Publications P, RetrieveLog L
WHERE P.Title = X AND P.pid = L.pid;
BEGIN
DBMS_OUTPUT.PUT_LINE('The dates the Book was viewed are :');
open viewed;
  loop fetch viewed into d;
    if(viewed%NOTFOUND) then
      exit;
    end if;
    DBMS_OUTPUT.PUT_LINE(d);
  end loop;
close viewed;
END;

-- 15. Perform checks, and then insert into the write table.
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

-- 16. Insert a rating for a book, the rater must have bought the work, or be an author
--And did not write it.
create or replace PROCEDURE Rates_1 (PERSONID IN INTEGER, pub_id in INTEGER, pub_rating in INTEGER) AS

BEGIN


  IF personExists(PERSONID) = 'F' then
    DBMS_OUTPUT.PUT_LINE('The person does not exist.');
  ELSIF bookExists(pub_id) = 'F' then
    DBMS_OUTPUT.PUT_LINE('The Publication does not exist.');
  ELSIF pub_rating < 1 OR pub_rating > 5 then
    DBMS_OUTPUT.PUT_LINE('Rating can be from 1 to 5');
  ElsIF isAuthor(personID,pub_id) = 'T' then
    DBMS_OUTPUT.PUT_LINE('The author of the book cannot rate book');
  ELSE
    INSERT INTO Rates (PERID, PID, RATING) VALUES (PERSONID, pub_id, pub_rating);
    DBMS_OUTPUT.PUT_LINE('Value inserted successfully');
  END IF;
  COMMIT;
END;

-- 17. List the authors that live in the city which contains the highest rated authors
Select P.name
FROM (Select A.city, AVG(R.rating) AvgRating
      FROM Rates R, Publications P, Writes W, Authors A
      WHERE A.perid = W.perid AND W.pid = P.pid AND P.pid = R.pid
      GROUP BY A.city ) Temp1,
      Authors A, Persons P
WHERE A.city = Temp1.city AND P.perid = A.perid
      AND Temp1.AvgRating = (  Select MAX(temp2.AvgRating)
                               FROM (Select A.city, AVG(R.rating) AvgRating
                                      FROM Rates R, Publications P, Writes W, Authors A
                                      WHERE A.perid = W.perid AND W.pid = P.pid AND P.pid = R.pid
                                      GROUP BY A.city) temp2);

-- 18. List All of the authors that live in the same city as another author.
SELECT P.name, A.city
FROM Persons P, Authors A, Authors B
WHERE P.perid = A.perid AND A.city = B.city AND A.perid<>B.perid
GROUP BY (A.city, P.name);


-- 3. List the counts of views by document type from all Persons. If they have a count of zero for views, show a zero.
-- 4. What is the average cost for an author's work.
-- 5. Name of books that that x has read along with the amount of times they have retrieved the work.
-- 6. Show each person who has bought a book or published an article. Show the count of how many books a person has written, and also show the number of books that a customer has bought. If there is no amount, show a zero.
--7. Show all users that have read the book with the highest average rating.

--#4 List the most popular book by ascending order
--#5 List the name & id of Author and Customer who are from the same state
--#7 List the name, id & date viewed of publications that are rated more than 3 and
--were retrieved between 03/01/2010 and 09/01/2016
--#8 List the names of the authors and publications where the author wrote more than
--2 types of publications and the cost was between $5 and $20
