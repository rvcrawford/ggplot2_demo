library(tidyverse)
library(janitor)

nir_times <- read_csv("./input_data/nir_times/nir_time.csv", skip = 11)

# bunch of preparatory stuff to get ready to plot
times_to_plot <- nir_times |> 
  clean_names() |> 
  select(1:7) |> 
  # cleaning up time data
  mutate(ith_run = 1:n(), date = lubridate::mdy(date),
         date_time = parse_datetime(paste(date, time), locale = locale(tz = "US/Eastern"))
         ) |> 
  group_by(date) |> 
  # calculate time to run next sample
  mutate(time_between = time - lag(time))

# times_to_plot |> filter(time_between>6000)

# we've got a GIANT OUTLIER!
times_to_plot |>
  ggplot(aes(ith_run, time_between)) + geom_point()

# somewhat silly
# times_to_plot |> 
#   filter(time_between < 6000) |>
#   ggplot(aes(date_time, hms::as_hms(time_between))) + 
#   geom_line()


(time_plot <- times_to_plot |>
  filter(time_between < 6000, date < "2023-01-30") |>
  ggplot(aes(ith_run, hms::as_hms(time_between))) +
  geom_line() + 
  theme_bw() + 
  ylab("Lag Between Samples (Minutes)") + 
  xlab("Number of Samples Run") +
  labs(title = "Time Lag Between Scanned NIR Samples", subtitle = "Peaks are breaks to clean cells"))


(ttp1 <- times_to_plot |>
  filter(time_between < 6000, date < "2023-01-30") |>
  ggplot(aes(ith_run, hms::as_hms(time_between), color = operator)) +
  geom_smooth(method = "lm"))

ttp1 +
  # FACET WRAPPING BY DAY, SHOW DIFFERENCES BY DAY
  # Note how we set scales to free
  facet_wrap(vars(date), ncol = 4, scales = "free_x")

# BUT let's capitalize our names

ttp1 + 
  facet_wrap(vars(date), ncol = 4, scales = "free_x") +
  scale_color_discrete(labels=c("Ryan", "Miguel"))
# pretty good



