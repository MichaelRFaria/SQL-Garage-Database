/* SECTION 1 - CREATE TABLE STATEMENTS */

CREATE TABLE adgf023_Resident(
    resident_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    first_name VARCHAR(22) NOT NULL,
    last_name VARCHAR(22) NOT NULL,
    dob INTEGER(6),
    apartment_block CHAR(1) NOT NULL,
    apartment_number INTEGER(3) NOT NULL,
    phone_number VARCHAR(11) NOT NULL UNIQUE,
    email VARCHAR(45) UNIQUE,
    PRIMARY KEY(resident_id)
);

CREATE TABLE adgf023_Management(
    management_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    first_name VARCHAR(22) NOT NULL,
    last_name VARCHAR(22) NOT NULL,
    hire_date INTEGER(6),
    phone_number VARCHAR(11) NOT NULL UNIQUE,
    email VARCHAR(45) NOT NULL,
    PRIMARY KEY(management_id)
);

CREATE TABLE adgf023_ParkingSpace (
    space_number INTEGER NOT NULL UNIQUE,
    leased CHAR(1),
    PRIMARY KEY(space_number)
);

CREATE TABLE adgf023_Agreement(
    agreement_id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    space_number INTEGER,
    start_date INTEGER(6),
    end_date INTEGER(6),
    lease_price INTEGER,
    resident_id INTEGER,
    management_id INTEGER,
    PRIMARY KEY(agreement_id),
    FOREIGN KEY(resident_id) REFERENCES adgf023_Resident(resident_id),
    FOREIGN KEY(management_id) REFERENCES adgf023_Management(management_id),
    FOREIGN KEY(space_number) REFERENCES adgf023_ParkingSpace(space_number)
);

CREATE TABLE adgf023_Vehicle(
    license_plate VARCHAR(8) UNIQUE,
    manufacturer VARCHAR(45),
    model VARCHAR(45),
    colour VARCHAR(45),
    space_number INTEGER,
    PRIMARY KEY(license_plate),
    FOREIGN KEY(space_number) REFERENCES adgf023_ParkingSpace(space_number)
);

/* SECTION 2 - INSERT STATEMENTS */

INSERT INTO adgf023_Resident VALUES (001,'Michael', 'Faria',950709,'A','012','07132821356','michaelfaria@email.com'),
(002,'Dante','Dunlap',950514,'B','023','01270605009',NULL),
(003,'Ronald','Dale',980719,'A','007','05156191550',NULL),
(004,'Leroy','Perry',850403,'E','112','06632030835','leroyperry@email.com'),
(005,'Fabian','Cardenas',991109,'F','065','06193452008','fabiancardenas@email.com'),
(006,'Daisie','Bonner',921225,'A','045','08153142228','daisiebonner@email.com'),
(007,'Elias','Montgomery',900601,'G','009','09623780949',NULL),
(008,'Chaim','David',970113,'G','053','07509449923','chaimdavid@email.com'),
(009,'Rhianna','Barker',981016,'A','024','08767459770','rhiannabarker@email.com'),
(010,'Safaa','Griffith',910817,'C','017','09082710423',NULL);

INSERT INTO adgf023_ParkingSpace VALUES (123,'Y'),
(81,'N'),
(13,'Y'),
(23,'Y'),
(96,'Y'),
(43,'Y'),
(121,'Y'),
(45,'Y'),
(73,'N'),
(22,'Y'),
(93,'Y'),
(56,'Y');

INSERT INTO adgf023_Management VALUES (001,'James','Smith',160614,'01273948576','jamessmith@email.com'),
(002,'Emily','Johnson',230712,'09827364571','emilyjohnson@email.com'),
(003,'Michael','Williams',110918,'05683927415','michaelwilliams@email.com'),
(004,'Sarah','Brown',200203,'04573829164','sarahbrown@email.com'),
(005,'David','Jones',130426,'07683921547','davidjones@email.com'),
(006,'Jessica','Davis',210115,'08375921647','jessicadavis@email.com'),
(007,'Robert','Miller',120601,'09753286471','robertmiller@email.com'),
(008,'Ashley','Wilson',170809,'05473892651','ashleywilson@email.com'),
(009,'John','Moore',141025,'07359286471','johnmoore@email.com'),
(010,'Jennifer','Taylor',150331,'07861238131','jennifertaylor@email.com');


INSERT INTO adgf023_Vehicle VALUES ('BD51 SMR','Toyota','Camry','Red',123),
('GH12 IJP','Ford','Mustang','Blue',13),
('LM34 NSP','Honda','Civic','Green',23),
('QR56 ATU','BMW','3 Series','Yellow',96),
('VW78 XYK','Mercedes-Benz','E-Class','Black',43),
('AA23 BJD','Audi','A4','White',121),
('EF45 GAI','Volkswagen','Golf','Silver',45),
('JK67 LZN','Nissan','Altima','Grey',22),
('OP89 QTS','Hyundai','Elantra','Blue',93),
('TU01 VWD','Ford','F-150','Red',56);


INSERT INTO adgf023_Agreement VALUES (001,56,230307,240307,400,006,010),
(002,93,230512,240512,450,009,001),
(003,22,230109,240109,400,005,001),
(004,45,230411,250411,700,007,004),
(005,121,230205,260205,850,010,005),
(006,43,230610,240610,400,008,005),
(007,96,230901,240901,375,003,004),
(008,23,230708,240708,400,002,007),
(009,123,230312,250312,600,001,002),
(010,13,231011,241011,375,004,010);


/* SECTION 3 - UPDATE STATEMENTS */

/*1*/
UPDATE adgf023_Vehicle
SET license_plate = 'AD74 WED'
WHERE license_plate = 'QR56 ATU';

/*2*/
UPDATE adgf023_Agreement
SET end_date = 260411
WHERE agreement_id = 004;

/* SECTION 4 - SINGLE TABLE SELECT STATEMENTS - The queries must be explained in natural (English) language first, and then followed up by respective SELECTs*/


/* 
1)  
List the parking space numbers of all spaces that are not being leased.
*/
SELECT space_number
FROM adgf023_ParkingSpace
WHERE leased = 'N';


/* 
2)  
List the names of management staff who have been hired between 2020 and 2023.
*/
SELECT first_name,last_name
FROM adgf023_Management
WHERE hire_date >= 200101 AND hire_date <= 231231;



/* 
3)  
List the names of residents whose surname begins with 'D'. Sort the list by the alphabetical order of their first names.
*/
SELECT first_name,last_name
FROM adgf023_Resident
WHERE last_name LIKE 'D%'
ORDER BY first_name;


/* 
4)  
List all the names of residents who do not have a email address on record.
*/
SELECT first_name, last_name
FROM adgf023_Resident
WHERE email IS NULL;


/* 
5)  
How much money is being collected for all current parking space agreements that have been made before July 2023. List the total amount as 'Total lease revenue for first half of 2023'.
*/
SELECT SUM(lease_price) as 'Total lease revenue for first half of 2023'
FROM adgf023_Agreement
WHERE start_date <= 230630;


/* 
6)  
List all the manufacturers of the parked cars, in alphabetical order, that are not green. List each manufacturer only once.
*/
SELECT DISTINCT(manufacturer)
FROM adgf023_Vehicle
WHERE NOT colour = 'Green'
ORDER BY manufacturer ASC;

/* SECTION 5 - MULTIPLE TABLE SELECT STATEMENTS - The queries must be explained in natural (English) language first, and then followed up by respective SELECTs */


/* 
1)  
List the full name and license plate of the resident who is paying the highest for a parking space.
*/
SELECT r.first_name, r.last_name, v.license_plate
FROM adgf023_Resident r, adgf023_Vehicle v, adgf023_Agreement a
WHERE r.resident_id = a.resident_id 
AND a.space_number = v.space_number
AND lease_price = 
(SELECT MAX(lease_price) FROM adgf023_Agreement);


/* 
2)  
List the full name of management staff who have given parking space agreements. 
*/
SELECT first_name, last_name
FROM adgf023_Management
WHERE management_id IN 
(SELECT (management_id)
FROM adgf023_Agreement);


/* 
3)  
List the manufacturer and model of vehicles that are parked in parking spaces with lease agreements ending in 2024.
*/
SELECT manufacturer, model
FROM adgf023_Vehicle
WHERE space_number IN 
(SELECT space_number
FROM adgf023_Agreement
WHERE end_date LIKE '24%');


/* 
4)  
What is the full name of the management staff who signed the lease agreement for resident "Fabian Cardenas"?
*/
SELECT first_name, last_name
FROM adgf023_Management
WHERE management_id IN 
(SELECT management_id
FROM adgf023_Agreement
WHERE resident_id IN 
(SELECT resident_id
FROM adgf023_Resident
WHERE first_name = 'Fabian' AND last_name = 'Cardenas'));


/* 
5)  
List both the names of management staff who have signed 2 or more leasing agreements, and the agreement id. Sort the list alphabetically by last names.
*/
SELECT m.first_name, m.last_name, COUNT(*) AS agreements_signed 
FROM adgf023_Management m, adgf023_Agreement a
WHERE m.management_id = a.management_id
GROUP BY m.management_id
HAVING COUNT(*) >= 2
ORDER BY last_name ASC;


/* 
6)  
List the names of residents, along with their license plate and lease price, who are paying more than 400 on their lease. Sort the list by highest to lowest lease price
*/
SELECT r.first_name, r.last_name, v.license_plate, a.lease_price
FROM adgf023_Resident r, adgf023_Vehicle v, adgf023_Agreement a
WHERE r.resident_id = a.resident_id 
AND a.space_number = v.space_number
AND a.lease_price > 400
ORDER BY a.lease_price DESC;

/* SECTION 6 - DELETE ROWS (make sure the SQL is commented out in this section)

DELETE FROM adgf023_Vehicle WHERE license_plate = 'VW78 XYK';

DELETE FROM adgf023_Management WHERE first_name = 'Michael' AND last_name = 'Williams';

*/

/* SECTION 7 - DROP TABLES (make sure the SQL is commented out in this section)

DROP TABLE adgf023_Vehicle;
DROP TABLE adgf023_Agreement;
DROP TABLE adgf023_ParkingSpace;
DROP TABLE adgf023_Management;
DROP TABLE adgf023_Resident;
*/