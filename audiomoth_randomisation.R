#### Randomisation of AudioMoth Placement ####

##### Set-Up #####

# clear environment
rm(list = ls())



##### Phase One: Woodland Site #####

# import dataframe containing information about audiomoth placement
woodland_design <- read.csv("./data/phase1_woodland_layout.csv")

# generate vector with audiomoth IDs
audiomoth_IDs <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20)
# randomise the order of the audiomoth IDs
audiomoth_IDs_rand <- sample(audiomoth_IDs)

# add the randomised order to the dataframe
woodland_design$id <- audiomoth_IDs_rand

# check edited dataframe
View(woodland_design)

# update the file in folder, to copy into QGIS for use with MerginMaps in the field
write.csv(woodland_design, "./data/phase1_woodland_layout_edit.csv", row.names = FALSE)



##### Phase One: Moorland Site #####