/*
			TABLE DIGESTOR
*/
USE Northwind

/*
SELECT 
	CONCAT('@', c.name), ' ', t.name , '(', (C.max_length /2), ')'
		FROM (sys.columns AS c join sys.types AS t ON c.user_type_id=t.user_type_id)  
			WHERE c.object_id=OBJECT_ID('dbo.'+'@tablename');
*/



DECLARE @tablename nvarchar(20);

DECLARE @query	nvarchar(max) =
'SELECT 
	CONCAT(''@'', c.name), '' '', t.name , ''('', (C.max_length /2), '')''
		 FROM (sys.columns AS c join sys.types AS t ON c.user_type_id=t.user_type_id)  
			 WHERE c.object_id=OBJECT_ID(''dbo.''+@tablename);'
			 ;
			 print @query


