DROP TABLE food_delivery_cleaning;
DESCRIBE food_delivery_mysql;
SHOW WARNINGS;

SELECT COUNT(*) AS rows_with_cancel_reason
FROM food_delivery_mysql
WHERE cancel_reason IS NOT NULL;

DROP TABLE food_delivery_mysql;

SELECT @@secure_file_priv;

SHOW VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = ON;

SHOW VARIABLES LIKE 'local_infile';
CREATE TABLE food_delivery_cleaning (
    order_id TEXT,
    order_time TEXT,
    delivery_time TEXT,
    delivery_duration_min INT,
    city TEXT,
    state TEXT,
    latitude DOUBLE,
    longitude DOUBLE,
    restaurant TEXT,
    is_canceled INT,
    cancel_reason TEXT,
    customer_rating DOUBLE,
    order_date TEXT,
    order_hour INT,
    order_day TEXT,
    delivery_status TEXT,
    calculated_delivery_duration_min INT,
    duration_difference_min INT
);

LOAD DATA LOCAL INFILE 'E:/NUCOT/Food Delivery Performance Analytics/Excel/food_delivery_mysql.csv'
INTO TABLE food_delivery_cleaning
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SHOW VARIABLES LIKE 'local_infile';

LOAD DATA LOCAL INFILE 'E:/NUCOT/Food Delivery Performance Analytics/Excel/food_delivery_mysql.csv'
INTO TABLE food_delivery_cleaning
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS total_records
FROM food_delivery_cleaning;

SHOW WARNINGS LIMIT 20;

SELECT is_canceled, COUNT(*) AS total
FROM food_delivery_cleaning
GROUP BY is_canceled;

select * 
from food_delivery_cleaning
limit 10;

select count(*) as total_records
from food_delivery_cleaning;

describe food_delivery_cleaning;

SELECT
    COUNT(*) AS total_records,
    COUNT(order_id) AS order_id_count,
    COUNT(order_time) AS order_time_count,
    COUNT(delivery_time) AS delivery_time_count,
    COUNT(delivery_duration_min) AS delivery_duration_count,
    COUNT(city) AS city_count,
    COUNT(state) AS state_count,
    COUNT(restaurant) AS restaurant_count,
    COUNT(is_canceled) AS canceled_count,
    COUNT(cancel_reason) AS cancel_reason_count,
    COUNT(customer_rating) AS rating_count
FROM food_delivery_cleaning;

SELECT
    COUNT(*) AS total_records,
    COUNT(latitude) AS latitude_count,
    COUNT(longitude) AS longitude_count,
    COUNT(order_date) AS order_date_count,
    COUNT(order_hour) AS order_hour_count,
    COUNT(order_day) AS order_day_count,
    COUNT(delivery_status) AS delivery_status_count,
    COUNT(calculated_delivery_duration_min) AS calculated_duration_count,
    COUNT(duration_difference_min) AS difference_count
FROM food_delivery_cleaning;

select order_id,
count(*) as order_count
from food_delivery_cleaning
group by order_id
having count(*)>1;

select is_canceled,
count(*) as total_orders
from food_delivery_cleaning
group by is_canceled;

SELECT
    COUNT(CASE WHEN is_canceled = 1 THEN 1 END) * 100.0 / COUNT(*) AS cancellation_rate
FROM food_delivery_cleaning;

SELECT
    ROUND(
        COUNT(CASE WHEN is_canceled = 1 THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate
FROM food_delivery_cleaning;

select city, count(*) as total_orders
from food_delivery_cleaning
group by city
order by total_orders DESC;

select round(avg(delivery_duration_min),2) as avg_delivery_time
from food_delivery_cleaning;

select city,
round(avg(delivery_duration_min),2) as avg_delivery_time
from food_delivery_cleaning
group by city
order by avg_delivery_time ASC;

select city,
round(avg(delivery_duration_min),2) as avg_delivery_time
from food_delivery_cleaning
group by city
order by avg_delivery_time DESC;

select city,
count(*) as canceled_orders
from food_delivery_cleaning
where is_canceled = 1
group by city
order by canceled_orders DESC;

SELECT
    city,
    COUNT(CASE WHEN is_canceled = 1 THEN 1 END) AS canceled_orders,
    COUNT(*) AS total_orders,
    ROUND(
        COUNT(CASE WHEN is_canceled = 1 THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate
FROM food_delivery_cleaning
GROUP BY city
ORDER BY cancellation_rate DESC;

select delivery_status,
count(*) as total_orders
from food_delivery_cleaning
group by delivery_status
order by total_orders DESC;

select order_day,
count(*) as total_orders
from food_delivery_cleaning
group by order_day
order by total_orders DESC;

select order_day,
round(avg(delivery_duration_min),2) as avg_delivery_time
from food_delivery_cleaning
group by order_day
order by avg_delivery_time DESC;

select restaurant,
count(*) as total_orders
from food_delivery_cleaning
group by restaurant
order by total_orders DESC;

select restaurant,
count(*) as total_orders,
round(avg(delivery_duration_min),2) as avg_delivery_time
from food_delivery_cleaning
group by restaurant
order by avg_delivery_time ASC;

select restaurant,
count(customer_rating) as rated_orders,
round(avg(customer_rating),2) as avg_rating
from food_delivery_cleaning
group by restaurant
order by avg_rating DESC;

SELECT
    CASE
        WHEN delivery_duration_min < 30 THEN 'Under 30 min'
        WHEN delivery_duration_min BETWEEN 30 AND 45 THEN '30-45 min'
        WHEN delivery_duration_min BETWEEN 46 AND 60 THEN '46-60 min'
        ELSE 'Above 60 min'
    END AS delivery_time_group,
    COUNT(*) AS total_orders,
    ROUND(AVG(customer_rating), 2) AS avg_rating
FROM food_delivery_cleaning
GROUP BY delivery_time_group
ORDER BY avg_rating DESC;

SELECT
    CASE
        WHEN delivery_duration_min < 30 THEN 'Under 30 min'
        WHEN delivery_duration_min BETWEEN 30 AND 45 THEN '30-45 min'
        WHEN delivery_duration_min BETWEEN 46 AND 60 THEN '46-60 min'
        ELSE 'Above 60 min'
    END AS delivery_time_group,
    COUNT(*) AS total_orders,
    ROUND(AVG(customer_rating), 2) AS avg_rating
FROM food_delivery_cleaning
GROUP BY delivery_time_group
ORDER BY avg_rating DESC;

SELECT
    MIN(delivery_duration_min) AS minimum_delivery_time,
    MAX(delivery_duration_min) AS maximum_delivery_time,
    ROUND(AVG(delivery_duration_min), 2) AS average_delivery_time
FROM food_delivery_cleaning;

select count(*) as zero_minute_deliveries
from food_delivery_cleaning
where delivery_duration_min=0;

select is_canceled,
count(*) as total_orders
from food_delivery_cleaning
where delivery_duration_min=0
group by is_canceled;

select 
count(*) as completed_orders,
round(avg(delivery_duration_min),2) as avg_completed_delivery_time
from food_delivery_cleaning
where is_canceled=0;

select 
min(delivery_duration_min) as minimum_delivery_time,
max(delivery_duration_min) as maximum_delivery_time,
round(avg(delivery_duration_min),2) as avg_delivery_time
from food_delivery_cleaning
where is_canceled=0;

select city,
count(*) as completed_orders,
round(avg(delivery_duration_min),2) as avg_delivery_time
from food_delivery_cleaning
where is_canceled=0
group by city
order by avg_delivery_time ASC;

select city,
count(*) as completed_orders,
round(avg(delivery_duration_min),2) as avg_delivery_time
from food_delivery_cleaning
where is_canceled=0
group by city
order by avg_delivery_time DESC;

select restaurant,
count(*) as completed_orders,
round(avg(delivery_duration_min),2) as avg_delivery_time
from food_delivery_cleaning
where is_canceled=0
group by restaurant
order by avg_delivery_time ASC;

select restaurant,
count(*) as completed_orders,
round(avg(delivery_duration_min),2) as avg_delivery_time
from food_delivery_cleaning
where is_canceled=0
group by restaurant
order by avg_delivery_time DESC;

select cancel_reason,
count(*) as canceled_orders
from food_delivery_cleaning
where is_canceled=1
group by cancel_reason
order by canceled_orders DESC;

SELECT
    cancel_reason,
    COUNT(*) AS canceled_orders,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*)
         FROM food_delivery_cleaning
         WHERE is_canceled = 1),
        2
    ) AS cancellation_percentage
FROM food_delivery_cleaning
WHERE is_canceled = 1
GROUP BY cancel_reason
ORDER BY cancellation_percentage DESC;

select 
min(customer_rating) as minimum_rating,
max(customer_rating) as maximum_rating,
round(avg(customer_rating),2) as average_rating
from food_delivery_cleaning;

select count(*) as zero_rated_orders
from food_delivery_cleaning
where customer_rating =0;

select is_canceled,
count(*) as total_orders
from food_delivery_cleaning
where customer_rating=0
group by is_canceled;

select 
count(*) as rated_orders,
round(avg(customer_rating),2) as avg_customer_rating
from food_delivery_cleaning
where is_canceled=0;

select customer_rating,
count(*) as total_ratings
from food_delivery_cleaning
where is_canceled=0
group by customer_rating
order by customer_rating ASC;

SELECT
    CASE
        WHEN customer_rating < 2.5 THEN 'Poor'
        WHEN customer_rating BETWEEN 2.5 AND 3.4 THEN 'Average'
        WHEN customer_rating BETWEEN 3.5 AND 4.4 THEN 'Good'
        ELSE 'Excellent'
    END AS rating_category,
    COUNT(*) AS total_orders
FROM food_delivery_cleaning
WHERE is_canceled = 0
GROUP BY rating_category
ORDER BY total_orders DESC;

SELECT
    CASE
        WHEN customer_rating < 2.5 THEN 'Poor'
        WHEN customer_rating BETWEEN 2.5 AND 3.4 THEN 'Average'
        WHEN customer_rating BETWEEN 3.5 AND 4.4 THEN 'Good'
        ELSE 'Excellent'
    END AS rating_category,
    COUNT(*) AS total_orders,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*)
         FROM food_delivery_cleaning
         WHERE is_canceled = 0),
        2
    ) AS rating_percentage
FROM food_delivery_cleaning
WHERE is_canceled = 0
GROUP BY rating_category
ORDER BY rating_percentage DESC;

SELECT
    CASE
        WHEN delivery_duration_min < 30 THEN 'Under 30 min'
        WHEN delivery_duration_min BETWEEN 30 AND 45 THEN '30-45 min'
        WHEN delivery_duration_min BETWEEN 46 AND 60 THEN '46-60 min'
        ELSE 'Above 60 min'
    END AS delivery_category,
    COUNT(*) AS completed_orders,
    ROUND(AVG(customer_rating), 2) AS average_rating
FROM food_delivery_cleaning
WHERE is_canceled = 0
GROUP BY delivery_category
ORDER BY average_rating DESC;

SELECT
    CASE
        WHEN delivery_duration_min < 30 THEN 'Under 30 min'
        WHEN delivery_duration_min BETWEEN 30 AND 45 THEN '30-45 min'
        WHEN delivery_duration_min BETWEEN 46 AND 60 THEN '46-60 min'
        ELSE 'Above 60 min'
    END AS delivery_category,
    COUNT(*) AS completed_orders,
    ROUND(AVG(customer_rating), 2) AS average_rating
FROM food_delivery_cleaning
WHERE is_canceled = 0
GROUP BY delivery_category
ORDER BY completed_orders DESC;

SELECT
    city,
    COUNT(*) AS completed_orders
FROM food_delivery_cleaning
WHERE is_canceled = 0
GROUP BY city
ORDER BY completed_orders DESC;

SELECT
    restaurant,
    COUNT(*) AS completed_orders
FROM food_delivery_cleaning
WHERE is_canceled = 0
GROUP BY restaurant
ORDER BY completed_orders DESC;

SELECT
    restaurant,
    COUNT(*) AS completed_orders,
    ROUND(AVG(customer_rating), 2) AS average_rating
FROM food_delivery_cleaning
WHERE is_canceled = 0
GROUP BY restaurant
ORDER BY average_rating DESC;

select city,
count(*) as completed_orders,
round(avg(customer_rating),2) as avg_rating
from food_delivery_cleaning
where is_canceled =0
group by city
order by avg_rating DESC; 

select city,
count(*) as completed_orders,
round(avg(delivery_duration_min),2) as avg_delivery_time,
round(avg(customer_rating),2) as avg_rating
from food_delivery_cleaning
where is_canceled=0
group by city
order by avg_delivery_time ASC;

select city,
count(*) as completed_orders,
round(avg(delivery_duration_min),2) as avg_delivery_time
from food_delivery_cleaning
where is_canceled =0
group by city
having count(*) >900
and avg(delivery_duration_min)<50
order by avg_delivery_time ASC;

SELECT
    city,
    COUNT(*) AS completed_orders,
    ROUND(AVG(customer_rating), 2) AS average_rating
FROM food_delivery_cleaning
WHERE is_canceled = 0
GROUP BY city
HAVING COUNT(*) >= 900
   AND AVG(customer_rating) >= 3.90
ORDER BY average_rating DESC;

select restaurant,
count(*) as completed_orders,
round(avg(customer_rating),2) as avg_customer_rating
from food_delivery_cleaning
where is_canceled =0
group by restaurant
having count(*) >900
and avg(customer_rating)>3.90
order by avg_customer_rating DESC;

select restaurant,
count(*) as completed_orders,
round(avg(delivery_duration_min),2) as avg_delivery_time
from food_delivery_cleaning
where is_canceled =0
group by restaurant
having count(*) >900
and avg(delivery_duration_min)<50
order by avg_delivery_time ASC;

SELECT
    restaurant,
    COUNT(*) AS completed_orders,
    SUM(
        CASE
            WHEN delivery_duration_min <= 45 THEN 1
            ELSE 0
        END
    ) AS orders_within_45_min
FROM food_delivery_cleaning
WHERE is_canceled = 0
GROUP BY restaurant
ORDER BY orders_within_45_min DESC;

SELECT
    restaurant,
    COUNT(*) AS completed_orders,
    SUM(
        CASE
            WHEN delivery_duration_min <= 45 THEN 1
            ELSE 0
        END
    ) AS orders_within_45_min,
    ROUND(
        SUM(
            CASE
                WHEN delivery_duration_min <= 45 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS within_45_percentage
FROM food_delivery_cleaning
WHERE is_canceled = 0
GROUP BY restaurant
ORDER BY within_45_percentage DESC;

SELECT
    COUNT(*) AS completed_orders,
    SUM(
        CASE
            WHEN delivery_duration_min <= 45 THEN 1
            ELSE 0
        END
    ) AS orders_within_45_min,
    ROUND(
        SUM(
            CASE
                WHEN delivery_duration_min <= 45 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS within_45_percentage
FROM food_delivery_cleaning
WHERE is_canceled = 0;

select city,
count(*) as total_orders,
sum(
case
when is_canceled=1 then 1
else 0
End
) as canceled_orders,
round(sum(case
when is_canceled=1 then 1
else 0
end
)*100.0/ count(*),
2
)as cancellation_percentage
from food_delivery_cleaning
group by city
order by cancellation_percentage DESC;

select restaurant,
count(*) as total_orders,
sum(
case when is_canceled =1 then 1
else 0
end
)as canceled_orders,
round(sum(case
when is_canceled=1 then 1
else 0
end
)*100.0/count(*),
2
)as cancellation_percentage
from food_delivery_cleaning
group by restaurant
order by cancellation_percentage DESC;

select restaurant,cancel_reason,
count(*) as canceled_orders
from food_delivery_cleaning
where is_canceled=1
group by restaurant,cancel_reason
order by restaurant,canceled_orders DESC;

select cancel_reason,
count(*) as canceled_orders
from food_delivery_cleaning
where is_canceled =1
group by cancel_reason
order by canceled_orders DESC;

SELECT
    cancel_reason,
    COUNT(*) AS canceled_orders,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*)
         FROM food_delivery_cleaning
         WHERE is_canceled = 1),
        2
    ) AS cancellation_percentage
FROM food_delivery_cleaning
WHERE is_canceled = 1
GROUP BY cancel_reason
ORDER BY cancellation_percentage DESC;

SELECT
    is_canceled,
    MIN(delivery_duration_min) AS min_duration,
    MAX(delivery_duration_min) AS max_duration,
    AVG(delivery_duration_min) AS avg_duration,
    COUNT(*) AS total_orders
FROM food_delivery_cleaning
GROUP BY is_canceled;

describe food_delivery_cleaning;

SELECT
    CASE
        WHEN delivery_duration_min < 30 THEN 'Under 30 min'
        WHEN delivery_duration_min BETWEEN 30 AND 45 THEN '30-45 min'
        WHEN delivery_duration_min BETWEEN 46 AND 60 THEN '46-60 min'
        ELSE 'Above 60 min'
    END AS delivery_time_category,

    COUNT(*) AS completed_orders,

    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*)
         FROM food_delivery_cleaning
         WHERE is_canceled = 0),
        2
    ) AS percentage_of_completed_orders

FROM food_delivery_cleaning

WHERE is_canceled = 0

GROUP BY
    CASE
        WHEN delivery_duration_min < 30 THEN 'Under 30 min'
        WHEN delivery_duration_min BETWEEN 30 AND 45 THEN '30-45 min'
        WHEN delivery_duration_min BETWEEN 46 AND 60 THEN '46-60 min'
        ELSE 'Above 60 min'
    END

ORDER BY percentage_of_completed_orders DESC;

select restaurant,
count(*) as completed_orders,
round(avg(delivery_duration_min),2) as avg_delivery_time
from food_delivery_cleaning
where is_canceled=0
group by restaurant
order by avg_delivery_time ASC;

select city,
count(*) as completed_orders,
round(avg(delivery_duration_min),2) as avg_delivery_time
from food_delivery_cleaning
where is_canceled=0
group by city
order by avg_delivery_time ASC;

SELECT
    restaurant,
    COUNT(*) AS completed_orders,
    ROUND(AVG(customer_rating), 2) AS average_rating
FROM food_delivery_cleaning
WHERE is_canceled = 0
GROUP BY restaurant
ORDER BY average_rating DESC;

select city,
count(*) as completed_orders,
round(avg(customer_rating),2) as avg_ratings
from food_delivery_cleaning
where is_canceled =0
group by city
order by avg_ratings DESC;

select city,
count(*) as completed_orders,
round(avg(delivery_duration_min),2) as avg_delivery_time,
round(avg(customer_rating),2) as avg_ratings
from food_delivery_cleaning
where is_canceled =0
group by city
order by avg_delivery_time ASC;

SELECT is_canceled, cancel_reason
FROM food_delivery_cleaning
WHERE is_canceled = 1
LIMIT 10;