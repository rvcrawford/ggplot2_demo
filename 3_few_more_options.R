# plot points
iris |> 
  ggplot(aes(x = Species, y = Sepal.Length)) + 
  geom_point()

######### POTENTIAL OVERPLOTTING! ######

# how to deal with that

# adjusting alpha level
iris |> 
  ggplot(aes(x = Species, y = Sepal.Length)) + 
  geom_point(alpha = 0.5)

# once more
iris |> 
  ggplot(aes(x = Species, y = Sepal.Length)) + 
  geom_point(alpha = 0.2)

# try geom_jitter

(iris_jitter <- iris |> 
  ggplot(aes(x = Species, y = Sepal.Length)) + 
  geom_jitter(aes(color = Species)))

# summary statistics (defaults to mean)
iris_jitter+ 
  stat_summary()

# fancy summary stats (bootstrapped means I think, read docs for better references)
iris_jitter+ 
  stat_summary(fun.data = "mean_cl_boot", size = 0.5) + 
# WE CAN ALSO REORDER ITEMS IN THE PLOT
  scale_x_discrete(limits=c("versicolor", "virginica", "setosa"))


#### ORDER MATTERS ###

# another geom--geom_violin...
# geom_violin

iris |> 
  ggplot(aes(x = Species, y = Sepal.Length)) + 
  geom_jitter() + 
  geom_violin()

# note that we've plotted over our points

iris |> 
  ggplot(aes(x = Species, y = Sepal.Length)) + 
  geom_violin() + 
  geom_jitter()

# maybe we'd want some other arrangment of the dots here...

###  COLORS#####

# map color to continuous value, as well as discrete
cars_plot + 
  geom_point(aes(color = qsec))


# can also choose our gradient

# https://ggplot2.tidyverse.org/reference/scale_gradient.html

# note how we have to set the midpoint manually 
mtcars |> 
  ggplot( aes(x = wt, y = hp)) +
  geom_point(aes(colour = drat)) + 
  scale_colour_gradient2(midpoint = mean(mtcars$drat))


