Day 11: Circular
================

``` r
library(tidyverse)
```

``` r
whitewine <- read_csv("white-wine-price-rating.csv")
```

``` r
regionwine <- whitewine %>%
  group_by(Region) %>%
  summarise(avgprice = mean(WinePrice)) %>%
  mutate(id = 1:32) %>%
  filter(!is.na(Region))

label_data <- regionwine
 
number_of_bar <- nrow(label_data)

angle <-  90 - 360 * (label_data$id-0.5) /number_of_bar 

label_data$hjust<-ifelse( angle < -90, 1, 0)

label_data$angle<-ifelse(angle < -90, angle+180, angle)

p <- ggplot(regionwine, aes(x=as.factor(id), y=avgprice)) + 
  geom_bar(stat="identity", fill=alpha("navajowhite", 0.7)) +
  ylim(-50,200) +
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.margin = unit(rep(-1,4), "cm")) +
  coord_polar(start = 0)+
  geom_text(data=label_data, aes(x=id, y=avgprice+10, label=Region, hjust=hjust), 
            color="black", fontface="bold",alpha=0.6, size=2.5, angle= label_data$angle, inherit.aes = FALSE ) +
  annotate(geom="text", x=0, y=190, label="average price of \nregional white wines")
 
p
```

![](11-circular_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

``` r
#ggsave("images/11-wineregion.png")
```

``` r
varietywine <- whitewine %>%
  group_by(RegionalVariety) %>%
  summarise(avgprice = mean(WinePrice)) %>%
  mutate(id = 1:32) %>%
  filter(!is.na(RegionalVariety))

label_data <- varietywine
 
number_of_bar <- nrow(label_data)

angle <-  90 - 360 * (label_data$id-0.5) /number_of_bar

label_data$hjust<-ifelse( angle < -90, 1, 0)
 
label_data$angle<-ifelse(angle < -90, angle+180, angle)

p <- ggplot(varietywine, aes(x=as.factor(id), y=avgprice)) + 
  geom_bar(stat="identity", fill=alpha("bisque", 0.7)) +
  ylim(-30,300) +
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.margin = unit(rep(-2,4), "cm")) +
  coord_polar(start = 0)+
  geom_text(data=label_data, aes(x=id, y=avgprice+10, label=RegionalVariety, hjust=hjust), 
            color="black", fontface="bold",alpha=0.6, size=2, angle= label_data$angle, inherit.aes = FALSE)+
  annotate(geom="text", x=0, y=250, label="average price of \nregional white wine varieties")

p
```

![](11-circular_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

``` r
#ggsave("images/11-winevariety.png")
```
