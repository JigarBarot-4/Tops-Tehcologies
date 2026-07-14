CREATE DATABASE zomato_db;

USE zomato_db;
CREATE TABLE zomato (
    name VARCHAR(100),
    location VARCHAR(100),
    cuisines VARCHAR(100),
    rate DECIMAL(2,1),
    approx_cost_for_two_people INT,
    online_order VARCHAR(3)
);
INSERT INTO zomato
(name, location, cuisines, rate, approx_cost_for_two_people, online_order)
VALUES
('Empire Restaurant','Koramangala','North Indian',4.5,800,'Yes'),
('Meghana Foods','Koramangala','North Indian',4.7,900,'Yes'),
('Truffles','Koramangala','Fast Food',4.6,700,'Yes'),
('Dominos Pizza','Indiranagar','Pizza',4.2,600,'Yes'),
('Pizza Hut','Koramangala','Pizza',3.8,750,'Yes'),
('KFC','BTM','Fast Food',3.6,500,'Yes'),
('Burger King','Whitefield','Fast Food',3.9,550,'Yes'),
('Cafe Coffee Day','MG Road','Cafe',4.1,450,'Yes'),
('Barbeque Nation','Indiranagar','BBQ',4.8,1800,'No'),
('Onesta','Koramangala','Italian',4.3,850,'Yes'),
('Subway','Electronic City','Sandwich',3.5,400,'Yes'),
('Chinese Wok','Koramangala','Chinese',3.2,650,'Yes'),
('Biryani Zone','Koramangala','North Indian',2.8,500,'Yes'),
('Royal Biryani','Koramangala','North Indian',2.5,450,'Yes'),
('Sagar Ratna','MG Road','South Indian',4.4,650,'Yes'),
('A2B','Jayanagar','South Indian',4.2,500,'Yes'),
('McDonalds','Indiranagar','Fast Food',3.7,550,'Yes'),
('Dominos Pizza','Whitefield','Pizza',4.1,650,'Yes'),
('Empire Restaurant','BTM','North Indian',4.6,850,'Yes'),
('Meghana Foods','Indiranagar','North Indian',4.8,950,'Yes');

SELECT
    name,
    location,
    cuisines,
    rate
FROM zomato_db
WHERE location = 'Koramangala'
  AND cuisines LIKE '%North Indian%'
ORDER BY rate DESC
LIMIT 5;

SELECT
    cuisines,
    AVG(approx_cost_for_two_people) AS avg_cost
FROM zomato
GROUP BY cuisines
ORDER BY avg_cost DESC
LIMIT 3;

SELECT
    name,
    location,
    cuisines,
    rate,
    approx_cost_for_two_people
FROM zomato
WHERE online_order = 'Yes'
  AND rate < 3.0
ORDER BY rate;

SELECT
    CASE
        WHEN approx_cost_for_two_people < 400 THEN 'Budget'
        WHEN approx_cost_for_two_people BETWEEN 400 AND 800 THEN 'Mid-Range'
        ELSE 'Premium'
    END AS Market_Segment,

    COUNT(*) AS Number_of_Restaurants

FROM zomato

GROUP BY Market_Segment;

SELECT
    name,
    COUNT(*) AS outlet_count
FROM zomato
GROUP BY name
ORDER BY outlet_count DESC
LIMIT 10;