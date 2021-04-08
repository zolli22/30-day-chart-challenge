Day 8: Animals
================

``` r
library(tidyverse)
library(palmerpenguins)
library(see)
library(Hmisc)
library(showtext)
```

``` r
font_add_google("Lora", "lora")
showtext_auto(enable=TRUE)
```

``` r
#from palmerpenguins
penguins <- penguins
```

``` r
ggplot(penguins, aes(x=species, y=bill_length_mm, fill=species))+
  geom_violinhalf() +
  geom_dotplot(binaxis = "y", stackdir = "down", 
               dotsize=.4, position = position_nudge(-0.025))+
  theme_modern() +
  stat_summary(fun.data = mean_sdl, 
               fun.args = list(mult = 1), 
               geom = "pointrange", 
               position = position_nudge(0.05)) +
  scale_fill_manual(values=c("#9fb69b", "#f7cfad", "#e8867c"))+
  theme(text=element_text(family = "lora"))+
  labs(y="bill length (mm)")
```

![](8-animals_files/figure-gfm/bill%20length-1.png)<!-- -->

``` r
##file = group2-distributions/images/8_bill_length.png
```

``` r
ggplot(penguins, aes(x=species, y=body_mass_g, fill=species))+
  geom_violinhalf() +
  geom_dotplot(binaxis = "y", stackdir = "down", 
               dotsize=.4, position = position_nudge(-0.025))+
  theme_modern() +
  stat_summary(fun.data = mean_sdl, 
               fun.args = list(mult = 1), 
               geom = "pointrange", 
               position = position_nudge(0.05)) +
  scale_fill_manual(values=c("#9fb69b", "#f7cfad", "#e8867c"))+
  theme(text=element_text(family = "lora"))+
  labs(y="body mass (g)")
```

![](8-animals_files/figure-gfm/body%20mass-1.png)<!-- -->

``` r
##file = group2-distributions/images/8_body_mass.png
```
