

#### load libraries ####
library(ggplot2)
library(data.table)


#### load iris example data (https://www.statology.org/iris-dataset-r/) ####
data(iris) 

## convert to data.table 
setDT(iris) 

## assign three colours 
col = c("#1b9e77", "#d95f02", "#7570b3") 

## assign theme
theme_iris <- theme(legend.position = 'none',
                    panel.grid.minor = element_blank(),
                    panel.background = element_blank(), 
                    panel.border = element_rect(colour = "black", fill=NA, size = 1))


#### basic boxplot ####
ggplot(iris) + 
  geom_boxplot(aes(Species, 
                   Sepal.Length, 
                 color = Species)) +
  ylab("Sepal length (cm)") +
  xlab("Species") +
  scale_color_manual(values = col) +
  theme_iris

#### update plot 1 ####
## add data points in background

## plot
ggplot(iris, aes(Species, 
                 Sepal.Length, 
                 color = Species)) + 
  geom_boxplot(outlier.color = NA) + ## outlier.color = NA removes the outlier points that are automatically assigned with geom_boxplot
  geom_jitter(alpha = 0.5) +
  ylab("Sepal length (cm)") +
  xlab("Species") +
  scale_color_manual(values = col) +
  theme_iris

