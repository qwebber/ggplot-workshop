


#### load libraries ####
library(ggplot2)
library(data.table)
library(gridExtra)
library(ggridges)

## load iris data
data(iris)

## convert to data.table 
setDT(iris) 

## assign three colours 
col = c("#1b9e77", "#d95f02", "#7570b3") 

#### assign theme ####
theme_iris <- theme(legend.position = 'none',
                    panel.grid.minor = element_blank(),
                    panel.background = element_blank(), 
                    panel.border = element_rect(colour = "black", fill=NA, size = 1))


#### basic density distribution ####
ggplot(iris) +
  geom_density(aes(Sepal.Length, 
                   fill = Species), 
               alpha = 0.5) +
  theme_iris

#### update plot 1 ####
## add vertical lines for the mean of each distribution

mean_iris <- iris[, mean(Sepal.Length), by = "Species"]

## plot
ggplot(iris) +
  geom_density(aes(Sepal.Length, 
                   fill = Species), 
               alpha = 0.5) +
  geom_vline(data = mean_iris, 
             aes(xintercept = V1), 
             lty = 2) +
  theme_iris

#### update plot 2 ####
## separate plots (using facet)

## plot
ggplot(iris) +
  geom_density(aes(Sepal.Length, 
                   fill = Species), 
               alpha = 0.5) +
  geom_vline(data = mean_iris, 
             aes(xintercept = V1), 
             lty = 2) +
  theme_iris +
  theme(strip.background = element_rect(color = "black", 
                                        fill = "white", 
                                        size = 1),
        strip.text = element_text(size = 14, color = "black")) +
  facet_wrap(~Species)

#### update plot 3 ####
## separate plots (without using facet)

## plot
gg_virginica <- ggplot(iris[Species == "virginica"]) +
  geom_density(aes(Sepal.Length, 
                   fill = Species), 
               alpha = 0.5, 
               fill = "#1b9e77") +
  geom_vline(data = mean_iris[Species == "virginica"], 
             aes(xintercept = V1), 
             lty = 2) +
  ggtitle("A)") +
  theme_iris
  
gg_setosa <- ggplot(iris[Species == "setosa"]) +
  geom_density(aes(Sepal.Length, 
                   fill = Species), 
               alpha = 0.5,
               fill = "#d95f02") +
  geom_vline(data = mean_iris[Species == "setosa"], 
             aes(xintercept = V1), 
             lty = 2) +
  ggtitle("B)") +
  theme_iris

gg_versicolor <- ggplot(iris[Species == "versicolor"]) +
  geom_density(aes(Sepal.Length, 
                   fill = Species), 
               alpha = 0.5,
               fill = "#7570b3") +
  geom_vline(data = mean_iris[Species == "versicolor"], 
             aes(xintercept = V1), 
             lty = 2) +
  ggtitle("C)") +
  theme_iris


png("figures/fig2.png", width = 3000, height = 2000, units = "px", res = 500)
gridExtra::grid.arrange(gg_virginica, 
             gg_setosa, 
             gg_versicolor, 
             nrow = 1,
             ncol = 3)
dev.off()


#### ggridges ####

data("lincoln_weather")

ggplot(lincoln_weather,
       aes(x = `Mean Temperature [F]`, 
           y = Month, 
           fill = stat(x))) +
  geom_density_ridges_gradient(scale = 3, 
                               size = 0.3, 
                               rel_min_height = 0.01) +
  scale_fill_viridis_c(name = "Temp. [F]", option = "C") +
  xlab("Mean temperature [F]") +
  labs(title = 'Temperatures in Lincoln NE') +
  theme_bw()
