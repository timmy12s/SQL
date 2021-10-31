CREATE DATABASE gerobak_oden
GO
USE gerobak_oden

GO

DROP TABLE TrHeaderTransaction
DROP TABLE TrDetailTransaction
DROP TABLE MsOden
DROP TABLE MsCustomer
DROP TABLE MsStaff
CREATE TABLE MsOden(
	OdenId CHAR(5) CHECK(OdenId LIKE 'OD[0-9][0-9][0-9]') PRIMARY KEY NOT NULL,
	OdenName VARCHAR(50) NOT NULL,
	OdenTopping VARCHAR(50) NOT NULL,
	OdenSauce VARCHAR(30) NOT NULL,
	OdenPrice INT NOT NULL
)

CREATE TABLE MsCustomer(
	CustomerId CHAR(5) CHECK(CustomerId LIKE 'CU[0-9][0-9][0-9]') PRIMARY KEY NOT NULL,
	Customername VARCHAR(50)NOT NULL,
	CustomerGender VARCHAR(10) NOT NULL,
	CustomerDOB DATE NOT NULL,
	CustomerPhone VARCHAR(15) NOT NULL
)

CREATE TABLE MsStaff(
	StaffId CHAR(5) CHECK(StaffId LIKE 'ST[0-9][0-9][0-9]') PRIMARY KEY NOT NULL,
	StaffName VARCHAR(50)NOT NULL,
	StaffGender VARCHAR(10) NOT NULL,
	StaffDOB DATE NOT NULL,
	StaffPhone VARCHAR(15) NOT NULL
)

CREATE TABLE TrHeaderTransaction(
	TransactionId CHAR(5) CHECK(TransactionId LIKE 'TR[0-9][0-9][0-9]') NOT NULL PRIMARY KEY,
	[Date] DATE NOT NULL,
	CustomerId CHAR(5) NOT NULL ,
	StaffId CHAR(5) NOT NULL
	CONSTRAINT CustomerId FOREIGN KEY (CustomerId) REFERENCES MsCustomer(CustomerId) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT StaffId FOREIGN KEY (StaffId) REFERENCES MsStaff(StaffId) ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE TrDetailTransaction(
	TransactionId CHAR(5) NOT NULL,
	OdenId CHAR(5) CHECK(OdenId LIKE 'OD[0-9][0-9][0-9]') NOT NULL,
	Quantity INT NOT NULL
	CONSTRAINT TransactionId FOREIGN KEY (TransactionId) REFERENCES TrHeaderTransaction(TransactionId) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT OdenId FOREIGN KEY (OdenId) REFERENCES MsOden(OdenId) ON DELETE CASCADE ON UPDATE CASCADE
)

GO
INSERT INTO MsCustomer VALUES('CU001', 'James Hogwart', 'Male', '09/07/2000', '0856959120000')
INSERT INTO MsCustomer VALUES('CU002', 'John Wik', 'Male', '06/06/1998', '0856959056000')
INSERT INTO MsCustomer VALUES('CU003', 'Anna Kimberly', 'female', '12/07/2001', '0856959350000')
INSERT INTO MsCustomer VALUES('CU004', 'Jane Mary', 'female', '01/11/1995', '0856959002200')
INSERT INTO MsCustomer VALUES('CU005', 'Tommy Back', 'Male', '12/12/2000', '0856959007700')
GO
GO
INSERT INTO MsStaff VALUES('ST001', 'Bone wart', 'Male', '03/07/2000', '0856959044000')
INSERT INTO MsStaff VALUES('ST002', 'Banner Kiw', 'Male', '01/07/1998', '08569590000120')
INSERT INTO MsStaff VALUES('ST003', 'Iana Kimberly', 'female', '03/07/2001', '08569590100000')
INSERT INTO MsStaff VALUES('ST004', 'Ash Lee', 'female', '01/11/2000', '0856959001100')
INSERT INTO MsStaff VALUES('ST005', 'Toms Spel', 'Male', '12/12/2000', '0856959000012')
GO
INSERT INTO MsOden VALUES('OD001', 'Daikon', 'Nori', 'Teriyaki Sauce', 2000)
INSERT INTO MsOden VALUES('OD002', 'Sumire', 'Nori', 'Dengaku Miso', 2000)
INSERT INTO MsOden VALUES('OD003', 'Chikuwa', 'Katsuoboshi', 'Daikon Sauce', 2500)
INSERT INTO MsOden VALUES('OD004', 'Aburaage Tofu', 'Chili Flakes', 'Ponzu Sauce', 3000)
INSERT INTO MsOden VALUES('OD005', 'Konnyaku', 'Katsuoboshi', 'Teriyaki Sauce', 1500)

GO
INSERT INTO TrHeaderTransaction VALUES('TR001', '11/12/2019', 'CU002', 'ST001')
INSERT INTO TrHeaderTransaction VALUES('TR002', '09/10/2019', 'CU001', 'ST002')
INSERT INTO TrHeaderTransaction VALUES('TR003', '08/08/2019', 'CU002', 'ST005')
INSERT INTO TrHeaderTransaction VALUES('TR004', '12/01/2019', 'CU005', 'ST004')
INSERT INTO TrHeaderTransaction VALUES('TR005', '07/03/2019', 'CU003', 'ST001')
INSERT INTO TrHeaderTransaction VALUES('TR006', '12/12/2019', 'CU002', 'ST003')
INSERT INTO TrHeaderTransaction VALUES('TR007', '01/11/2019', 'CU003', 'ST002')
INSERT INTO TrHeaderTransaction VALUES('TR008', '01/01/2019', 'CU002', 'ST002')
INSERT INTO TrHeaderTransaction VALUES('TR009', '12/01/2019', 'CU002', 'ST004')
INSERT INTO TrHeaderTransaction VALUES('TR010', '07/03/2019', 'CU004', 'ST001')

GO
INSERT INTO TrDetailTransaction VALUES('TR001', 'OD002', '1')
INSERT INTO TrDetailTransaction VALUES('TR002', 'OD001', '2')
INSERT INTO TrDetailTransaction VALUES('TR003', 'OD002', '2')
INSERT INTO TrDetailTransaction VALUES('TR004', 'OD005', '5')
INSERT INTO TrDetailTransaction VALUES('TR005', 'OD003', '3')
INSERT INTO TrDetailTransaction VALUES('TR006', 'OD002', '2')
INSERT INTO TrDetailTransaction VALUES('TR006', 'OD003', '3')
INSERT INTO TrDetailTransaction VALUES('TR007', 'OD002', '2')
INSERT INTO TrDetailTransaction VALUES('TR007', 'OD002', '4')
INSERT INTO TrDetailTransaction VALUES('TR008', 'OD004', '5')
INSERT INTO TrDetailTransaction VALUES('TR009', 'OD002', '2')
INSERT INTO TrDetailTransaction VALUES('TR009', 'OD001', '1')
INSERT INTO TrDetailTransaction VALUES('TR009', 'OD002', '5')
INSERT INTO TrDetailTransaction VALUES('TR010', 'OD005', '5')
INSERT INTO TrDetailTransaction VALUES('TR010', 'OD003', '3')
INSERT INTO TrDetailTransaction VALUES('TR001', 'OD002', '2')
INSERT INTO TrDetailTransaction VALUES('TR002', 'OD003', '10')
INSERT INTO TrDetailTransaction VALUES('TR003', 'OD002', '2')
INSERT INTO TrDetailTransaction VALUES('TR003', 'OD002', '2')
INSERT INTO TrDetailTransaction VALUES('TR004', 'OD004', '3')


--1
SELECT 
	StaffName,
	StaffGender,
	StaffPhone
FROM MsStaff S
WHERE MONTH(S.StaffDOB) BETWEEN 3 AND 7

--2
SELECT 
	TransactionId,
	[OdenId] = REPLACE(DT.OdenId,'OD00','ODEN'),
	OdenTopping
FROM TrDetailTransaction DT
JOIN MsOden AS O ON DT.OdenId = O.OdenId
WHERE Quantity > 2

--3
SELECT
	DT.TransactionId,
	[Total Quantity] = SUM(Quantity),
	[Date] = CONVERT(VARCHAR,Date,107)
FROM TrDetailTransaction AS DT
JOIN TrHeaderTransaction AS HT ON DT.TransactionId = HT.TransactionId
WHERE CustomerId LIKE 'CU002'
GROUP BY DT.TransactionId, Date

--4
SELECT
	HT.Date,
	HT.CustomerId,
	[Total Type Oden] = COUNT(O.OdenId),
	[Total Price] = 'Rp.'+ CAST(SUM(OdenPrice) AS VARCHAR)
FROM TrHeaderTransaction AS HT
JOIN MsCustomer AS C ON HT.CustomerId = C.CustomerId
JOIN TrDetailTransaction AS DT ON HT.TransactionId = DT.TransactionId
JOIN MsOden AS O ON DT.OdenId = O.OdenId
WHERE MONTH(HT.Date) = 8
GROUP BY HT.Date, HT.CustomerId

UNION 

SELECT
	HT.Date,
	HT.CustomerId,
	[Total Type Oden] = COUNT(O.OdenId),
	[Total Price] = 'Rp.'+ CAST(SUM(OdenPrice) AS VARCHAR)
FROM TrHeaderTransaction AS HT
JOIN MsCustomer AS C ON HT.CustomerId = C.CustomerId
JOIN TrDetailTransaction AS DT ON HT.TransactionId = DT.TransactionId
JOIN MsOden AS O ON DT.OdenId = O.OdenId
WHERE MONTH(HT.Date) = 9
GROUP BY HT.Date, HT.CustomerId


--5
SELECT 
	[Customername] = Customername,
	[CustomerGender] = CustomerGender,
	[CustomerPhone] = STUFF(CustomerPhone, 1, 1, '+62')
FROM MsCustomer AS C
WHERE DATEDIFF(YEAR,CustomerDOB,'2020-02-02') > 21

--6
SELECT
    [First Name] = SUBSTRING(Customername,1,CHARINDEX(' ',Customername)),
    OdenName,
    OdenTopping
FROM MsCustomer AS C
    JOIN TrHeaderTransaction AS HT ON C.CustomerId = HT.CustomerId
    JOIN  TrDetailTransaction AS DT ON HT.TransactionId = DT.TransactionId
    JOIN MsOden AS O ON DT.OdenId = O.OdenId,
    (SELECT [Value] = AVG(OdenPrice) FROM MsOden) AS AVERAGE
WHERE OdenPrice IN (SELECT OdenPrice FROM MsOden WHERE OdenPrice > AVERAGE.Value)
GROUP BY OdenName,OdenTopping, Customername

--7
GO
CREATE VIEW [ReplaceToppingName] AS
SELECT
    OdenName,
    [OdenTopping] = OdenTopping + ' Flakes',
    OdenSauce
FROM MsOden
WHERE OdenName NOT LIKE '% %'

GO
SELECT * FROM ReplaceToppingName
ORDER BY OdenName

--8
GO
CREATE VIEW [HighestSoldOden] AS
SELECT
    OdenName,
    [Total Price] = 'Rp. ' + CAST(SUM(Quantity)*OdenPrice AS VARCHAR)
FROM MsOden AS O
    JOIN TrDetailTransaction AS DT ON O.OdenId = DT.OdenId
WHERE OdenName IN(SELECT OdenName FROM MsOden WHERE OdenName LIKE 'A%' OR OdenName LIKE 'D%')
GROUP BY OdenName, OdenPrice

--9
GO
ALTER TABLE MsStaff
ADD StaffEmail VARCHAR(200)

ALTER TABLE MsStaff
ADD CONSTRAINT CheckEmail 
CHECK(StaffEmail LIKE '%@%')

SELECT *FROM MsStaff --untuk tes

--10
GO
BEGIN TRAN
    DELETE MsOden
    FROM MsOden AS MO
        JOIN TrDetailTransaction AS DT ON MO.OdenId = DT.OdenId
        WHERE Quantity < 5 AND REVERSE(SUBSTRING(REVERSE(OdenSauce),1,CHARINDEX(' ',REVERSE(OdenSauce)))) LIKE ' Sauce'

ROLLBACK

SELECT *FROM MsOden --untuk tes


