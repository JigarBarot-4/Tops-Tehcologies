USE zomato_db;

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