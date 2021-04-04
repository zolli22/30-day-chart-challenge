library(emojifont)  
library(dplyr)
library(tidyverse)
library(ggwaffle)

iris$Species <- as.character(iris$Species)
waffle_data <- waffle_iron(iris, aes_d(group = Species)) %>% mutate(label = emoji('heavy_dollar_sign'))


ggplot(waffle_data, aes(x, y, colour = group)) + 
  geom_text(aes(label=label), size=4, family='EmojiOne') +
  coord_equal() + 
  scale_colour_waffle() + 
  theme_waffle()


search_emoji('money')
emoji(search_emoji('lemon'))


d <- data.frame(x=x, y=y,
                label = sample(c(emoji('cow'), emoji('camel')), 10, replace=TRUE),
                type = sample(LETTERS[1:3], 10, replace=TRUE))

library("ggplot2")
ggplot(d, aes(x, y, color=type, label=label)) +
  geom_text(family="EmojiOne", size=6)