SELECT *
FROM PortfolioCovidProject..novcovid
WHERE continent IS NOT NULL;

 -- looking a total cases vs population

SELECT location, date, population, total_cases, total_deaths, (total_deaths/population)* 100 AS DeathPercentage
FROM PortfolioCovidProject..novcovid
WHERE continent IS NOT NULL
ORDER BY 1, 2;


-- looking at countries infection rate and death rate compare to population using location
-- shows the likelihood of dying if you contract covid in portugal
--show population that got covid


-- for Portugal 

SELECT location, date, population, total_cases, total_deaths,
(total_cases/population)* 100 AS CasesPercentage,
(total_deaths/population)* 100 AS DeathPercentage
FROM PortfolioCovidProject..novcovid
WHERE location LIKE '%portugal%' 
ORDER BY 2;

-- for Nigeria

SELECT location, date, population, total_cases, total_deaths,
(total_cases/population)* 100 AS CasesPercentage,
(total_deaths/population)* 100 AS DeathPercentage
FROM PortfolioCovidProject..novcovid
WHERE location like '%nigeria%'
ORDER BY 2;


--Countries with  highest infection rate vs population

SELECT location, population, 
MAX(total_cases) AS HighestInfecPop, 
MAX(total_cases/population)*100 AS infectPopPercentage
FROM PortfolioCovidProject..novcovid
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY infectPopPercentage DESC;

--countries with highest death count per population

SELECT location, MAX(total_deaths) AS Totaldeathcount
FROM PortfolioCovidProject..novcovid
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY Totaldeathcount DESC;

--BREAKING DOWN BY CONTINENTS

SELECT continent,  MAX(total_deaths) AS Totaldeathcount
FROM PortfolioCovidProject..novcovid
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY Totaldeathcount DESC;

-- For data with null continent

SELECT continent,  MAX(total_deaths) AS Totaldeathcount
FROM PortfolioCovidProject..novcovid
--WHERE location LIKE '%portugal%'
WHERE continent IS NULL
GROUP BY continent
ORDER BY Totaldeathcount DESC;


--Continent with highest death count

SELECT continent,  MAX(total_deaths) AS Totaldeathcount
FROM PortfolioCovidProject..novcovid
--WHERE location LIKE '%portugal%'
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY Totaldeathcount DESC;


-- global numbers

SELECT location, date, total_cases, total_deaths
FROM PortfolioCovidProject..novcovid
--WHERE location LIKE '%portugal%'
WHERE continent IS NOT NULL
GROUP BY location, date, total_cases, total_deaths
ORDER BY 1,2;

--- using aggregate function

SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS INT)) AS Total_deaths, SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 AS Deathpercentage
FROM PortfolioCovidProject..novcovid
WHERE location LIKE '%portugal%' AND continent IS NOT NULL
ORDER BY 1,2;

SELECT *
FROM PortfolioCovidProject..novvaccine;

--TO JOIN TWO TABLE

-- total population vs vaccinations
-- shows percentage of population that has recieved at least one covid vaccine

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(BIGINT,vac.new_vaccinations)) OVER (PARTITION BY dea.location order by dea.location, dea.date) AS rollingpeoplevaccinated
--, (rollingpeoplevaccinated/population)*100
FROM PortfolioCovidProject..novcovid dea
JOIN PortfolioCovidProject..novvaccine vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3;

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS BIGINT)) OVER (PARTITION BY dea.location)
FROM PortfolioCovidProject..novcovid dea
JOIN PortfolioCovidProject..novvaccine vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 1,2,3;

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(BIGINT, new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS agreggatecountvaccination
FROM PortfolioCovidProject..novcovid dea
JOIN PortfolioCovidProject..novvaccine vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 1,2,3;


--HOW MANY PEOPLE VACINATED BY POPULATION USING CTE SINCE WE CANNOT USE THE NEW GENERATED COLUMN

WITH popvsvacc (continent, location, date, population, new_vaccinations, rollingpeoplevaccinated)
AS 
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(BIGINT, new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS agreggatecountvaccination
FROM PortfolioCovidProject..novcovid dea
JOIN PortfolioCovidProject..novvaccine vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3
)
SELECT *, (rollingpeoplevaccinated/population)*100
FROM popvsvacc


--USING TEMP TABLE TO PERFORM CALCULATION ON PARTITION BY IN PREVIOUS QUERY

DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
continent NVARCHAR(255),
location NVARCHAR(255),
date DATETIME,
population NUMERIC,
new_vaccinations NUMERIC,
rollingpeoplvaccinated NUMERIC
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(BIGINT,vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rollingpeoplevaccinated
--, (rollingpeoplvaccinated/population)*100
FROM PortfolioCovidProject..novcovid dea
JOIN PortfolioCovidProject..novvaccine vac
	ON dea.location = vac.location
	and dea.date = vac.date
--WHERE dea.continent IS NOT NULL
--ORDER BY 2,3;


SELECT *, (rollingpeoplevaccinated/population)*100  /**look again**/
FROM #PercentPopulationVaccinated;

SELECT *
FROM #PercentPopulationVaccinated;



-- creating view to store data for a later visualization

CREATE VIEW PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(BIGINT, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rollingpeoplevaccinated
--, (rollingpeoplevaccinated/population)*100
FROM PortfolioCovidProject..novcovid dea
JOIN PortfolioCovidProject..novvaccine vac
	 ON dea.location = vac.location
	 AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;

