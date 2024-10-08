--  lecture 1
--  in this lecture we will   see the options inside the pgadmin4
--  when we install pg we are installing    postgress server. one server  can contains many databases .
--  lecture 2
/* in this lecture we will study about the differenct data types in postgress..
this is the table representing different numeric sub data types avalible in postgress.
Data Type,Description,Range,Size (in bytes),Use Case
SMALLINT,Small integer,-32,768 to 32,767,2,Suitable for small integer values, such as age or counts
INTEGER (INT),Standard integer,-2,147,483,648 to 2,147,483,647,4,Default integer type for general use
BIGINT,Large integer,-9,223,372,036,854,775,808 to 9,223,372,036,854,775,807,8,Used when very large numbers are required (e.g., population count)
SERIAL,Auto-incrementing integer (integer),1 to 2,147,483,647,4,Auto-generated ID for tables (integer type)
BIGSERIAL,Auto-incrementing large integer (bigint),1 to 9,223,372,036,854,775,807,8,Auto-generated ID for large datasets
DECIMAL (p, s),Exact numeric, where precision and scale are defined,Up to 131,072 digits before the decimal and 16,383 after,Variable,Used for financial and precise calculations, e.g., prices
NUMERIC (p, s),Same as DECIMAL,Up to 131,072 digits before the decimal and 16,383 after,Variable,Interchangeable with DECIMAL for high precision
REAL,Single precision floating-point number,6 decimal digits precision,4,Used when precision is not as critical
DOUBLE PRECISION,Double precision floating-point number,15 decimal digits precision,8,Suitable for scientific calculations, larger numbers
MONEY,Currency amount with a fixed fractional precision,-92233720368547758.08 to +92233720368547758.07,8,Handling of financial data with currency formatting
decimal:
 precision is the number of digits that can be store both after and before the point.
 scale is the number of digits that appears after the decimal point.
 e.g decimal(5,2)  means i can have total 5 digits  where 2 digits are after point. e.g 619.12
 the numeric:
 the numeric data type is similar to the  decimal data type.
 Money:
  the money data type is good for storing currency. it has fixed fractional precision 2 digits after decimal point. 

*/

--  lecture 3
/*
the most comman data types that are use in number are 
serial or bigsereial:
use this data type if you want to auto increment the number. This data type is mostly used in primery key.
smallint ,int,  or bigint:
all integer types  are used when you dont want to store any kinda  of decimal.
store the number as   smallint if these are like ages , int if it is a bigger number and bigint if it is really big number like population of a country.
numeric or decimal:
use numeric or decimal when you have fractional part and you need really high precision, like in scientific calcualtions.
double precision:
the double precision is used when you want a decimal number but the precision of the numbers  does not has to be 100% accurate, like when you calculating a weight of something where the weight is 25.01356 kg .
*/

--  lecture 4
/*
in this lecture we  will practice the type casting different number data types into one another. we use "::" operator  to type cast    one data type to another.
syntax : Select  original_data::type_cast_data;
SELECT 234.24::INT;
*/
-- lecture 5
/*
in this lecture we will revise the  string  data type and its veriation.

1. CHAR(5): Store some characters, length will always be 5 even if PG has to insert spaces.
2. VARCHAR: Store any length of string.
3. VARCHAR(40): Store a string up to 40 characters, automatically remove extra characters.
4. TEXT: Store any length of string.
CHAR(LENGTH):
    the char data type allows you have fix length of text. meaning any characters > then the provided length shall be trimmed, and if the length of the string is < then provided length additional space characters are added to fill that .
    varchar:
    the varchar does not add paddin if the string is  shorter then  the specified length.
    text:
    you can have any length of string inside text data type.
    it is very important to note that   behind the seens all the string data types has similar performance they just give you  different types just to put limit of not storing too long string.
*/
--  lecture  6
/*
ininthis lecture we will study about the  boolean data type.
we can use  convert 't,TRUE,FALSE,t,F,FALSE,false,f,0,1' into boolean data type.
select ( above_value::BOOLEAN;
*/

--  lecture 7 
/*
in this lecture we will study about the  date and  time type.
DATE:
you can provide    any type of date string  to DATE data type and it will store it .
it is very important to note that  the date data type only stores info aobut the day,month,year. any information about the time like hours mints and seconds are truncated.
INVALID FORMAT:
SELECT ('26-11-2000'::DATE);
VALID FORMATS:
SELECT ('nov-26-1999'::DATE);
SELECT ('NOV-26-2000'::DATE);
SELECT ('26-NOV-2000'::DATE);
SELECT ('11-26-2000'::DATE);
SELECT ('11,26,1999'::DATE);
SELECT ('NOV 26,1999'::DATE);
YOU CAN ALSO DO SUBTRACTION AND ADDITION WITH DATES
SELECT (' 23 NOV,2024'::DATE-'22 NOV,2024')
you can check the return typeof  the the expression using pg_typeof  function.
SELECT pg_typeof((' 23 NOV,2024'::DATE-'22 NOV,2024');)
TIME:
you can store  time in postgress with out time zoon. By default it stores time without any time zoon.  you can also specify AM and pm as well.
THE POSTGRESS USES 24 HOUR CLOCK. so dont add am and pm with them.
if you wanna store entire date use the timestamp data type.
it is very imimportant to note that Time data type does not stores date information it stores only time info like hours ,mints , and seconds and timezones .
SELECT ('12:12:12 AM'::TIME); WITH OUT TIME ZONE
this is simular
SELECT ('12:12:12 AM'::TIME WITHOUT TIME ZONE); 

SELECT ('13:13:13'::TIME);
SELECT ('01:30:30 PM'::TIME);
SELECT ('1:30:30 PM'::TIME);
YOU can also subtract from time 
suppose we want to calculate the  how many hours  each person spends at school. we can do it by subtractring the IN  time from out time.
SELECT('8:15:00 AM'::TIME) - ('1:30:00 PM'::TIME);

TIME WITH  TIME ZONE:
SELECT ('01:23:23 PM'::TIME WITH TIME ZONE);
store the time with default utc time zone.
you can also provide a different time zone.
SELECT('20:20:20 GMT'::TIME WITH TIME ZONE);
TIMESTAMP:
SELECT('26 NOV,1999 02:30:30 PM'::TIMESTAMP WITH TIME ZONE);
SELECT('NOV 18,2022'::TIMESTAMP);
INVALID TIMESTAMP:
SELECT('20:20:20'::TIMESTAMP);

--  lecture 8
/*
INTERVAL :
in this ledcture we will study about the interval data type.
/*
 the interval data type is mainly  use for   time durrations  like hours ,mints  ,  seconds ,  days etc.
 ITis important to note that you can either use "day", or "DAY" but whatever you use it is good practice to be consistant.
 SELECT('2 day')::INTERVAL;
 SELECT('2 hour')::INTERVAL;
 SELECT('2 minute')::INTERVAL;
 SELECT('2 second')::INTERVAL;
 you can also use the time durriations first letters instead of  writing the entire the word.
SELECT('1 D 22 H 19 M 3 ')::INTERVAL;
one of the unique feature of the interval data type that you can add or subtract time.
subtracting from the interval. -> returns a interval.
SELECT('8 H 20 M 30 S'::INTERVAL ) - ('30 M'::INTERVAL);
subtracting from timestamp. -> returns timestamp.
SELECT('sep 11,2021 13:53:20'::TIMESTAMP) - ('13 H'::INTERVAL);
subtracting from date data type. -> returns timestamp since the date data type doesnot include the time component.
SELECT('OCT 8,2024'::DATE ) - ('15 H'::INTERVAL);
subtracting from Time data type. -> returns time.
SELECT('8:03:00 AM'::TIME) - ('2 H'::INTERVAL);
it is very important to note that all the date and time data types allows addition and subtraction besides  interval.
 */