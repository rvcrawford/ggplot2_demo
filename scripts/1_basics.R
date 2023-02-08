#### 1. BASICS #######

# Q. Why bother? base-R is fine.

# A. Can you make a pretty base R plot?  Some people can, but not me.

# ggplot is pretty much ubiquitous (even if you don't like tidyverse), 
# plays very well with tidyverse, an easy way to learn to do a lot of stuff 
# quickly.

# note that I'm not loading the entire tidyverse
library(ggplot2)

# load datasets
data(mtcars)
data(iris)

head(iris)
head(mtcars)

# in base R
plot(mtcars$wt, mtcars$hp)

# save a few characters with:
with(mtcars, plot(wt, hp))

####### ggplot 2 ########3

# - note use of base-R pipe

# note that nothing is plotted yet - we need a geom!
mtcars |> 
  ggplot(aes(wt, hp))

(cars_plot <- mtcars |> 
  ggplot(aes(wt, hp)) + 
  geom_point())

#Q: Why doesn't the following work? 

mtcars %>%
  ggplot(aes(wt, hp)) + 
  geom_point()

# A: "%>%" comes from magrittr, which we did not load (would have loaded with library(tidyverse),
# if we did this, we would also need to use a "." before "aes" in the ggplot() call)


# looking at iris, make plots colored by species 

(iris_plot <- iris |> 
  ggplot(aes(x = Sepal.Width, y = Sepal.Length, col = Species)) + 
  geom_point())

# how about a boxplot?

(iris_boxplot <- iris |> 
    ggplot(aes(x = Species, y = Petal.Length)) + 
    geom_boxplot())

# histogram color coded by species--but something doesn't look quite right!
(iris_hist <- iris |> 
  ggplot(aes( x = Petal.Length, col = Species)) + 
  geom_histogram())

# histogram by groups
(iris_hist <- iris |> 
    # note only x supplied, used "fill" argument to specify filling the histogram
    ggplot(aes( x = Petal.Length, fill = Species)) + 
    # adjusted number of bins
    geom_histogram(bins = 20))
