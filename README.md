---
output:
  html_document: default
  pdf_document: default
---
# How does a bike share navigate speedy success
In this case study we will work for a fictional company, Cyclistic, a bike-share company in Chicago. For the director of marketing of the company’s, future success depends on maximizing the number of annual memberships. Therefore, rather than creating a marketing campaign that targets all-new customers, the director of marketing believes there is a very good chance to convert casual riders into members. 

Source: [Link](https://d3c33hcgiwev3.cloudfront.net/aacF81H_TsWnBfNR_x7FIg_36299b28fa0c4a5aba836111daad12f1_DAC8-Case-Study-1.pdf?Expires=1681084800&Signature=WgKO~-LpPUMKTGb95H3tFbjTpbRvtu1nqBpjLACnTFrK6jBlggPYFa4lDd6jERYrYmrs7kP~4W~AJU4a3TgXhrp8XFq2c5L5gXwSIcBZNrDDKEeT1ZPXQzSUUGbFtvzy5iz-TyEvMJ-2ETjsA-oDex859GY-Ztjr8EitozVmK2w_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A)

In order to help the company design a new marketing strategy to convert casual riders into annual members, some questions need to be answered

* 1. How do annual members and casual riders use Cyclistic bikes differently?
* 2. Why would casual riders buy Cyclistic annual memberships?
* 3. How can Cyclistic use digital media to influence casual riders to become members?

This case study will focus on the first question.

## How do annual members and casual riders use Cyclistic bikes differently?
The objective is to analyze and compare the usage habits of annual members and casual riders of Cyclistic bicycles in order to identify differences in their behavior and preferences. The goal is to gain insights that can be used to design effective marketing strategies to convert casual cyclists into annual members. By understanding the key factors that influence user behavior and preferences, Cyclistic can tailor its marketing efforts to better meet the needs of casual cyclists and encourage them to become long-term loyal customers.

## Data
The data used in this study are Cyclistic’s historical trip data. The initial case study suggests to get only the previous 12 months trips data but we will consider all data (from January 2015 to March 2023). This could give more insights regarding changes over years.

There are several csv files containing trips data ([seen list sata sets here](https://divvy-tripdata.s3.amazonaws.com/index.html)). The name of variables are not consistent across all data sets but they contain similar information. The information that can be found in these data sets are:

* trip_id: ID attached to each trip taken
* start_time: day and time trip started, in CST
* stop_time: day and time trip ended, in CST
* bikeid: ID attached to each bike
* tripduration: time of trip in seconds 
* from_station_name: name of station where trip originated
* to_station_name: name of station where trip terminated 
* from_station_id: ID of station where trip originated
* to_station_id: ID of station where trip terminated
* usertype: "Customer" is a rider who purchased a 24-Hour Pass; "Subscriber" is a rider who purchased an Annual Membership
* gender: gender of rider 

## Scripts in this project
This project contains different files with different purpose:

* [first_step__extraction_script](https://github.com/bationoA/How_does_a_bike_share_navigate_speedy_success/blob/main/first_step__extraction_script.Rmd): Contains scripts to download all data sets, extract and combine relevant csv files. The extractions scripts can easily be modify to download only data sets based on years. The scripts in this file should be the first to be ran
* [second_step__Formating](https://github.com/bationoA/How_does_a_bike_share_navigate_speedy_success/blob/main/second_step__Formating.Rmd): To be ran at the after first_step__extraction_script, it contains scripts to consolidate the format of data sets (date-time), rename columns or combine all data sets into only 2
* [third_step__Cleaning](https://github.com/bationoA/How_does_a_bike_share_navigate_speedy_success/blob/main/third_step__Cleaning.Rmd): This contains scripts for cleaning the previous 2 data sets and combine them into one. 
* [fourth_step__analysis](https://github.com/bationoA/How_does_a_bike_share_navigate_speedy_success/blob/main/fourth_step__analysis.Rmd): This file contains scripts for all the analysis related to to case study


## Key Findings
  
* Casual and member customers have approximately the same number of rides on weekends (Saturday and Sunday) but member customers initiate up to two times more rides than casual on working days
* Rides initiated by casual customers tend to last much longer (more than 1 to 2 times longer on average) than rides initiated by member customers
* The difference discovered in the duration of rides of cusual and member customers was tested and found significant with more than 99.99% of confidence
* The Streeter Dr & Grand Ave' station is mostly used by casual customers as starting location while the Linton St & Washington Blvd' station is mostly used by member customers
* Classic bikes are the most frequently used bikes by both customers but they all use docked bikes for longer rides
* Casual customers use classic bikes more often than member customers 
* Member customers use electric bikes more often than casual customers
    
## Recommendations for an effective marketing strategy
Based on the results of the analysis, here are nine recommendations for designing marketing strategies aimed at converting casual riders into annual members:

* __1. Offer promotions and discounts for annual memberships during weekdays__: 
Member customers tend to use the bikes more often. This can encourage casual riders to become members and take advantage of the benefits of more frequent rides during weekdays.

* __2. Promote the benefits of annual membership for weekend riders__: 
Although casual and member customers have similar number of rides during weekends, annual members have more flexibility to take longer trips without worrying about extra fees. Marketing campaigns should emphasize this benefit to encourage casual riders to become annual members.

* __3. Offer incentives to encourage casual riders to use docked bikes more often__: 
Since casual riders account for the majority of trips made with docked bikes, incentives such as discounts or free rides can encourage them to become more loyal customers and potentially convert to annual members.

* __4. Focus marketing efforts on promoting the benefits of using bikes from different starting stations__: 
Since casual customers tend to use a specific starting station much more often, marketing campaigns should focus on the benefits of exploring different areas and using bikes from different starting stations. This can encourage casual riders to become more adventurous and potentially become annual members.

* __5. Highlight the cost savings of annual memberships for frequent riders__: 
The analysis shows that casual riders tend to use bikes for longer duration than annual members. Promoting the cost savings of an annual membership for frequent riders can encourage casual riders to become members and take advantage of the cost savings for longer trips.

* __6. Offer membership trial periods__: 
The company can offer casual riders the chance to try out the annual membership for a certain period of time (e.g. a week or a month) to see if they would benefit from the service. This can help to increase the number of annual members by giving casual riders a chance to experience the benefits of an annual membership without committing to it fully.

* __7. Create a community for annual members__: 
Since annual members tend to be more frequent users of the service, the company can create a community for them to promote social interaction and encourage them to use the service more often. This can help to increase their loyalty to the service and encourage casual riders to convert to annual members.



Find the full report [here](main.Rmd).
