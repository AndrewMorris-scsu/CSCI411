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
dateViewed CHAR(10),
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

INSERT INTO Persons (perid) VALUES (1);
INSERT INTO Persons (perid) VALUES (2);
INSERT INTO Persons (perid) VALUES (3);
INSERT INTO Persons (perid) VALUES (4);
INSERT INTO Persons (perid) VALUES (5);
INSERT INTO Publications (pid, Title, type, Content, price) VALUES (1, 'Posuere libero.', 'Transactions', 'Neque, torquent duis.', 724002.91);
INSERT INTO Publications (pid, Title, type, Content, price) VALUES (2, 'Penatibus tempor!', 'Conference Proceedings', 'Quis ipsum habitant.', 594202.30);
INSERT INTO Publications (pid, Title, type, Content, price) VALUES (3, 'Duis dictum.', 'Transactions', 'Mauris praesent lacus!', 614066.00);
INSERT INTO Customer (perid) VALUES (3);
INSERT INTO Customer (perid) VALUES (4);
INSERT INTO Customer (perid) VALUES (5);
INSERT INTO Authors (perid, city, state, streetAddress) VALUES (1, 'irving', 'tx', '6772 hortense');
INSERT INTO Authors (perid, city, state, streetAddress) VALUES (2, 'madison', 'wi', '1645 cregier');



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

