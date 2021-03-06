Day 2: Pictogram
================

I had a difficult time figuring out how to add icons/emojis to my
charts, so once I was able to figure it out, I was happy with that. It’s
nothing fancy, but I am proud of it!

``` r
library(tidyverse)
library(showtext)
library(ggpomological)
library(emojifont)
```

``` r
fruit <- c("tangerine", "apple", "peach", "cherry", "lemon")
label <- c(emoji('tangerine'), emoji('apple'), emoji('peach'), emoji('cherries'), emoji('lemon'))

df <- data.frame(fruit, label) %>%
  mutate(row = " ")

font_add_google("Homemade Apple", family="homemade-apple")

ggplot(df, aes(x=fruit, y=row))+
  geom_text(aes(label=label, color=fruit), size=30, family='EmojiOne')+
  theme_pomological(base_family = "homemade-apple", base_size = 16)+
  scale_color_manual(values=c("#919c4c", "#c03728", "#f5c04a", "#e68c7c", "#fd8f24"))+
  labs(x=' ', y=" ")+
  guides(color="none")
```

![](2-pictogram_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->
