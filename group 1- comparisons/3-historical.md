Day 3: Historical
================

Day 3: Historical

``` r
library(tidyverse)
library(lubridate)
library(emojifont)
library(scales)
```

data from
[kaggle](https://www.kaggle.com/sudalairajkumar/cryptocurrencypricehistory?select=coin_Bitcoin.csv)

``` r
crypto_month <- read_csv("group-1-data/coin_Bitcoin.csv") %>%
  mutate(Date = ymd_hms(Date)) %>%
  select(4:10) %>%
  mutate(month = month(Date), year=year(Date)) %>%
  filter(year >= 2017)%>%
  unite("monthyear", month:year) %>%
  mutate(monthyear = my(monthyear)) %>%
  group_by(monthyear) %>%
  summarize(avg_open = mean(Open), avg_high = mean(High), avg_low= mean(Low), 
            avg_close = mean(Close), avg_volume = mean(Volume), avg_mcap = mean(Marketcap)) %>%
  mutate(label = emoji('heavy_dollar_sign'))
```

``` r
ggplot(crypto_month, aes(x=monthyear, y=avg_high))+
  geom_line(alpha=.7, size=.3, color='grey')+
  geom_text(aes(label=label, size=avg_volume), family='EmojiOne', color='forestgreen')+
  theme_bw()+
  labs(x='date', y='average high price', title='bitcoin through the ages (2017 - 2021)', subtitle='average high bitcoin price per month', caption='size of point is mapped to average trade volume')+
  guides(size="none")
```

![](3-historical_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

data from [kaggle](https://www.kaggle.com/neuromusic/avocado-prices)

``` r
avocado_time <- read_csv("group-1-data/avocado.csv") %>%
  filter(region=="TotalUS") %>%
  mutate(Date = ymd(Date)) %>% 
  group_by(Date) %>%
  summarize(avg_price = mean(AveragePrice),  avg_volume = mean(`Total Volume`)) %>%
  mutate(money_spent = avg_volume*avg_price)
```

    ## Warning: Missing column names filled in: 'X1' [1]

``` r
ggplot(avocado_time, aes(x=Date, y=money_spent))+
  geom_step(color="darkgreen")+
  theme_bw()+
  labs(y="average money spent on avocados\n(millions $)", 
       title="how much money are people spending on avocados?", x="date")+
  scale_y_continuous(labels = label_number(suffix = " M", scale = 1e-6))
```

![](3-historical_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->
