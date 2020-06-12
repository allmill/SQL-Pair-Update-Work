-- Write queries to return the following:
-- Make the following changes in the "world" database.

-- 1. Add Superman's hometown, Smallville, Kansas to the city table. The 
-- countrycode is 'USA', and population of 45001. (Yes, I looked it up on 
-- Wikipedia.)
--select * from city where name = 'Smallville'
insert into city (name, countrycode, district, population)
values ('Smallville', 'USA', 'Kansas', 45001)
-- 2. Add Kryptonese to the countrylanguage table. Kryptonese is spoken by 0.0001
-- percentage of the 'USA' population.
--select * from countrylanguage where language = 'Kryptonese'
insert into countrylanguage (countrycode, language, isofficial, percentage)
values ('USA','Kryptonese', 0, 0.0001)
-- 3. After heated debate, "Kryptonese" was renamed to "Krypto-babble", change 
-- the appropriate record accordingly.
--select * from countrylanguage where language = 'Krypto-babble'
update countrylanguage set language = 'Krypto-babble'
where countrycode = 'USA' and language = 'Kryptonese'
-- 4. Set the US captial to Smallville, Kansas in the country table.
--select * from country where code = 'USA'
--select * from city where name = 'Smallville'
update country set capital = (select id from city where name = 'Smallville')
-- 5. Delete Smallville, Kansas from the city table. (Did it succeed? Why?)
delete from city where id = (select id from city where name = 'Smallville' and countrycode = 'USA')
--Did not succeed, as it is referenced in World.db/country table, and in column capital.
-- 6. Return the US captial to Washington.
update country set capital = (select id from city where name = 'Washington' and district = 'District of Columbia')
where code = 'USA' 
-- 7. Delete Smallville, Kansas from the city table. (Did it succeed? Why?)
delete from city where name = 'Smallville' and countrycode = 'USA'
--Yes, because nothing was referenced to Smallville.

-- 8. Reverse the "is the official language" setting for all languages where the
-- country's year of independence is within the range of 1800 and 1972 
-- (exclusive). 
-- (590 rows affected)
update countrylanguage set isofficial = ~isofficial
where countrycode in (select code from country where indepyear between '1800' and '1972')

-- 9. Convert population so it is expressed in 1,000s for all cities. (Round to
-- the nearest integer value greater than 0.)
-- (4079 rows affected)
update city set population = round(population/1000,3)

-- 10. Assuming a country's surfacearea is expressed in square miles, convert it to 
-- square meters for all countries where French is spoken by more than 20% of the 
-- population.
-- (7 rows affected)

update country set surfacearea = surfacearea*1609.344
where code in (select countrycode from countrylanguage where language = 'French' and percentage > 20.0)

