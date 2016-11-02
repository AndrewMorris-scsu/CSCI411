CREATE OR REPLACE PROCEDURE pay (buyerPerid in INTEGER, buy_pid in INTEGER)
AS 
bookwriter integer;
checkp integer;
amount real;
isCustomer integer;
BEGIN
  --Check that the book and the person exists
  if (bookExists(buy_pid)) and (personExists(BuyerPerid)) THEN 
  else
    
    -- Check to make sure the person is not the author of this
    --particular article. 
    Select A.perid INTO bookwriter
    FROM Writes W, Publications P, Person Per, Authors A
    WHERE Per.perid = A.perid AND A.perid = W.perid AND W.pid = P.pid
          AND P.pid = buy_pid;
    
    if bookwriter IS NOT NULL THEN 
      DBMS_OUTPUT.PUT_LINE('The author of the book does not need to pay!');
    else 
      
      --Check that the person has not already bought the publication
      Select C.perid INTO checkp
      FROM Person P, Customer C, PaysFor PF
      WHERE buyerPerid = P.perid AND P.perid = C.perid and C.perid = PF.perid AND PF.pid = buy_pid;
      
      if checkp IS NOT NULL THEN 
        DBMS_OUTPUT.PUT_LINE('This user has previously bought this publication!');
      else
        -- insert into customers if they have not yet bought a publication
        Select C.pid INTO isCustomer
        FROM Customer C
        WHERE C.perid = buyerPerid
        
        if isCustomer IS NULL
          INSERT INTO Customer (perid) VALUES (buyerPerid);
        END IF;
        
        Select P.price INTO amount
        FROM Publications P
        WHERE P.pid = buy_pid;

        INSERT INTO paysFor (perid, pid, cost) VALUES (buyerPerid, buy_pid, amount); 

      END IF;

    END IF; 
    

  END IF; 
END;
