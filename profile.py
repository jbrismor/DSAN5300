import os
import pandas as pd

# Define the path to the directory containing the CSV files
input_directory = "./cleaned_rock_data"  
output_directory = "./"  

# Create the output directory if it doesn't exist
if not os.path.exists(output_directory):
    os.makedirs(output_directory)

# List all CSV files in the input directory
file_list = [os.path.join(input_directory, f) for f in os.listdir(input_directory) if f.endswith('.csv')]

# Define the columns for which we want to calculate the mean
mean_columns = ["danceability", "energy", "key", "loudness", "mode",
                "speechiness", "acousticness", "instrumentalness",
                "liveness", "valence", "tempo", "duration_ms"]

# Define the columns for which we want to calculate the mode
mode_columns = ["key_mode", "time_signature", "explicit"]

# Initialize an empty list to store the results
mean_values_list = []

# Iterate over each file
for file_path in file_list:
    # Read in the CSV file
    data = pd.read_csv(file_path)
    
    # Calculate the mean for the specified columns
    means = data[mean_columns].mean(skipna=True)
    
    # Calculate the mode for the specified mode columns
    modes = data[mode_columns].mode().iloc[0]

    # Get the artist name and ID (assuming these are the same for all rows in the file)
    artist_info = data.iloc[0][["artist_name", "artist_id"]]
    
    # Combine the means, modes, and the artist info into a dataframe
    combined = pd.concat([artist_info, means, modes]).to_frame().T
    
    # Append to the list
    mean_values_list.append(combined)

# Combine all the dataframes in the list into one dataframe
mean_values_df = pd.concat(mean_values_list, ignore_index=True)

# Set the column names for the result dataframe
mean_values_df.columns = ["artist_name", "artist_id"] + mean_columns + mode_columns

# Convert object types in the dataframe to string to prevent issues when writing to CSV
mean_values_df = mean_values_df.astype(str)

# Write the result dataframe to a CSV file in the output directory
mean_values_df.to_csv(os.path.join(output_directory, "aggregated.csv"), index=False, quotechar='"')

# Print completion message
print("Aggregation complete. Mean and mode values CSV created in the cleaned_rock_data directory.")
