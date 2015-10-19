-- Note: Please consult the directions for this assignment 
-- for the most explanatory version of each question.

-- 1. Select all columns for all brands in the Brands table.

SELECT * FROM Brands;

-- 2. Select all columns for all car models made by Pontiac in the Models table.

SELECT * FROM Models WHERE brand_name = "Pontiac";

-- 3. Select the brand name and model 
--    name for all models made in 1964 from the Models table.

SELECT brand_name,name FROM Models WHERE year = 1964;

-- 4. Select the model name, brand name, and headquarters for the Ford Mustang 
--    from the Models and Brands tables.

SELECT Models.name,brand_name, headquarters FROM Models JOIN Brands ON 
Models.brand_name = Brands.name WHERE Models.name = "Mustang" AND Brands.name = "Ford";

-- 5. Select all rows for the three oldest brands 
--    from the Brands table (Hint: you can use LIMIT and ORDER BY).

SELECT *  FROM Brands ORDER BY founded LIMIT 3;

-- 6. Count the Ford models in the database (output should be a number).

SELECT COUNT(*) FROM Models JOIN Brands ON Models.brand_name = Brands.name 
WHERE Brands.name = "Ford"; 

-- 7. Select the name of any and all car brands that are not discontinued.

SELECT name FROM Brands WHERE discontinued IS NULL;

-- 8. Select rows 15-25 of the DB in alphabetical order by model name.

SELECT * FROM Models JOIN Brands ON Models.brand_name = Brands.name 
ORDER BY Models.name LIMIT 20;

-- 9. Select the brand, name, and year the model's brand was 
--    founded for all of the models from 1960. Include row(s)
--    for model(s) even if its brand is not in the Brands table.
--    (The year the brand was founded should be NULL if 
--    the brand is not in the Brands table.)

SELECT brand_name, Models.name, founded FROM Models JOIN Brands 
ON Models.brand_name = Brands.name WHERE year = 1960;

-- Part 2: Change the following queries according to the specifications. 
-- Include the answers to the follow up questions in a comment below your
-- query.

-- 1. Modify this query so it shows all brands that are not discontinued
-- regardless of whether they have any models in the models table.
-- before:
    -- SELECT b.name,
    --        b.founded,
    --        m.name
    -- FROM Model AS m
    --   LEFT JOIN brands AS b
    --     ON b.name = m.brand_name
    -- WHERE b.discontinued IS NULL;

SELECT b.name,b.founded, m.name FROM Brands AS b LEFT JOIN Models AS m 
on b.name = m.brand_name WHERE b.discontinued IS NULL;

-- 2. Modify this left join so it only selects models that have brands in the Brands table.
-- before: 
    -- SELECT m.name,
    --        m.brand_name,
    --        b.founded
    -- FROM Models AS m
    --   LEFT JOIN Brands AS b
    --     ON b.name = m.brand_name;

SELECT m.name, m.brand_name, b.founded FROM Models AS m LEFT JOIN Brands AS b ON
b.name = m.brand_name WHERE b.name IS NOT NULL;

-- followup question: In your own words, describe the difference between 
-- left joins and inner joins.

--Inner joins and left joins are both ways to combine SQL tables. Inner joins 
--combine the two tables using a common field in both tables (i.e. brand name in 
--the previous examples) as long as the field is not null while left joins combine 
--tables based on a field in the left able regardlss of whether or not the value is null. 

-- 3. Modify the query so that it only selects brands that don't have any models in the models table. 
-- (Hint: it should only show Tesla's row.)
-- before: 
    -- SELECT name,
    --        founded
    -- FROM Brands
    --   LEFT JOIN Models
    --     ON brands.name = Models.brand_name

SELECT Brands.name, founded FROM Brands LEFT JOIN Models ON brands.name = Models.brand_name 
WHERE Models.name IS NULL;
    

-- 4. Modify the query to add another column to the results to show 
-- the number of years from the year of the model until the brand becomes discontinued
-- Display this column with the name years_until_brand_discontinued.
-- before: 
    -- SELECT b.name,
    --        m.name,
    --        m.year,
    --        b.discontinued
    -- FROM Models AS m
    --   LEFT JOIN brands AS b
    --     ON m.brand_name = b.name
    -- WHERE b.discontinued NOT NULL;
   
SELECT b.name,m.name,(b.discontinued-m.year) FROM Models AS m LEFT JOIN brands 
AS b ON m.brand_name = b.name WHERE b.discontinued NOT NULL;



-- Part 3: Further Study

-- 1. Select the name of any brand with more than 5 models in the database.

SELECT brand_name FROM Models GROUP BY name HAVING COUNT(name) > 5;

-- 2. Add the following rows to the Models table.

-- year    name       brand_name
-- ----    ----       ----------
-- 2015    Chevrolet  Malibu
-- 2015    Subaru     Outback

INSERT INTO Models VALUES(49, 2015,'Chevrolet','Malibu');
INSERT INTO Models VALUES(50, 2015,'Subaru','Outback');

-- 3. Write a SQL statement to crate a table called `Awards`
--    with columns `name`, `year`, and `winner`. Choose
--    an appropriate datatype and nullability for each column
--   (no need to do subqueries here).

CREATE TABLE Awards(
    name VARCHAR(20) NOT NULL,
    year INTEGER(4) NOT NULL,
    winner VARCHAR(30)
);

-- 4. Write a SQL statement that adds the following rows to the Awards table:

--   name                 year      winner_model_id
--   ----                 ----      ---------------
--   IIHS Safety Award    2015      the id for the 2015 Chevrolet Malibu
--   IIHS Safety Award    2015      the id for the 2015 Subaru Outback

INSERT INTO Awards VALUES('IIHS Safety Award', 2015, '2015 Chevrolet Malibu');
INSERT INTO Awards VALUES('IIHS Safety Award', 2015, '2015 Subaru Outback');

-- 5. Using a subquery, select only the *name* of any model whose 
-- year is the same year that *any* brand was founded.
SELECT Models.name FROM Models JOIN Brands ON
  Models.brand_name = Brands.name
  WHERE year IN
  (SELECT founded FROM Brands);







