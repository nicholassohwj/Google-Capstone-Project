CREATE TABLE IF NOT EXISTS stations (
    id                  VARCHAR(15) PRIMARY KEY,
    station_name        VARCHAR(40) UNIQUE,
    lat                 DECIMAL(10,6),
    lng                 DECIMAL(10,6)
);

CREATE TABLE IF NOT EXISTS rides (
    ride_id             VARCHAR(20) PRIMARY KEY,
    rideable_type       TEXT,
    started_at          DATETIME,
    ended_at            DATETIME,
    start_station_name  VARCHAR(40),
    start_station_id    VARCHAR(15),
    end_station_name    VARCHAR(40),
    end_station_id      VARCHAR(15),
    start_lat           DECIMAL(10,6),
    start_lng           DECIMAL(10,6),
    end_lat             DECIMAL(10,6),
    end_lng             DECIMAL(10,6),
    member_casual       TEXT NOT NULL,
    CHECK (member_casual IN ('member', 'casual')),
    FOREIGN KEY (start_station_id) REFERENCES stations(id),
    FOREIGN KEY (end_station_id) REFERENCES stations(id)
);

/*
-- For importing data from source to database.db
.import --csv /workspaces/Google-Capstone-Project/source/202305-divvy-tripdata.csv rides --skip 1
.import --csv /workspaces/Google-Capstone-Project/source/202306-divvy-tripdata.csv rides --skip 1
.import --csv /workspaces/Google-Capstone-Project/source/202307-divvy-tripdata.csv rides --skip 1
.import --csv /workspaces/Google-Capstone-Project/source/202308-divvy-tripdata.csv rides --skip 1
.import --csv /workspaces/Google-Capstone-Project/source/202309-divvy-tripdata.csv rides --skip 1
.import --csv /workspaces/Google-Capstone-Project/source/202310-divvy-tripdata.csv rides --skip 1
.import --csv /workspaces/Google-Capstone-Project/source/202311-divvy-tripdata.csv rides --skip 1
.import --csv /workspaces/Google-Capstone-Project/source/202312-divvy-tripdata.csv rides --skip 1
.import --csv /workspaces/Google-Capstone-Project/source/202401-divvy-tripdata.csv rides --skip 1
.import --csv /workspaces/Google-Capstone-Project/source/202402-divvy-tripdata.csv rides --skip 1
.import --csv /workspaces/Google-Capstone-Project/source/202403-divvy-tripdata.csv rides --skip 1
.import --csv /workspaces/Google-Capstone-Project/source/202404-divvy-tripdata.csv rides --skip 1
*/

/*
-- Data cleaning commands executed

## Remove trips without station names for start and/or stop points
DELETE FROM rides WHERE start_station_name = '' OR end_station_name = '';

## Remove trips where start trip time = end trip time or end trip time is before start trip time
DELETE FROM rides WHERE ended_at <= started_at;

## Remove trip where end_lat or end_lng is 0
DELETE FROM rides WHERE end_lat =0 OR end_lng = 0;


SELECT (strftime('%s', ended_at) - strftime('%s', started_at))/60 AS duration FROM rides LIMIT 5;

*/

-- For Viz of seasonality of bike usage and product offering
CREATE VIEW IF NOT EXISTS trip_data_duration AS
SELECT 
    ride_id, 
    rideable_type, 
    started_at, 
    ended_at, 
    member_casual,
    (strftime('%s', ended_at) - strftime('%s', started_at))/60 AS duration_mins,
    ROUND(2 * 6371000 *
        ASIN(
            SQRT(
                POWER(SIN(RADIANS(end_lat - start_lat) / 2), 2) +
                COS(RADIANS(start_lat)) * COS(RADIANS(end_lat)) *
                POWER(SIN(RADIANS(end_lng - start_lng) / 2), 2)
            ) 
        ),2) AS trip_distance_meters,
    CASE CAST (strftime('%w',started_at) as integer)
        WHEN 0 THEN 'Sunday'
        WHEN 1 THEN 'Monday'
        WHEN 2 THEN 'Tuesday'
        WHEN 3 THEN 'Wednesday'
        WHEN 4 THEN 'Thursday'
        WHEN 5 THEN 'Friday'
        ELSE 'Saturday'
        END AS day_of_week
FROM rides
WHERE duration_mins>0 AND duration_mins<1440;

CREATE VIEW IF NOT EXISTS geographic_info AS
SELECT
    ride_id,
    start_lat, start_lng,
    end_lat, end_lng
FROM rides;