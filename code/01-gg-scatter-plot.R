
#### load libraries ####
library(ggplot2)
library(data.table)


#### load iris example data (https://www.statology.org/iris-dataset-r/) ####
data(iris) 

## convert to data.table 
setDT(iris) 

#### basic scatter plot ####
ggplot(data = iris) + 
  geom_point(aes(Sepal.Length, 
                 Sepal.Width)) 

#### update plot 1 ####
#### color by species and have appropriate axis labels

## plot
ggplot(iris) + 
  geom_point(aes(Sepal.Length, 
                 Sepal.Width, 
                 color = Species)) +
  ylab("Sepal width (cm)") +
  xlab("Sepal length (cm)")

#### update plot 2 ####
#### customize color (https://colorbrewer2.org/)

## assign three colours 
col = c("#1b9e77", "#d95f02", "#7570b3") 

## plot
ggplot(iris) + 
  geom_point(aes(Sepal.Length, 
                 Sepal.Width, 
                 color = Species)) +
  ylab("Sepal width (cm)") +
  xlab("Sepal length (cm)") +
  scale_color_manual(values = col)
  #scale_color_viridis_d()

#### update plot 3 ####
#### customize background using a theme

## assign theme
theme_iris <- theme(legend.position = c(0.8, 0.8),
                    legend.key = element_blank(),
                    panel.grid.minor = element_blank(),
                    panel.background = element_blank(), 
                    panel.border = element_rect(colour = "black", fill=NA, size = 1))

## plot
ggplot(iris) + 
  geom_point(aes(Sepal.Length, 
                 Sepal.Width, 
                 color = Species)) +
  xlim(3,9) +
  ylim(2,6) +
  ylab("Sepal width (cm)") +
  xlab("Sepal length (cm)") +
  scale_color_manual(values = col) +
  theme_iris
  #theme_bw()

#### update plot 4 ####
#### facet_wrap

## assign theme
theme_facet <- theme(legend.position = 'none',
                     strip.background = element_rect(color = "black", 
                                                     fill = "white", 
                                                     size = 1),
                     strip.text = element_text(size = 14, color = "black"),
                     panel.grid.minor = element_blank(),
                     panel.background = element_blank(), 
                     panel.border = element_rect(colour = "black", fill=NA, size = 1))

## plot
ggplot(iris) + 
  geom_point(aes(Sepal.Length, 
                 Sepal.Width, 
                 color = Species)) +
  ylab("Sepal width (cm)") +
  xlab("Sepal length (cm)") +
  scale_color_manual(values = col) +
  theme_facet +
  facet_wrap(~Species)

#### update plot 5 ####
#### export as "publication ready"

png("figures/fig1.png", width = 3000, height = 2000, units = "px", res = 500)
ggplot(iris) + 
  geom_point(aes(Sepal.Length, 
                 Sepal.Width, 
                 color = Species)) +
  ylab("Sepal width (cm)") +
  xlab("Sepal length (cm)") +
  scale_color_manual(values = col) +
  theme_facet +
  facet_wrap(~Species)
dev.off()
