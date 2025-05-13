#### Randomisation of Playback Experiments ####

##### Set-Up #####

# clear environment
rm(list = ls())



##### Phase One: Woodland Site #####

# generate a dataframe, containing row of all playback recordings to be played
#playback_recordings <- c("dunnock", "chiffchaff", "willow_warbler", "wren", "great_tit", "robin", "goldcrest", "chaffinch", "blackbird", "wood_pigeon")
# edited species list, with 5 instead of 10
playback_recordings <- c("dunnock", "wren", "great_tit", "blackbird", "wood_pigeon")

# generate a dataframe with the (random) playback schedule for each AudioMoth
# generate empty dataframe for overall schedule
woodland_playback_schedule <- data.frame(
  experiment_no = rep(NA, 400),
  audiomoth_ID = rep(NA, 400),
  species_call = rep(NA, 400)
)

# Add each randomised schedule to woodland_playback_schedule
for (exp in 1:4) {
  
  # create a temporary dataframe to store one experiment's playback schedule
  temp_schedule <- data.frame()
  
  # create 20 shuffled datasets
  for (i in 1:20) {
    
    playback <- data.frame(
      experiment_no = exp,
      audiomoth_ID = i,
      species_call = sample(playback_recordings),
      stringsAsFactors = FALSE
    )
    
    # bind to temporary schedule for this experiment repetition
    temp_schedule <- rbind(temp_schedule, playback)
  }
  
  # calculate rows for the data
  start_row <- (exp-1) * 100 + 1
  end_row <- exp * 100
    
  # add the schedule for AudioMoth[i] to the appropriate part of the combined schedule
  woodland_playback_schedule[start_row:end_row, ] <- temp_schedule
  }

# check final schedule
View(woodland_playback_schedule)

# save the schedule to the project folder as reference for designing playbacks
write.csv(woodland_playback_schedule, "./data/phase1_woodland_playback.csv", row.names = FALSE)

# create the playlist for the woodland playback experiments

# define file paths
source_folder <- "./data/audio_files"
destination_folder <- "./data/woodland_playlist"

# loop through each row of the schedule
for (i in 1:nrow(woodland_playback_schedule)) {
  
  # get row data
  species <- woodland_playback_schedule$species_call[i]
  audiomoth <- woodland_playback_schedule$audiomoth_ID[i]
  experiment <- woodland_playback_schedule$experiment_no[i]
  
  # generate the file name
  track_number <- sprintf("%02d", i) # 0 to 2 digits
  output_filename <- paste0(
    track_number, " - ", species, " ", experiment, ".", audiomoth, ".wav")
  
  # build full paths
  source_file <- file.path(source_folder, paste0(species, ".wav"))
  destination_file <- file.path(destination_folder, output_filename)
  
  # copy the file
  file.copy(from = source_file, to = destination_file, overwrite = TRUE)

}



##### Phase One: Moorland Site #####