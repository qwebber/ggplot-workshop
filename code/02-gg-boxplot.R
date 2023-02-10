

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

#### update plot 2 ####
## split by sex

## remove NAs from DT
penguins <- penguins[!is.na(penguins$sex)]

## update theme_penguin
theme_penguin <- theme(legend.position = c(0.2,0.8),
                       legend.key = element_blank(),
                       axis.text = element_text(color = "black"),
                       panel.grid.minor = element_blank(),
                       panel.background = element_blank(), 
                       panel.border = element_rect(colour = "black", fill=NA, size = 1))


sum_data <- penguins[, .N, by = c("species", "sex")]


## plot
ggplot() + 
  geom_jitter(data = penguins, 
              aes(species, 
                  bill_length_mm, 
                  fill = sex,
                  color = sex), 
              alpha = 0.5, 
              position = position_jitterdodge()) +
  geom_boxplot(data = penguins, aes(species, 
                                    bill_length_mm,
                                    fill = sex), 
               outlier.color = NA, 
               alpha = 0.75,
               notch = T) + 
  geom_text(data = sum_data, aes(x = species, 
                                 y = 59, 
                                 label = N, 
                                 fill = sex),
            position = position_jitterdodge()) +
  ylab("Bill length (mm)") +
  xlab("Species") +
  scale_fill_manual(values = col) +
  scale_color_manual(values = col) +
  theme_penguin

#### update plot 3 ####
## compare multiple phenotypes by sex and species

gg_bill_len <- ggplot(penguins, aes(species, 
                                    bill_length_mm)) + 
  geom_jitter(aes(fill = sex,
                  color = sex), 
              alpha = 0.5, 
              position = position_jitterdodge()) +
  geom_boxplot(aes(fill = sex), 
               outlier.color = NA, 
               alpha = 0.75,
               notch = T) + 
  ylab("Bill length (mm)") +
  xlab("Species") +
  ggtitle("A)") +
  scale_fill_manual(values = col) +
  scale_color_manual(values = col) +
  theme_penguin

gg_flipper_len <- ggplot(penguins, aes(species, 
                                       flipper_length_mm)) + 
  geom_jitter(aes(fill = sex,
                  color = sex), 
              alpha = 0.5, 
              position = position_jitterdodge()) +
  geom_boxplot(aes(fill = sex), 
               outlier.color = NA, 
               alpha = 0.75,
               notch = T) + 
  ylab("Flipper length (mm)") +
  xlab("Species") +
  ggtitle("B)") +
  scale_fill_manual(values = col) +
  scale_color_manual(values = col) +
  theme_penguin

gg_body_mass <- ggplot(penguins, aes(species, 
                                     body_mass_g)) + 
  geom_jitter(aes(fill = sex,
                  color = sex), 
              alpha = 0.5, 
              position = position_jitterdodge()) +
  geom_boxplot(aes(fill = sex), 
               outlier.color = NA, 
               alpha = 0.75,
               notch = T) + 
  ylab("Body mass (g)") +
  xlab("Species") +
  ggtitle("C)") +
  scale_fill_manual(values = col) +
  scale_color_manual(values = col) +
  theme_penguin

png("figures/fig2.png", 
    width = 6000, 
    height = 3000, 
    units = "px", 
    res = 500)
gridExtra::grid.arrange(gg_bill_len, 
                        gg_flipper_len, 
                        gg_body_mass,
                        nrow = 1, 
                        ncol = 3)
dev.off()
