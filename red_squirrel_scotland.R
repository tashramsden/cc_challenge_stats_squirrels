############################################################
#                                                          #
#              Stats from Scratch Challenge                #
#            Where are all the red squirrels?              #
#               Natasha Ramsden 24/05/2021                 #
#                                                          #
############################################################

# Introduction ----

# Red squirrels, once widespread throughout the UK, have declined sharply in 
# the last century following the introduction of grey squirrels from North 
# America. Most of the remaining populations are now restricted to parts of 
# Scotland, and still threatened by the expansion of grey squirrels, which are 
# more competitive and carry the deadly squirrel pox.

# Red squirrels are a protected species and, with conservation efforts from 
# dedicated organisations, are able to maintain strongholds in various parts 
# of Scotland. These organisations also collect information on red and grey 
# squirrel sightings, and we will use these data in the challenge to learn more 
# about red squirrel population trends and habitat preferences.

# Datasets

# squirrels.csv: A dataset of grey and red squirrel observations compiled by 
# the Scottish Wildlife Trust and hosted on the NBN Atlas. The most relevant 
# variables in the dataset for this challenge are:
# Year: the year of the sighting
# Count: the number of squirrels sighted on the occasion (if blank, assume it 
# is 1)
# OSGR: the Ordnance Survey grid reference for 10 x 10 km squares; will be 
# useful to link the forest cover data

# forestcoverOS.csv: This dataset contains the forest cover (in % and total 
# area) in each OS grid cell. This dataset was created by us*, using:
# The National Forest Inventory for Scotland 2017, from the Forestry Commission
# OS grid cells at a 10 x 10 km resolution, from this Git repository


# Tasks ----

# 1. Data manipulation
# Clean the squirrel dataset for the last decade, so it’s ready to analyse. 

# 2. Temporal trends
# Determine if there is a temporal trend in the number of observations for red 
# and grey squirrels (2008-2017). 

# 3. Do red and grey squirrels prefer different habitats?
# We usually think of grey squirrels as city dwellers, while red squirrels 
# require extensive forest cover. Determine whether recent squirrel counts in 
# OS grid cells (10km) are linked to forest cover in that cell. 

# 4. Re-classify forest cover
# Building on the previous point, try turning the forest cover data into a 
# categorical variable, and use the visual representation of your choice to 
# display the median abundance of grey and red squirrels in these classes, 
# and the uncertainty around these measures.


# Set working directory ----
setwd('challenges/stats_from_scratch_squirrels')


# Libraries ----
library(tidyr)
library(dplyr)


# Import data ----
raw_squirrels <- read.csv('data/squirrels.csv')


# 1. Data manipulation ----
# Clean the squirrel dataset for the last decade, so it’s ready to analyse. 

# Be prepared to answer the question:
#   To the nearest thousand, how large is your cleaned dataset?


# Keep only observations for the years 2008 to 2017 (using the Start.date.year 
# column and renaming it to year)
squirrels = filter(raw_squirrels,  between(Start.date.year, 2008, 2017))
squirrels <- rename(squirrels, year = Start.date.year, count = Individual.count)

str(squirrels)

# Remove the observations that are not at the species level (i.e. we don’t know 
# whether they are grey or red squirrels)

squirrels <- filter(squirrels, Taxon.Rank == "species")

# Create a species column that will have Red and Grey as factor levels
squirrels <- squirrels %>% 
  mutate(species = case_when(
    Common.name == "Red Squirrel" ~ "Red",
    Common.name == "Grey Squirrel" ~ "Grey"
  ))
squirrels$species <- as.factor(squirrels$species)
str(squirrels)

# We will assume that the observations that have NA as count are observations 
# of one squirrel; replace them with the value 1.
squirrels$count <- replace_na(squirrels$count, 1)


# Remove unwanted columns (not sure if this wanted!!!) ----
small_squirrels <- dplyr::select(squirrels, species, count, year, Occurrence.ID)


# UP TO HERE!!!!!!!!!!!!!!!!! -----------

# 2. Temporal trends ----
# Determine if there is a temporal trend in the number of observations for red 
# and grey squirrels (2008-2017).

# Specifically, you should:
# Summarise the number of observations per species and per year. (That means a 
# total number of red vs grey squirrels for each year.) A more complex analysis 
# would also account for spatial autocorrelation and other factors, but as a
# preliminary analysis you are only asked to consider the total numbers at the
# national scale.
# Plot the data and run one linear model to test the question Have squirrel 
# populations increased or decreased over time, and is the trend the same for 
# red and grey squirrels?

# Be prepared to answer the questions:
#   Which species showed the strongest change over time?
#   What were your predictor variable(s) and their data type in the model?
#   What is the adjusted R-squared of the regression?
#   Considering the nature of our response variable, what modelling approach 
# would be the most appropriate? (Don’t worry if you only ran a linear 
# regression! It’s a justifiable approach for a preliminary analysis, and 
# for such large numbers the results will be similar.)
# Think about the following: what could be the reasons for this trend? Is i
# t ecologically meaningful? Are there any biases in the data to be aware of?






# 3. Do red and grey squirrels prefer different habitats? ----
# We usually think of grey squirrels as city dwellers, while red squirrels 
# require extensive forest cover. Determine whether recent squirrel counts in 
# OS grid cells (10km) are linked to forest cover in that cell. 

# Specifically, you should:
# Filter the data to the period covering 2015-2017. Summarise the squirrel 
# count data at the species and grid cell level. (You can sum counts across 
# years; this is not ideal but since we’re only dealing with a few years of 
# data this will give us a population index that allows for inconsistent 
# sampling across years, hopefully without double-counting too much.) 
# Remove observations greater than 300, as they mess up with the plots 
# later (but feel free to experiment with different subsets!).
# Merge the squirrel and forest datasets
# Visualise the scatterplot of abundance as a function of forest cover for each 
# species. Run one linear model (bonus: try a glm with the appropriate 
# distribution) to test the relationship.

# Be prepared to answer the questions:
#   Are red squirrels significantly associated with forested areas?
#   Does the model explain the variation in the data well?





# 4. Re-classify forest cover ----
# Building on the previous point, try turning the forest cover data into a 
# categorical variable, and use the visual representation of your choice to 
# display the median abundance of grey and red squirrels in these classes, 
# and the uncertainty around these measures.

# Specifically, you should:
# Transform the cover data into a cover.class variable with the following bins:
# 0-10%
# 10-20%
# 20-30%
# 30-40%
# 40-50%
# 50+%
# Create your visualisation

# Be prepared to answer the question:
# In what cover classes are red squirrels more abundant than the grey?





