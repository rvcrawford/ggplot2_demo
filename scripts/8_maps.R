library(tidyverse)
#  handles spatial data, projections, etc; sf = spatial features
library(sf)
# contains maps
library(maps)

# sf lets you match up projections etc.
states <- st_as_sf(map("state", plot = FALSE, fill = TRUE))

# plot whole US
ggplot(data = states) +
  # plots our shape
  geom_sf() 

states2 <- bind_cols(states, st_coordinates(st_point_on_surface(states)))

st_of_int <- c("new york", "pennsylvania", "ohio", "new jersey")

ggplot(data = states |> filter(ID %in% st_of_int)) +
  geom_sf(fill = "pink") + 
  # turn off coordinates
  theme_void() +
  geom_text(data = states2 |> filter(ID %in% st_of_int), aes(X, Y, label = ID))



ggplot(data = states) +
  geom_sf(fill = "lightblue") + 
  coord_sf(xlim = c(-84, -69), ylim = c(38, 46), expand = FALSE) 

