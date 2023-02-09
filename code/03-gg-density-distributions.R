


#### load libraries ####
library(ggplot2)
library(data.table)
library(gridExtra)
library(ggridges)
library(palmerpenguins)

## load penguin data
data(penguins)

## convert to data.table 
setDT(penguins)

## assign three colours 
col = c("#1b9e77", "#d95f02", "#7570b3") 

#### assign theme ####
theme_penguin <- theme(legend.position = 'none',
                    panel.grid.minor = element_blank(),
                    panel.background = element_blank(), 
                    panel.border = element_rect(colour = "black", fill=NA, size = 1))


#### basic density distribution ####
ggplot(penguins) +
  geom_density(aes(bill_length_mm, 
                   fill = species), 
               alpha = 0.5) +
  theme_penguin

#### update plot 1 ####
## add vertical lines for the mean of each distribution

mean_penguin <- setDT(penguins)[, mean(bill_length_mm, na.rm = T), by = "species"]

## plot
ggplot(penguins) +
  geom_density(aes(bill_length_mm, 
                   fill = species), 
               alpha = 0.5) +
  geom_vline(data = mean_penguin, 
             aes(xintercept = V1, col = species), 
             lty = 2) +
  theme_penguin

#### update plot 2 ####
## separate plots (using facet)

## plot
ggplot(penguins) +
  geom_density(aes(bill_length_mm, 
                   fill = species), 
               alpha = 0.5) +
  geom_vline(data = mean_penguin, 
             aes(xintercept = V1), 
             lty = 2) +
  theme_penguin +
  theme(strip.background = element_rect(color = "black", 
                                        fill = "white", 
                                        size = 1),
        strip.text = element_text(size = 14, color = "black")) +
  facet_wrap(~species)

#### update plot 3 ####
## separate plots (without using facet)

## plot
gg_adelie <- ggplot(penguins[species == "Adelie"]) +
  geom_density(aes(bill_length_mm, 
                   fill = species), 
               alpha = 0.5, 
               fill = "#1b9e77") +
  geom_vline(data = mean_penguin[species == "Adelie"], 
             aes(xintercept = V1), 
             lty = 2) +
  ggtitle("A)") +
  theme_penguin
  
gg_chinstrap <- ggplot(penguins[species == "Chinstrap"]) +
  geom_density(aes(bill_length_mm, 
                   fill = species), 
               alpha = 0.5,
               fill = "#d95f02") +
  geom_vline(data = mean_penguin[species == "Chinstrap"], 
             aes(xintercept = V1), 
             lty = 2) +
  ggtitle("B)") +
  theme_penguin

gg_gentoo <- ggplot(penguins[species == "Gentoo"]) +
  geom_density(aes(bill_length_mm, 
                   fill = species), 
               alpha = 0.5,
               fill = "#7570b3") +
  geom_vline(data = mean_penguin[species == "Gentoo"], 
             aes(xintercept = V1), 
             lty = 2) +
  ggtitle("C)") +
  theme_penguin


png("figures/fig2.png", width = 3000, height = 2000, units = "px", res = 500)
gridExtra::grid.arrange(gg_adelie, 
             gg_chinstrap, 
             gg_gentoo, 
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
