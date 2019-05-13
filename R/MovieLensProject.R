

# LOADING FILES -----------------------------------------------------------
library(readr)
links <- read_csv("DbMovieLens/links.csv")
Parsed
  cols(
    movieId = col_double(),
    imdbId = col_character(),
    tmdbId = col_double()
  )
View(links)


library(readr)
movies <- read_csv("DbMovieLens/movies.csv")
Parsed
  cols(
    movieId = col_double(),
    title = col_character(),
    genres = col_character()
  )
View(movies)

library(readr)
ratings <- read_csv("DbMovieLens/ratings.csv")
Parsed
  cols(
    userId =  col_double(),
    movieId =  col_double(),
    rating = col_double(),
    timestamp = col_double()
  )
View(ratings)

library(readr)
tags <- read_csv("DbMovieLens/tags.csv")
Parsed
  cols(
    userId = col_double(),
    movieId = col_double(),
    tag = col_character(),
    timestamp = col_double()
  )
View(tags)

# Checking of files class -------------------------------------------------
class(links)
class(movies)
class(ratings)
class(tags)

# CHECKING OF COLUMN CLASS IN DATA.FRAME RATINGS --------------------------

sapply(links, class)
sapply(movies, class)
sapply(ratings, class)
sapply(tags, class)


# PREPARING DATA---------------------------------------

library(dplyr)
library(lubridate)
library(stringr)
library(tidyr)
library(sqldf)
library(magrittr)
library (tidyverse) #for mutate

# 1. Creating new df "ratings1" with adding a new column "ratingdate" as copy of timestamp from ratings changing date format from Epoch timestamp into readable date (GMT) ---------------------------------------------------

Rating <- ratings %>%
  mutate(ratingdate = as.Date(as.POSIXlt(ratings$timestamp, origin="1970-01-01"))) %>%
view(Rating, title = NULL)

# saveRDS()
write.table(Rating, file = "Rating.csv", append = FALSE, sep = " ", dec = ".",
            row.names = TRUE, col.names = TRUE)

Rating <- read_csv("R/Rating.csv")
Parsed
cols(
  movieId = col_double(),
  imdbId = col_character(),
  tmdbId = col_double()
)
View(Rating)

# WorkingDirectory and rename of the file from hello into MovieLen --------

#
# setwd(D:'AGNIESZKA/WsbProject/MovieLens/R')
# getwd()
#
# file.rename("hello", "MovieLensProject")


#checking of dimension of ratings table and ratings 1 table
dim(ratings)
dim(Rating)

# checking of column ratings1 class after changing
sapply(Rating,class)


# Rename of the files -----------------------------------------------------
file.rename(title, Rating)


# 2. Checking null and n/a value --------------------------------------------------

is.na(Rating)

# 3. Checkin NA value -----------------------------------------------------

is.na()

# SEPARATION DATE FROM TITLE ----------------------------------------------


# DIVISION CATEGORY OF FILMS ----------------------------------------------


# TOP 5 FROM ACTION -------------------------------------------------------


# TOP 5 FROM ADVENTURE ----------------------------------------------------


# TOP 5 FROM ANIMATION ----------------------------------------------------


# TOP 5 FROM CHILDREN'S ---------------------------------------------------


# TOP 5 FROM COMEDY -------------------------------------------------------


# TOP 5 FROM CRIME --------------------------------------------------------


# TOP 5 FROM DOCUMENTARY --------------------------------------------------


# TOP 5 FROM DRAMA --------------------------------------------------------


# TOP 5 FROM FANTASY ------------------------------------------------------


# TOP 5 FROM FILM-NOIR ----------------------------------------------------


# TOP 5 FROM HORROR -------------------------------------------------------


# TOP 5 FROM MUSICAL ------------------------------------------------------


# TOP 5 FROM MYSTERY ------------------------------------------------------


# TOP 5 FROM ROMANCE ------------------------------------------------------


# TOP 5 FROM SCI-FI -------------------------------------------------------


# TOP 5 FROM THRILLER -----------------------------------------------------


# TOP 5 FROM WAR ----------------------------------------------------------


# TOP 5 FROM WESTERN ------------------------------------------------------


# TOP 5 FROM NO GENRES LISTED ---------------------------------------------



#as.numeric(Sys.time()) to get the current epoch time in R
links<- read.csv(file = 'ratings')


# Data visualisation ------------------------------------------------------


# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'


library(rsconnect)
rsconnect:deployApp('D:\AGNIESZKA\WsbProject\WsbProjectAK')
#add template
library(library(shiny),

        ui <- fluidPage(

        ),

        server <- function(input, output, session) {

        }

        shinyApp(ui, server))



# USEFULL BUT NOT USED ANYMORE --------------------------------------------

# View(ratings1)
# # changing of format RagintDate into date with hour - command without "as.date"
# as.POSIXlt(ratings1$RatingDate, origin="1970-01-01")
# View(ratings1)
#changing of format RatingDate from timestamp into date in UTC (without hours)
# as.Date(as.POSIXlt(ratings1$RatingDate, origin="1970-01-01"))
# sprawdzenie klas kolumny
# sapply(ratings1,class)
# #changing of column classes for RatingDate from "character" into "numeric"
# ratings1$RatingDate = as.numeric(ratings1$RatingDate)
# ***Changing format of the date ------------------------------------------
# > value <- 1372657859
#   > as.Date(as.POSIXct(value, origin="1970-01-01"))
# [1] "2013-07-01"
# SPOSOB
# > as.POSIXct(value, origin="1970-01-01")
# [1] "2013-07-01 11:20:59 IST"
# then use lubridate package
# ten kod dobrze zamienia timestamp na datę, gdy z=konkretna timestamp as.Date(as.POSIXlt(964982703, origin="1970-01-01"))
# class(2019-05-11)
# class(964982703)
# class(timestamp)
# class(964980868) #from column RatingDate
# class(964983664) #from column timestamp of ratings1
# class(1445715166) #from column timestamp of ratings

#***Creating new table (ratings1) with changing name of Column name (timestamp-->DateOfrating) with changing format of date from unix into UTC -----------------
# try(ratings)
#
# ratings1<- ratings %>%
#   mutate(RatingDate = paste(ratings$timestamp, sep = "", collapse = NULL))
# view(ratings1)

# as.numeric(ratings1$RatingDate)
