#'---
#'title: "Ontap"
#'author: "Wojciech Supko"
#'date: "4 lutego 2018"
#'output: github_document
#'---

#+ r setup, include=FALSE

knitr::opts_chunk$set(echo = TRUE)

### Install (if not available already) required libraries ###

if (!'data.table' %in% installed.packages()) {install.packages('data.table')}
if (!'RPostgreSQL' %in% installed.packages()) {install.packages('RPostgreSQL')}
if (!'ggplot2' %in% installed.packages()) {install.packages('ggplot2')}
if (!'scales' %in% installed.packages()) {install.packages('scales')}

#' ### Load required libraries ###

library(data.table)
library(RPostgreSQL)
library(ggplot2)
library(scales)
library(lubridate)


#+ r DataInput, include = FALSE 

Imp.All <- fread('./data/in/Data.Sample.txt')



#+ r



ggplot(Imp.All[, .(ct = .N), .(Date = as.Date(Podlaczenie))]) + 
    geom_bar(aes(x = Date, y = ct), stat = 'identity') + 
    theme_minimal() + theme(legend.position = 'none')





