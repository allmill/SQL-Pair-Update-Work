-- Write queries to return the following:
-- The following queries utilize the "world" database.

-- 1. The city name, country name, and city population of all cities in Europe with population greater than 1 million
-- (36 rows)
select city.name as CityName, country.name as CountryName, city.population from city
join country on city.countrycode = country.code
where continent = 'Europe' and city.population > 1000000

-- 2. The city name, country name, and city population of all cities in countries where French is an official language and the city population is greater than 1 million
-- (2 rows)
select city.name as CityName, country.name as CountryName, city.population from city
join country on city.countrycode = country.code
join countrylanguage on country.code = countrylanguage.countrycode
where city.population > 1000000 and language = 'French' and isofficial = 1

-- 3. The name of the countries and continents where the language Javanese is spoken
-- (1 row)
select country.name, country.continent from country
join countrylanguage on country.code = countrylanguage.countrycode
where language = 'Javanese'
group by country.name, country.continent

-- 4. The names of all of the countries in Africa that speak French as an official language
-- (5 row)
select country.name from country
join countrylanguage on country.code = countrylanguage.countrycode
where continent = 'Africa' and language = 'French' and isofficial = 1

-- 5. The average city population of cities in Europe
-- (average city population in Europe: 287,684)
select avg(city.population) as AvgCityPop from city
join country on city.countrycode = country.code
where continent = 'Europe'
-- 6. The average city population of cities in Asia
-- (average city population in Asia: 395,019)
select avg(city.population) as AvgCityPop from city
join country on city.countrycode = country.code
where continent = 'Asia'
-- 7. The number of cities in countries where English is an official language
-- (number of cities where English is official language: 523)
select count(city.name) from city
join countrylanguage on city.countrycode = countrylanguage.countrycode
where language = 'English' and isofficial = 1

-- 8. The average population of cities in countries where the official language is English
-- (average population of cities where English is official language: 285,809)
select avg(city.population) from city
join countrylanguage on city.countrycode = countrylanguage.countrycode
where language = 'English' and isofficial = 1

-- 9. The names of all of the continents and the population of the continent’s largest city
-- (6 rows, largest population for North America: 8,591,309)
select country.continent, max(city.population) as MaxPop from city
join country on city.countrycode = country.code
group by continent 
order by MaxPop desc

-- 10. The names of all of the cities in South America that have a population of more than 1 million people and the official language of each city’s country
-- (29 rows)

select city.name, countrylanguage.language from city
join country on city.countrycode = country.code
join countrylanguage on city.countrycode = countrylanguage.countrycode
where country.continent = 'South America' and city.population > 1000000 and isofficial = 1


