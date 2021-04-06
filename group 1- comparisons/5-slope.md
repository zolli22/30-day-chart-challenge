Day 5: Slope
================

``` r
library(tidyverse)
```

``` r
load("~/Desktop/R work/30-day-chart-challenge/group 1- comparisons/group-1-data/parabola_points.rdata")

ggplot(data=parabola_points)+
  geom_point(aes(x=x1, y=y1), size=.01, alpha=.01)+
  geom_point(aes(x=x2, y=y2), size=.01, alpha=.01)+
  geom_abline(aes(slope=slope, intercept=int), alpha=.2, size=.2)+
  geom_vline(xintercept=c(0, 50, -50), alpha=.2, size=.2)+
  geom_hline(yintercept=c(0, 50, -50), alpha=.2, size=.2)+
  theme_void()
```

<img src="5-slope_files/figure-gfm/parabola-1.png" style="display: block; margin: auto;" />
