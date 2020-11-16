--==========-- Basic Commands	--==========--

USE Northwind;

--==========-- basic maths. (addition)	--==========--

SELECT 5+10			
;


--==========--		DATE & TIME		--==========--

SELECT GETDATE()	
	-- gets todays date. accurate to the milisecond.
	SELECT GETDATE() AS TARİH	
		-- gets todays date as TARİH

SET STATISTICS TIME ON;
SET STATISTICS TIME OFF;
	-- gives completion times.
;



--==========--		PRINT			--==========--
PRINT 'Bilge Adam';



--==========--	STRING FUNCTIONS	--==========--

SELECT ASCII ('A') as 'ascii kod değeri: '
SELECT ASCII ('Z') as 'ascii kod değeri: '
SELECT ASCII ('0') -- ascii code 48
SELECT ASCII ('9') -- ascii code 53
;	-- for a program to accept numerics ascii (>= 48 and <= 53) or =43 (asciis for 0,9 and +)
 
SELECT CHAR(65) AS 'Character' ; -- gets the character from ascii code. (A)
;

SELECT 
	CHARINDEX('@','ba.yusufbozkir@gmail.com') 
			as 'index number'
	-- index number starts from 0 in sql instead of 1 like other programming languages.

SELECT 
	CHARINDEX('a','ba.yusufbozkir@gmail.com') 
			as 'index number'	
	-- searches A in ba.yusufbozkir@gmail.com from start.

SELECT 
	CHARINDEX('a','ba.yusufbozkir@gmail.com', 3) 
			as 'index number'
	-- searches A in ba.yusufbozkir@gmail.com from 3rd character.
;
SELECT LEFT  ('Bilge Adam', 5) as 'First(=fromleft) 5 characters'  --=> Bilge 
SELECT RIGHT ('Bilge Adam', 4) as 'Last (=fromright) 4 characters' --=> Adam =! mada (doesn't reverse)
;

SELECT LEN('Bilge Adam Beşiktaş Yazılım Kursu') as 'Number of Characters in String' ;

--==========-- DECLARING VARIABLES IN SQL	--==========--

DECLARE @BenimMetnim nvarchar(150) = 'can set default value here' ;

	SET @BenimMetnim = '	declaring new value to the existing variable.';

	SELECT LTRIM('')	;	-- clears the empty gaps in start.

;	--example--

DECLARE @Metin nvarchar(150) = 'can set default value here' ;
	print @Metin

	SET @Metin = '     declaring new value to the existing variable.';
	print @Metin;
	PRINT LEN(@Metin);

	SET @Metin = LTRIM(@Metin);
	PRINT @Metin;
	PRINT LEN(@Metin);
	
	SET @Metin = 'a new line with empty gaps at the end.              '
	PRINT @Metin;
	PRINT LEN(@Metin);
	SET @Metin=RTRIM(@Metin); -- not needed in newer versions after SQL2016
	PRINT CONCAT('Length of @Metin after the gap is removed at the end = ', LEN(@Metin)) ;

	SET @Metin = '          bilge          ';
	PRINT @Metin;
	PRINT LEN(@Metin);

	SET @Metin= LTRIM(RTRIM(@Metin));	-- TRIMs STRING from left and right
	PRINT @Metin;
	PRINT LEN(@Metin);

	SET @Metin = '          bilge          ';

	SET @Metin= TRIM(@Metin);			-- TRIMs STRING from left and right
	PRINT @Metin;
	PRINT LEN(@Metin);

PRINT TRIM('2017' FROM '2017Bilge2017AdamSQL2017') -- prints Bilge2017AdamSQL
PRINT TRIM(LEADING '2017' FROM '2017Bilge2017AdamSQL2017') -- DOESNOTWORK

		
;	

--==========-- REPLACE	--==========--

SELECT REPLACE ('Bilge Adam', 'adam', 'Hatun');
	--	REPLACE	(MainString, Selection, UpdatedValue)

SELECT 
	*
	INTO Urunler2 
		FROM Urunler; -- Created new table named urunler2

SELECT 
	ProductName
		FROM Urunler2; -- selected productnames.

SELECT 
	ProductName
			FROM Urunler2
			WHERE ProductName like '%Ö%'; -- selected productnames including 'ö'.

SELECT 
	ProductName
			FROM Urunler2
			WHERE ProductName like '%o%'; -- selected productnames including 'o'.


SELECT 
	ProductID,
	ProductName,
	REPLACE(REPLACE(REPLACE(ProductName, 'á', 'a'), 'ô', 'o'),'â', 'a') as [NewName]
		FROM Urunler2
			WHERE ProductID in(24,38); 
		-- SELECTED productnames including á, ô and â and printed as a,o,a

UPDATE Urunler2
	SET ProductName = REPLACE(REPLACE(REPLACE(LOWER(ProductName),'á', 'a'), 'ô', 'o'),'â', 'a')
		-- UPDATED productnames including á, ô and â and printed as a,o,a

	SELECT
		ProductID,
		ProductName
			FROM Urunler2; -- selected productnames from urunler2 (updated)
;

--==========--	REPLACE vs TRIM	--==========--

DECLARE @metin1	nvarchar(100) = ' ! metin!metin ! ';
PRINT TRIM (' ! ' from @metin1)
PRINT REPLACE(REPLACE(@metin1 , '!', ''), ' ', '')


--==========--	REPLACE vs TRIM	--==========--
;

--==========--REVERSE		--  not a sorting tool. just backwards. --==========--

SELECT REVERSE (ProductName)
	FROM Urunler2

--==========-- REPLICATE	--==========--
					 
PRINT REPLICATE('Enter String Here'+ CHAR(13), 1000);
	-- REPLICATE ( Expression nvarchar(1) + Number of chars in a single line, number of repetition )



SELECT LOWER('ALL ARE LOWER CASE')
SELECT UPPER('all are upper case')




--==========--	SUBSTRING	--==========--

DECLARE @metin2 nvarchar(100) = 'ba.yusufbozkir@gmail.com';
	SELECT SUBSTRING(@metin2, 1, CHARINDEX('.',@metin2)-1);
		-- SELECT from 1ST character to  dot (.) 

DECLARE @tags nvarchar(150) = 'clothing,road, ,,touring,bike';
	SELECT value
		FROM STRING_SPLIT(@tags, ',')
			--WHERE RTRIM(value) <> '';
			  WHERE RTRIM(value) not in (' ', '', ',');
				-- split string by commas.
				;

SELECT
	ProductID, ProductName, value
	FROM Products cross apply string_split(ProductName, ' ')
		WHERE ProductID = 4
			ORDER BY ProductID






--==========--	***************	--==========--

DROP TABLE Urunler2;

ALTER DATABASE northwind
SET COMPATIBILITY_LEVEL = 130 