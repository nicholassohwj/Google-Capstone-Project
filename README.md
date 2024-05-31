
# Google-Capstone-Project

#### Made by Nicholas Soh

This is my Capstone Project for the Google Data Analytics Course on Coursera. This project comprises of a case study on a fictional bike-sharing company, Cyclistic, that is looking to understand how casual riders and annual members use their bikes differently. 

---

### Data used

* 12 months of trip data between May 2023 to April 2024 (total of 5,738,612 trips recorded) [Link](https://divvy-tripdata.s3.amazonaws.com/index.html)

### Data preparation

From the trip data extracted, there are a total of 5,738,612 trip records between May 2023 to April 2024. Based on the problem statement there are several preliminary questions I have:

1. __Seasonality of bike usage__: between members vs casual users? | Duration between seasons, breakdown to weekdays and weekends.
2. __Product offering__: There are 3 different types of bikes (Electric, Classic, Docked) do members/casuals prefer one over others? and is there an element of price preference?
3. __Locations__: Are there locations that are more used than others? Could there be a limited availability of bikes in hotspots? Is there a difference between residential areas vs commercial areas?

### Limitations around data used

Based on the questions I had, I found that there are several limitations with the data available for the analysis.

1. No demographic data on members or casuals to determine if there are any demographical impact to the bike usage
2. Full data on all the stations were not available, only stations that are part of the data are considered and if there are any stations that were not interacted with over the 12 month period, it will not be considered in this report. 

### Data cleaning

1. There are 1,402,657 records where the station names of the start and/or end points are missing. These trips will be assumed to be invalid and will be removed. (4,335,955 records remain)

    `DELETE FROM rides WHERE start_station_name = '' OR end_station_name = '';`

2. There are 652 records where the timestamp of the trip start time is either after or the same as the trip end time. These instances are assumed to be either returned immediately or erroneous records and will be removed. (4,335,303 records remain)

    `DELETE FROM rides WHERE ended_at <= started_at;`

3. There are 15 records where the station names/id seem to be test records, e.g. "OH Charging Stx - Test", "OH - BONDFIRE - TESTING". These records seem to be test rides by the company and are removed. (4,335,288 records remain)

    `DELETE FROM rides WHERE start_station_name LIKE '%test%' OR end_station_name LIKE '%test%';`

4. There was a record where the ending station longtitude and langtitude coordinates were posted as 0, which would not be possible as the distance would be out of US. It is very likely that this record was an error and hence was removed. 

    `DELETE FROM rides WHERE end_lat =0 OR end_lng = 0;`

### Summary

...

### Recommendations

...