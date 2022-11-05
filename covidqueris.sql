select *
from novcovid
 where continent is not null

 -- looking a total cases vs population

select location, date, population, total_cases, total_deaths, (total_deaths/population)* 100 as DeathPercentage
from novcovid
where continent is not null
order by 1, 2


-- looking at countries infection rate and death rate compare to population using location
-- shows the likelihood of dying if you contract covid in portugal
--show population that got covid

select location, date, population, total_cases, total_deaths,
(total_cases/population)* 100 as CasesPercentage,
(total_deaths/population)* 100 as DeathPercentage
from novcovid
where location like '%portugal%' 
order by 2

-- for nigeria

select location, date, population, total_cases, total_deaths,
(total_cases/population)* 100 as CasesPercentage,
(total_deaths/population)* 100 as DeathPercentage
from novcovid
where location like '%nigeria%'
order by 2


--looking at countries with  highest infection rate vs population

select location, population, 
max(total_cases) as HighestInfecPop, 
max(total_cases/population)*100 as infectPop
from novcovid
where continent is not null
group by location, population
order by InfectPop desc

--countries with highest death count per population

select location, max(total_deaths) as Totaldeathcount
from novcovid
where continent is not null
group by location
order by Totaldeathcount desc

--breaking by continent

select continent,  max(total_deaths) as Totaldeathcount
from novcovid
where continent is not null
group by continent
order by Totaldeathcount desc

-- breaking by continent

select continent,  max(total_deaths) as Totaldeathcount
from novcovid
--where location like '%portugal%'
where continent is null
group by continent
order by Totaldeathcount desc


-- showing the continent with highest death count

select continent,  max(total_deaths) as Totaldeathcount
from novcovid
--where location like '%portugal%'
where continent is not null
group by continent
order by Totaldeathcount desc


-- global numbers

select location, date, total_cases, total_deaths
from novcovid
--where location like '%portugal%'
where continent is not null
group by location, date, total_cases, total_deaths
order by 1,2

--- using aggregate function

select location, date, sum(new_cases) as NewcasesDaily
from novcovid
--where location like '%portugal%'
where continent is not null
group by location, date, total_cases, total_deaths
order by 1,2

-- adding death

select  sum(cast(new_deaths as int)) as totalDailydeath, 
sum(cast(new_deaths as int))/sum(cast(new_cases as int))* 100 as DeathPercentage
from novcovid
--where location like '%portugal%'
where continent is not null
group by location, date, total_cases, total_deaths
order by 1,2

select *
from novcovid

--TO JOIN TWO TABLE

--select dea.continent, dea.location, dea.date, dea.population, vac.novvacination
--from novcovid dea
--join novvacine vac
--on dea.location = vac.location
--and dea.date = vac.location
--where dea.continent is not null
--order by 1,2,3

-- PARTIION
--select dea.continent, dea.location, dea.date, dea.population, vac.novvacine,
--sum(cast(vac.novvaccine as int)) ovrer (partition by dea.location)
--from novcovid dea
--join novvacine vac
--on dea.location = vac.location
--and dea.date = vac.location
--where dea.continent is not null
--order by 1,2,3

--select dea.continent, dea.location, dea.date, dea.population, vac.novvacine,
--sum(convert(int, novvaccine)) over (partition by dea.location order by dea.location, dea.date) as agreggatecountvaccination,
--from novcovid dea
--join novvacine vac
--on dea.location = vac.location
--and dea.date = vac.location
--where dea.continent is not null
--order by 1,2,3


--how many people vaccinated by population using cte since we cant use the new generated column

--with popvsvacc (continent, location, date, population, novvacine, agreggatecountvaccination)
--as 
--(

--select dea.continent, dea.location, dea.date, dea.population, vac.novvacine,
--sum(convert(int, novvaccine)) over (partition by dea.location order by dea.location, dea.date) as agreggatecountvaccination,
--from novcovid dea
--join novvacine vac
--on dea.location = vac.location
--and dea.date = vac.location
--where dea.continent is not null

)
--as  select *
--from popvsvacc



--runnnig the cte

