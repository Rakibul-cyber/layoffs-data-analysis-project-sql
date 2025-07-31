-- Data Cleaning

/* we creat a table for our analysis*/
create Table layoffs_staging
LIKE layoffs;

-- 1. Removing Duplicates
-- 2. Standardize
-- 3. Null Values or blank values
-- 4. Remove Any Colums or rowa

SELECT *,
row_number () OVER (
partition by company,location,industry,total_laid_off,percentage_laid_off,'data',stage,country,funds_raised_millions) as row_num

FROM layoffs_staging;
/* we are creating a duplicate because we can not work with row data and orginal data set that why we careated a copy */
with duplicate_cte as
(select*,
row_number () OVER (
partition by company,location,industry,total_laid_off,percentage_laid_off,'data',stage,country,funds_raised_millions) as row_num
FROM layoffs_staging
)

select *
from duplicate_cte
where row_num >1;

select *
from layoffs_staging
where company = 'Casper';


/* Becially we are craeting this duplicate table to delete our duplicate data, here we input an extra row which is row_num */
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



select *
From layoffs_staging2
where row_num >1;

insert INTO layoffs_staging2
select *,
row_number() over(
partition by company, location,
industry, total_laid_off, percentage_laid_off, Country, funds_raised_millions) As row_num
FROM layoffs_staging;

delete
From layoffs_staging2
Where row_num > 1;

select *
From layoffs_staging2;

-- Standardizing

select company, trim(company)
from layoffs_staging2;

Update layoffs_staging2
set company = TRIM(company);

select distinct industry
from layoffs_staging2;


select *
from layoffs_staging2
WHERE industry LIKE 'Crypto';


update layoffs_staging2
set industry = 'crypto'
where industry LIKE 'crypto%'; 

select distinct country
from layoffs_staging2
Where country like 'United States%';

Select distinct country = Trim(trailing '.' FROM country)
where country like 'united states%';

update layoffs_staging2
SET country = trim(Trailing '.' from country)
Where country LIKE 'United states%';

select *
from layoffs_staging2;


Select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');
alter Table layoffs_staging2
modify column `date`DATE;

SELECT*
FROM layoffs_staging2
Where total_laid_off is null
AND percentage_laid_off Is Null;

delete
FROM layoffs_staging2
Where total_laid_off is null
AND percentage_laid_off Is Null;

SELECT*
FROM layoffs_staging2;

update layoffs_staging2
set industry = null
where industry = '';

Select *
from layoffs_staging2
Where industry is null
or industry = '' ;

select *
from layoffs_staging2
WHere company = 'Airbnb';

select *
from layoffs_staging2 t1
join layoffs_staging2 t2
     on t1.company = t2.company
where (t1.industry IS NULL OR t1.industry = '')
 AND t2.industry IS NOT NULL;   


Update layoffs_staging2 t1
Join layoffs_staging2 t2
	 on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null
And t2.industry is not null;

alter table layoffs_staging2
drop column row_num;

SELECT*
FROM layoffs_staging2;
