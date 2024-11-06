library(tidyverse)
library(here)
library(palmerpenguins)
library(janitor)


colnames(penguins_raw)
# [1] "studyName"           "Sample Number"       "Species"            
# [4] "Region"              "Island"              "Stage"              
# [7] "Individual ID"       "Clutch Completion"   "Date Egg"           
# [10] "Culmen Length (mm)"  "Culmen Depth (mm)"   "Flipper Length (mm)"
# [13] "Body Mass (g)"       "Sex"                 "Delta 15 N (o/oo)"  
# [16] "Delta 13 C (o/oo)"   "Comments"
#saving to current directory
write.csv(penguins_raw, here("data","penguins_raw.csv"))

#silly as overrides
penguins_raw <- select(penguins_raw, -Comments)

colnames(penguins_raw)
# [1] "studyName"           "Sample Number"       "Species"            
# [4] "Region"              "Island"              "Stage"              
# [7] "Individual ID"       "Clutch Completion"   "Date Egg"           
# [10] "Culmen Length (mm)"  "Culmen Depth (mm)"   "Flipper Length (mm)"
# [13] "Body Mass (g)"       "Sex"                 "Delta 15 N (o/oo)"  
# [16] "Delta 13 C (o/oo)"  

penguins_raw <- read.csv(here("data","penguins_raw.csv"))

#now saving as a different thing and using piping
penguins_clean <- penguins_raw %>% 
  select(-Comments) %>% 
  select(-starts_with("Delta"))

colnames(penguins_clean)
# [1] "X"                   "studyName"           "Sample.Number"      
# [4] "Species"             "Region"              "Island"             
# [7] "Stage"               "Individual.ID"       "Clutch.Completion"  
# [10] "Date.Egg"            "Culmen.Length..mm."  "Culmen.Depth..mm."  
# [13] "Flipper.Length..mm." "Body.Mass..g."       "Sex"  

#with janitor makes them all unified, improves names
penguins_clean <- penguins_raw %>% 
  select(-Comments) %>% 
  select(-starts_with("Delta")) %>% 
  clean_names()

colnames(penguins_clean)

write.csv(penguins_clean, here("data","penguins_clean.csv"))


#doing it in function form because that's how we roll
cleaning_columns <- function(raw_data){
  raw_data %>% 
    select(-Comments) %>% 
    select(-starts_with("Delta")) %>% 
    clean_names()
}

baby_boi <- cleaning_columns(penguins_raw)

renv::init()

renv::snapshot()
y