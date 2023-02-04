library(tidyverse)
library(ggridges)

# idea and plotting code shamelessly borrowed from:
# https://cran.r-project.org/web/packages/ggridges/vignettes/introduction.html

ith_22 <- read_csv("./input_data/weather_data/2022_daily_temps.csv")

head(ith_22)


ith_22 |> 
  distinct(STATION)
# we have four stations

ith_22 |> 
  group_by(STATION) |> 
  summarize(sum(is.na(TMIN)), sum(is.na(TMAX)))

# only the last station has no missing data (I think this is Cornell, but maybe the airport)

# choose it to keep things simple

# filter it and calculate mean temp

ith_weather <- ith_22 |> 
  filter(STATION == "USC00304174") |> 
  transmute(
    STATION, 
    DATE, 
    mean_temp = rowMeans(across(c(TMAX, TMIN))), 
    month = lubridate::month(DATE, label = T, abbr = F))


ggplot(ith_weather, aes(x = mean_temp, y = month, fill = stat(x))) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01) +
  scale_fill_viridis_c(name = "Temp. [F]", option = "C") +
  labs(title = 'Temperatures in Ithaca NY in 2022') + 
  theme_ridges() + 
  ylab("Month") + 
  xlab("Mean Temperature")
        

# stat(x) is apparently necessary
# ggplot(ith_weather, aes(x = mean_temp, y = month, fill = stat(y))) +
#   geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01) +
#   scale_fill_viridis_c(name = "Temp. [F]", option = "C") +
#   labs(title = 'Temperatures in Ithaca NY in 2022')
