# Read all clean tracks and save them toghether in a combined csv file

# Libraries
library(tidyverse)

# List all CSV files in the cleaned_track_data folder
files <- list.files("cleaned_track_data", full.names = TRUE, pattern = "\\.csv$")

# Create a new folder called combined_track_data
if (!dir.exists("combined_track_data")) {
  dir.create("combined_track_data")
}

# Read each file and bind them into a single dataframe
cleaned_tracks_alltogether <- files %>%
  map_df(~ read_csv(.))

# Save the combined data to the new folder
write_csv(cleaned_tracks_alltogether, "combined_track_data/cleaned_tracks_alltogether.csv")