library(tidyverse)
#  handles spatial data, projections, etc; sf = spatial features
library(sf)
# contains maps
library(maps)
library(plotly)

# sf lets you match up projections etc. 
states <- st_as_sf(map("state", plot = FALSE, fill = TRUE))

# plot whole US
ggplot(data = states) +
  # plots our shape
  geom_sf() 

states2 <- bind_cols(states, st_coordinates(st_point_on_surface(states)))

st_of_int <- c("new york", "pennsylvania", "ohio", "new jersey")

ggplot(data = states2 |> filter(ID %in% st_of_int)) +
  geom_sf(fill = "pink") + 
  # turn off just about everything
  theme_void() +
  geom_text(data = states2 |> filter(ID %in% st_of_int), aes(X, Y, label = ID))



(ne_map <- ggplot(data = states) +
  geom_sf(fill = "lightblue") + 
  # note use of coordinate boxes
  coord_sf(xlim = c(-84, -69), ylim = c(38, 46), expand = FALSE))

# load in US cities 

data(us.cities)

# get some points
cities <-  st_as_sf(us.cities, coords = c("long", "lat"), remove = F,crs = 4326,agr = "constant")

# add cities in our box
(ne_map2 <- ggplot(data = states) +
  geom_sf(fill = "lightblue") + 
  geom_sf(data = cities) + 
    # note that "text" gives us our tooltip
  geom_point(data = us.cities, aes(x = long, y = lat, text = name), colour="red", alpha=1/2)+
  # note use of coordinate boxes
  coord_sf(xlim = c(-84, -69), ylim = c(38, 46), expand = FALSE))

(fig <- ggplotly(ne_map2))

        