#### Randomisation of Playback Experiments ####

##### Set-Up #####

# clear environment
rm(list = ls())



##### Phase One: Woodland Site #####

# generate a dataframe, containing row of all playback recordings to be played
playback_recordings <- c("dunnock", "chiffchaff", "willow_warbler", "wren", "great_tit", "robin", "goldcrest", "chaffinch", "blackbird", "wood_pigeon")

# generate a dataframe with the (random) playback schedule for each AudioMoth
# generate empty dataframe for overall schedule
woodland_playback_schedule <- data.frame(
  audiomoth_ID = rep(NA, 200),
  species_call = rep(NA, 200)
)

# Add each randomised schedule to woodland_playback_schedule
for (i in 1:20) {
  
  # Loop to create 20 shuffled datasets
  playback <- data.frame(
    audiomoth_ID = i,
    species_call = playback_recordings,
    stringsAsFactors = FALSE
  )
  
  # row indexing for adding data to combined dataset
  start_row <- (i-1) * 10 + 1
  end_row <- i * 10
  
  # add the schedule for AudioMoth[i] to the appropriate part of the combined schedule
  woodland_playback_schedule[start_row:end_row, ] <- playback
}

# now randomise the schedule, to avoid any pseudoreplication
woodland_playback_schedule <- woodland_playback_schedule[sample(nrow(woodland_playback_schedule)), ]

# check final schedule
View(woodland_playback_schedule)

# might need to add additional code if I am going to repeat this 4x at each corner of the grid - but need to discuss time constraints with supervisor

# save the schedule to the project folder as reference for designing playbacks
write.csv(woodland_playback_schedule, "./data/phase1_woodland_playback.csv", row.names = FALSE)



##### Phase One: Moorland Site #####