
#### load libraries ####
library(ggplot2)
library(data.table)


#### load penguins example data ####
install.packages("palmerpenguins")
library(palmerpenguins)

data(penguins)

## convert to data.table 
setDT(penguins) 

#### basic scatter plot ####
ggplot(data = penguins) + 
  geom_point(aes(bill_length_mm, 
                 bill_depth_mm)) 

#### update plot 1 ####
#### color by species and have appropriate axis labels

## plot
ggplot(penguins) + 
  geom_point(aes(bill_length_mm, 
                 bill_depth_mm, 
                 color = species)) 
  ylab("Bill depth (mm)") +
  xlab("Bill length (mm)")

#### update plot 2 ####
#### customize color (https://colorbrewer2.org/)

## assign three colours 
col = c("#1b9e77", "#d95f02", "#7570b3") 

## plot
ggplot(penguins) + 
  geom_point(aes(bill_length_mm, 
                 bill_depth_mm, 
                 color = species)) +
  ylab("Bill depth (mm)") +
  xlab("Bill length (mm)") +
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
ggplot(penguins) + 
  geom_point(aes(bill_length_mm, 
                 bill_depth_mm, 
                 color = species)) +
  xlim(30,60) +
  ylim(10,25) +
  ylab("Bill depth (mm)") +
  xlab("Bill length (mm)") +
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
ggplot(penguins) + 
  geom_point(aes(bill_length_mm, 
                 bill_depth_mm, 
                 color = species)) +
  ylab("Bill depth (mm)") +
  xlab("Bill length (mm)") +
  scale_color_manual(values = col) +
  theme_facet +
  facet_wrap(~species)

#### update plot 5 ####
#### export as "publication ready"

png("figures/fig1.png", width = 3000, height = 2000, units = "px", res = 500)
ggplot(penguins) + 
  geom_point(aes(bill_length_mm, 
                 bill_depth_mm, 
                 color = species)) +
  ylab("Bill depth (mm)") +
  xlab("Bill length (mm)") +
  scale_color_manual(values = col) +
  theme_facet +
  facet_wrap(~species)
dev.off()
