library("tidyverse")
library("lubridate")

# -------------- Read all extracted csv files
#______________________________________________________________________________#

df_2015_to_2017 <- read_csv("data_2015_to_2017.csv")
df_2018 <- read_csv("data_2018.csv")

df_2019_to_2020_Q1 <- read_csv("data_2019_to_2020_Q1.csv")
colnames(df_2019_to_2020_Q1)
View(tail(df_2019_to_2020_Q1))

df_2020_Q2_to_2020_11 <- read_csv("data_2020_Q2_to_2020_11.csv")
colnames(df_2020_Q2_to_2020_11)

df_2020_12_to_2023 <- read_csv("data_2020_12_to_2023.csv")
colnames(df_2020_12_to_2023)

# -------------- Fix columns-related issues
#______________________________________________________________________________#

# ---- Data set 1: df_2015_to_2017
# format the data
# default: start_time is dmy h:m
# default: starttime is mdy h:m

# Transform dates into the same format
df_2015_to_2017$starttime <- mdy_hm(df_2015_to_2017$starttime)
df_2015_to_2017$start_time <- dmy_hm(df_2015_to_2017$start_time)
df_2015_to_2017$stoptime <- mdy_hm(df_2015_to_2017$stoptime)
df_2015_to_2017$end_time <- dmy_hm(df_2015_to_2017$end_time)

# starttime and start_time are from different csv files. The fusion has 
# introduced missing values to starttime and start_time where for rows that are 
# not from their corresponding original data set
# Replace missing values of starttime by corresponding values in start_time

# View(tail(df_2015_to_2017))

df_2015_to_2017$starttime[is.na(df_2015_to_2017$starttime)] <- 
  df_2015_to_2017$start_time[is.na(df_2015_to_2017$starttime)]
df_2015_to_2017$stoptime[is.na(df_2015_to_2017$stoptime)] <- 
  df_2015_to_2017$end_time[is.na(df_2015_to_2017$stoptime)]

View(head(df_2015_to_2017))
View(tail(df_2015_to_2017))

# Only select columns of interest
colnames(head(df_2015_to_2017))
df_2015_to_2017 <- select(df_2015_to_2017, "trip_id", "starttime", "stoptime", 
                          "bikeid", "tripduration", "from_station_id", 
                          "from_station_name", "to_station_id", 
                          "to_station_name", "usertype")
# Change the name of columns
df_2015_to_2017 <- rename(df_2015_to_2017, 
                          rid_id = trip_id, 
                          rideable_type = bikeid,
                          started_at = starttime,
                          ended_at = stoptime,
                          ride_length = tripduration, 
                          start_station_id = from_station_id, 
                          start_station_name = from_station_name, 
                          end_station_id = to_station_id, 
                          end_station_name = to_station_name,
                          member_casual = usertype)
dim(df_2015_to_2017)
View(head(df_2015_to_2017))
View(tail(df_2015_to_2017))

colSums(is.na(df_2015_to_2017)) # Check if there are any missing values in the data frame
colSums(!is.na(df_2015_to_2017)) # Check if there are any missing values in the data frame

# ---- Data set 2: df_2015_to_2017
df_2018$trip_id[is.na(df_2018$trip_id)] <- 
  df_2018$X01...Rental.Details.Rental.ID[is.na(df_2018$trip_id)]
df_2018$bikeid[is.na(df_2018$bikeid)] <- 
  df_2018$X01...Rental.Details.Bike.ID[is.na(df_2018$bikeid)]
df_2018$end_time[is.na(df_2018$end_time)] <- 
  df_2018$X01...Rental.Details.Local.End.Time[is.na(df_2018$end_time)]
df_2018$tripduration[is.na(df_2018$tripduration)] <- 
  df_2018$X01...Rental.Details.Duration.In.Seconds.Uncapped[is.na(df_2018$tripduration)]
df_2018$from_station_name[is.na(df_2018$from_station_name)] <- 
  df_2018$X03...Rental.Start.Station.Name[is.na(df_2018$from_station_name)]
df_2018$to_station_name[is.na(df_2018$to_station_name)] <- 
  df_2018$X02...Rental.End.Station.Name[is.na(df_2018$to_station_name)]
df_2018$start_time[is.na(df_2018$start_time)] <- 
  df_2018$X01...Rental.Details.Local.Start.Time[is.na(df_2018$start_time)]
df_2018$from_station_id[is.na(df_2018$from_station_id)] <- 
  df_2018$X03...Rental.Start.Station.ID[is.na(df_2018$from_station_id)]
df_2018$to_station_id[is.na(df_2018$to_station_id)] <- 
  df_2018$X02...Rental.End.Station.ID[is.na(df_2018$to_station_id)]
df_2018$usertype[is.na(df_2018$usertype)] <- 
  df_2018$User.Type[is.na(df_2018$usertype)]



# Only select columns of interest
colnames(head(df_2018))
df_2018 <- select(df_2018, "trip_id", "start_time", "end_time", 
                          "bikeid", "tripduration", "from_station_id", 
                          "from_station_name", "to_station_id", 
                          "to_station_name", "usertype")

# Change the name of columns
df_2018 <- rename(df_2018, 
                  rid_id = trip_id, 
                  rideable_type = bikeid,
                  started_at = start_time,
                  ended_at = end_time,
                  ride_length = tripduration, 
                  start_station_id = from_station_id, 
                  start_station_name = from_station_name, 
                  end_station_id = to_station_id, 
                  end_station_name = to_station_name,
                  member_casual = usertype)

colnames(head(df_2018))
View(head(df_2018))
View(tail(df_2018))
any(is.na(df_2018))  # Check if there are any missing values in the data frame

# ---- Data set 3: df_2019_to_2020_Q1
colnames(df_2019_to_2020_Q1)
View(head(df_2019_to_2020_Q1))
View(tail(df_2019_to_2020_Q1))

df_2019_to_2020_Q1$trip_id[is.na(df_2019_to_2020_Q1$trip_id)] <- 
  df_2019_to_2020_Q1$X01...Rental.Details.Rental.ID[is.na(df_2019_to_2020_Q1$trip_id)]
df_2019_to_2020_Q1$bikeid[is.na(df_2019_to_2020_Q1$bikeid)] <- 
  df_2019_to_2020_Q1$X01...Rental.Details.Bike.ID[is.na(df_2019_to_2020_Q1$bikeid)]
df_2019_to_2020_Q1$end_time[is.na(df_2019_to_2020_Q1$end_time)] <- 
  df_2019_to_2020_Q1$X01...Rental.Details.Local.End.Time[is.na(df_2019_to_2020_Q1$end_time)]
df_2019_to_2020_Q1$tripduration[is.na(df_2019_to_2020_Q1$tripduration)] <- 
  df_2019_to_2020_Q1$X01...Rental.Details.Duration.In.Seconds.Uncapped[is.na(df_2019_to_2020_Q1$tripduration)]
df_2019_to_2020_Q1$from_station_name[is.na(df_2019_to_2020_Q1$from_station_name)] <- 
  df_2019_to_2020_Q1$X03...Rental.Start.Station.Name[is.na(df_2019_to_2020_Q1$from_station_name)]
df_2019_to_2020_Q1$to_station_name[is.na(df_2019_to_2020_Q1$to_station_name)] <- 
  df_2019_to_2020_Q1$X02...Rental.End.Station.Name[is.na(df_2019_to_2020_Q1$to_station_name)]
df_2019_to_2020_Q1$start_time[is.na(df_2019_to_2020_Q1$start_time)] <- 
  df_2019_to_2020_Q1$X01...Rental.Details.Local.Start.Time[is.na(df_2019_to_2020_Q1$start_time)]
df_2019_to_2020_Q1$from_station_id[is.na(df_2019_to_2020_Q1$from_station_id)] <- 
  df_2019_to_2020_Q1$X03...Rental.Start.Station.ID[is.na(df_2019_to_2020_Q1$from_station_id)]
df_2019_to_2020_Q1$to_station_id[is.na(df_2019_to_2020_Q1$to_station_id)] <- 
  df_2019_to_2020_Q1$X02...Rental.End.Station.ID[is.na(df_2019_to_2020_Q1$to_station_id)]
df_2019_to_2020_Q1$member_casual[is.na(df_2019_to_2020_Q1$member_casual)] <- 
  df_2019_to_2020_Q1$usertype[is.na(df_2019_to_2020_Q1$member_casual)]

df_2019_to_2020_Q1 <- select(df_2019_to_2020_Q1, "trip_id", "start_time", 
                             "end_time", "bikeid", "tripduration", 
                             "from_station_id", "from_station_name", 
                             "to_station_id", "to_station_name", "member_casual")
# Change the name of columns
df_2019_to_2020_Q1 <- rename(df_2019_to_2020_Q1, 
                              rid_id = trip_id, 
                              rideable_type = bikeid,
                              started_at = start_time,
                              ended_at = end_time,
                              ride_length = tripduration, 
                              start_station_id = from_station_id, 
                              start_station_name = from_station_name, 
                              end_station_id = to_station_id, 
                              end_station_name = to_station_name)

View(head(df_2019_to_2020_Q1))
View(tail(df_2019_to_2020_Q1))

# Mer
# Add week day column
# get the day of the week
wday(head(df_2015_to_2017$started_at), label = TRUE)
