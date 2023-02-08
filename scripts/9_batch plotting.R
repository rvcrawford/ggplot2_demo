library(tidyverse)
#### doing things in batches ###

# boring old iris again
head(iris)
str(iris)

#### may be better ways to do this, but this is how I tend to ###
iris_long <- iris |> 
  pivot_longer(-Species) 

head(iris_long)


(iris_nested <- iris_long |> 
      nest_by(name))
  
iris_nested$data |> head()

(iris_plots_1 <- iris_nested |> 
  ungroup() |> 
  mutate(my_plots = 
    # looks like some sort of weird conflict, have to specify
    # that we're using map()
    purrr::map(data, ~ ggplot(.x, 
              aes(x = Species, value, color = Species)) +
                  geom_boxplot())))
  

iris_plots_1$my_plots
# but it's unclear what our values are!

# fixing this...
(iris_plots_2 <- iris_nested |> 
  ungroup() |> 
  mutate( my_plots = 
            # use map2()
            purrr::map2(data, name,  ~ ggplot(.x, 
                                      aes(x = Species, value,
                                          color = Species)) +
                         geom_boxplot() + ylab(.y))))

iris_plots_2$my_plots

# use map2 to name plots specify a drive
map2(iris_plots_2$my_plots,iris_plots_2$name, ~ggsave(plot = .x, filename = paste0("./plots/",.y, ".png")))

     