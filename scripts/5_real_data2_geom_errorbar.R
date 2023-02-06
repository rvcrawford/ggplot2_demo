library(tidyverse)
library(lme4)
library(lmerTest)
swg <- read_csv("./input_data/swg_yield/new_york_seeded_plot_yields_2020_2021_2022.csv") |>
  mutate_at(vars(rep, year), as.character)

yld_sum <- swg |>
  group_by(year, entry2) |>
  summarize_at(vars(yld_dta), mean)

# yld_sum |>
#   ggplot(aes(x = entry2, y = yld_dta)) +
#   geom_point() +
#   facet_wrap(nrow = 3,vars(year))

# interaction doesn't appear significant

mod2 <- lmer(yld_dta ~ year * entry2 + (1|rep), data = swg)

anova(mod2)

emmeans::emmeans(mod2, "entry2") |>
  data.frame() |>
  ggplot(aes(x = fct_reorder(entry2, desc(emmean)), y = emmean)) +
  geom_point() +
  geom_errorbar(aes(ymin = lower.CL, ymax = upper.CL)) +
  theme_light() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  ylab("Yield (Dry Tons Per Acre)") +
  xlab("Cultivar")

