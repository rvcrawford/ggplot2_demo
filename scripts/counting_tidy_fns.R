library(tidyverse)

tids <- tidyverse::tidyverse_packages(include_self = TRUE)

my_pk <- function(pkg){
  eval(bquote(library(.(pkg))))
  return(lsf.str(paste("package:", pkg, sep = "")) |> as.vector())
}

tt <- tibble(pkg_name = tids) |> 
  mutate(fns = map(pkg_name, my_pk)) |> 
  unnest(fns)

tt |> head()

# just to take a look
tt |> 
  filter(str_detect(fns, "^geom"))


