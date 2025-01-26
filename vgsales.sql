select * from vgsales

--1.finding top publishers by global sales
SELECT Publisher, 
       SUM(Global_Sales) AS Total_Global_Sales 
FROM VGSales 
GROUP BY Publisher 
HAVING SUM(Global_Sales) > 50 
ORDER BY Total_Global_Sales DESC;

--2.Identifying the Most Successful Genres in Specific Regions
SELECT Genre, 
       SUM(NA_Sales) AS Total_NA_Sales, 
       SUM(EU_Sales) AS Total_EU_Sales 
FROM VGSales 
GROUP BY Genre 
HAVING SUM(NA_Sales) > 20 AND SUM(EU_Sales) > 15 
ORDER BY Total_NA_Sales DESC, Total_EU_Sales DESC;

--3.Top 5 Games by Global Sales Across All Platforms
SELECT Name, Platform, 
       Global_Sales 
FROM VGSales 
ORDER BY Global_Sales DESC 
LIMIT 5;

--4.Games Released After 2005 With High Global Sales
SELECT Name, Platform, Genre, Global_Sales 
FROM VGSales 
WHERE Year > 2005 AND Global_Sales > 15 
ORDER BY Global_Sales DESC;

--5.Using a Subquery to Find Games with Above-Average Global Sales
SELECT Name, Platform, Global_Sales 
FROM VGSales 
WHERE Global_Sales > (SELECT AVG(Global_Sales) FROM VGSales) 
ORDER BY Global_Sales DESC;

--6.Ranking Games Based on Global Sales Within Each Genre
SELECT Name, Genre, Global_Sales, 
       RANK() OVER (PARTITION BY Genre ORDER BY Global_Sales DESC) AS Genre_Rank 
FROM VGSales;

--7. Case Statement: Categorizing Games by Global Sales
SELECT Name, Global_Sales, 
       CASE 
           WHEN Global_Sales >= 30 THEN 'Blockbuster' 
           WHEN Global_Sales >= 20 THEN 'Hit' 
           WHEN Global_Sales >= 10 THEN 'Moderate Success' 
           ELSE 'Low Sales' 
       END AS Sales_Category 
FROM VGSales 
ORDER BY Global_Sales DESC;

--8. Finding the Most Popular Platform by Genre
SELECT Genre, Platform, 
       SUM(Global_Sales) AS Total_Global_Sales 
FROM VGSales 
GROUP BY Genre, Platform 
ORDER BY Genre, Total_Global_Sales DESC;

--9. Comparing Sales in North America and Europe
SELECT Name, Platform, 
       NA_Sales, EU_Sales, 
       CASE 
           WHEN NA_Sales > EU_Sales THEN 'More Popular in NA' 
           WHEN NA_Sales < EU_Sales THEN 'More Popular in EU' 
           ELSE 'Equally Popular' 
       END AS Popularity 
FROM VGSales 
ORDER BY Name;












