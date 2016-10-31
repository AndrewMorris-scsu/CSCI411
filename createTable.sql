CREATE TABLE Persons(
perid integer,
name CHAR(20),
PRIMARY KEY(perid)
);

CREATE TABLE Authors(
perid integer,
city CHAR(30),
state CHAR(5),
streetAddress CHAR(30),
PRIMARY KEY(perid),
FOREIGN KEY(perid) REFERENCES Persons
);

CREATE TABLE Publications (
pid integer,
Title CHAR(30),
type CHAR(30),
content CHAR(50),
price real,
PRIMARY KEY(pid) );

CREATE TABLE Writes (
perid integer,
pid integer,
PRIMARY KEY(perid,pid), 
FOREIGN KEY(perid) REFERENCES Authors,
FOREIGN KEY(pid) REFERENCES Publications );

CREATE TABLE RetrieveLog (
perid integer,
pid integer,
dateViewed DATE,
PRIMARY KEY(perid,pid,dateViewed),
FOREIGN KEY(perid) REFERENCES Persons,
FOREIGN KEY(pid) REFERENCES Publications );

CREATE TABLE Refers(
pid integer,
rid integer,
PRIMARY KEY(pid,rid),
FOREIGN KEY(pid) REFERENCES Publications );

CREATE TABLE Customer (
perid integer,
PRIMARY KEY(perid),
FOREIGN KEY(perid) REFERENCES Persons
);

CREATE TABLE paysFor(
perid integer,
pid integer,
cost real,
PRIMARY KEY(perid,pid),
FOREIGN KEY(perid) REFERENCES Customer,
FOREIGN KEY(pid) REFERENCES Publications );

CREATE TABLE Rates (
perid integer,
pid integer,
rating integer,
PRIMARY KEY(perid,pid),
FOREIGN KEY(perid) REFERENCES Customer,
FOREIGN KEY(pid) REFERENCES Publications );

--INSERT VALUES__
--Persons
INSERT INTO Persons (perid, name) VALUES (1, 'Andrew');
INSERT INTO Persons (perid, name) VALUES (2, 'Yulduz');
INSERT INTO Persons (perid, name) VALUES (3, 'Aman');
INSERT INTO Persons (perid, name) VALUES (4, 'Erik');
INSERT INTO Persons (perid, name) VALUES (5, 'Dude');
INSERT INTO Persons (perid, name) VALUES (6, 'Mala');
INSERT INTO Persons (perid, name) VALUES (7, 'Jake');
INSERT INTO Persons (perid, name) VALUES (8, 'Kate');
INSERT INTO Persons (perid, name) VALUES (9, 'John');
INSERT INTO Persons (perid, name) VALUES (10, 'Drake');

--Publications
INSERT INTO Publications (pid, Title, type, Content, price) VALUES (1, 'Posuere libero.', 'Transactions', 'Neque, torquent duis.', 10);
INSERT INTO Publications (pid, Title, type, Content, price) VALUES (2, 'Penatibus tempor!', 'Conference Proceedings', 'Quis ipsum habitant.', 20);
INSERT INTO Publications (pid, Title, type, Content, price) VALUES (3, 'Duis dictum.', 'Transactions', 'Mauris praesent lacus!', 30);
INSERT INTO PUBLICATIONS (pid, title, type, content, price) VALUES (4,'The end of poverty','Journal','Solving pressing problems', 35);
INSERT INTO PUBLICATIONS (pid, title, type, content, price) VALUES (5, 'Automobile', 'Magazine', 'Auto staff', 5);
INSERT INTO PUBLICATIONS (pid, title, type, content, price) VALUES (6, 'Dash Diet', 'Article', 'Health issues', 9);
INSERT INTO PUBLICATIONS (pid, title, type, content, price) VALUES (7, 'Nature', 'Journal', 'Science and Technology', 20);
--Customers
INSERT INTO Customer (perid) VALUES (3);
INSERT INTO Customer (perid) VALUES (4);
INSERT INTO Customer (perid) VALUES (5);

--authors
INSERT INTO Authors (perid, city, state, streetAddress) VALUES (1, 'irving', 'tx', '6772 hortense');
INSERT INTO Authors (perid, city, state, streetAddress) VALUES (2, 'madison', 'wi', '1645 cregier');
INSERT INTO AUTHORS (perid,city,state,streetAddress) VALUES (3,'St. Cloud', 'MN', '342 Street A');
INSERT INTO AUTHORS (perid,city,state,streetAddress) VALUES (4, 'Duluth', 'MN','566 1st Avenue');
INSERT INTO AUTHORS (perid, city,state,streetAddress) VALUES (5,'Minneapolis', 'MN', '892 Street M');
INSERT INTO AUTHORS (perid, city, state, streetAddress) VALUES (6, 'St. Paul', 'MN', '555 5th Avenue');
INSERT INTO AUTHORS (perid, city, state, streetAddress) VALUES (7, 'irving', 'tx', '6780 hortense');
INSERT INTO AUTHORS (perid, city, state, streetAddress) VALUES (8, 'Duluth', 'MN', '8978 Street B');
INSERT INTO AUTHORS (perid, city, state, streetAddress) VALUES (9, 'madison', 'wi', '1988 Asher');
INSERT INTO AUTHORS (perid, city, state, streetAddress) VALUES (10, 'Duluth', 'MN', '888 East Jackson');

--paysFor
INSERT INTO PaysFor (perid, pid, cost) VALUES (3, 1, 10);
INSERT INTO PaysFor (perid, pid, cost) VALUES (4, 2, 20);

--Rates
INSERT INTO Rates (perid, pid, rating) VALUES (5, 3, 5);

--RetrieveLog

INSERT INTO RetrieveLog (perid, pid, DateViewed) VALUES (3, 1, TO_DATE('10/27/2016', 'MM/DD/YYYY'));
INSERT INTO RetrieveLog (perid, pid, DateViewed) VALUES (4, 2, TO_DATE('10/01/2016', 'MM/DD/YYYY'));
INSERT INTO Writes (perid, pid) VALUES ( 1, 1);
INSERT INTO Writes (perid, pid) VALUES ( 1, 2);
INSERT INTO Writes (perid, pid) VALUES ( 2, 2);
INSERT INTO Writes (perid, pid) VALUES ( 2, 3);



--DELETE TABLES__

DROP TABLE Rates;
DROP TABLE paysFor;
DROP TABLE Customer;
DROP TABLE Refers;
DROP TABLE RetrieveLog ;
DROP TABLE Writes;
DROP TABLE Publications;
DROP TABLE Authors;
DROP TABLE Persons;
