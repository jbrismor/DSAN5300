library(dplyr)

# Get the list of files in the temp_rock_data folder
files <- list.files("track_data", full.names = TRUE)

# Create a new folder called cleaned_track_data
if (!dir.exists("cleaned_track_data")) {
  dir.create("cleaned_track_data")
}

# Loop through each file
for (file in files) {
  # Read the file
  data <- read.csv(file)

  # Remove rows with "-" in "track_name" column
  data <- data[!grepl("-", data$track_name), ]

  # Ensure the album_release_date is in Date format
  data$album_release_date <- as.Date(data$album_release_date)

  # If duplicates in names are found, remove the one with the newest date
  data <- data %>%
    group_by(track_name) %>%
    filter(album_release_date == min(album_release_date)) %>%
    ungroup()

  # drop columns (unwanted or not informative for our purposes): album_type, album_release_date, album_release_date_precision, analysis_url, disc_number, explicit, track_href, is_local, track_preview_url, track_number, type, track_uri, external_urls.spotify, key_name, mode_name
  data <- data %>%
    select(-album_type, -album_release_date, -album_release_date_precision, -analysis_url, -disc_number, -explicit, -track_href, -is_local, -track_preview_url, -track_number, -type, -track_uri, -external_urls.spotify, -key_name, -mode_name)

  # Save the cleaned data to the new folder
  write.csv(data, paste0("cleaned_track_data/", basename(file)), row.names = FALSE)
}