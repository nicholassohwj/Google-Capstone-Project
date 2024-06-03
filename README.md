
# Google-Capstone-Project

#### Made by Nicholas Soh

This is my Capstone Project for the Google Data Analytics Course on Coursera. This project comprises of a case study on a fictional bike-sharing company, Cyclistic, that is looking to understand how they might be able to convert more users to become members of their bike-sharing service. 

For this purpose, we will analyse the behaviour between members and non-members of Cyclistic based on the trip data between May 2023 to April 2024 and make recommendations on how Cyclistic may be able to invoke more casual users to become members.

---

### Data used

* 12 months of trip data between May 2023 to April 2024 (total of 5,738,612 trips recorded) [Link](https://divvy-tripdata.s3.amazonaws.com/index.html)

### Data preparation

From the trip data extracted, there are a total of 5,738,612 trip records between May 2023 to April 2024. Based on the problem statement there are several preliminary questions I have:

1. __Seasonality of bike ridership__: between members vs casual users? | Duration between seasons, breakdown to weekdays and weekends.
2. __Product offering__: There are 3 different types of bikes (Electric, Classic, Docked) do members/casuals prefer one over others?
3. __Locations__: Are there locations that are more used than others? Could there be a limited availability of bikes in hotspots? Is there a difference between residential areas vs commercial areas?

### Limitations around data used

Based on the questions I had, I found that there are several limitations with the data available for the analysis.

1. No demographic data on members or casuals to determine if there are any demographical impact to the bike usage
2. No information on pricing of usage between bike types or membership prices
3. Full data on all the stations were not available, only stations that are part of the data are considered and if there are any stations that were not interacted with over the 12 month period, it will not be considered in this report. 

## Data cleaning

1. There are 1,402,657 records where the station names of the start and/or end points are missing. These trips will be assumed to be invalid and will be removed. (4,335,955 records remain)

    `DELETE FROM rides WHERE start_station_name = '' OR end_station_name = '';`

2. There are 652 records where the timestamp of the trip start time is either after or the same as the trip end time. These instances are assumed to be either returned immediately or erroneous records and will be removed. (4,335,303 records remain)

    `DELETE FROM rides WHERE ended_at <= started_at;`

3. There are 15 records where the station names/id seem to be test records, e.g. "OH Charging Stx - Test", "OH - BONDFIRE - TESTING". These records seem to be test rides by the company and are removed. (4,335,288 records remain)

    `DELETE FROM rides WHERE start_station_name LIKE '%test%' OR end_station_name LIKE '%test%';`

4. There was a record where the ending station longtitude and langtitude coordinates were posted as 0, which would not be possible as the distance would be out of US. It is very likely that this record was an error and hence was removed. 

    `DELETE FROM rides WHERE end_lat =0 OR end_lng = 0;`


## Findings

1. __Seasonality of bike ridership__

    In analyzing the seasonality of bike ridership, Figure 1.1 shows the frequency of ridership according to the months depicts a strong indication that bike ridership is at its highest in August and at its lowest in the month of January.

    ![Figure 1.1 Breakdown of Ridership from May 2023 to April 2024](visualizations/Seasonal_Month_viz.png "Figure 1.1")

    Digging deeper, we will analyze the difference between members and casual users. In Figure 1.2 below, it details 2 main points:
    
    1. Ridership is highest in the warmer months and lowest in the cooler months across members and casual users of Cyclistic bikes.
    2. Most of the users of Cyclistic bikes are members across the year.

    ![Figure 1.2 Breakdown of ridership between member and casual users from May 2023 to April 2024](visualizations/Seasonal_Month%20BD.png "Figure 1.2")

    We can delve deeper into the data to identify if there are any behavioural differences between ridership between the member and casual users by dissecting the frequnency of ridership according to the day of the week. In Figure 1.3, we explore the ridership according to the day of the week between members and casual riders in the months of June to August 2023, where ridership is at its highest in the 12 month period. 

    ![Figure 1.3 Ridership according to day of the week (Jun to Aug)](visualizations/Day_of_Week_JunJulAug.png "Figure 1.3")

    Pertinently, we can identify that there is a divergence in the behavior of members and casual users according to the day of the week. 
    
    Notably, we can see that ridership amongst members is highest during the weekdays. Whereas, ridership amongst casual users is highest during the weekends, even surpassing member ridership during the weekends. It is possible that this divergence is due to members using the bikes for their daily commute to and from work/school and casual users are more likely to use the bikes on weekends for leisure, running errands or used by tourists.

    Figure 1.4 explores the ridership according to the day of the week between members and casual riders during the cooler months, where ridership is at its lowest during the 12 month period. 

    ![Figure 1.4 Ridership according to the day of the week (Dec to Feb)](visualizations/Day_of_Week_DecJanFeb.png "Figure 1.4")

    It is notable that although ridership across all days are a lot lower than the warmer months, ridership is dominated by member users and members are making more trips during the weekdays. This further indicates that Cyclistic members frequently use the bikes for their daily commute for work/school during the weekdays and lesser on the weekends. It is also notable that trips made by casual users during this 3 month period remains low across the week, showing that during the colder months, non-members are not as willing to use the bikes and prefer other means of transport. 



2. __Product offering__ 

    There are 3 different types of bikes that are offered by Cyclistic:
        1. Electric bike
        2. Docked bike
        3. Classic bike

    In Figure 2.1, it shows the breakdown of the usage of bike types between members and casual users.

    ![Figure 2.1 Breakdown of bike types](visualizations/Product_offering.png "Figure 2.1")


### Summary

...

### Recommendations

...