--SELECT

--select distinct OrganizationLevel, JobTitle
--from HumanResources.Employee;

select LoginID + ' is a ' + JobTitle
from HumanResources.Employee

select SUBSTRING(LoginID,17,10) + ' is a ' + JobTitle as 'Kim jest pracownik?'
from HumanResources.Employee

select VacationHours, CAST(VacationHours as float)/8 as 'Ile dni wolnych pozostalo?'
from HumanResources.Employee;

select BusinessEntityID, JobTitle
from HumanResources.Employee;

--bledne zapytanie \/ nie mozna polaczyc kolumn z danymi roznej wartosci np -> int i stringa
select BusinessEntityID + JobTitle
from HumanResources.Employee;

select LoginID + ' is a ' + JobTitle
from HumanResources.Employee;

select SUBSTRING(LoginID,17,20) + ' is a ' + JobTitle
from HumanResources.Employee;

select LoginID ,VacationHours, cast(VacationHours as float)/8 as 'godziny wakajek'
from HumanResources.Employee;


--cw2 
--Zadanie: Z tabeli Person.Address pobierz Address ID, oraz połączenie kolumn
--AddressLine1, City i PostalCode. Pomiędzy wartościami z tych trzech kolumn
--wstaw najpierw przecinek ze spacją, a następnie samą spację (adres, miasto
--kod). Nowej kolumnie nadaj alias Adres.


select AddressID, AddressLine1+ ', ' + City + ' '+ cast(PostalCode as nvarchar) as Adres
from Person.Address;

select AddressID, AddressLine1 + ', ' + City + ' ' +
PostalCode as Adres
from Person.Address;

--WHERE 



select BusinessEntityID, JobTitle, MaritalStatus
from HumanResources.Employee
where MaritalStatus = 'M';


select BusinessEntityID,JobTitle, HireDate
from HumanResources.Employee
where HireDate = '20090114';

select BusinessEntityID, JobTitle, HireDate, OrganizationLevel
from HumanResources.Employee
where OrganizationLevel = 2 or OrganizationLevel = 4;

select BusinessEntityID, JobTitle, HireDate, OrganizationLevel,Gender
from HumanResources.Employee
where OrganizationLevel < 2 and gender = 'F';


select BusinessEntityID, JobTitle, HireDate, OrganizationLevel, Gender
from HumanResources.Employee
where OrganizationLevel < 2 and gender = 'F' or gender = 'M';

select BusinessEntityID, JobTitle, HireDate, OrganizationLevel, Gender
from HumanResources.Employee
where OrganizationLevel < 2 and (gender = 'F' or gender = 'M');


--Zadanie 3: Z tabeli HumanResources.EmployeeDepartmentHistory zwróć
--wszystkie rekordy, w których BusinessEntityID jest równy lub większy od 200,
--oraz DepartmentID jest równy 6, lub 4.

select * 
from HumanResources.EmployeeDepartmentHistory
where BusinessEntityID >= 200 and (DepartmentID = 4 or DepartmentID = 6);


--BETWEEN filtrowanie zakresow zwracanych dancyh

select BusinessEntityID, SickLeaveHours
from HumanResources.Employee
where SickLeaveHours between 40 and 50;

-- IN pozwala tworzyc tablice wartosci, ktore moga spelniac warunek 

select hr.BusinessEntityID, hr.SickLeaveHours
from HumanResources.Employee as hr
where SickLeaveHours IN(41,45,50);

-- LIKE pozwala na szukanie podobnych ciągów znakow tekstowych z uzyciem znakow specjalnych
-- % jest to dowolny ciag znakow
-- _ jest to pojedynczy znak 

select * 
from Person.CountryRegion
where name like 'A%';

select * 
from Person.CountryRegion
where name like '_o%';

-- LIKE[] nawiasy kwadratowe pozwalaja na wprowadzenie ciagu znakow, po ktorych wartosci beda filtrowane 

select * 
from Person.CountryRegion as pcr
where pcr.CountryRegionCode like '[B-C]%';

select * 
from Person.CountryRegion
where CountryRegionCode like '[DEF]%';


-- ESCAPE kluzula pozwa na wyszukiwanie znaku specjalnego % lub _ to znaczy ze ESCAPE pozbawia mocy znak 
-- specjalny i zamienia go w zwykły znak. WHERE... LIKE '%\_'ESCAPE'\' oznacza ze znak specjaly po znaku '\' jest 
-- zwyczajnym znakiem.


-- IS NULL jest to warunek sprawdzajacy czy zamiast wartosci w polu znajduje sie NULL. NULL nie jest wartoscia
-- tylko jest brakiem wartosci.

select  * 
from HumanResources.Employee
where OrganizationLevel IS NULL;


select * 
from HumanResources.JobCandidate
where BusinessEntityID is null;

-- NOT jest to zaprzeczenie, czyli znalezienie wszystkich rekordow ktore nie selniaja warunku

select * 
from HumanResources.JobCandidate
where BusinessEntityID is not null;



--Zadanie 4: Z tabeli HumanResources.EmployeePayHistory wybierz kolumny
--BusinessEntityID, Rate, oraz RateChangeDate. Wyfiltruj tylko te rekordy, w
--których Rate wynosi między 60 a 100, oraz zmiana stawki odbyła się nie
--wcześniej niż w 2009 roku.

select BusinessEntityID, Rate, RateChangeDate
from HumanResources.EmployeePayHistory
where Rate between 60 and 100 and RateChangeDate > 2009;



-- ORDER BY jest kto klauzula sortujaca domyslnie sortowanie jes ustawione rosnąco(ASC), (DESC) malejąco

select *
from HumanResources.Employee
order by OrganizationLevel desc;


select BusinessEntityID, JobTitle as 'Stanowisko'
from HumanResources.Employee
order by 'Stanowisko' desc;


select BusinessEntityID , JobTitle as Stanowisko
from HumanResources.Employee
order by Stanowisko;

select BusinessEntityID , JobTitle as Stanowisko
from HumanResources.Employee
order by 2;

-- Sortowac mozna wielopoziomowo, poprzez dopisywanie kolejnych kolumn do klauzuli ORDER BY

select BusinessEntityID, JobTitle as Stanowisko, HireDate as 'Data Zatrudnienia'
from HumanResources.Employee
order by 2 desc, 'Data Zatrudnienia';

select distinct GroupName 
from HumanResources.Department;

select * 
from Production.Product

--Zadanie 5: Z tabeli Production.Location wyciągnij LocationID, Name, oraz
--CostRate. Niech zapytanie zwróci tylko jeden rekord, którego CostRate jest
--najwyższy.

select top 1 LocationID, Name, CostRate
from Production.Location
order by 3 desc;



-- Zadanie
--Stwórz zapytanie, które z tabeli Production.Product zwróci rekordy spełniające warunki:
-- SafetyStockLevel ma być równe 1000, oraz nazwa (name) na zawierać słowo „race” lub
-- ReorderPoint ma być równy 375 lub 600, oraz Color ma się zaczynać na literę S.
--Ile rekordów zwróci zapytanie?


select *
from Production.Product
where SafetyStockLevel = 1000 and Name like '%race%' or (ReorderPoint between 375 and 600) and Color like 'S%';


--SPRAWDZANIE TYPOW DANYCH W TABELI ZA POMOCA SKRYPTU EXEC sp_help

exec sp_help 'HumanResources.Employee';


-- CAST() - funkcja sluzaca do konwersji danych 

select NationalIDNumber as NowyNumer
from HumanResources.Employee
order by NowyNumer;

select cast(NationalIDNumber as bigint) as NowyNumer
from HumanResources.Employee
order by NowyNumer;


select cast(VacationHours as float)/8 as Wakajki
from HumanResources.Employee;


-- GETDATE() funkcja ta zwraca date dzisiejsza 


select GETDATE() as "Data/Godzina", cast(GETDATE() as date) as "Data";

-- DATEDIFF() funkcja pozwala obliczyc roznice w datach

select HireDate, DATEDIFF(year, HireDate, CAST(GETDATE() as date)) as "Ile już lat mineło?"
from HumanResources.Employee;


-- CONVERT() funkcja sluzy do konwersji danych

select 'Todat is a ' + DATENAME(WEEKDAY,GETDATE()) + ', ' + CONVERT(varchar(10), GETDATE(),105) as "Jaki dziś dzień";

-- STR() funkcja sluzy do konwersji danych

select str(cast(VacationHours as float)/8, 6,2) as "Wakajki"
from HumanResources.Employee;


--Zadanie 6: Z tabeli HumanResources.EmployeePayHistory zwróć kolumnę
--BusinessEntityID, kolumnę RateChangeDate przekonwertowaną na datę (bez
--godziny) z aliasem Data zmiany, kolumnę Rate, oraz kolumnę Rate jako tekst z
--maksymalną liczbą znaków 7, oraz 3 miejscami po przecinku. Ostatniej
--kolumnie nadaj alias Sformatowana stawka.

select BusinessEntityID , cast(RateChangeDate  as date) as "Data zmiany", 
Rate, str(cast(Rate as varchar(7)),7, 3) as "Stawka sformatowana"
from HumanResources.EmployeePayHistory;


-- WALIDACJA DANYCH

-- ISNUMERIC - sprawdza czy wskazane wyrazenie da sie przekonwertowac na liczbe, 
--				jesli TRUE to zwaraca 1,
--				jesli FALSE to zwraca 0, 
--Wynik 1 jest zwracany bez wzgledu na to, czy bedzie to typ int czy char skladajacy sie z samych cyfr.

select isnumeric(BusinessEntityID)
from HumanResources.Employee;

select ISNUMERIC(NationalIDNumber)
from HumanResources.Employee;


-- ISDATE  - jesli wyrazenie jest rozpoznane jako data, jesli TRUE to 1, jesli FALSE 0. Wyrazenie musi byc tekstem.

select isdate('20190607');

-- Jesli sprawdzane sa wartosci w kolumnach, to typ danych w tej kolumnie nie moze byc datą.

select ISDATE(HireDate)
from HumanResources.Employee;


select ISDATE(cast(HireDate as char))
from HumanResources.Employee;


-- ISNULL ta funkcja walidujaca pozwana na sprawdzenie, czy brakuje wartosci we skazanej kolumnie. Jesli jest NULL to zastepuje do wskazanym wyrazeniem, a jesli jest cos , to wartosc istniejaca zostaje nienaruszona. ISNULL pozwala na wprowadzenie dat, tesktów i liczb.

select BusinessEntityID, StartDate, ISNULL(EndDate, CAST(getdate() as date))
from HumanResources.EmployeeDepartmentHistory;

select BusinessEntityID, StartDate, EndDate
from HumanResources.EmployeeDepartmentHistory;

select JobCandidateID, ISNULL(BusinessEntityID, 0)
from HumanResources.JobCandidate
order by JobCandidateID;


-- COALESCE - to funkcja sprawdzjaca kolejne elementy tablicy wprowadzonej do funkcji. Zwraca pierwsza wartość która nie jest NULL.

select coalesce(null, null, 'Darek', null, cast(3 as char ));


-- NULLIF - zwraca NULL, kiedy dwie porownywane ze soba wartosci sa równe.

select MaritalStatus, Gender, nullif(MaritalStatus,Gender)
from HumanResources.Employee

--Zadanie 7: Z tabeli Production.Product zwróć kolumny Name, ProductNumber,
--ListPrice, oraz kolumnę Color, w której w przypadku wystąpienia null zamień go
--na frazę ‘No color’. Dopilnuj aby kolumna zachowała swoją nazwę. Wyfiltruj
--tylko te rekordy, których wartości z koulmny ListPrice mieszczą się w zakresie
--między 100 a 200. Dane posortuj rosnąco po kolumnie ListPrice.

select Name, ProductNumber, ListPrice, isnull(cast(Color as char),'No color') as "Color"
from Production.Product
where ListPrice between 100 and 200
order by ListPrice;


-- DZIALANIA ARYTMETYCZNE I ZAOKRAGLANIE DANYCH 
-- standardowe operacje dodawania, odejmowania, mnozenia i dzielenia dokonywane sa za pomoca znakow +, -, *, /.

select hreph.BusinessEntityID, hreph.Rate, 
hreph.Rate + 10 as "Wynagrodzenie zwiększone o 10 dolarów",
hreph.Rate * 1.1 as "Wynagrodznie zwiększone o 10 procent",
hreph.Rate - 10 as "Wynagrodzenie zmniejszone o 10 dolarów",
hreph.Rate / 3 as "Wynagrodznie zamienione na złotówki"
from HumanResources.EmployeePayHistory as hreph;


-- X % Y - wynik reszty z dzielenia X przez Y - MODULP


select 3500 % 1500 as "Reszta z dzielenia",
		3500 / 1500 as "Dzielenie",
		CAST(3500 as float) / 1500 as "Dzielenie z reszta";

-- ROUND - zaokrąglanie wartosci liczbowych do wskazanej liczby miejsc po przecinku. W standardowej formie funkcji ROUND wprowadza sie wyrazenie oraz liczbe miejsc po przecinkiu do jakiej ma byc wartosc zaokraglona. Wtedy zaokraglenie jest w gore, jesli liczba uzyskala conajmniej polowe wartosci calkowitej, albo w dol jesli nie uzyskała.

select round(-2.49, 0),
		round(-2.5,0),
		ROUND(1.2683, 2);


-- funkcja ROUND ma jeszcze jeden argumen którego domyślna wartość wynosi 0. Jezeli zostanie ten argument wprowadzony jakio 1 to funkcja zadziala tak, że zacznie obcinac wartosci do wskazanej liczby miejsc po przecinku.

select hr.BusinessEntityID,
hr.Rate,
round(hr.Rate,2) as "Wartości zaokrąglone do 2 miejsc po przecinku",
round(hr.Rate,2,1) as "Wartości skrócone do 2 miejsc po przeicnku"
from HumanResources.EmployeePayHistory as hr;


-- kiedy argumentem oznaczającym liczbe miejsc po przecinku będzie liczba ujemna to zaokrąglenia będą dotyczyły liczb calkowitych


select eph.BusinessEntityID, eph.Rate,
	round(eph.Rate, -1) as "Bez jedności",
	ROUND(eph.Rate, -2) as "Bez dziesiątek" 
from HumanResources.EmployeePayHistory as eph;


-- CEILING i FLOOR to funkcje zaokraglajace wartosc do liczby całkowitej w górę lub w dół. Przyjmują tylko 1 argument


select BusinessEntityID, Rate,
floor(Rate) as "Do całkowitej w dół",
CEILING(Rate) as "Do całkowitej w fore"
from HumanResources.EmployeePayHistory;



-- RAND to funkcja generujaca losowo liczby w zakresie od 0 do 1. Aby uzyskac generator liczb losowych mozna stwożyć formułę, która z wykorzystaniem funkcji zaokrąglającej ROUND pozwoli na zwracanie wartosci całkowitych w wybranym zakresie liczb.

select round(rand()* (5-1), 0) +1;



select FLOOR(12.34),
	FLOOR(-12.34),
	ROUND(12.34,0),
	CEILING(12.34),
	CEILING(-12.34),
	ROUND(-12.34,0);



--Zadanie 8: Z tabeli Sales.SalesPerson zwróć dwie kolumny. Jedna z nich to
--kolumna SalesYTD, w której obcięte będą miejsca po przecinku np. 559697.00,
--a druga to kolumna, która zawierać będzie wartość SalesYTD podzieloną przez
--1000000 i zaokrągloną do dwóch miejsc po przecinku, oraz doklejoną frazą
--‘mln’ np. 0.56 mln.


select  SalesYTD, round(cast(SalesYTD as float),2), cast(ROUND(SalesYTD/1000000,2) as char) + ' mln'
from Sales.SalesPerson 


--           FUNKCJE AGREGUJACE 
-- funkcje agregujące operują na całych kolumnach, aby dać jeden wynik 
------------------
--SUM - suma wartosci. Moze byc stosowana tylko i wyłącznie dla danych liczbowych.


select sum(SickLeaveHours)/24 as "Suma dni chorobowego"
from HumanResources.Employee;


-- MIN i MAX - najnizsza i najwyzsza wartość. Moze byćstosowana do danych liczbowych, ciągów tekstu i dat.

select max(VacationHours) as "Najwyzsza liczba dni wolnych",
	min(HireDate) as "Najdluzej pracujaca osoba",
	max(JobTitle) as "Ostatna nazwa stanowiska"
from HumanResources.Employee;


-- COUNT(*) - zwraca ilosc rekordow w w tabeli.

select COUNT(*) as "Loczba rekordow"
from Sales.SpecialOffer


-- COUNT(nazwa kolumny) - zwraca liczbe rekordow w kolumnie z pominieciem wartosci NULL

select count(MaxQty) as "Liczba rekordow z wartoscia w kolumnie MAXQTY"
from Sales.SpecialOffer