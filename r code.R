# Purpose of the script
# Your name, date and email

# Your working directory, set to the folder you just downloaded from Github, e.g.:
setwd("~/Downloads/CC-4-Datavis-master")

# Libraries - if you haven't installed them before, run the code install.packages("package_name")
library(tidyr)
library(dplyr)
library(ggplot2)
library(readr)
library(gridExtra)
# Import data from the Living Planet Index - population trends of vertebrate species from 1970 to 2014
LPI <- read.csv("LPIdata_CC.csv")
LPI2 <- gather(LPI, "year", "abundance", 9:53)
View(LPI2)
LPI2$year <- parse_number(LPI2$year)
str(LPI2)
LPI2$abundance <- as.numeric(LPI2$abundance)
unique(LPI2$Common.Name)
vulture <- filter(LPI2, Common.Name == "Griffon vulture / Eurasian griffon")
head(vulture)

# There are a lot of NAs in this dataframe, so we will get rid of the empty rows using na.omit()
vulture <- na.omit(vulture)
LPI2$abundance <- as.numeric(LPI2$abundance)
vulture <- na.omit(vulture)
# With base R graphics
base_hist <- hist(vulture$abundance)
vulture_hist <- ggplot(vulture, aes(x = abundance))  +
  geom_histogram()
vulture_hist
(vulture_hist <- ggplot(vulture, aes(x = abundance))  +
    geom_histogram())

(vulture_hist <- ggplot2(vulture, aes(x = abundance)) +                
    geom_histogram(binwidth = 250, colour = "#8B5A00", fill = "#CD8500") + geom_vline(aes(xintercept = mean(abundance)),                       # Adding a line for mean abundance
                                                                                      colour = "red", linetype = "dashed", size=1) +           # Changing the look of the line
    theme_bw() + ylab("Count\n") +                                                   # Changing the text of the y axis label
    xlab("\nGriffon vulture abundance")  +                              # \n adds a blank line between axis and text
    theme(axis.text = element_text(size = 12),                          # Changing font size of axis labels and title
          axis.title.x = element_text(size = 14, face = "plain"),panel.grid = element_blank(),                                 # Removing the grey grid lines
          plot.margin = unit(c(1,1,1,1), units = , "cm")))    

(vulture_hist <- ggplot(vulture, aes(x = abundance)) +                
    geom_histogram(binwidth = 250, colour = "#43CD80", fill = "#FF3030") +    # Changing the binwidth and colours
    geom_vline(aes(xintercept = mean(abundance)),                       # Adding a line for mean abundance
               colour = "red", linetype = "dashed", size=1) +           # Changing the look of the line
    theme_bw() +                                                      # Changing the theme to get rid of the grey background
    ylab("Count\n") +                                                   # Changing the text of the y axis label
    xlab("\nGriffon vulture abundance")  +                              # \n adds a blank line between axis and text
    theme(axis.text = element_text(size = 12),                          # Changing font size of axis labels and title
          axis.title.x = element_text(size = 14, face = "plain"),       # face="plain" is the default, you can change it to italic, bold, etc. 
          panel.grid = element_blank(),                                 # Removing the grey grid lines
          plot.margin = unit(c(1,1,1,1), units = , "cm")))              # Putting a 1 cm margin around the plot

# We can see from the histogram that the data are very skewed - a typical distribution of count abundance data
install.packages("colourpicker")# Filtering the data to get records only from Croatia and Italy using the `filter()` function from the `dplyr` package
vultureITCR <- filter(vulture, Country.list %in% c("Croatia", "Italy"))

# Using default base graphics
plot(vultureITCR$year, vultureITCR$abundance, col = c("#1874CD", "#68228B"))

# Using default ggplot2 graphics
(vulture_scatter <- ggplot(vultureITCR, aes(x = year, y = abundance, colour = Country.list)) +  # linking colour to a factor inside aes() ensures that the points' colour will vary according to the factor levels
    geom_point())

