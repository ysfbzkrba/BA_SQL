use Northwind;


-- doğrudan f5 yapmıyoruz. istediğimiz satırı seçip onu çalıştırıyoruz.


-- use database seçimi için
-- tekli yorum satırı

/*
Çoklu
Yorum
Satırı
*/

/*
ctrl+k+c => yorumlaştırma
ctrl+k+u => yorumdan çıkarma
ctrl + r => sorgu ekranı
*/
;

--	SELECT KOMUTU -- 
 -- 1. Yöntem --


 select * from Employees; --tüm sütunları çeker

 select FirstName, LastName, Title, BirthDate 
 From Employees;
 -- seçili sütunları çeker. tek satırda olmak zorunda değil

select
	[EmployeeID], [LastName], [FirstName], [Title], [TitleOfCourtesy], [BirthDate], [HireDate], [Address], [City], [Region], [PostalCode], [Country], [HomePhone], [Extension], [Photo], [Notes], [ReportsTo], [PhotoPath] 
from Employees;
 --doğrudan northwind/tables/employees/colums klasörünü çek bırak işlemi.

select FirstName as adı, LastName as soyadı, Title as görevi  
from Employees ;
--as komutuyla sütun isimlerini farklı dışa aktarma
;

-- 2.Yöntem


select FirstName İsim, LastName Soyisim, Title Görevi, BirthDate 'Doğum Tarihi' 
from Employees;


-- 3. Yöntem --


select 
top 5 
Adı = FirstName, Soyadı=LastName, Görevi = Title, [Doğum Tarihi] = BirthDate, HireDate'İşe Alınma Tarihi' 
from Employees;
	/*
	 value = column_name;
	 column_name value; 
	 column_name 'value';

	 'value' column_name => tüm değerleri value ya çevirir.
	*/
select distinct
	City
from Employees;
-- yalnızca farklıları yansıtma
;
--Metinleri birleştirme--
select 
	Personel = TitleOfCourtesy +' '+ FirstName +' '+ LastName
from Employees;

/*
	select
		Column_name = ....
	from Table_name;

	select
		 .... as Column_name
	from Table_name;

	select
		value = ....
	from Table_name;
*/

select 
CONCAT( titleofcourtesy, ' ', FirstName, ' ', LastName ) 'Personel'
from employees

insert
into Categories(CategoryName, [Description])
values ('Kategori adı','Kategori açıklaması')

-- (1 row affected) => girdi yapılan satır sayısı.

insert
into Categories ([Description])
values ('Bu alana eklemeye çalıştığınız kayıt, DB içerisine eklenmeyecektir.');
--Cannot insert the value NULL into column 'CategoryName', table 'Northwind.dbo.Categories'; column does not allow nulls. INSERT fails.



insert
into Categories(CategoryName)
values ('KategoriAdı');


Select
*
From Shippers;

insert
into Shippers (CompanyName, Phone)
values ('MNG Kargo', '(503) 555-9831');
-- eğer tüm Columnlara değer girilecekse, sırası korunmak şartıyla Column isimleri girilmeden işlem yapılabilir.

insert
into shippers
values ('Aras Kargo', '(506) 555-8635');

insert
into Shippers
values	('Yurtiçi Kargo', '(506) 555-8635'),
		('Horoz Lojistik','(503) 588-9245');


select
*
from Customers

insert
into Customers 
values ('BABSK','BilgeAdam','Murat Vuranok', 'Educator', 'Beşiktaş', 'İstanbul','Europe', '34353', 'Turkey', '(539) 654 54 54', '(539) 654 54 54');


/*
2)	UPDATE:
		kayıt güncelleme. hangi kaydın güncelleneceğini açıkça belirtmek gerekli. yoksa tüm kayıtlar güncellenir.

		update <table_name> set <column name> = <Column_value>,<Column_Name> = <Column_Value>
*/

select
 * 
 into Calisanlar 
 from Employees
 -- Employees tablosunu Calisanlar olarak kopyalar.

 UPDATE Calisanlar
	Set LastName= 'Vuranok';


SELECT
 * 
 FROM Calisanlar;

 UPDATE Calisanlar
	SET LastName = 'Davalio'
	WHERE EmployeeID=1 ;
	-- Where koşulu.
UPDATE Calisanlar
	SET	LastName = 'Şahin'
	WHERE TitleOfCourtesy = 'Ms.';

SELECT
 * 
 INTO Urunler
 FROM Products
 
UPDATE Urunler
	set UnitPrice = UnitPrice*105/100;

SELECT
  ProductID, ProductName, OldPrice = UnitPrice, NewPrice= UnitPrice + (Unitprice*0.05)
 INTO FiyatGüncelleme
 FROM Products;

SELECT
*
FROM FiyatGüncelleme ;


/*
3) DELETE
	ex:		delete from <TableName>
*/

DELETE
	FROM Urunler;


SELECT
*
FROM Calisanlar;

DELETE
FROM Calisanlar
WHERE EmployeeID=1;		-- ID değeri 1 olanı siler

DELETE
FROM Calisanlar
WHERE EmployeeID>5;		-- ID değeri > 5 olanı siler

-- Calisanlar ve Urunler tablolarının DB den silinmesi

DROP
	TABLE Calisanlar;
DROP
	TABLE Urunler;

SELECT
	*
	INTO Calisanlar
	FROM Employees;

DELETE
	FROM Calisanlar
		WHERE TitleOfCourtesy = 'Mrs.'; -- title of courtesy = mrs. olanları sil

DELETE
	FROM Calisanlar
		WHERE TitleOfCourtesy in ('Mr.', 'Dr.'); -- title of courtesy = mr. ve dr. olanları sil

DELETE
	FROM Calisanlar
		WHERE TitleOfCourtesy='ms.' and Country = 'USA'; -- VE

DELETE
	FROM Calisanlar
		WHERE TitleOfCourtesy='ms.' or Country = 'USA'; -- YADA


-- BilgeAdam Beşiktaş 11/11/2020 SQL-Query 1  --