-- create database
DROP DATABASE IF EXISTS world_layoffs
CREATE DATABASE world_layoffs

-- create table
DROP TABLE IF EXISTS layoffs;
CREATE TABLE layoffs(
company varchar(20),
location varchar(20),
industry varchar(20),
total_laid_off INT,
percentage_laid_off FLOAT,
date varchar(15),
stage varchar(10),
country varchar(20),
funds_raised_millions INT 
);

-- load data
/*
LOAD DATA INFILE './layoffs.csv'
INTO TABLE layoffs
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SHOW GLOBAL VARIABLES LIKE '%secure%';

載入資料過程碰到 --secure-file-priv無法變更(找不到my.cnf，由mysql workbench產生檔案後仍載入失敗)、
從mysql workbench載入csv時無法完整載入，最後將csv轉為json檔並由mysql workbench載入成功
*/