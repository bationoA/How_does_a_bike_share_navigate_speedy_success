install.packages("tidyverse")
install.packages("lubridate") # Manipulate date attributes
install.packages("httr")
install.packages("rvest")

library("tidyverse")
library(httr)

get_links_with_keywords <- function(url, keywords, all_keywords=TRUE){
  # url: the URL of the website to scrape
  # keywords: the list keywords to search for in each links
  # Example: c("keyword1", "keyword2", "keyword3")
  ## All kewords should be found in a link for that link to be valid
  
  # Load necessary libraries
  library(rvest)
  
  # Use rvest to scrape the website and extract the links
  page <- read_html(url)
  links <- page %>% 
    html_nodes("a") %>% 
    html_attr("href")
  
  # Create a regular expression pattern that matches all the keywords
  pattern <- paste0("(?=.*", paste(keywords, collapse = ".*"), ").*\\.zip$")
  
  if (!all_keywords){
    # Filter the links to keep only those containing the keywords
    filtered_links <- links[grep(paste(keywords, collapse="|"), links)]
  } else{
    # Filter the links to keep only those containing all the keywords
    filtered_links <- links[grepl(pattern, links, perl = TRUE)]
  }
  return(filtered_links)
}

get_csv_from_zip_in_one_csv <- function(zip_file, search_subtext, dirct, 
                                        except_subtext = c(NULL)){
  # Get the list of files in the zip file
  zip_filepath <- paste0(dirct, zip_file)
  files_in_zip <- unzip(zip_filepath, list=TRUE)
  
  # Extract just the file names from the list of files in the zip file
  file_names_inside_zip <- files_in_zip[, "Name"]
  
  # Create empty dataframe to store combined data
  tmp_combined_data <- data.frame()
  
  for (file_name in file_names_inside_zip){
    if (all(sapply(search_subtext, grepl, file_name)) & 
        !any(sapply(except_subtext, grepl, file_name))) {
      
      # print(zip_filepath)
      print(paste0("Extracting from: ", file_name))
      
      # Read in the csv file and add it to the combined data
      # extract the file from the zip archive and read it into R
      tmp_csvdata <- read.csv(unzip(zip_filepath, file_name), 
                              stringsAsFactors = FALSE)
      # colnames(tmp_csvdata) <- df_colname
      
      tmp_combined_data <- bind_rows(tmp_combined_data, tmp_csvdata)
      
      # remove csv file
      file.remove(file_name)
    }
  }
  return(tmp_combined_data)
}

download_zip_files <- function(url_list, 
                               search_subtext = c("Divvy_Trips"),
                               years_range = c(2015:2017),
                               except_subtext = c(NULL)){
  # Set directory for saving downloaded files
  dir <- "downloaded_zip/"
  
  combined_data = data.frame()
  
  # filtered_links <- links[grep(paste(keywords, collapse="|"), links)]
  url_list <- url_list[grep(paste(years_range, collapse="|"), url_list)]
  
  # Loop through each year and month and download and extract the zip files
  i <- 0
  for (fileurl in url_list) {
    print(paste0(round(100*i/length(url_list)), "%"))
    # Construct URL for the zip file. Example: 202303-divvy-tripdata.zip
    # filename <- paste0(year, sprintf("%02d", month), "-divvy-tripdata.zip")
    # fileurl <- paste0(url, filename)
    filename <- strsplit(fileurl, "/")[[1]][4]
    filepath <- paste0(dir, filename)
    
    if (!file.exists(filepath)){# If file deos not exist then...
      # Download and save the zip file
      print(paste0("Downloading ", filename))
      GET(fileurl, write_disk(filepath, overwrite = TRUE))
    }
    
    # Extract the csv file from the zip file
    csvdata = get_csv_from_zip_in_one_csv(zip_file = filename,
                                          search_subtext = search_subtext, 
                                          dirct = "downloaded_zip/",
                                          # df_colname = df_colname,
                                          except_subtext = except_subtext)
    
    combined_data <- bind_rows(combined_data, csvdata)
    
    i <- i + 1
  }
  print("100%")
  
  return(combined_data)
}

# We need to download the all quarters data trips (from 2015Q1 to 2020 Q1) and 
# all data from April (4th month) 2020 to march (3rd month) 2023

url <- "Index_of_bucket_divvy-tripdata.html"

keywords1 <- c("Divvy_Trips_", ".zip")
list_Divvy_Trips_zip <- get_links_with_keywords(url = url, 
                                                keywords = keywords1)

#

# Data 1:--------------------- 2015 to 2017
for (year in 2015:2020){
  years_range = c(year)
  df_2015_to_2017 <- download_zip_files(
    url_list = list_Divvy_Trips_zip,
    years_range = years_range,
    search_subtext = c("Divvy_Trips_", ".csv"), 
    except_subtext = c("Stations", "MACOSX"))
  
  # Export to CSV
  filename = paste0('data_', ifelse(year != 2020, year, paste0(year, "_Q1")), 
                    '.csv')
  write.csv(df_2015_to_2017, file=file.path("data", filename), row.names = FALSE)
}

# ==============================================================================

keywords2 <- c("-divvy-tripdata", ".zip")
list_divvy_tripdata_zip <- get_links_with_keywords(url = url, 
                                                   keywords = keywords2)
list_divvy_tripdata_zip

# Data 4:--------------------- 2020 Q2 to 2020-11
years_range = c(202004:202011)
df_2020_Q2_to_2020_11 <- download_zip_files(url_list = list_divvy_tripdata_zip, 
                                    years_range = years_range,
                                    search_subtext = c("-divvy-tripdata", ".csv"), 
                                    except_subtext = c("Stations", "MACOSX"))
dim(df_2020_Q2_to_2020_11)


filter(df_2020_Q2_to_2020_11, is.na(end_station_name))

#View(head(df_Q2_to_2023))
# Export to CSV
write.csv(df_2020_Q2_to_2020_11, file=file.path('data', 'data_2020_Q2_to_2020_11.csv'), row.names = FALSE)


# Data 5:--------------------- 2020-12 Q2 to 2023
years_range = c(202012, 2021:2023)
df_2020_12_to_2023 <- download_zip_files(url_list = list_divvy_tripdata_zip, 
                                            years_range = years_range,
                                            search_subtext = c("-divvy-tripdata", ".csv"), 
                                            except_subtext = c("Stations", "MACOSX"))
dim(df_2020_12_to_2023)
#View(head(df_2020_12_to_2023))
# Export to CSV
write.csv(df_2020_12_to_2023, file=file.path('data', 'data_2020_12_to_2023.csv'), row.names = FALSE)

#=================================== END ======================================#