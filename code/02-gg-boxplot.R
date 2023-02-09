

#### load libraries ####
library(ggplot2)
library(data.table)
library(palmerpenguins)

#### load penguins example data (https://allisonhorst.github.io/palmerpenguins/) ####
data(penguins) 

## convert to data.table 
setDT(penguins) 

## assign three colours 
col = c("#1b9e77", "#d95f02", "#7570b3") 

## assign theme
theme_penguin <- theme(legend.position = 'none',
                    panel.grid.minor = element_blank(),
                    panel.background = element_blank(), 
                    panel.border = element_rect(colour = "black", fill=NA, size = 1))


#### basic boxplot ####
ggplot(penguins) + 
  geom_boxplot(aes(species, 
                   bill_length_mm, 
                 color = species)) +
  ylab("Bill length (mm)") +
  xlab("Species") +
  scale_color_manual(values = col) +
  theme_penguin

#### update plot 1 ####
## add data points in background

## plot
ggplot(penguins, aes(species, 
                     bill_length_mm, 
                 color = species)) + 
  geom_boxplot(outlier.color = NA) + ## outlier.color = NA removes the outlier points that are automatically assigned with geom_boxplot
  geom_jitter(alpha = 0.5) +
  ylab("Bill length (mm)") +
  xlab("Species") +
  scale_color_manual(values = col) +
  theme_penguin

