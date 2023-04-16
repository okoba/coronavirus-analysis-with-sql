select * 
from [Portfolio project].dbo.[covid death sheet]
order by 3,4 

select * 
from [Portfolio project].[dbo].[covid vacc]
order by 3,4 

select location, date, total_cases,new_cases, total_deaths, population
from [Portfolio project].dbo.[covid death sheet]


--What is the total number of confirmed COVID-19 cases in SOUTH america ?

SELECT SUM(total_cases) AS total_confirmed_cases
from [Portfolio project].dbo.[covid death sheet]
WHERE continent = 'south america';


--The tables was imported as a varchar data type so it has to be changed to bigint data type, it had to be altered to give the right output 
--the query for altering the table is below

ALTER TABLe [Portfolio project].dbo.[covid death sheet]

ALTER COLUMN total_cases BIGINT; 

--What is the total number of COVID-19 cases reported in Nigeria? 

SELECT SUM(total_cases) AS total_cases
from [Portfolio project].dbo.[covid death sheet]
WHERE location ='Nigeria';




--What is the trend of COVID-19 cases over time (e.g., daily and year) in a particular Asia/China?

-- Query to get the trend of COVID-19 cases over time in a particular Asia/China

-- Set parameters for continent/locatio and date part for time interval
DECLARE @continent VARCHAR(50) = 'Asia'; 
DECLARE @location VARCHAR(50) = 'China'; 
DECLARE @DatePart VARCHAR(10) = 'DAY'; 

-- Get the COVID-19 cases data for the specified region/country and time interval
SELECT
    DATEPART(YEAR, [date]) AS Year,
    DATEPART(DAYOFYEAR, [date]) AS TimeInterval,
    SUM(total_cases) AS TotalCases
FROM
    [Portfolio project].dbo.[covid death sheet]
WHERE
    continent = 'ASIA'
    AND location= 'china'
GROUP BY
    DATEPART(YEAR, [date]),
    DATEPART(DAYOFYEAR, [date])
ORDER BY
    Year, TimeInterval;



	--What are the most affected countries by COVID-19 in terms of total cases and deaths

	SELECT location, SUM(total_cases) AS total_cases, SUM(total_deaths) AS total_deaths
FROM     [Portfolio project].dbo.[covid death sheet]
GROUP BY location
ORDER BY total_cases DESC, total_deaths DESC


--how many patients with Covid-19 where diabetic in European/Asia based on their countries?

SELECT 
    [diabetes_prevalence],
    COUNT(*) AS total_occurrences, [location]
      FROM [Portfolio project].[dbo].[CovidVaccinations]
WHERE 
    continent IN ('Europe', 'Asia')
GROUP BY 
    [diabetes_prevalence],[location]
ORDER BY 
    total_occurrences DESC;



	--What are the testing trends for COVID-19 (e.g., number of tests conducted, test positivity rate) in a particular Europe and south america?




	-- Query to extract COVID-19 testing trends in Europe and South America


SELECT continent, Date, [total_tests], [positive_rate]
FROM [Portfolio project].[dbo].[CovidVaccinations]
WHERE continent IN ('europe', 'South America', 'africa');




-- Example query to change data type of total_doses_administered column to INT
ALTER TABLE [Portfolio project].[dbo].[CovidVaccinations]
ALTER COLUMN [total_vaccinations] INT;


--What are the vaccination rates (e.g., total doses administered, percentage of population vaccinated) for COVID-19 in europe?

--query to change data type of total_doses_administered column to INT
ALTER TABLE [Portfolio project].[dbo].[CovidVaccinations]
ALTER COLUMN [total_vaccinations] INT;


	
    SELECT 
    continent, 
    SUM(CAST(total_vaccinations AS bigint)) AS total_doses_administered, 
    CAST(SUM(CAST(total_vaccinations AS bigint)) AS decimal(18,2)) / SUM(CAST(total_tests AS bigint)) * 100 AS percentage_population_vaccinated 
FROM 
    [Portfolio project].[dbo].[CovidVaccinations]
WHERE 
    continent = 'europe'
GROUP BY
    continent;



	
	  --What are the impacts of COVID-19 on gdp and poverty in Africa and south America

	  SELECT 
    location,
    Continent, 
    [gdp_per_capita]
      ,[extreme_poverty]
FROM 
        [Portfolio project].[dbo].[CovidVaccinations]

WHERE 
    Continent IN ('Africa', 'South America')


	--looking at total population vs vaccinations in North America

	select a.continent, b.location, b.date, b.population, a. new_vaccinations
from         [Portfolio project].[dbo].[CovidVaccinations] a
join [Portfolio project].dbo.[covid death sheet] b
on b.location = a.location
and a.date = b.date
where a.continent = 'north america'
order by 1,2,3 Asc







