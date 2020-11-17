/*
			MAIL ADDRESS DISECTOR
*/

DECLARE	@Mail	nVarChar(100)	=	'yusuf.bozkir@hotmail.com' ;
	DECLARE @Name nVarChar(100)	=	'';
	DECLARE @Lname nVarChar(100)	=	'';
	DECLARE @domain nVarChar(100)	=	'';
	DECLARE @Extention nVarChar(100)	=	'';
	DECLARE @Slice nVarChar(100)	=	'';
	DECLARE @Slice2 nVarChar(100)	=	'';

	--SELECT @Mail as Mail ;

		--SELECT	SUBSTRING(@Mail, 1, CHARINDEX('.',@Mail)-1) as isim ;
	SET	@Name	= SUBSTRING(@Mail, 1, CHARINDEX('.',@Mail)-1) ;
		SET	@Slice	= SUBSTRING(@Mail, 1, CHARINDEX('.',@Mail)) ;
		SET @Slice2	=	TRIM(@Slice FROM @Mail);

			--SELECT	SUBSTRING(@Slice2, 1, CHARINDEX('@',@Slice2)-1) as soyisim ;
			--SET	@Slice2 = TRIM(SUBSTRING(@Slice2, 1, CHARINDEX('@',@Slice2)) FROM @Slice2) ;
	SET	@Lname	= SUBSTRING(@Slice2, 1, CHARINDEX('@',@Slice2)-1);

				--SELECT	SUBSTRING(@Slice2, 1, CHARINDEX('.',@Slice2)-1) as domain;
	SET	@domain	= SUBSTRING(@Slice2, 1, CHARINDEX('.',@Slice2)-1);
				SET @Slice = SUBSTRING(@Slice2, 1, CHARINDEX('.',@Slice2)-1);

				SET	@Extention = SUBSTRING(@Slice2, LEN(@slice)+1, 10) ;
	--SET	@Extention = SUBSTRING(@Slice2, LEN(@slice)+2, 10) ;
					--SELECT @Slice2 as extention; 	
					SELECT
						@Mail as mail, 
						@Name as [Name],
						@Lname as LastName, 
						@domain as Domain, 
						@Extention as extention; 

