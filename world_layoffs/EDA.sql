SELECT MAX(total_laid_off),MAX(percentage_laid_off)
FROM layoffs_staging2;

-- layoff distrribution of companies
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY SUM(total_laid_off) DESC;

-- duration of the dataset
SELECT MAX(`date`), MIN(`date`)
FROM layoffs_staging2;

-- layoff distrribution of industries
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY SUM(total_laid_off) DESC;

-- layoff distrribution of countries
SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY SUM(total_laid_off) DESC;

-- layoffs by year
SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY YEAR(`date`) DESC;

-- layoffs by year-month
SELECT DATE_FORMAT(`date`,'%Y-%m') AS Month, SUM(total_laid_off)
FROM layoffs_staging2
WHERE DATE_FORMAT(`date`,'%Y-%m') IS NOT NULL
GROUP BY DATE_FORMAT(`date`,'%Y-%m')
ORDER BY DATE_FORMAT(`date`,'%Y-%m') ASC;

-- running total of layoffs by year-month
WITH Rolling_Total AS (
    SELECT DATE_FORMAT(`date`,'%Y-%m') AS Month, SUM(total_laid_off) AS Total_Laid_Off
    FROM layoffs_staging2
    WHERE DATE_FORMAT(`date`,'%Y-%m') IS NOT NULL
    GROUP BY DATE_FORMAT(`date`,'%Y-%m')
    ORDER BY DATE_FORMAT(`date`,'%Y-%m') ASC)
SELECT Month, Total_Laid_Off,SUM(Total_Laid_Off) OVER (ORDER BY Month ASC) AS Running_Total
FROM Running_Total;


SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)

-- top 5 companies with highest layoffs by year
WITH Company_Year(company, years, total_laid_off) AS(
    SELECT company, YEAR(`date`), SUM(total_laid_off)
    FROM layoffs_staging2
    GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS(
SELECT *, DENSE_RANK() OVER (
    PARTITION BY years
    ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 5;