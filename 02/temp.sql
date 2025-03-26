INSERT INTO cities (Name,Country,Population,Area)
VALUES
('tokuyo','japan',38000000,6000),
('delhi','india',200000000,658),
('karachi','pakistan',1000000,3124),
('dallas','united states of america',50000,2000);
SELECT Name, Population*Area  AS Density FROM cities;
SELECT Name FROM Cities WHERE Area > 6000;
CREATE TABLE phones (
id SERIAL PRIMARY KEY,
name VARCHAR(100),
price NUMERIC,
brand TEXT
);
INSERT INTO phones (name,price,brand)
VALUES
('s24 ultra',100, NULL);
('galaxy s21',1000,'samsung'),
('mi 14 pro',1300,'xiaomi'),
('magic pro',800,'honour'),
('galaxy A53',500,'samsung');
-- QUARIES
-- IS, IS NOT OPERATORS
SELECT * FROM phones WHERE   BRAND IS NOT NULL;
-- THIS IS WRONG 
SELECT * FROM phones WHERE brand = NULL;
-- INSQL NULL MEANS NOTHING SO ANYTHING COMPARE TO IT RESULT IN NOTHING OR NULL.
-- TO CHECK SUCH CONDITIONS LIKE NULL OR TRUE AND FALSE USE'IS' OPERATOR.
SELECT * FROM phones WHERE brand IS NULL;
-- IN , BETWEEN START ANDEND INCLUSIVE OPERATORS 
SELECT * FROM phones WHERE  price BETWEEN 500 AND 1000;
SELECT * FROM phones WHERE LOWER(brand) IN ('xiaomi','hauwei','samsung','honour');

-- USING LOGICAL AND AND LOGICAL OR OPERATORS.
SELECT * FROM  phones WHERE price <= 500 AND LOWER(brand) ='samsung';
--using logical not
select * from PHONES where  not  price = 500;
-- exercise
SELECT name,price*units AS totalrevinue  FROM phones WHERE  price * units > 1000000;
-- updating   
UPDATE cities SET population=39000000 WHERE LOWER(Country)='japan';
-- will update all the cities population where name is dallas.
UPDATE cities SET Population= 100000 WHERE  LOWER(Name)= 'dallas';
-- deleting exercise
DELETE FROM  cities WHERE LOWER(Country) = 'south africa';
-- updating exercise
UPDATE cities SET population = 38005000  WHERE LOWER(Country) = 'japan';