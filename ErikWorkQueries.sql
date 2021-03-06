-- Find the author for a book
--WILL NOT WORK - > There can be multiple authors for one book.
CREATE OR REPLACE PROCEDURE findAuthor(X IN CHAR) AS
n CHAR(30);
BEGIN
SELECT R.name INTO n
FROM Publications P, Writes W, Authors A, Persons R
WHERE P.Title = X AND P.pid = W.pid AND W.perid = A.perid AND A.perid = R.perid;
DBMS_OUTPUT.PUT_LINE('The Author of the Book of this book is '||n);
END;

EXEC findAuthor('Posuere libero.');


--3.Print out the names of each user who have viewed a Book of type Y. where Y is a input parameter.
--FIXED and
CREATE OR REPLACE PROCEDURE findUsers(Y IN CHAR) AS
s CHAR(30);
cursor find is SELECT DISTINCT S.name
FROM Publications P, PaysFor F, Customer C, Persons S
WHERE P.type = Y AND P.pid = F.pid AND F.perid = C.perid AND C.perid = S.perid;
BEGIN
open find;
loop fetch find INTO s;
if(find%NOTFOUND) then exit;
end if;
DBMS_OUTPUT.PUT_LINE('The names of users who viewed a Book of type are '||s);
end loop;
close find;
END;

Test;
	The names of users who viewed a Book of type are Aman


 CREATE OR REPLACE PROCEDURE findUsers(Y IN CHAR) AS
s CHAR(30);
cursor find is SELECT DISTINCT S.name
FROM Publications P, PaysFor F, Customer C, Persons S
WHERE P.type = Y AND P.pid = F.pid AND F.perid = C.perid AND C.perid = S.perid;
BEGIN
open find;
loop fetch find INTO s;
if(find%NOTFOUND) then exit;
end if;
DBMS_OUTPUT.PUT_LINE('The names of users who viewed a Book of type are '||s);
end loop;
close find;
END;

Test;
4. CREATE OR REPLACE PROCEDURE rating(X IN CHAR) AS
n integer;
BEGIN
SELECT R.rating INTO n
FROM Publications P, Rates R
WHERE P.Title = X AND P.pid = R.pid;
DBMS_OUTPUT.PUT_LINE('The rating of the Book is '||n);
END;

EXEC rating('Duis dictum.');

Test:
	The rating of the Book is 5

--5.What is the Average cost that each Author charges for there books. Please print
--out the Authors Name as well as the Average cost of thier books for each of them.

SELECT DISTINCT S.name, AVG(P.price)
FROM Persons S, Authors A, Writes W, Publications P
WHERE S.perid = A.perid AND  A.perid = W.perid AND W.pid = P.pid
GROUP BY S.name;


--6.Whats the name of each book that the user X payed to view. Where X is a input parameter.

CREATE OR REPLACE PROCEDURE bookName(X IN CHAR) AS
n CHAR(30);
cursor books is SELECT DISTINCT P.Title
FROM Persons S, Customer C, paysFor F, Publications P
WHERE S.name = X AND S.perid = C.perid AND C.perid = F.perid AND F.pid = P.pid;
BEGIN
open books;
loop
fetch books INTO n;
if(books%NOTFOUND) then exit;
end if;
DBMS_OUTPUT.PUT_LINE('The user saw were named '||n);
end loop;
close books;
END;

Test;  the Books the user saw were named Penatibus tempor!


7. For each Author find the Average rating give for each of their books. Print the Authors Name and the Average rating
SELECT DISTINCT S.name, AVG(R.rating)
FROM Persons S, Authors A, Writes W, Publications P, Rates R
WHERE S.perid = A.perid AND A.perid = W.perid AND W.pid = P.pid AND P.pid = R.pid
GROUP BY S.name;

Test;
	Name			AVG(R.RATING)
-------------------------------------------------
	Yulduz              	5

8. For Book X find each date for which the book was viewed. where X is a input parameter
CREATE OR REPLACE PROCEDURE datesviewed(X IN CHAR) AS
d CHAR(30);
cursor viewed is SELECT DISTINCT L.dateViewed
FROM Publications P, RetrieveLog L
WHERE P.Title = X AND P.pid = L.pid;
BEGIN
open viewed;
loop fetch viewed into d;
if(viewed%NOTFOUND) then exit;
end if;
DBMS_OUTPUT.PUT_LINE('The dates the Book was viewed are: ' ||d);
end loop;
close viewed;
END;

Test;
	The dates the Book was viewed are: 27-OCT-16


9. For Book X find the Names of each user who has viewed it. Print out the name of the user as well as the Name of the Book. Where X is an input
parameter.
CREATE OR REPLACE PROCEDURE usersView(X in CHAR) AS
v CHAR(30);
cursor us is SELECT DISTINCT S.name INTO v
FROM Customer C, Publications P, RetrieveLog L, Persons S, paysFor F
WHERE P.Title = X AND P.pid = L.pid AND L.perid = S.perid AND S.perid = C.perid AND C.perid = S.perid
GROUP BY S.name;
BEGIN
open us;
loop fetch us into v;
if(us%NOTFOUND) then exit;
end if;
DBMS_OUTPUT.PUT_LINE('Names of user who have viewed the Book are: '||v);
end loop;
close us;
END;

Test;
	Names of user who have viewed the Book are: Erik

2 things in Progress:

10. Difficult Query
For Each User, Count the number of Book's they have viewed, and separately. Also count the Number of books each each Author has published.
A User and Author must be listed even if the Count is zero for either of them.
