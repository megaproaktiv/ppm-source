pak::pak("tidyverse/ggplot2")
library(ggplot2)

png("scatter.png", width=1065, height=584)
ggplot(mpg, aes(displ, hwy, colour = class)) + 
  geom_point()
dev.off()