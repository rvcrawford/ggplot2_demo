#### 2. SOME OPTIONS #######


# adjust theme
iris_plot + 
  theme_bw()

iris_plot + 
  theme_classic()

# add a title

iris_plot + 
  labs(title = "My Awesome Iris Plot", 
       # NOTE LINE BREAK IN SUBTITLE "\n"
       subtitle = "Data Visualization \nis My Passion")

## adjust theme size

iris_plot + 
  theme_bw(24)

# adjust legend position

# (very helpful page for how to adjust these parameters)
# http://www.sthda.com/english/wiki/ggplot2-legend-easy-steps-to-change-the-position-and-the-appearance-of-a-graph-legend-in-r-software

iris_plot + 
  theme(legend.position="bottom")

# put legend in the plot
iris_plot +
  theme(legend.position = c(0.9, 0.8))

# turn off legend
iris_plot + 
  theme(legend.position='none')

# change fonts
iris_plot + 
  theme(text=element_text(family="serif"))

# change fonts again
iris_plot + 
  theme(text=element_text(family="Palantino"))

# my impression is that there may be differences in this stuff 
# depending on your OS.

##### adding lines/ smoothers

# add loess smoother
cars_plot + 
  geom_smooth()

# add a linear model
cars_plot + 
  geom_smooth(method = "lm")

# smooth by groups
iris_plot + 
  geom_smooth()

# what if we just want one line, but colored dots
iris_plot + 
  geom_smooth(aes(x = Sepal.Width, y = Sepal.Length))

# doesn't work (I believe) because we've told ggplot that Species will be a grouping variable at the global level of the plot

# but the following works 
iris |> 
  ggplot(aes(x = Sepal.Width, y = Sepal.Length)) + 
  # applies additional aesthetic for color at the "point" level
  geom_point(aes(col = Species)) + 
  geom_smooth(method = "lm")


# modfiying a bunch of parameters 

# ggplot docs contain a bunch of info on what is what
iris |> 
  ggplot(aes(x = Sepal.Width, y = Sepal.Length)) + 
  # modifying shapes
  geom_point(aes(col = Species), shape = 4) + 
  # turned off standard errors ("se = F")
  # modified line type argument ("lty")
  # made it big
  # kind of silly
  geom_smooth(method = "lm", se = F, lty = 4, color = "darkblue", size = 3)


# one more for good measure...
# using shape to distinguish between species...

iris |> 
  ggplot(aes(x = Sepal.Width, y = Sepal.Length)) + 
  # modifying shapes
  geom_point(aes(shape = Species))


