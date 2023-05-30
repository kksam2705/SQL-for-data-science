-- Module - C7084 Big Data and Decision Making
-- Id No - 22302900

-- BACKGROUND
-- This is a database of cars for sale on a German car website.
-- Each row is a car listing, each column is a feature of each listing.
-- With this database we are going to perform various operations using SQL commands.

-- DATABASE SETUP
-- In order to connect to our database we need to go to mqsql command line and enter the password.
-- After successful connection go to mysql work bench and create schema. Schema is defined has the
-- how our data organized within in a relational database(without schema we can't store data).it 
-- includes logical constraints such has table names, fields,data types, and the relationship between
-- these entities.

-- DATA IMPORT
-- Start by launching the MySQL Workbench programme on your PC. Make sure you've connected to the MySQL server you wish to use to import the data.
-- Choosing a Database Locate the "Navigator" panel on the left side of the screen, then select the "Schema" tab. The database where you wish to import the data should then be expanded.
-- Table Data Import Wizard in Access: Select with the right click the database table where you want to import the data. Go to the context menu and select "Table Data Import Wizard." 
-- By doing so, the import wizard will launch and walk you through the procedure.
-- Choose an import source. You'll be asked to select the data source in the import wizard. Data may be imported from a variety of sources.
-- such as from a clipboard, a CSV file, a SQL script, an Excel spreadsheet, etc. Depending on the format of your data, choose the relevant choice.
-- Configure Import parameters: You must adjust import parameters in accordance with the source you have selected. For instance, if you are importing data from a CSV file, you will need to indicate field separators and line terminators as well as the location of the file.
-- The columns from your source may need to be mapped to the relevant columns in the table if you are importing data into an already-existing table. This process makes sure that the data is inserted into the appropriate columns.-- Preview and Import Data: 
-- Following setting up the import parameters and column mapping, you will have the chance to examine the data before to import. Use this opportunity to check the data and make sure everything is as intended. If everything appears to be in order, import the goods.
-- Execute the Import: Click the "Import" button to start the data import procedure if you are pleased with the data preview. The relevant queries will be run by MySQL Workbench in order to put the data into the chosen table.
-- Verify Import Success: After the import is finished, MySQL Workbench will provide you a summary of what happened, along with the number of rows that were imported. The imported data may be manually verified to confirm that it is correct and present in the table.

-- DATABASE OPEARTIONS
-- SQL has various commands which each command is used to perform different opeartions.
-- SELECT - used to select data from database tables
-- UPDATE - used to update existing data in database tables
-- INSERT - used to insert new data in database tables
-- DELETE - used to delete existing data in database tables
-- DROP - used to drop data
-- ALTER - used to alter tables in database
-- MAX,MIN,AVG,COUNT,SUM - these are the aggreations commands in sql
-- PRIMARY KEY - it is unique value in table and must not be empty
-- FOREIGN KEY - build relationship between tables
-- CREATE DATABASE - used to create new database
-- CREATE TABLE - used to create new table
-- DISTINCT - used to retrun only different values
-- WHERE - used to filter records

-- CREATE DATABASE
create database c7084;

-- VIEW OUR DATABASE
select * from c7084.autos;

-- DROP UNWANTED COLUMNS
alter table c7084.autos
drop column  datecrawled,
drop column  datecreated,
drop column lastSeen,
drop column offertype;

-- CHECK THE COLUMNS IF DELETED OR NOT
select * from c7084.autos;
-- great it is deleted

select distinct price, brand
from c7084.autos;
-- Seeing the price of each brand(distinct function will not show the duplicate values)

-- use where function to filter records
select brand, fueltype
from c7084.autosv
where fueltype = 'benzin'
order by brand;
-- checking which brand runs in benzin fuel

-- Check the which brand runs on automatic
select brand,kilometer,fueltype,gearbox 
from c7084.autos
where gearbox = 'automatic';

-- Check the which brand runs on manual
select brand, kilometer, gearbox
from c7084.autos
where gearbox = 'manual';

-- CHECK NOT NULL VALUES
select brand, price
from c7084.autos
where price is not null;

-- CHECK WHICH BRAND NOT DAMAGED WITH PRICE AND KILOMETER
select brand, kilometer, price, damage
from c7084.autos
where damage = 'no'
order by brand;
-- with this query i can make decision which vehicle i can buy based kilometer, price and with no damage

-- CHECK damaged vehicle
select brand, kilometer, price,damage
from c7084.autos
where damage = 'yes'
order by price;
-- with this query i can aviod buying damaged vehicle
-- well some brand has zero price so i can buy for free and i can repair them

-- USE OF WILD CARDS
select * from c7084.autos
where brand like '%aud%';
-- selecting  brand name that starts with aud

select * from c7084.autos 
where brand like 'a%';
-- selecting the brand that starts with name a 

select * from c7084.autos
where postalcode like '%0';
-- selecting postal code that ends with zero

-- USE IN COMMAND TO SPECIFY MULTIPLE VALUES WHEN USING WHERE COMMAND
select price,gearbox,powerps,damage, yearofregistration
 from c7084.autos
where yearofregistration in (2015, 2016, 2017, 2018);
-- Checking the recent year registration of vechicle

-- USE BETWEEN COMMAND TO SELECT VALUES WITHIN THE RANGE
select brand, damage, price
from c7084.autos
where price between 1000 and 2000
order by brand;

select gearbox, brand, fueltype, price
from c7084.autos
where price between 2000 and 3000
and brand not in  ('bmw');
-- retrieve all brand name except bmw


select brand, gearbox,  price, kilometer
from c7084.autos
where kilometer in(10000, 5000,6000,8000);

-- ALIAS
select powerps as horsepower
from c7084.autos;
-- i named powerps as horsepower for temporarily  

-- UNIONS
select yearofregistration from c7084.autos
union all
select monthofregistration from c7084.autos;  
-- i have joined year and month of registration column

-- USE OF MAXIMUM FUNCTION
select max(kilometer) as maximumkilometers
from c7084.autos;
-- so the maximunm kilometer is 150000

-- USE OF MINIMUM FUNCTION
select min(price) as minimumprice
from c7084.autos;

-- USE OF COUNT,SUM,AVG COMMAND
select avg(price)
from c7084.autos;
-- the average price is 5874.0164

select count(price) 
from c7084.autos;
-- total count in price is 3602

select sum(price)
from c7084.autos;
-- total price of all cars is 21158207

-- USE OF AND OR COMMAND
select * from c7084.autos
where powerps = 100 or price = 500;

select * from c7084.autos
where price = 1000 and brand = 'bmw' and  powerps = 150;

-- USE OF limit COMMAND
select * from c7084.autos
limit 3;

-- USE OF  NULL COMMAND
select price, brand, damage
from c7084.autos
where damage is not null;

select price, brand, kilometer, powerps, fueltype
from c7084.autos
where brand is null;

-- USE OF ALL COMMAND
select all brand,price, kilometer
from c7084.autos
where price > 3000 and kilometer <10000
order by brand;

-- USE OF ASCENDING AND DESCENDING COMMAND
select price, brand, kilometer, powerps, fueltype
from c7084.autos
order by price desc;

select price, brand, kilometer, powerps, fueltype, yearofregistration
from c7084.autos
order by kilometer asc;



-- SUMMARY

-- The resulting automotive database is useful in terms of information delivery and decision support for the selling of cars.
--  Users can get data using a variety of filters, including brand, fuel type, gearbox type, price range, distance in kilometres, and damage status. 
-- The database offers insights into car listings, including information on the make, model, cost, mileage, horsepower, registration year, and more.

-- Data retrieval: Users can utilise the database to discover specific information based on their needs, such as cars of a given brand, in a specific price range, 
-- or with particular attributes like an automatic transmission or no damage.

-- Making decisions: The database can assist users in making well-informed decisions about buying automobiles based on their preferences and limits by giving data on car listings, 
-- including prices, kilometres, and damage status.

-- Analysis and aggregation: The database has aggregation options like MAX, MIN, AVG, COUNT, and SUM that let users compute statistics and discover information about the data, like the average cost or the total number of cars.

-- Flexibility: The database provides for record filtering and sorting based on a variety of criteria, allowing for flexibility in data exploration and adapting the outcomes to particular requirements.

-- But there are some restrictions to take into account:

-- Only information on car listings on a German auto website is included in the database, which has a limited scope. It may not incorporate information from other sources or cover all car models, 
-- which would restrict its comprehensiveness and usefulness.
-- Accuracy and dependability of the data are influenced by the source and the fairness of the data collection procedure. It's crucial to make sure the data is reliable and current before making decisions.
-- lacking historical information The database might not have historical information on car listings, which makes it harder to spot trends or changes over time.
-- No user reviews: The database does not contain user reviews or ratings, which can be useful information for making decisions.
-- Overall, the database's ability to retrieve data, help decision-making, and perform simple analyses makes it useful. When using the database for decision-making, 
-- it's crucial to take into account the restrictions in terms of scope, data accuracy, historical data, and the absence of user feedback.


