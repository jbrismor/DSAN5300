# Read all clean tracks and save them toghether in a combined csv file

# Libraries
library(tidyverse)

# Define the column types, ensuring artist_name is a character
col_types <- cols(
  .default = col_guess(),  # Guess the type for all columns except for artist_name
  artist_name = col_character(),  # Ensure artist_name is treated as a character
  album_name = col_character() # Ensure album_name is treated as a character
)

# List all CSV files in the cleaned_track_data folder
files <- list.files("../data/modified_data/cleaned_track_data", full.names = TRUE, pattern = "\\.csv$")

# Read each file and bind them into a single dataframe
cleaned_tracks_alltogether <- files %>%
  map_df(~ read_csv(., col_types = col_types, show_col_types = FALSE))

# Save the combined data to the new folder
write_csv(cleaned_tracks_alltogether, "../data/modified_data/all_tracks.csv")