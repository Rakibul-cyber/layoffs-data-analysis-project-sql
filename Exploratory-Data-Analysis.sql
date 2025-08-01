-- Exploratory Data Analysis

select*
from layoffs_staging2;



select MAX(total_laid_off), max(percentage_laid_off)
from layoffs_staging2;

select*
from layoffs_staging2
where percentage_laid_off = 1
order by total_laid_off DESC;

select*
from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions DESC;


select company, SUM(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select MIN(`date`), MAX(`date`)
from layoffs_staging2;

select industry, SUM(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc;

select country, SUM(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

select `date`, SUM(total_laid_off)
from layoffs_staging2
group by `date`
order by 2 desc;

select `date`, SUM(total_laid_off)
from layoffs_staging2
group by `date`
order by 1 desc;

select year(`date`), SUM(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 1 desc;

select year(`date`), SUM(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 1 desc;

select stage, SUM(total_laid_off)
from layoffs_staging2
group by stage
order by 2 desc;

select company, SUM(percentage_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select company, avg(percentage_laid_off)
from layoffs_staging2
group by company
order by 2 desc;


select substring(`date`,6,2) As `Month`
from layoffs_staging2;


select substring(`date`,6,2) As `Month`, sum(total_laid_off)
from layoffs_staging2
group by `month`;

select substring(`date`,1,7) As `Month`, sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by 1 ASC;


with Rolling_Total As
(
select substring(`date`,1,7) As `Month`, sum(total_laid_off) As total_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by 1 ASC
)
select `Month`,total_off, SUM(total_off)
Over(order by`Month`) As rolling_total
FROM Rolling_Total;


select company, SUM(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select company, YEAR(`date`), SUM(total_laid_off)
from layoffs_staging2
group by company,YEAR(`date`)
order by company ASC;

select company, YEAR(`date`), SUM(total_laid_off)
from layoffs_staging2
group by company,YEAR(`date`)
order by 3 DESC;


With Company_year (company, years, total_laid_off) AS
(
select company, YEAR(`date`), SUM(total_laid_off)
from layoffs_staging2
group by company,YEAR(`date`)
)
select *, 
dense_rank() OVER (partition by years order by total_laid_off DESC) As Ranking
FROM company_year
where years is not null
order by Ranking ASC;

With Company_year (company, years, total_laid_off) AS
(
select company, YEAR(`date`), SUM(total_laid_off)
from layoffs_staging2
group by company,YEAR(`date`)
), company_year_Rank As
(select *, 
dense_rank() OVER (partition by years order by total_laid_off DESC) As Ranking
FROM company_year
where years is not null
)
select *
from Company_year_Rank
where Ranking <= 5;


