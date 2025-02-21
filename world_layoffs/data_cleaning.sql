-- make a copy and keep the raw data
CREATE TABLE layoffs_staging
SELECT * FROM layoffs;

-- remove duplicates
WITH duplicate_cte AS(
    SELECT *, ROW_NUMBER() OVER(
        PARTITION BY company,location, industry, total_laid_off, percentage_laid_off, `date`, stage, country,funds_raised_millions) AS row_num
    FROM layoffs_staging)
-- row_num > 1 表示有重複
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

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

INSERT INTO layoffs_staging2
SELECT *, ROW_NUMBER() OVER(
    PARTITION BY company,location, industry, total_laid_off, percentage_laid_off, `date`, stage, country,funds_raised_millions) AS row_num
FROM layoffs_staging;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;

-- standardize the data

-- company
SELECT company, TRIM(company)
FROM layoffs_staging2;

-- 使用這個指令需先關閉safe update mode, 允許沒有WHERE clause的UPDATE / DELETE statement
UPDATE layoffs_staging2
SET company = TRIM(company);

-- industry
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1; -- there's Crypto/Crypto Currency/CryptoCurrency

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- country
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1; -- there's United States / United States.

UPDATE layoffs_staging2
SET country = 'United States'
WHERE country LIKE 'United States%';

-- date
-- convert TEXT 'NULL' to NULL value
UPDATE layoffs_staging2
SET `date` = NULL
WHERE `date` = 'NULL';

-- change format
SELECT `date`, STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

-- modify data type
SHOW FIELDS FROM layoffs_staging2; -- date was TEXT
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- null / blank values
-- replace blank / 'NULL' with NULL value in industry
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = 'NULL' OR industry = '';

-- fill NULL in industry with the same company
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

-- relpace 0 with NULL in total_laid_off for companies did lay off
UPDATE layoffs_staging2
SET percentage_laid_off = NULL
WHERE percentage_laid_off = 'NULL' OR percentage_laid_off = '';

ALTER TABLE layoffs_staging2
MODIFY COLUMN percentage_laid_off FLOAT;

UPDATE layoffs_staging2
SET total_laid_off = NULL
WHERE total_laid_off = 0 AND percentage_laid_off != 0;

-- remove unnecessary column
DELETE
FROM layoffs_staging2
WHERE total_laid_off = 0 AND percentage_laid_off IS NULL;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;