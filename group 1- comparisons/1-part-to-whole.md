Day 1: part-to-whole
================

``` r
library(tidyverse)
library(ggraph)
library(igraph)
```

lego data from [kaggle](https://www.kaggle.com/rtatman/lego-database)

``` r
sets <- read_csv("group-1-data/sets.csv")
inventories <- read_csv("group-1-data/inventories.csv")
inventory_parts <- read_csv("group-1-data/inventory_parts.csv")
colors <- read_csv("group-1-data/colors.csv") %>%
  rename("color_id" = "id", "color_name" = "name")
parts <- read_csv("group-1-data/parts.csv")
part_categories <- read_csv("group-1-data/part_categories.csv")%>%
  rename("part_cat_id" = "id")
```

``` r
ewok_village <- sets %>%
  filter(name == "Ewok Village") %>%
  left_join(inventories) %>%
  rename("inventory_id" = "id")
```

    ## Joining, by = "set_num"

``` r
ewok_id <- ewok_village$inventory_id

ewok_inventory <- inventory_parts %>%
  filter(inventory_id == ewok_id) %>%
  left_join(parts, by="part_num") %>%
  left_join(part_categories, by="part_cat_id") %>%
  rename("part_name"="name.x", "part_cat_name"="name.y") %>%
  left_join(colors, by="color_id") %>%
  mutate(origin = "origin")

set1 <- ewok_inventory %>%
  select(origin, part_cat_name) %>%
  rename("from"="origin", "to"="part_cat_name")

set2 <- ewok_inventory %>%
  select(part_cat_name, color_name) %>%
  rename("from"="part_cat_name", "to"="color_name")

hierarchy <- rbind(set1, set2)
vertices <- data.frame(name = unique(c(as.character(hierarchy$from), as.character(hierarchy$to))) )

mygraph <- graph_from_data_frame(hierarchy, vertices=vertices)
```

``` r
plot(mygraph, vertex.label="", edge.arrow.size=0, vertex.size=2)
```

![](1-part-to-whole_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

``` r
ggraph(mygraph, layout = 'dendrogram', circular = TRUE) + 
  geom_edge_diagonal(size=.25) +
  geom_node_point(aes(filter = leaf)) +
  theme_void()
```

    ## Multiple parents. Unfolding graph

    ## Warning: Ignoring unknown parameters: edge_size

![](1-part-to-whole_files/figure-gfm/unnamed-chunk-3-2.png)<!-- -->

``` r
ggraph(mygraph, layout='dendrogram', circular=FALSE) + 
  geom_edge_diagonal() +
  theme_void() +
  theme(legend.position="none")
```

    ## Multiple parents. Unfolding graph

![](1-part-to-whole_files/figure-gfm/unnamed-chunk-3-3.png)<!-- -->

``` r
ggraph(mygraph) + 
  geom_edge_link(alpha=.4, size=.5) + 
  geom_node_point() +
  theme_void() +
  theme(legend.position="none")
```

    ## Using `sugiyama` as default layout

    ## Warning: Ignoring unknown parameters: edge_size

![](1-part-to-whole_files/figure-gfm/unnamed-chunk-3-4.png)<!-- -->

``` r
falling_water <- sets %>%
  filter(name == "Fallingwater") %>%
  left_join(inventories) %>%
  rename("inventory_id" = "id")

fallingwater_id <- falling_water$inventory_id

falling_water_parts <- inventory_parts %>%
  filter(inventory_id == fallingwater_id) %>%
  left_join(parts, by="part_num") %>%
  left_join(part_categories, by="part_cat_id") %>%
  rename("part_name"="name.x", "part_cat_name"="name.y") %>%
  left_join(colors, by="color_id")

set1_fw <- falling_water_parts %>%
  select(inventory_id, part_cat_name) %>%
  rename("from"="inventory_id", "to"="part_cat_name")

set3_fw <- falling_water_parts %>%
  select(part_cat_name, color_name) %>%
  rename("from"="part_cat_name", "to"="color_name")

set2_fw <- falling_water_parts %>%
  select(color_name, part_name) %>%
  rename("from"="color_name", "to"="part_name")

hierarchy_fw <- rbind(set1_fw, set2_fw, set3_fw)
vertices_fw <- data.frame(name = unique(c(as.character(hierarchy_fw$from), as.character(hierarchy_fw$to))) )

mygraph_fw <- graph_from_data_frame(hierarchy_fw, vertices=vertices_fw)
```

``` r
plot(mygraph_fw, vertex.label="", edge.arrow.size=0, vertex.size=2)
```

![](1-part-to-whole_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

``` r
ggraph(mygraph_fw, layout = 'dendrogram', circular = TRUE) + 
  geom_edge_diagonal() +
  geom_node_point(aes(filter = leaf)) +
  theme_void()
```

![](1-part-to-whole_files/figure-gfm/unnamed-chunk-5-2.png)<!-- -->

``` r
ggraph(mygraph_fw, layout='dendrogram', circular=FALSE) + 
  geom_edge_diagonal(alpha=.4, size=.5) +
  theme_void() +
  theme(legend.position="none")
```

    ## Warning: Ignoring unknown parameters: edge_size

![](1-part-to-whole_files/figure-gfm/unnamed-chunk-5-3.png)<!-- -->

``` r
ggraph(mygraph_fw) + 
  geom_edge_link(alpha=.4, size=.5) + 
  geom_node_point() +
  theme_void() +
  theme(legend.position="none")
```

    ## Warning: Ignoring unknown parameters: edge_size

![](1-part-to-whole_files/figure-gfm/unnamed-chunk-5-4.png)<!-- -->
