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

-- 2. List the 10 latest retrieved books 



-- 3. List the counts of views by document type from all Persons. If they have a count of zero for views, show a zero. 
-- 4. What is the average cost for an author's work. 
-- 5. Name of books that that x has read along with the amount of times they have retrieved the work. 
-- 6. Show each person who has bought a book or published an article. Show the count of how many books a person has written, and also show the number of books that a customer has bought. If there is no amount, show a zero. 
--7. Show all users that have read the book with the highest average rating. 
--8. Print out the names of all of the Customers that have viewed book X.

#1
List the perid of the Author who has max number of publications

Select A.perid, P.name, count(*) AS "Number of Publications"
  from Authors A, Persons P, Writes Wr
Where 
  A.perid = P.perid and
  A.perid = Wr.perid
  Group by A.PERID, P.name  Order by "Number of Publications" desc fetch first 1 ROWS only;
  
#2
List the names of Authors who live in the same city

SELECT P.name, A.city
FROM Persons P, Authors A, Authors B
WHERE P.perid = A.perid AND A.city = B.city AND A.perid<>B.perid
GROUP BY (A.city, P.name);

#3
List the most expensive publications

SELECT Per.name, P.title, P.price
FROM Persons Per, Publications P, Authors A, Writes W
WHERE A.perid=Per.perid AND W.perid=A.perid AND W.pid = P.pid AND
      P.price = (SELECT MAX (P2.price) FROM Publications P2)
GROUP BY (P.price,P.title,Per.name);

#4
List the most popular book by ascending order
#5
List the name & id of Author and Customer who are from the same state
#6
List name, id & cost of publications that are of type journals and magazines

SELECT P.pid,P.title,P.type
FROM Publications P
Where P.type ='Journal' OR P.TYPE='Magazine'
ORDER BY P.type;

#7
List the name, id & date viewed of publications that are rated more than 3 and 
were retrieved between 03/01/2010 and 09/01/2016
#8
List the names of the authors and publications where the author wrote more than 
2 types of publications and the cost was between $5 and $20