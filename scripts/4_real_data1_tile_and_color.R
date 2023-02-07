library(tidyverse)
library(broom)
# load the full tidyverse just to keep things simple 

# first load our nursery data

nurs_data <- read_csv("./input_data/nursery_data_2019/plot_means.csv") |> 
  rename(rng = range) |> 
  select(rng, row, leaf_hgt_2020)

head(nurs_data)

nurs_plan <- read_csv("./input_data/nursery_data_2019/field_plan.csv") |> 
  rename(population = blk) |> 
  select(-old_plant_no)

head(nurs_plan)

nurs_2 <- left_join(nurs_plan, nurs_data) |> 
  # convert replication to character to fit model
  mutate_at(vars(rep), as.character)

head(nurs_2)

mod <- lm(leaf_hgt_2020 ~ rng + row + hs, data = nurs_2)
summary(aov(mod))

nurs_3 <- nurs_2 |> 
  # use transmute to only keep relevant variables
  transmute(rng, row, rep, resid = mod$residuals)

head(nurs_3)

######## moisture gradient within a field

# finally, make our plot
nurs_3 |> 
  ggplot(aes(x = row, y = rng)) + 
  # use geom_tile to make heatmaps
  geom_tile(aes(fill = resid)) + 
  # lets make a gradient
  # we need to supply a value for our gradient
  scale_fill_gradient2(low = "red", midpoint = median(nurs_3$resid), high = "darkgreen")

# thus we can see pattern of spatial variation within the nursery (wet and dry portions, edge effects)

# https://ggplot2.tidyverse.org/reference/scale_gradient.html

#### trivial but very useful below, especially when your fields get complicated! #########

# answer the question of whether we made/ numbered our field plan correctly

nurs_3 |> 
  ggplot(aes(x = row, y = rng)) + 
  geom_tile(aes(fill = rep))

# test if rows are correctly coded even / odd
nurs_3 |> 
  ggplot(aes(x = row, y = rng)) + 
  # note modulus operator to test for odd
  geom_tile(aes(fill = ifelse(row %% 2 == 1, "a", "b")))
