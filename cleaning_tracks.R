# get the list of files in the temp_rock_data folder
files <- list.files("track_data", full.names = TRUE)

# create a new folder called cleaned_rock_data
dir.create("cleaned_rock_data")

# loop through each file
for (file in files) {
  # read the file
  data <- read.csv(file)
  
  # remove rows with "-" in "track_name" column
  data <- data[!grepl("-", data$track_name), ]

  # If duplicates in names are found, remove the one with the newest date in the column "album_release_date"
  data <- data[!duplicated(data$track_name, fromLast = TRUE), ]
  
  # save the cleaned data to the new folder
  write.csv(data, paste0("cleaned_track_data/", basename(file)), row.names = FALSE)
}
