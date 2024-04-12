# DSAN5300

Repo for DSAN 5300 Statistical Learning Project.

Brief summary for navigating the repo:

- First, we pulled spotify data using the `data_gathering.qmd` file in the docs folder.
- We then cleaned the data using the files inside "scripts" folder in this order:
  1. `cleaning_tracks.R`
  2. `profile.py`
  3. `The_Track_Merginator.R`
- This data needed correct labels which were fixed with the following files:
  1. `binning.py` for the track data (decades)
  2. `fixing_labels.ipynb` for the artist-level data to assign genres
- All data can be found in the data folder
- Next task: classification!!