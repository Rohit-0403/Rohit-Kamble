CREATE TABLE MelbourneProperties (
    Suburb TEXT,
    Address TEXT,
    Rooms INTEGER,
    Type TEXT,
    Price INTEGER,
    Method TEXT,
    SellerG TEXT,
    Date DATE,
    Distance REAL,
    Postcode INTEGER,
    Bedroom2 INTEGER,
    Bathroom INTEGER,
    Car INTEGER,
    Landsize INTEGER,
    BuildingArea INTEGER,
    YearBuilt INTEGER,
    CouncilArea TEXT,
    Lattitude REAL,
    Longtitude REAL,
    Regionname TEXT,
    Propertycount INTEGER,
    Year INTEGER,
    Price_per_sqm REAL,
    Property_Age INTEGER
);


INSERT INTO MelbourneProperties (
    Suburb, Address, Rooms, Type, Price, Method, SellerG, Date, Distance, Postcode,
    Bedroom2, Bathroom, Car, Landsize, BuildingArea, YearBuilt, CouncilArea,
    Lattitude, Longtitude, Regionname, Propertycount, Year, Price_per_sqm, Property_Age
)
VALUES
('Abbotsford', '85 Turner St', 2, 'h', 1480000, 'S', 'Biggin', '2016-12-03', 2.5, 3067,
 2, 1, 1, 202, 126, 1970, 'Yarra', -37.7996, 144.9984, 'Northern Metropolitan', 4019, 2016, 11746.031746, 54),
('Abbotsford', '40 Federation La', 3, 'h', 850000, 'PI', 'Biggin', '2017-03-04', 2.5, 3067,
 3, 2, 2, 156, 126, 1970, 'Yarra', -37.7969, 144.9969, 'Northern Metropolitan', 4019, 2017, 6746.031746, 54),
('Abbotsford', '129 Charles St', 2, 'h', 941000, 'S', 'Jellis', '2016-05-07', 2.5, 3067,
 2, 1, 0, 134, 126, 1970, 'Yarra', -37.8041, 144.9953, 'Northern Metropolitan', 4019, 2016, 7468.253968, 54),
('Abbotsford', '6/241 Nicholson St', 1, 'u', 300000, 'S', 'Biggin', '2016-10-08', 2.5, 3067,
 1, 1, 1, 94, 126, 1970, 'Yarra', -37.8008, 144.9973, 'Northern Metropolitan', 4019, 2016, 2380.952381, 54),
('Abbotsford', '411/8 Grosvenor St', 2, 'u', 700000, 'VB', 'Jellis', '2016-11-12', 2.5, 3067,
 2, 1, 1, 120, 126, 1970, 'Yarra', -37.8110, 145.0067, 'Northern Metropolitan', 4019, 2016, 5555.555556, 54),
('Abbotsford', 'Unit 3/12 Harrison Cres', 3, 't', 1175000, 'S', 'Nelson', '2016-12-10', 2.5, 3067,
 3, 2, 2, 220, 110, 1990, 'Yarra', -37.7995, 144.9976, 'Northern Metropolitan', 4019, 2016, 5340.909091, 36),
('Abbotsford', '68 William St', 2, 'h', 1140000, 'S', 'Jellis', '2017-03-18', 2.5, 3067,
 2, 1, 0, 234, 130, 1900, 'Yarra', -37.8024, 144.9958, 'Northern Metropolitan', 4019, 2017, 4871.794872, 117),
('Abbotsford', '11/5 Victoria St', 3, 'u', 850000, 'PI', 'Biggin', '2016-05-21', 2.5, 3067,
 3, 2, 2, 156, 130, 1970, 'Yarra', -37.7965, 144.9984, 'Northern Metropolitan', 4019, 2016, 5431.372549, 46),
('Abbotsford', '25 Davison St', 4, 'h', 1600000, 'VB', 'Nelson', '2016-07-30', 2.5, 3067,
 4, 3, 2, 350, 150, 2000, 'Yarra', -37.7997, 144.9998, 'Northern Metropolitan', 4019, 2016, 4571.428571, 16),
('Abbotsford', '69 Turner St', 3, 'h', 940000, 'S', 'Biggin', '2016-06-18', 2.5, 3067,
 3, 2, 2, 210, 125, 1910, 'Yarra', -37.8021, 144.9972, 'Northern Metropolitan', 4019, 2016, 4476.190476, 106);

select * from melbourneproperties;

--Find the total number of properties sold, grouped by their type.
SELECT 
    Type, 
    COUNT(*) AS Total_Properties_Sold
FROM 
    MelbourneProperties
GROUP BY 
    Type
ORDER BY 
    Total_Properties_Sold DESC;

--Calculate the average price for properties based on the number of rooms.
SELECT 
    Rooms, 
    ROUND(AVG(Price), 2) AS Average_Price
FROM 
    MelbourneProperties
GROUP BY 
    Rooms
HAVING AVG(Price) IS NOT NULL
ORDER BY AVG(Price) DESC;

--Identify the top 5 suburbs with the highest average property prices.
SELECT 
    Suburb, 
    ROUND(AVG(Price), 2) AS Average_Price
FROM 
    MelbourneProperties
GROUP BY 
    Suburb
ORDER BY 
    Average_Price DESC
LIMIT 5;

--Calculate the percentage of properties sold by each selling method.
SELECT 
    Method,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM MelbourneProperties), 2) AS Percentage
FROM 
    MelbourneProperties
GROUP BY 
    Method
ORDER BY 
    Percentage DESC;

--Find the number of properties sold in the latest year.
SELECT 
    Year, 
    COUNT(*) AS Total_Sold
FROM 
    MelbourneProperties
WHERE 
    Year = (SELECT MAX(Year) FROM MelbourneProperties)
GROUP BY 
    Year;

--List properties that have a price above the average price in the dataset.
SELECT 
    Suburb, Address, Rooms, Price
FROM 
    MelbourneProperties
WHERE 
    Price > (SELECT AVG(Price) FROM MelbourneProperties)
ORDER BY 
    Price DESC;

--Get details of the property with the largest land size.
SELECT 
    Suburb, Address, Rooms, Landsize, Price
FROM 
    MelbourneProperties
WHERE 
    Landsize = (SELECT MAX(Landsize) FROM MelbourneProperties);

--Identify properties with a price per square meter greater than 10,000.
SELECT 
    Suburb, Address, Rooms, Price_per_sqm, Price
FROM 
    MelbourneProperties
WHERE 
    Price_per_sqm > 10000
ORDER BY 
    Price_per_sqm DESC;

-- CTE to calculate total properties sold and average price per year.
WITH YearlyStats AS (
    SELECT 
        Year, 
        COUNT(*) AS Total_Properties_Sold,
        ROUND(AVG(Price), 2) AS Average_Price
    FROM 
        MelbourneProperties
    GROUP BY 
        Year
)
SELECT 
    Year, Total_Properties_Sold, Average_Price
FROM 
    YearlyStats
ORDER BY 
    Year ASC;

	









