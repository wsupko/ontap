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

 ### Load required libraries ###

library(data.table)
library(RPostgreSQL)
library(ggplot2)
library(scales)
library(lubridate)


#+ r DataInput, include = FALSE 

Imp.All <- fread('./data/in/Data.Sample.txt')
Imp.All[, wd := lubridate::wday(Podlaczenie, label = T, abbr = T)]
Imp.All[, id := 1:.N]
Imp.All[, Cena := max(Cena1, Cena2, Cena2, na.rm = T), by = id]

#+ DataManipulation
#' Spojrzmy na zbior danych 
#' Inicjujemy funkcje str()
 
str(Imp.All)

#' Zauwazylem piwa, ktore nie posiadaja ceny - multitapy nie lubia sie dzielic czy blad?
#' Takich rekordów jest:
Imp.All[Cena1 == 0 & Cena2== 0 & Cena3 == 0, .N]

Proc.Count <- merge(Imp.All[Cena == 0, .(noprice = .N), Multitap], 
                    Imp.All[, .(total = .N), Multitap], 
                    by = 'Multitap', all.y = T); Proc.Count[is.na(noprice), noprice := 0]
Proc.Count[, perc := noprice/total]



ggplot(Proc.Count) + geom_histogram(aes(perc), binwidth = .05)

#' ## Data Visualization
#' #### Liczba podłączeń w maju 2018

#+ r, echo = FALSE 



ggplot(Imp.All[, .(ct = .N), .(Date = as.Date(Podlaczenie), wd)]) + 
    geom_bar(aes(x = Date, y = ct, fill = wd), stat = 'identity') + 
    theme_minimal() + 
    scale_fill_brewer(palette = 'Dark2') +
    theme(legend.position = 'bottom', legend.title = element_blank(), 
          axis.title = element_blank())





