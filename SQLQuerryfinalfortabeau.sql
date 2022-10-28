


Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PorfolioProject..CovidDeaths
--Where location like '%Poland%'
where continent is not null 
--Group By date
order by 1,2


-- numbers are extremely close so we will keep them - The Second includes "International"  Location


--Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
--From PortfolioProject..CovidDeaths
--Where location like '%poland%'
--where location = 'World'
--Group By date
--order by 1,2


-- 2. 


-- European Union is part of Europe

Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From PorfolioProject..CovidDeaths
--Where location like '%poland%'
Where continent is null 
and location not in ('World', 'European Union', 'International', 'Lower middle income', 'Upper middle income', 'High income', 'Low income', 'Oceania')
Group by location
order by TotalDeathCount desc


-- 3.

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PorfolioProject..CovidDeaths
--Where location like '%poland%'
Group by Location, Population
order by PercentPopulationInfected desc


-- 4.


Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PorfolioProject..CovidDeaths
--Where location like '%poland%'
Group by Location, Population, date
order by PercentPopulationInfected desc
