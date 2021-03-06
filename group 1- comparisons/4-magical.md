Day 4: Magical
================

``` r
library(tidyverse)
library(gutenbergr)
library(tidytext)
library(wordcloud)
library(rcartocolor)
library(textdata)
library(showtext)
library(tm)
```

``` r
font_add_google("EB Garamond", "eb-garamond")
showtext_auto()
```

``` r
andersen <- gutenberg_download(1597)  %>%
  unnest_tokens(output = word, input = text, token = "words") %>%
  group_by(word) %>%
  count(word, sort=TRUE) %>%
  ungroup()

grimms <- gutenberg_download(2591) %>%
  unnest_tokens(output = word, input = text, token = "words") %>%
  group_by(word) %>%
  count(word, sort=TRUE) %>%
  ungroup()
```

``` r
nrc<-get_sentiments("nrc")

nrc_hans_all <- andersen %>%
  inner_join(sentiments, by = "word") %>%
  mutate(color = case_when(sentiment == "negative" ~ "#d98994", 
                           sentiment == "positive" ~ "#72aaa1"))

nrc_grimm_all <- grimms %>%
  inner_join(sentiments, by = "word") %>%
  mutate(color = case_when(sentiment == "negative" ~ "#d98994", 
                           sentiment == "positive" ~ "#72aaa1"))
```

``` r
layout(matrix(c(1, 2), nrow=2), heights=c(1.3, 7))
par(mar=rep(0, 4))
plot.new()
text(x=0.5, y=0.5, "Andersen's Fairy Tales\nSentiment Wordcloud\n(green = positive, pink = negative)", family="eb-garamond")
wordcloud1 <- nrc_hans_all %>%
  slice(1:100) %>%
  with(wordcloud(word, n, colors = color, min.freq = 5, ordered.colors=TRUE,
                 random.order = FALSE, scale = c(4, .5), fixed.asp = FALSE, 
                 rot.per=0, family="eb-garamond", main="Title"))
```

![](4-magical_files/figure-gfm/wordcloud%201-1.png)<!-- -->

``` r
wordcloud1
```

    ## NULL

``` r
layout(matrix(c(1, 2), nrow=2), heights=c(1.3, 7))
par(mar=rep(0, 4))
plot.new()
text(x=0.5, y=0.5, "Grimm's Fairy Tales\nSentiment Wordcloud\n(green = positive, pink = negative)", family="eb-garamond")
wordcloud2 <- nrc_grimm_all %>%
  slice(1:100) %>%
  with(wordcloud(word, n, colors = color, min.freq = 10, ordered.colors=TRUE,
                 random.order = FALSE, scale = c(3.5, .5), fixed.asp = FALSE, 
                 rot.per=0, family="eb-garamond"))
```

![](4-magical_files/figure-gfm/wordcloud%202-1.png)<!-- -->

``` r
wordcloud2
```

    ## NULL

``` r
nrc_hans2 <- andersen %>%
  count(word, sort=TRUE) %>%
  inner_join(nrc, by = "word") %>%
  group_by(sentiment) %>%
  summarize(n = sum(n)) %>%
  mutate(prop = n/sum(n)) %>%
  mutate(sentiment = fct_reorder(sentiment, n), book="andersen")

nrc_grimm2 <- grimms %>%
  count(word, sort=TRUE) %>%
  inner_join(nrc, by = "word") %>%
  group_by(sentiment) %>%
  summarize(n = sum(n)) %>%
  mutate(prop = n/sum(n)) %>%
  mutate(sentiment = fct_reorder(sentiment, n), book="grimm")

books <- nrc_grimm2 %>%
  full_join(nrc_hans2)
```

``` r
sentiment <- ggplot(books, aes(y = prop, x  = sentiment, fill = book)) +
  geom_col(position = "dodge")+
  scale_fill_manual(values=c("#72aaa1","#e5b9ad"), name="anthology", labels=c("Anderson's Fairy Tales", "Grimm's Fairy Tales"))+
  coord_flip()+
  theme_bw()+
  labs(y="proportion of words")+
  theme(text=element_text(family="eb-garamond", face = "plain"))

sentiment
```

![](4-magical_files/figure-gfm/sentiment%20chart-1.png)<!-- -->
