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

