/*
			BİLGE ADAM BEŞİKTAŞ SQL.queries 4. GÜN
*/
;
;
USE Northwind
	--========--	JOINS	--========--
;
	--========-- INNER	JOINS	--========--

SELECT
	*
	FROM Categories;

SELECT
	*
	FROM Categories
		WHERE CategoryID = 1;

SELECT
	ProductID, ProductName, UnitPrice
	FROM Products
		WHERE CategoryID = 1
			ORDER BY 3; -- memory refreshers
			

SELECT
	ProductName, UnitPrice, Products.CategoryID, Categories.CategoryName, Categories.Description 
	FROM ( Categories INNER JOIN Products on Categories.CategoryID = Products.CategoryID)
	-- 	FROM ( Categories INNER JOIN Products on Categories.CategoryID = Products.CategoryID) --
		-- is a new combined table of Categories + Products tables.--
		WHERE Categories.CategoryID=1 ; -- if a column name is ambiguous == tablename.columnname 


		--	 exercise	--
		--	 which order, by whom, to whom. --
SELECT
	OrderID, 
	CONCAT (YEAR(OrderDate),'/',MONTH(OrderDate),'/',DAY(OrderDate)) as OrderDate,
	CONCAT (FirstName, ' ', LastName) as Employee, 
	CompanyName, ContactTitle
	FROM ( Customers C INNER JOIN (Orders O INNER JOIN Employees E on O.EmployeeID = E.EmployeeID) on C.CustomerID = O.CustomerID) ; 
		-- ORDERS O .. = names ORDERS column as O // O.orderid is faster then orderid by itself
;		--	exercise out	--
;


	--========-- OUTER	JOINS	--========--

SELECT
	CategoryName, ProductName
		FROM Categories AS C LEFT OUTER JOIN Products as P on C.CategoryID = P.CategoryID ;
		-- LEFT OUTER JOIN	:: all entries from the table on left + only keyed entries from right

SELECT
	CategoryName, ProductName
		FROM Categories AS C RIGHT JOIN Products as P on C.CategoryID = P.CategoryID ;
		--  RIGHT OUTER JOIN:: all entries from the table on right + only keyed entries from left

SELECT
	CategoryName, ProductName
		FROM Categories AS C FULL JOIN Products as P on C.CategoryID = P.CategoryID ;
		--  FULL OUTER JOIN	:: all entries from both tables

SELECT
	CategoryName, ProductName
		FROM Categories cross join Products ;
		-- CROSS JOIN		:: joins tables without defining key.
;

	--========-- AGGREGATE FUNCTIONS	--========--
;
	--========-- COUNT	--========--

SELECT COUNT(*) as 'ToplamÇalışanSayısı' FROM Employees -- = gives number of entries on table. =
SELECT COUNT(Region) FROM Employees -- = gives number of *specific* entries on table. =
;		--*** NULL values wont be counted when ColumnName is given ***-- 
SELECT COUNT(DISTINCT City) FROM Employees -- = gives number of *distinct* entries on table. =

;
	--========-- SUM	--========--

SELECT SUM(EmployeeID) FROM Employees ; -- gives sum of named values. numerical types only.

;
		--	 exercise	--
		--	 SUM OF AGES OF EMPLOYEES --
SELECT SUM(YEAR(GETDATE()) - YEAR(BirthDate)) FROM Employees;

SELECT SUM(DATEDIFF(YEAR,BirthDate,GETDATE())) FROM Employees; 
			-- DATEDIFF (period, x, y) = y-x as specified period of time.
;			--	 exercise	--
;


	--========-- AVG	--========--
SELECT AVG(EmployeeID) FROM Employees;

;		--	 exercise	--
		--	 AVG OF AGES OF EMPLOYEES --
SELECT AVG(DATEDIFF(YEAR,BirthDate,GETDATE())) FROM Employees;
;		--	 exercise	--
		--	 AVG OF AGES OF EMPLOYEES --

;	--========-- MAX & MIN	--========--

SELECT MAX(EmployeeID) FROM Employees; -- maximum numerical value

SELECT MAX(FirstName) FROM Employees; -- last alphabetical order

SELECT MIN(EmployeeID) FROM Employees; -- minimum numerical value

SELECT MIN(FirstName) FROM Employees; -- first alphabetical order


--
--
	--========--	VIEWS	--========-- 
;
	--not tables those are just views.

;		--	 exercise	--
;		--	 What order, which employee, to whom, what category, what product, unit price, order price, quantity --
SELECT

	o.OrderID,
	CONCAT (FirstName, ' ', LastName) as Employee, 
	c.CustomerID,
	CONCAT (CompanyName, ' ', ContactTitle) as Customer,
	CategoryName,
	ProductName,
	pr.UnitPrice,
	[Order Details].UnitPrice as 'OrderPrice',
	[Order Details].Quantity

		FROM (( Customers C INNER JOIN 
				(Employees E INNER JOIN 
					(Orders O INNER JOIN 
						([order details] INNER JOIN 
							(Categories CA INNER JOIN Products PR 
							 on CA.CategoryID=PR.CategoryID) 
						 on [order details].productid = pr.productid)  
					 on O.OrderID=[Order Details].OrderID )
				 on O.EmployeeID = E.EmployeeID) 
			 on C.CustomerID = O.CustomerID))  ; 
			--HandWritten


SELECT
	dbo.[Order Details].OrderID, dbo.Employees.FirstName, dbo.Employees.LastName, dbo.Customers.CompanyName, dbo.Customers.ContactName, dbo.[Order Details].ProductID, dbo.Products.ProductName, dbo.Categories.CategoryName, dbo.Categories.Description, dbo.Products.UnitPrice, dbo.[Order Details].UnitPrice AS OrderPrice, dbo.[Order Details].Quantity 
	FROM dbo.Orders INNER JOIN dbo.Customers ON dbo.Orders.CustomerID = dbo.Customers.CustomerID INNER JOIN
                         dbo.Employees ON dbo.Orders.EmployeeID = dbo.Employees.EmployeeID INNER JOIN
                         dbo.[Order Details] ON dbo.Orders.OrderID = dbo.[Order Details].OrderID INNER JOIN
                         dbo.Products ON dbo.[Order Details].ProductID = dbo.Products.ProductID INNER JOIN
                         dbo.Categories ON dbo.Products.CategoryID = dbo.Categories.CategoryID
		ORDER BY dbo.[Order Details].OrderID, dbo.Employees.FirstName;			-- from  Views // New View -- 

SELECT * FROM [dbo].[SatisRapor]; -- drag and drop from views



;	--========--	CREATE // ALTER // DELETE	--========-- 
;

CREATE VIEW KategoriListesi AS
		SELECT 
			*
			FROM Categories;	-- Creates a view named KategoriListesi from Categories.

SELECT 
	*
	FROM KategoriListesi;	-- Selects all values in view KategoriListesi.


ALTER VIEW KategoriListesi AS
     SELECT 
		CategoryID , Description
		FROM Categories; -- Alters View 'KategoriListesi' to contain CategoryID, Description.

-- View üzerinden tüm CRUD işlemlerini yapabilirsiniz
-- NOT : view içerisinde yer alan tablonun kuralları geçerlidir.

DELETE FROM 
	KategoriListesi
		WHERE CategoryID > 8;	-- deletes categoryID > 8 from kategorilistesi

SELECT 
	*
	FROM KategoriListesi;	-- select kategorilistesi

INSERT INTO 
	KategoriListesi (Description) 
		VALUES ( 'Açıklama Alanı' ); -- ERR::Cannot insert the value NULL into column 'CategoryName' 
ALTER VIEW KategoriListesi AS
     SELECT 
		CategoryID , 
		CategoryName , 
		Description
			FROM Categories; -- Alters View 'KategoriListesi' to contain CategoryID, CategoryName, Description.
INSERT INTO 
	KategoriListesi
		VALUES ( 'Kategori Adı' , 'Açıklama' ); -- adds according to columns specified on the upper line
						-- 'kategori adı' => CategoryName, 'Açıklama' => Description

INSERT INTO 
	Categories
		VALUES ( 'Kategori Adı' , 'Açıklama'); -- DoesNotWork // table has 1 more column not addressed here (picture)
INSERT INTO 
	Categories
		VALUES ( 'Kategori Adı' , 'Açıklama', ''); -- WORKS // Column.Picture is addressed by ''. outputs 0x 
INSERT INTO 
	Categories ( CategoryName , Description ) 
VALUES ( 'Kategori Adı' , 'Açıklama'); -- WORKS // wich columns to add value is addressed by (CategoryName, Description)
SELECT * FROM Categories


CREATE VIEW OgrenciListesi AS
     SELECT 
		FirstName , LastName , Title , City
			FROM Employees; -- Creates view from Employees containing "FirstName, LastName, Title, City" named OgrenciListesi

SELECT *
FROM OgrenciListesi; -- Selects OgrenciListesi

INSERT INTO OgrenciListesi
		VALUES ( 'Murat' , 'Vuranok' , 'Kaldırım Mühendisi' , 'Ankara'); -- Inserts Murat Vuranok Kaldırım Mühendisi Ankara into Ogrencilistesi

ALTER VIEW OgrenciListesi AS
     SELECT 
		FirstName , LastName , Title , City
			FROM Employees
				WHERE City = 'Ankara'; -- Alters OgrenciListesi to contain (FirstName, LastName, Title, City) with rule "City=Ankara"

INSERT INTO OgrenciListesi
	VALUES ( 'Ahmet' , 'Şahin' , 'Kaldırım Mühendisi' , 'İzmir'); -- Inserts Ahmet Şahin Kaldırım Mühendisi İzmir into Ogrencilistesi
;					

ALTER VIEW OgrenciListesi AS
     SELECT 
		FirstName , LastName , Title , City
		FROM Employees
			WHERE City = 'Ankara'
				WITH CHECK OPTION; -- Alters OgrenciListesi to contain (FirstName, LastName, Title, City) with rule "City=Ankara" 
				-- DOES NOT WORK because we set the rule City=Ankara WITH Check Option


ALTER VIEW OgrenciListesi WITH ENCRYPTION AS
     SELECT FirstName , LastName , Title , City
		FROM Employees
			WHERE City = 'Ankara'
				WITH CHECK OPTION;	-- Encrypts OgrenciListesi so it is safer


	--========--	CASE WHEN THEN	--========-- 
	
	-- (case (column) when 'value' then 'new value' end) as 'output column name'

SELECT 
	FirstName,
	LastName,
	Title,
	(CASE(Country)
	WHEN 'UK' THEN 'United Kingdom'
	WHEN 'USA' THEN 'United States of America'
	ELSE Country
	END) AS 'Country' 
FROM Employees

SELECT 
	EmployeeID,
	FirstName,
	LastName,
	Title,
		(CASE
		WHEN EmployeeID>5
			THEN 'Bigger than 5'
		WHEN EmployeeID<5
			THEN 'Smaller than 5'
		ELSE 'Equals 5'
		END)	AS 'Status'
	FROM Employees


	--========--	SUBQUERIES	--========-- 	
;	-- 

SELECT 
	ProductID, ProductName, UnitPrice, UnitsInStock, 
		(SELECT CategoryName FROM Categories WHERE CategoryID=Products.CategoryID) AS Supplier
	FROM Products
	ORDER BY ProductName ASC, Supplier DESC

;
	--========--	GROUP BY / STORED PROCEDURE / FUNCTION	--========-- 	

