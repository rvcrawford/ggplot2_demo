# plot points by species
iris |> 
  ggplot(aes(x = Species, y = Sepal.Length)) + 
  geom_point()

######### POTENTIAL OVERPLOTTING! ######

# how to deal with that?

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

# summary statistics (defaults to mean and SE)
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

# maybe we'd want some other arrangement of the dots here...

###  COLORS#####

# map color to continuous value, as well as discrete
# also use "size" argument to make dots bigger
cars_plot + 
  geom_point(aes(color = qsec), size = 3)

# we can assign colors manually
iris |> 
  ggplot(aes(x = Species, y = Sepal.Length))+
  geom_jitter(aes(color = Species)) +
  scale_color_manual(values = c("red", "blue", "green"))

# vector of colors, taken from https://colorbrewer2.org
# i think that this is hexadecimal code (?)
my_col <- c('#7fc97f','#beaed4','#fdc086')

iris |> 
  ggplot(aes(x = Species, y = Sepal.Length))+
  geom_jitter(aes(color = Species)) +
  # pass in vector of colors via scale_color_manual
  scale_color_manual(values = my_col)

# can also choose a gradient (shown later)



