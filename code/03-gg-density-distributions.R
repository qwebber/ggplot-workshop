


#### load libraries ####
library(ggplot2)
library(data.table)
library(ggridges)
library(palmerpenguins)

## load penguin data (https://allisonhorst.github.io/palmerpenguins/)
data(penguins)

## convert to data.table 
setDT(penguins)

## assign three colours 
col = c("#1b9e77", "#d95f02", "#7570b3") 

#### assign theme ####
theme_penguin <- theme(legend.position = c(0.9, 0.8),
                       legend.key = element_blank(),
                       axis.text = element_text(color = "black"),
                       panel.grid.minor = element_blank(),
                       panel.background = element_blank(), 
                       panel.border = element_rect(colour = "black", 
                                                   fill=NA, size = 1))


#### basic density distribution ####
ggplot(penguins) +
  geom_density(aes(bill_length_mm, 
                   fill = species), 
               alpha = 0.5) 

#### update plot 1 ####
## add vertical lines for the mean of each distribution

mean_penguin <- setDT(penguins)[, mean(bill_length_mm, na.rm = T), 
                                by = "species"]

## plot
ggplot(penguins) +
  geom_density(aes(bill_length_mm, 
                   fill = species), 
               alpha = 0.5) +
  geom_vline(data = mean_penguin, 
             aes(xintercept = V1, col = species), 
             lty = 2) +
  geom_hline(aes(yintercept = 0.05),
             lty = 5) +
  theme_penguin

#### update plot 2 ####
## separate plots (using facet)

## plot
png("figures/fig3.png", width = 4000, height = 3000, units = "px", res = 500)
ggplot(penguins) +
  geom_density(aes(bill_length_mm, 
                   fill = species), 
               alpha = 0.5) +
  scale_fill_manual(values = col) +
  ylab("Density distribution") +
  xlab("Bill length (mm)") +
  theme_penguin +
  theme(strip.background = element_rect(color = "black", 
                                        fill = "white", 
                                        size = 1),
        strip.text = element_text(size = 14, color = "black")) +
  facet_wrap(~island)
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

