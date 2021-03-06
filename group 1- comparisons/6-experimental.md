Day 6: Experimental
================

``` r
library(tidyverse)
library(contouR)
```

``` r
setup = contour_grid(grid_size = 50, point_dist = .5, 
             z_method = "runif", z =1, z_span = 3)
contour_plot(setup, line_col = "#009392", background_col="#f1eac8") +
  ggplot2::xlim(1, 30) +
  ggplot2::ylim(1, 30) 
```

![](6-experimental_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

``` r
setup = contour_grid(grid_size = 200, point_dist = 1, 
             z_method = "runif", z =.3, z_span = 100)
contour_plot(setup, line_col = "#009392", background_col="#f1eac8") +
  ggplot2::xlim(1, 30) +
  ggplot2::ylim(1, 30)
```

![](6-experimental_files/figure-gfm/unnamed-chunk-2-2.png)<!-- -->

``` r
setup = contour_grid(grid_size = 150, point_dist = .8, 
             z_method = "runif", z =.3, z_span = 100) %>%
  contour_shape(radius = 15, 
                x_center = 20, y_center = 20,
                ring_system = "multiple",
                num_rings = 20) 

contour_plot(setup$grid_shape, setup$rings, line_col = "#009392", background_col="#f1eac8") +
  ggplot2::xlim(1, 50) +
  ggplot2::ylim(1, 50)
```

![](6-experimental_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->
