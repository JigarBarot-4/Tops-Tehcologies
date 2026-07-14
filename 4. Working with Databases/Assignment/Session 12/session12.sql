SELECT *
FROM Restaurants
WHERE delivery_charge < 50
  AND id IN (
      SELECT id
      FROM Restaurants
      WHERE location = 'Ahmedabad'
  );
  
  WITH AhmedabadRestaurants AS (
    SELECT *
    FROM Restaurants
    WHERE location = 'Ahmedabad'
)
SELECT *
FROM AhmedabadRestaurants
WHERE delivery_charge < 50;

WITH TopUsers AS (
    SELECT user_id, username, followers
    FROM Users
    ORDER BY followers DESC
    LIMIT 3
),

TopPosts AS (
    SELECT post_id, user_id, likes
    FROM Posts
    ORDER BY likes DESC
    LIMIT 3
)

SELECT 'Top Users' AS category, user_id, username, followers
FROM TopUsers

UNION ALL

SELECT 'Top Posts' AS category, post_id, NULL AS username, likes
FROM TopPosts;

WITH RECURSIVE DateSeries AS (

    -- Base case (today)
    SELECT CURRENT_DATE AS calendar_date, 1 AS day_num

    UNION ALL

    -- Recursive step
    SELECT DATE_ADD(calendar_date, INTERVAL 1 DAY), day_num + 1
    FROM DateSeries
    WHERE day_num < 7

)

SELECT calendar_date
FROM DateSeries;

WITH PopularUsers AS (
    SELECT user_id, username, followers
    FROM Users
    WHERE followers > 1000
)

SELECT *
FROM PopularUsers;