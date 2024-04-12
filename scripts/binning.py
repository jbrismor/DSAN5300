import pandas as pd
import os

input_directory = "../data/modified_data"  
output_directory = "../data/cleaned_data/"

# Create the output directory if it doesn't exist
if not os.path.exists(output_directory):
    os.makedirs(output_directory)


df = pd.read_csv(os.path.join(input_directory, 'all_tracks.csv'))

# Function to categorize year into decade
def categorize_to_decade(year):
    return f"{(year // 10) * 10}s"

# Apply the function to create a new column
df['decade'] = df['album_release_year'].apply(categorize_to_decade)

df.to_csv(os.path.join(output_directory, "artist_profiles.csv"), index=False, quotechar='"')
print("decade column added to dataframe.")