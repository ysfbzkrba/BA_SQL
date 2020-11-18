/*
			BİLGE ADAM BEŞİKTAŞ SQL.queries 5. GÜN
*/
;
;
USE Northwind
;
	--========--	GROUP BY / STORED PROCEDURE / FUNCTION	--========-- 

	--========--	GROUP BY	--========--

SELECT
	*
	FROM Employees
	;

SELECT
	Country,
	COUNT(*) AS [Total Number Of Personnel]
	FROM Employees
		Group by Country
		; -- won't work if group by Column is not specified under select too.


SELECT
	EmployeeID,
	count(*) AS [Total Number of orders by employees]
	FROM Orders
		Group By EmployeeID
		; -- Counts distinct values grouped by employeeids under orders table.

SELECT
	o.EmployeeID,
	E.FirstName+' '+E.LastName,
	count(*) AS [Total Number of orders by employees]
	FROM (Orders O inner join Employees E on O.EmployeeID=E.EmployeeID)
		Group By 	o.EmployeeID, E.FirstName+' '+E.LastName
		; -- Counts distinct values grouped by employeeid, firstname, lastname from joint table of orders + employees

SELECT
	CategoryName,
	P.CategoryID,
		COUNT(*) AS [PRICE LOWER THAN 35.00$]
	FROM (Products P inner join Categories C on P.CategoryID=C.CategoryID)
		WHERE UnitPrice < 35
		GROUP BY 	CategoryName, P.CategoryID
		; -- counts distinct entries priced lower then 35 groupd by CategoryName and CategoryID

;-- EXERCISE --
;-- Number of products in stock quantity between 5 and 50 and names from A to K Grouped under Category.

SELECT 
	c.CategoryID,
	CategoryName,
	COUNT(*) AS [Total Units in Stock Till Alphabetic K]
	FROM (Products P inner join Categories C on P.CategoryID=C.CategoryID)
		where ProductName <= 'K'
			  AND
			  UnitsInStock >= 5
			  AND
			  UnitsInStock <= 50
			GROUP BY 	c.CategoryID, CategoryName 
			; -- ProductName < K

SELECT 
	c.CategoryID,
	CategoryName,
	COUNT(*) AS [Total Units in Stock Till Alphabetic K]
	FROM (Products P inner join Categories C on P.CategoryID=C.CategoryID)
		where ProductName like '[A-K]%'
			  AND
			  UnitsInStock >= 5
			  AND
			  UnitsInStock <= 50
			GROUP BY 	c.CategoryID, CategoryName 
			; -- productname from A to K

SELECT 
	c.CategoryID,
	CategoryName,
	COUNT(*) AS [Total Units in Stock Till Alphabetic K]
	FROM (Products P inner join Categories C on P.CategoryID=C.CategoryID)
		where LEFT (ProductName, 1) BETWEEN 'A' AND 'K'
			  AND
			  UnitsInStock >= 5
			  AND
			  UnitsInStock <= 50
			GROUP BY 	c.CategoryID, CategoryName 
			; -- productName between A-K 

;-- Number of products in stock number between 5 and 50 and names from A to K Grouped under Category.
;-- EXERCISE OUT --


;-- EXERCISE --
;-- Number of products in each order.
SELECT
	OrderID,
	SUM(Quantity) as [Number Of Products]
	FROM [Order Details]
		GROUP BY OrderID
			ORDER BY [Number Of Products]
			;	-- SUM
;-- Number of products in each order.
;-- EXERCISE --

;	--========--	STORED PROCEDURE	--========--

/*
	TSQL komutları ile hazırladığmız işlemler bütününün çalıştırılma anında derlenmesi ile size bir sonuç üreten sql server bileşenidir
	Çalışma anı planlama sağlar ve tekrar tekrar kullanılabilir.
	querylerinize otomatik parametrelendirme getirir
	Uygulamalar arasında ortak kullanılabilir yapıdadır.
	Güvenli Data modifikasyonu sağlar
	Network bandwidth inden tasarruf sağlar
	job olarak tanımlanabilir ve schedule edilebilir
	Database objelerine güvenli erişim sağlar
*/

CREATE PROCEDURE sp_kategoriler AS
	SELECT 
		*
		FROM Categories ;
		; -- Creates procedure (sp_kategoriler) from Categories.
		EXEC sp_kategoriler
			; -- executes sp_kategoriler procedure.

CREATE PROC sp_productsbycategory @id int  AS
	SELECT
		*
		FROM Products
		WHERE CategoryID = @id
		; -- Creates procedure (sp_productsbycategory) with variable @id (datatype=int).
		EXEC sp_productsbycategory 5
		; -- executes sp_productsbycategory with @id = 5

		
CREATE PROC proc_employeesbyname AS
	SELECT 
		*
		FROM Employees
		; -- creates procedure named proc_employeesbyname from employees

ALTER PROC proc_employeesbyname @name nvarchar(50) as
	SELECT
		*
		FROM Employees
		WHERE FirstName like @name+'%' 
		; -- alters proc_employeesbyname to accept @name as nvarchar(50) to select names starting with @name
	EXEC proc_employeesbyname a
		; -- executes proc_employeesbyname // exec is not vital
	drop proc proc_employeesbyname
		; -- drops proc_employeesbyname


;
SELECT * from Customers
select * into Customers2 from Customers 
SELECT * from Customers2

CREATE PROC proc_Addtomusteri AS
	SELECT
	*
	FROM Customers2
	; -- creates proc from customers2 named proc_Addtomusteri

ALTER PROC proc_Addtomusteri
	@Cid	nvarchar(5),
	@ccname nvarchar(40) = 'NULL',
	@cname	nvarchar(30) = 'NULL',
	@ctitle	nvarchar(30) = 'NULL',
	@adres	nvarchar(60) = 'NULL',
	@city	nvarchar(15) = 'NULL',
	@reg	nvarchar(15) = 'NULL',
	@Pcode	nvarchar(10) = 'NULL',
	@Contry	nvarchar(15) = 'NULL',
	@phone	nvarchar(24) = 'NULL',
	@fax	nvarchar(24) = 'NULL'
	 AS

	INSERT INTO Customers2 values 
	(@Cid,
	@ccname,
	@cname,
	@ctitle,
	@adres,
	@city,
	@reg,
	@Pcode,
	@Contry,
	@phone,
	@fax)
	; -- ALTERS proc_Addtomusteri to accept values from procedure.

EXEC proc_Addtomusteri @ccname='Bilge Adam' , @Cid = 'BLGOM'; -- adds Bilge Adam companyName and BLGOM companyID into Customers2 TABLE.

SELECT
	*
	FROM Customers2
	where customerid = 'BLGOM'; -- Selects added BLGOM companyid from Customers2 TABLE.

;/*
Drop proc proc_Addtomusteri -- drops proc from db
DROP TABLE Customers2		-- drops table from db
*/

;
	--========--	FUNCTIONS // USER DEFINED FUNCTIONS	--========--
;

-- SCALER FUNCTIONS -- 

SELECT ProductID, ProductName, UnitPrice as 'KDV DAHİL DEĞİL', UnitPrice*1.18 as 'KDV DAHİL' FROM Products 


CREATE FUNCTION KDVHesapla (@price MONEY)
	returns money
		begin	-- { function starts
				-- Function Body
			return @price*1.18;
		end		-- } function ends
		;	-- creates function to calculate KDV

SELECT ProductID, ProductName, UnitPrice as 'KDV DAHİL DEĞİL', dbo.KDVHesapla(UnitPrice) as 'KDV DAHİL' FROM Products 



CREATE FUNCTION FormatPhone (@PHONE NVARCHAR(24))
	RETURNS NVARCHAR(24)
		BEGIN

		DECLARE @telefon nVarChar(24)

		RETURN @telefon
		END