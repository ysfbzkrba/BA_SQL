USE Northwind	;

-- SAMPLE QUERY --
-- SAMPLE QUERY --
SELECT
	TOP 3
		CONCAT (TitleOfCourtesy, ' ', FirstName, ' ', LastName) as [Name],
		Title, Country,
		(YEAR(getdate()) - YEAR(BirthDate)) as Age,
		CONCAT ( YEAR(BirthDate), '/', MONTH(BirthDate), '/', DAY(BirthDate)) as BirthDate,
		CONCAT ( YEAR(HireDate), '/', MONTH(HireDate), '/', DAY(HireDate)) as HireDate
			FROM Employees
				WHERE FirstName between 'Janet' and 'Robert'
					ORDER BY 2,6 desc		;
-- SAMPLE QUERY --
-- SAMPLE QUERY --
;
;
	--	____________________WHERE // Use for "Select" Conditioning.__________________________	--
	--	_____________________________________________________________________________________	--

SELECT	
	TitleOfCourtesy, FirstName, LastName
	FROM Employees
	WHERE TitleOfCourtesy = 'Mr.'   	; -- Titleofcourtesy = Mr.

SELECT	
	EmployeeID, FirstName, LastName
	FROM Employees
	WHERE EmployeeID > 5		; -- EmployeeID > 5
;


	--	_____________________YEAR(date) function, AND, BETWEEN_______________________________	--
	--	_____________________________________________________________________________________	--

SELECT
	BirthDate, TitleOfCourtesy, FirstName, LastName
	FROM Employees
	WHERE YEAR(BirthDate) = 1960		; --	YEAR	// Year is a function. YEAR(BirthDate) = 1960

SELECT
	YEAR(BirthDate) as BirthDate, FirstName, LastName
	FROM Employees
	WHERE YEAR(BirthDate) >= 1950
	AND
		  YEAR(BirthDate) <= 1961		; --	AND		// Combines two conditions.	// 1961 >= Birthdate >= 1950  

SELECT
	YEAR(BirthDate) as BirthDate, FirstName, LastName
	FROM Employees
	WHERE YEAR(BirthDate) between 1950 and 1961		; --	BETWEEN // ^^^^^^ Shorter version of the line above. ^^^^^^
;


	--	Exercise:  Select women living in UK and display; Name / Title / Country / BirthDate.	--
	--	_____________________________________________________________________________________	--

SELECT
	CONCAT (TitleOfCourtesy, ' ', FirstName, ' ', LastName) as [Name], 
	Title, Country, 
	CONCAT ( YEAR(BirthDate), '/', MONTH(BirthDate), '/', DAY(BirthDate)) as BirthDate
	FROM Employees
	WHERE 
		Country = 'UK'
		And
		(TitleOfCourtesy = 'Ms.' Or TitleOfCourtesy = 'Mrs.')		; --	CONCAT	//	CONCAT is a function. Combines columns.
				  --	OR		//	Uses either conditions.
;


	--	Exercise:  Select men older then 60 or display; Name / Title / Country / BirthDate.		--
	--	_____________________________________________________________________________________	--

SELECT
	CONCAT (TitleOfCourtesy, ' ', FirstName, ' ', LastName) as [Name],
	Title, Country,
	CONCAT ( YEAR(BirthDate), '/', MONTH(BirthDate), '/', DAY(BirthDate)) as BirthDate
		FROM Employees
			WHERE 
				(YEAR(getdate()) - YEAR(BirthDate)) > 60
				or
				TitleOfCourtesy = 'Mr.'		; --	YEAR(GetDate()) //  grabs current date
;


	--	____________________________Query for NULL values___________________________________	--
	--	_____________________________________________________________________________________	--

SELECT
	CONCAT (TitleOfCourtesy, ' ', FirstName, ' ', LastName) as [Name],
	Title, Region, Country,
	CONCAT ( YEAR(BirthDate), '/', MONTH(BirthDate), '/', DAY(BirthDate)) as BirthDate
	FROM Employees
	WHERE Region is null	   ; --		IS NULL	// Query for NULL values.

SELECT
		CONCAT (TitleOfCourtesy, ' ', FirstName, ' ', LastName) as [Name],
		Title, Region, Country,
		CONCAT ( YEAR(BirthDate), '/', MONTH(BirthDate), '/', DAY(BirthDate)) as BirthDate
			FROM Employees
				WHERE Region is not null	   ; --	IS NOT NULL	// Query for any  value .
;


	--	________________________________ORDERED SELECTIONS__________________________________	--
	--	_____________________________________________________________________________________	--

SELECT
	CONCAT (TitleOfCourtesy, ' ', FirstName, ' ', LastName) as [Name],
	Title, Country,
	CONCAT ( YEAR(BirthDate), '/', MONTH(BirthDate), '/', DAY(BirthDate)) as BirthDate
		FROM Employees
			WHERE EmployeeID between 2 and 8
				ORDER BY FirstName ASC		; --	ASC		// ascending order. (DEFAULT)

SELECT
	CONCAT (TitleOfCourtesy, ' ', FirstName, ' ', LastName) as [Name],
	Title, Country,
	CONCAT ( YEAR(HireDate), '/', MONTH(HireDate), '/', DAY(HireDate)) as HireDate
		FROM Employees
				ORDER BY HireDate DESC		; --	DESC	// descending order


SELECT
	*
	INTO Jobs
	FROM Employees		; -- create new table from Employees named Jobs.
SELECT
	FirstName, LastName
	FROM Jobs
		ORDER BY FirstName, LastName DESC		; -- order for when there are duplicate values.


SELECT
	CONCAT (TitleOfCourtesy, ' ', FirstName, ' ', LastName) as [Name],
	Title, Country,
	CONCAT ( YEAR(BirthDate), '/', MONTH(BirthDate), '/', DAY(BirthDate)) as BirthDate,
	CONCAT ( YEAR(HireDate), '/', MONTH(HireDate), '/', DAY(HireDate)) as HireDate
		FROM Employees
				ORDER BY 3,5 desc		; -- order for more then one columns. Tables start from 1 instead of 0 in programming languages. 
SELECT
	CONCAT (TitleOfCourtesy, ' ', FirstName, ' ', LastName) as [Name],
	Title, Country,
	CONCAT ( YEAR(BirthDate), '/', MONTH(BirthDate), '/', DAY(BirthDate)) as BirthDate,
	(YEAR(getdate()) - YEAR(BirthDate)) as Age,
	CONCAT ( YEAR(HireDate), '/', MONTH(HireDate), '/', DAY(HireDate)) as HireDate
		FROM Employees
				ORDER BY 2,5 desc		; -- selected for title and age in descending order.


SELECT
	CONCAT (TitleOfCourtesy, ' ', FirstName, ' ', LastName) as [Name],
	Title, Country,
	(YEAR(getdate()) - YEAR(BirthDate)) as Age,
	CONCAT ( YEAR(BirthDate), '/', MONTH(BirthDate), '/', DAY(BirthDate)) as BirthDate,
	CONCAT ( YEAR(HireDate), '/', MONTH(HireDate), '/', DAY(HireDate)) as HireDate
		FROM Employees
			WHERE YEAR(BirthDate) between 1952 and 1960
				ORDER BY 2,6 desc		; -- selected for title and BirthDate between 1952 and 1960 from column order

SELECT
	TitleOfCourtesy,
	FirstName, LastName,
	Title, Country,
	(YEAR(getdate()) - YEAR(BirthDate)) as Age,
	CONCAT ( YEAR(BirthDate), '/', MONTH(BirthDate), '/', DAY(BirthDate)) as BirthDate,
	CONCAT ( YEAR(HireDate), '/', MONTH(HireDate), '/', DAY(HireDate)) as HireDate
		FROM Employees
			WHERE FirstName between 'Janet' and 'Robert'
				ORDER BY FirstName	desc	   	; -- Names Robert and Janet
SELECT
	CONCAT (TitleOfCourtesy, ' ', FirstName, ' ', LastName) as [Name],
	Title, Country,
	(YEAR(getdate()) - YEAR(BirthDate)) as Age,
	CONCAT ( YEAR(BirthDate), '/', MONTH(BirthDate), '/', DAY(BirthDate)) as BirthDate,
	CONCAT ( YEAR(HireDate), '/', MONTH(HireDate), '/', DAY(HireDate)) as HireDate
		FROM Employees
			WHERE FirstName between 'Janet' and 'Robert'
				ORDER BY FirstName	desc	   	; -- Names Robert and Janet

SELECT
	TitleOfCourtesy,
	CONCAT (FirstName, ' ', LastName) as [Name],
	Title, Country,
	(YEAR(getdate()) - YEAR(BirthDate)) as Age,
	CONCAT ( YEAR(BirthDate), '/', MONTH(BirthDate), '/', DAY(BirthDate)) as BirthDate,
	CONCAT ( YEAR(HireDate), '/', MONTH(HireDate), '/', DAY(HireDate)) as HireDate
		FROM Employees
			WHERE TitleOfCourtesy = 'Ms.'
				  or
				  TitleOfCourtesy = 'Mr.'
				  or
				  TitleOfCourtesy = 'Dr.'		; --		IN		//	TitleOfCourtesy =/ Mrs.
SELECT
	CONCAT (TitleOfCourtesy, ' ', FirstName, ' ', LastName) as [Name],
	Title, Country,
	(YEAR(getdate()) - YEAR(BirthDate)) as Age,
	CONCAT ( YEAR(BirthDate), '/', MONTH(BirthDate), '/', DAY(BirthDate)) as BirthDate,
	CONCAT ( YEAR(HireDate), '/', MONTH(HireDate), '/', DAY(HireDate)) as HireDate
		FROM Employees
			WHERE TitleOfCourtesy in ('Ms.', 'Mr.', 'Dr.')
				ORDER BY 1		; --		IN		//	TitleOfCourtesy =/ Mrs. (SHORT)
SELECT
	CONCAT (TitleOfCourtesy, ' ', FirstName, ' ', LastName) as [Name],
	Title, Country,
	(YEAR(getdate()) - YEAR(BirthDate)) as Age,
	CONCAT ( YEAR(BirthDate), '/', MONTH(BirthDate), '/', DAY(BirthDate)) as BirthDate,
	CONCAT ( YEAR(HireDate), '/', MONTH(HireDate), '/', DAY(HireDate)) as HireDate
		FROM Employees
			WHERE TitleOfCourtesy not in ('Mrs.')
				ORDER BY 1		; --	 NOT IN		//	TitleOfCourtesy =/ Mrs. (SHORT)

SELECT
	CONCAT (TitleOfCourtesy, ' ', FirstName, ' ', LastName) as [Name],
	Title, Country,
	(YEAR(getdate()) - YEAR(BirthDate)) as Age,
	CONCAT ( YEAR(BirthDate), '/', MONTH(BirthDate), '/', DAY(BirthDate)) as BirthDate,
	CONCAT ( YEAR(HireDate), '/', MONTH(HireDate), '/', DAY(HireDate)) as HireDate
		FROM Employees
			WHERE YEAR(BirthDate) in (1950, 1955, 1960)		; -- 	Born in 1950, 1955, 1960
;


	--	________________________________NUMBERED SELECTIONS__________________________________	--
	--	_____________________________________________________________________________________	--

;		--	top is the last command to work in a query.										--
;		--	if there are any kind of filtering in a query the work order for filters is		--
;		--	WHERE, ORDER BY, TOP.															--

SELECT
	TOP 3
		EmployeeID,
		FirstName,
		LastName
			FROM Employees		; --		TOP		// exact amount of rows from top. 
						
SELECT
	TOP 25 PERCENT
		CONCAT (TitleOfCourtesy, ' ', FirstName, ' ', LastName) as [Name],
		(YEAR(getdate()) - YEAR(BirthDate)) as Age
			FROM Employees
					ORDER BY YEAR(BirthDate)		; -- TOP .. PERCENT	// percent amount of rows from top.
;


	--	_______________________________________LIKE__________________________________________	--
	--	_____________________________________________________________________________________	--


SELECT
	FirstName, LastName
		FROM Employees
			WHERE FirstName = 'Michael'		; --		=		//	equals
SELECT
	FirstName, LastName
		FROM Employees
			WHERE FirstName LIKE 'Michael'		; --		LIKE	//	LIKE keyword is equal to equation.
;


	--	________________________SELECT FOR INCOMPLETE VALUE INFORMATION______________________	--
	--	_____________________________________________________________________________________	--
;

	--									Symbol	Description	Examples							--
;
/*
		%		||	Represents zero or more characters			||	bl% finds bl, black, blue, and blob							||
		_		||	Represents a single character				||	h_t	finds hot, hat, and hit									||
		[]		||	Represents any single character				||	within the brackets	h[oa]t finds hot and hat, but not hit	||
		^		||	Represents any character not in the brackets||	h[^oa]t finds hit, but not hot and hat						||
		-		||	Represents a range of characters			||	c[a-b]t finds cat and cbt									||
*/
;


SELECT
	FirstName, LastName
	FROM Employees
		WHERE FirstName LIKE 'A%'		; --	'..%'		// selects with incomplete value info.
SELECT
	FirstName, LastName
	FROM Employees
		WHERE FirstName LIKE '[AL]%'		; --	'[..]%'		// selects with incomplete value info with different initials.
SELECT
	FirstName, LastName
	FROM Employees
		WHERE FirstName like '%[RT]%'		; --	'%[..]%'	// selects with incomplete value info with different initials.
SELECT
	FirstName, LastName
	FROM Employees
		WHERE FirstName like '%A_E%'		; --	'%.._..%	// selects with incomplete value info with different initials with 1 character in between
SELECT
	FirstName, LastName
	FROM Employees
		WHERE FirstName like '%A__E%'		; --	'%..__..%	// select with 2 character step in between


SELECT
	FirstName, LastName
	FROM Employees
		WHERE LEFT(FirstName, 1) = 'A'	 	; --	LEFT		// LEFT(type(CName), length(init))	// selects from left to right.
SELECT
	FirstName, LastName
	FROM Employees
		WHERE LEFT(FirstName, 1) = 'A'
				or
			  LEFT(FirstName, 1) = 'L'	 	; --	LEFT..OR..	// selects from left to right with different initials.
SELECT
	FirstName, LastName
	FROM Employees
		WHERE LEFT(FirstName, 1) in ('A','L')	 	; --	LEFT..IN..	// selects from left to right with different initials.

SELECT
	FirstName, LastName
	FROM Employees
		WHERE SUBSTRING(FirstName, 1, 1) = 'A'	 	; --	SUBSTRING	// SUBSTRING(type(CName), position(init), length(init)) // selects by substring elements with length


SELECT
	FirstName, LastName
	FROM Employees
		WHERE FirstName > 'j%'
			and
			  FirstName < 'r%'
			  ORDER BY FirstName		; -- example study :: select for starting with j or r // using:: % search
	



--STUDY 1-- Names start with LA, LN, AA or AN --
SELECT
	FirstName, LastName
	FROM Employees
		WHERE SUBSTRING(FirstName, 1, 2) = 'LA'
				or
			  SUBSTRING(FirstName, 1, 2) = 'LN'
				or
			  SUBSTRING(FirstName, 1, 2) = 'AA'
				or
			  SUBSTRING(FirstName, 1, 2) = 'AN'	 	; -- SOLUTION // STUDY 1-- Names start with LA, LN, AA or AN 











