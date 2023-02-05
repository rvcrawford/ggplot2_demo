library(tidyverse, attach.required = T)
library(janitor)

nir_times <- read_csv("./input_data/nir_times/nir_time.csv", skip = 11)

times_to_plot <- nir_times |> 
  clean_names() |> 
  select(1:6) |> 
  mutate(ith_run = 1:n()) |> 
  group_by(date) |> 
  # calculate time to run next sample
  mutate(time_between = time - lag(time))

times_to_plot |> filter(time_between>6000)

times_to_plot |> 
  ggplot(aes(ith_run, time_between)) + geom_point()

times_to_plot |> 
  filter(time_between < 6000) |>
  ggplot(aes(ith_run, hms::as_hms(time_between))) + geom_line()

