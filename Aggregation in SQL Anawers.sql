SHOW DATABASES; 
USE world;
---Question 1 --
select countrycode, count(*) AS totalcities
from city
group by countrycode;

---Question 2--
SELECT Continent, COUNT(*) AS TotalCountries
FROM Country
GROUP BY Continent
HAVING COUNT(*) > 30;

---Question 3--
SELECT Region, SUM(Population) AS TotalPopulation
FROM Country
GROUP BY Region
HAVING SUM(Population) > 200000000;

---Question 4--
SELECT Continent, AVG(GNP) AS AvgGNP
FROM Country
GROUP BY Continent
ORDER BY AvgGNP DESC
LIMIT 5;

---Question 5--
SELECT c.Continent, COUNT(cl.Language) AS TotalLanguages
FROM Country c
JOIN CountryLanguage cl
ON c.Code = cl.CountryCode
WHERE cl.IsOfficial = 'T'
GROUP BY c.Continent;

--Question 6--
SELECT Continent,
       MAX(GNP) AS MaxGNP,
       MIN(GNP) AS MinGNP
FROM Country
GROUP BY Continent;

--Question 7--
SELECT c.Name, AVG(ci.Population) AS AvgCityPopulation
FROM Country c
JOIN City ci
ON c.Code = ci.CountryCode
GROUP BY c.Name
ORDER BY AvgCityPopulation DESC
LIMIT 1;

--Question 8--
SELECT c.Continent, AVG(ci.Population) AS AvgCityPopulation
FROM Country c
JOIN City ci
ON c.Code = ci.CountryCode
GROUP BY c.Continent
HAVING AVG(ci.Population) > 200000;

--Question 9--
SELECT Continent,
       SUM(Population) AS TotalPopulation,
       AVG(LifeExpectancy) AS AvgLifeExpectancy
FROM Country
GROUP BY Continent
ORDER BY AvgLifeExpectancy DESC;

--Question 10--
SELECT Continent,
       AVG(LifeExpectancy) AS AvgLifeExpectancy,
       SUM(Population) AS TotalPopulation
FROM Country
GROUP BY Continent
HAVING SUM(Population) > 200000000
ORDER BY AvgLifeExpectancy DESC
LIMIT 3;




