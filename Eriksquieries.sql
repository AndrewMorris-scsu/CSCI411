What's the name of the Author who published X Book. Where X is a input Parameter.

1.) CREATE OR REPLACE PROCEDURE findAuthor(X IN CHAR) AS
n char;
BEGIN 
SELECT R.name INTO n
FROM Publications P, Writes W, Authors A, Persons R
WHERE P.Title = X AND P.pid = W.pid AND W.perid = A.perid AND A.perid = R.perid;
DBMS_OUTPUT.PUT_LINE(n);
END;

What Book or Books have the most recent dates they were viewed. Please Print out the name date it 
was viewed and the name of the book
2.) 

What's the name of the user who viewed a Book of type Y. Where Y is an input parameter
3.) CREATE OR REPLACE PROCEDURE findUser(Y IN CHAR) AS
r CHAR;
cursor users is SELECT DISTINCT R.name
FROM Publications P, PaysFor F, Customer C, Persons R
WHERE P.type= Y AND P.pid = F.pid AND F.perid = C.perid AND C.perid = R.perid
BEGIN
open users;
loop fetch users into r;
if(users%NOTFOUND) then exit;
endif;
DBMS_OUTPUT.PUT_LINE('The names of user's who viewed a Book of type are ' ||r);
end loop;
close users;
END;

4. What's the rating of the Book Titles named X. WHERE X is a input parameter.
CREATE OR REPLACE rating(X IN CHAR) AS
r integer;
BEGIN
SELECT R.rating INTO r
FROM Publications P, Rates R
WHERE P.Title = X AND P.pid = R.pid;  
DBMS_OUTPUT.PUT_LINE('The rating of the Book is '||5);
END;

5.What is the Average cost that each Author charges for there books. Please print 
out the Author's Name as well as the Average cost of thier books for each of them.
SELECT DISTINCT S.name, AVG(P.price)
FROM Persons S, Authors A, Writes W, Publications P
WHERE S.perid = A.perid AND  A.perid = W.perid AND W.pid = P.pid
GROUP BY S.name;

6.What's the name of each book that the user X payed to view. Where X is a input parameter. Also Count each
book that the user X viewed not counting Dupplicates.


7. For each Author find the Average rating give for each of their books. Print the Authors Name and the Average rating
SELECT DISTINCT S.name, AVG(R.rating)
FROM Persons S, Authors A, Writes W, Publications P, Rates R
WHERE S.perid = A.perid AND A.perid = W.perid AND W.pid = P.pid AND P.pid = R.pid
GROUP BY S.name;

8. For Book X find the dates for which the book was viewed. where X is a input parameter
CREATE OR REPLACE PROCEDURE views(X IN CHAR) AS
d CHAR;
cusors views is SELECT DISTINCT L.dateViewed
FROM Publications P, RetrieveLog L
WHERE P.Title = X AND P.pid = L.pid
BEGIN
open views;
loop fetch views into d;
if(views%NOTFOUND) then exit;
endif;
DBMS_OUTPUT.PUT_LINE('The dates the Book was viewed are ' ||d);
end loop;
close users;
END;

9. For Book X find the User's Names who have viewed it. Print out the name of the user as well as the Name of the Book. Where X is an input 
parameter.
CREATE OR REPLACE PROCEDURE usersView(X in CHAR) AS
v CHAR;
BEGIN
SELECT DISTINCT S.name INTO v
FROM Customer C, Publications P, RetrieveLog L, Persons S, paysFor F
WHERE P.Title = X AND P.pid = L.pid AND L.perid = S.perid AND S.perid = C.perid AND C.perid = S.perid
GROUP BY S.name
DBMS_OUTPUT_LINE('The user's who have viewed the Book are '||v);
END;
10. Difficult Query
For Each User, Count the number of Book's they have viewed, and separately. Also count the Number of books each each Author has published.
A User and Author must be listed even if the Count is zero for either of them.