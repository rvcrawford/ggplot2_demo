tids <- tidyverse::tidyverse_packages(include_self = TRUE)

my_pk <- function(pkg){
  eval(bquote(library(.(pkg))))
  return(lsf.str(paste("package:", pkg, sep = "")) |> as.vector())
}

out <- tids |> purrr::map(my_pk)

tt <- tibble(pkg_name = tids) |> 
  mutate(fns = map(pkg_name, my_pk)) |> 
  unnest(fns)

tt |> head()

tt |> filter(str_detect(fns, "^geom"))

tt |> 
  count(pkg_name) |>
  ggplot(aes(x = pkg_name, y = n)) + 
    geom_point()

tt |> 
  count(pkg_name) |>
      ggplot(aes(x = fct_reorder(pkg_name,-n), y = n)) + 
      geom_point(color = "red", size = 2, shape = 12) + 
      theme_dark(18)

data(mtcars)

mtcars |> 
  ggplot(aes(wt, hp)) + 
  geom_point()

mtcars |> 
  ggplot(aes(x = hp)) + 
  geom_histogram()

mtcars |> 
  ggplot(aes(x = hp, y = qsec)) + 
  geom_point() + 
  geom_smooth(method = "lm")+
  stat_summary(
    fun.data = "mean_cl_boot",
    geom = "crossbar",
    colour = "red", width = 0.3
  ) 

library(usethis)
use_git_config(user.name = "rvcrawford", user.email = "rvcrawford@gmail.com")
