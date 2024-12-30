

-- Create the database if it does not exist
CREATE DATABASE IF NOT EXISTS cyclist;

-- Drop the database (if it already exists)
DROP DATABASE cyclist;

-- Create the database again
CREATE DATABASE cyclist;

USE cyclist;

CREATE TABLE cycledata (
 ride_id VARCHAR(255),
 rideable_type VARCHAR(255),
 started_at DATETIME,
 ended_at DATETIME,
 start_station_name VARCHAR(255),
 start_station_id VARCHAR(255),
 end_station_name VARCHAR(255),
 end_station_id VARCHAR(255),
 start_lat DECIMAL,
 start_lng DECIMAL,
 end_lat DECIMAL,
 end_lng DECIMAL,
 member_casual VARCHAR(255)
);

SELECT * FROM cycledata;

ALTER TABLE cycledata
ADD ride_length DATETIME;

ALTER TABLE cycledata MODIFY ride_length INT;

SET SQL_SAFE_UPDATES = 0;


UPDATE cycledata
SET ride_length = TIMESTAMPDIFF(MINUTE, started_at, ended_at)
WHERE started_at IS NOT NULL AND ended_at IS NOT NULL;


ALTER TABLE cycledata 
ADD COLUMN weekday VARCHAR(10);
UPDATE cycledata SET weekday = DAYNAME(started_at);

SELECT * From cycledata;

SELECT AVG(ride_length) FROM cycledata;

SELECT MAX(ride_length) FROM cycledata;

SELECT weekday, COUNT(*) AS frequency
FROM cycledata
GROUP BY weekday
ORDER BY frequency DESC
LIMIT 1;

SELECT member_casual, AVG(ride_length) AS avg_usage
FROM cycledata
GROUP BY member_casual
ORDER BY avg_usage DESC;



SELECT weekday, AVG(ride_length) AS avg_usage_weekday
FROM cycledata
GROUP BY weekday
ORDER BY avg_usage_weekday DESC;

SELECT 
    DATE_FORMAT(started_at, '%y-%M') AS month_name,
    SUM(TIMESTAMPDIFF(MINUTE, started_at, ended_at)) AS total_length_minutes
FROM cycledata
WHERE started_at IS NOT NULL AND ended_at IS NOT NULL
GROUP BY DATE_FORMAT(started_at, '%y-%M')
ORDER BY total_length_minutes DESC;


SELECT 
    start_station_name,
    AVG(ride_length) AS avg_ride_length
FROM cycledata
WHERE start_station_name IS NOT NULL 
GROUP BY start_station_name
ORDER BY avg_ride_length DESC;

SELECT *
FROM cycledata
WHERE
 rideable_type IS NOT NULL
 AND started_at IS NOT NULL
 AND ended_at IS NOT NULL
 AND start_station_name IS NOT NULL
 AND start_station_id IS NOT NULL
 AND end_station_name IS NOT NULL
 AND end_station_id IS NOT NULL
 AND start_lat IS NOT NULL
 AND start_lng IS NOT NULL
 AND end_lat IS NOT NULL
 AND end_lng IS NOT NULL
 AND member_casual IS NOT NULL;



