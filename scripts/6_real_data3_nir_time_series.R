library(tidyverse)
library(janitor)
library(plotly)


nir_times <- read_csv("./input_data/nir_times/nir_time.csv", 
                      # note use of skipping rows
                      skip = 11)

# our tibble contains some messy names.
head(nir_times)

# if we aren't skipping lines, we get this mess
read_csv("./input_data/nir_times/nir_time.csv", 
     skip = 0)


# bunch of preparatory stuff to get ready to plot
times_to_plot <- nir_times |> 
  clean_names() |> 
  select(1:7) |> 
  # cleaning up time data
  mutate(ith_run = 1:n(), 
         ### lubridate makes working with dates much easier!###
         date = lubridate::mdy(date),
         # make date time, force computer to recognize
         # correct timezone
         date_time = parse_datetime(paste(date, time), 
              locale = locale(tz = "US/Eastern"))
         ) |> 
  group_by(date) |> 
  # calculate lag between samples (another tidyverse function)
  mutate(time_between = time - lag(time))

# how do the data look?
head(times_to_plot)

# we've got a GIANT OUTLIER! (Thursday, Jan 26, ~ 11 - 1 pm)
# does anybody want to guess what it is?
times_to_plot |>
  ggplot(aes(ith_run, time_between)) + 
  geom_point()

# somewhat silly
# times_to_plot |> 
#   filter(time_between < 6000) |>
#   ggplot(aes(date_time, hms::as_hms(time_between))) + 
#   geom_line()


(time_plot <- times_to_plot |>
  filter(time_between < 6000, date < "2023-01-30") |>
    # need to use as_hms to get something nicely plottable
  ggplot(aes(ith_run, hms::as_hms(time_between))) +
    # need text for ggplotly #
  geom_line(aes(text = time)) + 
  theme_bw() + 
  ylab("Lag Between Samples (Minutes)") + 
  xlab("Number of Samples Run") +
  labs(title = "Time Lag Between Scanned NIR Samples", 
       subtitle = "Peaks are breaks to clean cells"))

# make into a plotly, use a tool tip
(plotly_fig <- ggplotly(time_plot))

# try a plot by operator
(ttp1 <- times_to_plot |>
  filter(time_between < 6000, date < "2023-01-30") |>
  ggplot(aes(ith_run, hms::as_hms(time_between), color = operator)) +
  geom_smooth(method = "lm"))

ttp1 +
  # FACET WRAPPING BY DAY, SHOW DIFFERENCES BY DAY
  # Note how we set scales to free
  # not a great plot, mostly wanted to demo faceting and free scales...
  facet_wrap(vars(date), ncol = 4, scales = "free_x")

# BUT let's capitalize our names

ttp1 + 
  facet_wrap(vars(date), ncol = 4, scales = "free_x") +
  scale_color_discrete(labels=c("Ryan", "Miguel"))



