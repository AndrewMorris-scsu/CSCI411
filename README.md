# CSCI411
This is a repository for my CSCI 411 group at St. Cloud State University
# test inserts

INSERT INTO Persons ('perid') VALUES (1);
INSERT INTO Persons ('perid') VALUES (2);
INSERT INTO Persons ('perid') VALUES (3);
INSERT INTO Persons ('perid') VALUES (4);
INSERT INTO Persons ('perid') VALUES (5);
INSERT INTO Publications ('pid', 'Title', 'type', 'Content', 'cost') VALUES (1, 'Massa arcu.', 'Journals', 'Lorem ipsum nisl lorem sagittis lobortis varius scelerisque curabitur donec quam sociis sollicitudin morbi.\nPretium nunc libero odio dictum vitae posuere cras odio libero aptent.\n', 21401.83);
INSERT INTO Publications ('pid', 'Title', 'type', 'Content', 'cost') VALUES (2, 'Ante interdum.', 'Journals', 'Lorem ipsum parturient nullam congue felis consequat mauris libero vehicula varius vivamus.\nJusto sapien lacinia magna lectus habitant semper metus?\n', 778156.81);
INSERT INTO Publications ('pid', 'Title', 'type', 'Content', 'cost') VALUES (3, 'Mus amet.', 'Journals', 'Lorem ipsum est proin quisque ullamcorper sociosqu turpis massa sagittis!\nLacinia mus conubia ultricies fringilla sociis conubia torquent porttitor ultrices semper.\n', 118200.49);
INSERT INTO Customer ('perid') VALUES (3);
INSERT INTO Customer ('perid') VALUES (4);
INSERT INTO Customer ('perid') VALUES (5);
INSERT INTO Authors ('perid', 'city', 'state', 'st') VALUES (1, 'naperville', 'il', '4449 wilmot');
INSERT INTO Authors ('perid', 'city', 'state', 'st') VALUES (2, 'washington', 'dc', '3486 mcvicker');
INSERT INTO Rates ('PerID', 'pid', 'Rating') VALUES (5, 8, 2);
INSERT INTO Rates ('PerID', 'pid', 'Rating') VALUES (6, 7, 3);
INSERT INTO Rates ('PerID', 'pid', 'Rating') VALUES (1, 9, 4);
INSERT INTO Rates ('PerID', 'pid', 'Rating') VALUES (7, 7, 5);
INSERT INTO Rates ('PerID', 'pid', 'Rating') VALUES (7, 5, 2);
INSERT INTO PaysFor ('perid', 'cost', 'pid') VALUES (5, 538.30, 7);
INSERT INTO PaysFor ('perid', 'cost', 'pid') VALUES (9, 963.14, 8);
INSERT INTO PaysFor ('perid', 'cost', 'pid') VALUES (3, 97.81, 4);
INSERT INTO PaysFor ('perid', 'cost', 'pid') VALUES (4, 543.61, 10);
INSERT INTO PaysFor ('perid', 'cost', 'pid') VALUES (8, 76.42, 4);
INSERT INTO PaysFor ('perid', 'cost', 'pid') VALUES (2, 661.54, 9);
INSERT INTO PaysFor ('perid', 'cost', 'pid') VALUES (8, 10.06, 6);
INSERT INTO PaysFor ('perid', 'cost', 'pid') VALUES (5, 220.98, 8);
INSERT INTO PaysFor ('perid', 'cost', 'pid') VALUES (3, 175.86, 3);
INSERT INTO PaysFor ('perid', 'cost', 'pid') VALUES (7, 773.11, 2);
INSERT INTO Writes ('pid', 'perid') VALUES (10, 6);
INSERT INTO Writes ('pid', 'perid') VALUES (3, 7);
INSERT INTO Writes ('pid', 'perid') VALUES (4, 4);
INSERT INTO Writes ('pid', 'perid') VALUES (2, 7);
INSERT INTO Writes ('pid', 'perid') VALUES (4, 8);
INSERT INTO Writes ('pid', 'perid') VALUES (8, 5);
INSERT INTO Writes ('pid', 'perid') VALUES (8, 2);
INSERT INTO Writes ('pid', 'perid') VALUES (1, 4);
INSERT INTO Writes ('pid', 'perid') VALUES (2, 2);
INSERT INTO Writes ('pid', 'perid') VALUES (3, 1);
INSERT INTO RetrieveLog ('perid', 'pid', 'DateViewed') VALUES (10, 3, to_date('1983-11-15', 'YYYY-MM-DD'));
INSERT INTO RetrieveLog ('perid', 'pid', 'DateViewed') VALUES (7, 4, to_date('1951-10-30', 'YYYY-MM-DD'));
INSERT INTO RetrieveLog ('perid', 'pid', 'DateViewed') VALUES (4, 8, to_date('1957-11-01', 'YYYY-MM-DD'));
INSERT INTO RetrieveLog ('perid', 'pid', 'DateViewed') VALUES (6, 6, to_date('1905-07-01', 'YYYY-MM-DD'));
INSERT INTO RetrieveLog ('perid', 'pid', 'DateViewed') VALUES (10, 7, to_date('1953-01-24', 'YYYY-MM-DD'));
INSERT INTO RetrieveLog ('perid', 'pid', 'DateViewed') VALUES (2, 8, to_date('1978-01-11', 'YYYY-MM-DD'));
INSERT INTO RetrieveLog ('perid', 'pid', 'DateViewed') VALUES (9, 8, to_date('1990-10-06', 'YYYY-MM-DD'));
INSERT INTO RetrieveLog ('perid', 'pid', 'DateViewed') VALUES (2, 8, to_date('1961-12-27', 'YYYY-MM-DD'));
INSERT INTO RetrieveLog ('perid', 'pid', 'DateViewed') VALUES (10, 7, to_date('1972-11-17', 'YYYY-MM-DD'));
INSERT INTO RetrieveLog ('perid', 'pid', 'DateViewed') VALUES (5, 2, to_date('1977-09-12', 'YYYY-MM-DD'));
