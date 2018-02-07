Ontap
================
Wojciech Supko
4 lutego 2018

Here's some more prose. I can use usual markdown syntax to make things **bold** or *italics*. Let's use an example from the `dotchart()` help to make a Cleveland dot plot from the `VADeaths` data. I even bother to name this chunk, so the resulting PNG has a decent name.

``` r
ggplot(Imp.All[, .(ct = .N), .(Date = as.Date(Podlaczenie))]) + 
    geom_bar(aes(x = Date, y = ct), stat = 'identity') + 
    theme_minimal() + theme(legend.position = 'none')
```

![](untap.1.0_files/figure-markdown_github/r-1.png)
