


#### load libraries ####
library(ggplot2)
library(data.table)
library(ggridges)

## load data
data(lincoln_weather)

setDT(lincoln_weather)

setnames(lincoln_weather,
         c("Mean Temperature [F]"), 
         c("mean_temp"))

ggplot(lincoln_weather,
       aes(x = mean_temp, 
           y = Month, 
           fill = stat(x))) +
  geom_density_ridges_gradient(scale = 3, 
                               size = 0.3, 
                               rel_min_height = 0.01) +
  scale_fill_viridis_c(name = "Temp. [F]", option = "C") +
  xlab("Mean temperature [F]") +
  labs(title = 'Temperatures in Lincoln NE')
