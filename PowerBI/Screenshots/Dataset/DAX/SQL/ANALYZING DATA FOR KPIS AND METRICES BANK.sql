-- ALL THE TABLES I HAVE 
SELECT * FROM ActiveCustomer
SELECT * FROM Bank_Departure
SELECT * FROM CreditCard
SELECT * FROM CustomerInfo
SELECT * FROM ExitCustomer
SELECT * FROM Gender
SELECT * FROM Geography

-- ACTIVE MEMBERS COUNT - 4416
SELECT * FROM Bank_Departure
SELECT COUNT(B.CUSTOMERID) AS TOTALcUSTOMERS, A.ACTIVECATEGORY,B.IsActiveMember
FROM Bank_Departure B
INNER JOIN ActiveCustomer A
ON B.IsActiveMember = A.ActiveID
WHERE A.ActiveCategory = 'ACTIVE MEMBER'
GROUP BY B.IsActiveMember,A.ActiveCategory

-- total customers
SELECT COUNT(DISTINCT CustomerId) AS TOTALCUSTOMERS FROM Bank_Departure

--INACTIVE MEMBERS COUNT - 5584
SELECT * FROM Bank_Departure
SELECT COUNT(B.CUSTOMERID) AS TOTALcUSTOMERS, A.ACTIVECATEGORY,B.IsActiveMember
FROM Bank_Departure B
INNER JOIN ActiveCustomer A
ON B.IsActiveMember = A.ActiveID
WHERE A.ActiveCategory = 'INACTIVE MEMBER'
GROUP BY B.IsActiveMember,A.ActiveCategory

-- credit card holders  - 7055
SELECT * FROM Bank_Departure
SELECT COUNT(B.CUSTOMERID) AS TOTALcUSTOMERS, c.category,B.HasCrCard
FROM Bank_Departure B
INNER JOIN CreditCard c
ON B.HasCrCard = c.CreditID
WHERE c.Category = 'credit card holder'
GROUP By b.HasCrCard,c.category

-- non credit card holders  - 2945
SELECT * FROM Bank_Departure
SELECT COUNT(B.CUSTOMERID) AS TOTALcUSTOMERS, c.category,B.HasCrCard
FROM Bank_Departure B
INNER JOIN CreditCard c
ON B.HasCrCard = c.CreditID
WHERE c.Category = 'non credit card holder'
GROUP By b.HasCrCard,c.category

-- exit customers  -2037
select count(b.customerid) as totalCustomers, b.exited, e.exitcategory
from Bank_Departure b
inner join ExitCustomer e
on b.Exited = e.ExitID
where e.ExitCategory = 'exit'
group by b.exited,e.ExitCategory

-- Retain customers  - 7963
select count(b.customerid) as totalCustomers, b.exited, e.exitcategory
from Bank_Departure b
inner join ExitCustomer e
on b.Exited = e.ExitID
where e.ExitCategory = 'retain'
group by b.exited,e.ExitCategory

-- color combination codes - #008859;green , #f9f3ea cream ,  #fff white, #007aff;blue

--EXIT CUSTOMERS BY GENDER    FEMALE - 1139, MALE - 898

SELECT * FROM Gender
SELECT * FROM Bank_DeparturE

SELECT COUNT(B.CUSTOMERID), G.GENDERCATEGORY
FROM Bank_Departure B
INNER JOIN GENDER G
ON B.GENDERID = G.GENDERID
WHERE B.Exited = 1
GROUP BY G.GenderCategory

-- TOTAL CUSTOMERS BY YEAR AND ACTIVE CATEGORY
SELECT * FROM ActiveCustomer
SELECT * FROM Bank_DeparturE

SELECT COUNT(B.CUSTOMERID),  a.activecategory, DATEPART(YY,EXIT_DATE) AS YEAR
FROM Bank_Departure B
INNER JOIN ActiveCustomer A
ON B.IsActiveMember = A.ActiveID
GROUP BY A.ActiveCategory, DATEPART(YY,EXIT_DATE)

-- EXIT CUSTOMER BY CATEGORY ( CREDITCARD HOLDERS - 1424,  NON CREDIT CARD HOLDERS - 613)

SELECT * FROM Bank_DeparturE
SELECT * FROM CreditCard

SELECT COUNT(B.CUSTOMERID), C.CATEGORY
FROM Bank_Departure B
INNER JOIN CreditCard C
ON B.HasCrCard = C.CreditID
WHERE B.Exited = 1
GROUP BY C.CATEGORY



-- EXIT CUSTOMER BY CREDITSCORE CATEGORY 

SELECT COUNT(CUSTOMERID) AS TOTAL_CUST, CSCATEGORY FROM 
(SELECT *,
CASE 
WHEN CREDITSCORE >= 800 AND CREDITSCORE <= 850 THEN 'EXCELLENT'
WHEN CREDITSCORE >= 740 AND CREDITSCORE <= 799 THEN 'VERY GOOD'
WHEN CREDITSCORE >= 670 AND CREDITSCORE <= 739 THEN 'GOOD'
WHEN CREDITSCORE >= 580 AND CREDITSCORE <= 669 THEN 'FAIR'
WHEN CREDITSCORE >= 300 AND CREDITSCORE <= 579 THEN 'POOR'
END
AS CSCATEGORY
FROM BANK_DEPARTURE
) AS A
WHERE EXITED = 1
GROUP BY CSCATEGORY