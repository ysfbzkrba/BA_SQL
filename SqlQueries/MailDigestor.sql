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


	SET	@Name	= SUBSTRING(@Mail, 1, CHARINDEX('.',@Mail)-1) ;		-- @name= yusuf /(.bozkir@hotmail.com)
		SET	@Slice	= SUBSTRING(@Mail, 1, CHARINDEX('.',@Mail)) ;	-- @slice = yusuf. / (bozkir@hotmail.com)
		SET @Slice2	=	TRIM(@Slice FROM @Mail);					-- @slice2 = bozkir@hotmail.com
		SET	@Lname	= SUBSTRING(@Slice2, 1, CHARINDEX('@',@Slice2)-1);	--@Lname = bozkir / (@hotmail.com)
				SET	@Slice2 = TRIM(SUBSTRING(@Slice2, 1, CHARINDEX('@',@Slice2)) FROM @Slice2) ; -- @slice2 = bozkir@ / (hotmail.com)
				SET	@domain	= SUBSTRING(@Slice2, 1, CHARINDEX('.',@Slice2)-1);	-- @domain = hotmail / (.com)
					SET	@Extention = SUBSTRING(@Slice2, LEN(@domain)+1, 10) ;	-- @extention = .com 
					
					SELECT
						@Mail as mail, 
						@Name as [Name],
						@Lname as LastName, 
						@domain as Domain, 
						@Extention as extention; 
/*
			MAIL ADDRESS DISECTOR
			OUT
*/
