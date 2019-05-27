
# WorkingDirectory and rename of the file from hello into MovieLen --------

setwd(D:'AGNIESZKA/WsbProject/MovieLens/R')
getwd()


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
class(links) # links is data frame
class(movies) # movies is data frame
class(ratings) # ragings is data frame
class(tags)  # tags is data frame

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
library(sqldf) # for select function
library(magrittr) # for %>% conducting
library (tidyverse) #for mutate
library(rlang) #for last_error
library(foreach)
library(reshape)
library(reshape2)
library(recommenderlab)
library(ggplot2)
library(lattice) #histogram??funckje graficzne_Biecek str 364


# 1. Creating new df "ratings1" with adding a new column "ratingdate" as copy of timestamp from ratings changing date format from Epoch timestamp into readable date (GMT) ---------------------------------------------------

Rating <- ratings %>%
  mutate(ratingdate = as.Date(as.POSIXlt(ratings$timestamp, origin="1970-01-01"))) %>%
view(Rating, title = NULL)

# save csv and loading of csv
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




#checking of dimension of ratings table and ratings 1 table
dim(ratings)
dim(Rating)

# checking of column ratings1 class after changing
sapply(Rating,class)


# Rename of the files -----------------------------------------------------
file.rename(title, Rating)


# 2. Checking n/a value and null --------------------------------------------------

ifelse (is.na(links), na.omit(links), newlinks<- na.omit(links))
ifelse (is.na(movies), na.omit(movies), newmovies<- na.omit(lmovies))
ifelse (is.na(Rating), na.omit(Rating), newRating<- na.omit(Rating))
ifelse (is.na(tags), na.omit(tags), newtags<- na.omit(tags))

is_empty(links)
is_empty(movies)
is_empty(Rating)
is_empty(tags)


# is.na(Rating)

# SEPARATION DATE FROM TITLE ----------------------------------------------


# DIVISION CATEGORY OF FILMS ----------------------------------------------


# joining files: Rating with movies and creating new csv RatMov-------------------------------------------

RatMov<- merge(x=movies,y=Rating,by="movieId",all.x=TRUE)
view(RatMov)
class(RatMov)
sapply(RatMov, class)
  # select(title, genres, rating)%>%


write.table(RatMov, file = "RatMov.csv", append = FALSE, sep = " ", dec = ".",
            row.names = TRUE, col.names = TRUE)

RatMov <- read_csv("R/RatMov.csv")
Parsed
cols(
  movieId = col_double(),
  imdbId = col_character(),
  tmdbId = col_double()
)
View(RatMov)


Podsumowanie<- table(VecRat)
View(Podsumowanie)



# *****************************************************************************************************DATA AGGREGATION_calculation for mean Rating for each films --------------------------------------------------------
MeanRating_by_title<- round(tapply(RatMov$rating, RatMov$title, mean, na.rm=TRUE))
class(MeanRating_by_title)# New result is class: array
MeanRating<- as.data.frame.table(MeanRating_by_title) # changing array into data.frame
colnames(MeanRating) #getting columnn name
head(MeanRating)
names(MeanRating)[1]<- "Title" # changing name of column [1] from Var1 into Title
names(MeanRating)[2]<-  "MeanRating" #changing name of columne [2] from Freq into MeanRating
head(MeanRating)
class(MeanRating)#chacking corectness of changing class for MeanRatinf from array into data.frame
sapply(MeanRating, class)#checking class of variable in data.frame
MeanRating$Title<- as.character(MeanRating$Title)
sapply(MeanRating, class)
view(MeanRating)

MeanRating_movies<- merge(x=MeanRating, y=movies[ ,c("movieId", "title", "genres")], by.x = "Title", by.y="title", all.x=TRUE)
head(MeanRating_movies)
class(MeanRating_movies)
sapply(MeanRating_movies, class)


write.table(MeanRating_movies, file = "MeanRating_movies.csv", append = FALSE, sep = "  ", dec = ".",
            row.names = TRUE, col.names = TRUE)#creating csv file as "MeanRating_movies"for merged tables

MeanRating_movies <- read_csv("MeanRating_movies.csv")
Parsed
cols(
  Title = col_character(),
  MeanRating = col_double(),
  movieId = col_double(),
  genres = col_character()
    )
View(MeanRating_movies)
class(MeanRating_movies)

MeanRating_sorted<- arrange(MeanRating, desc(MeanRating)) #data sorted by rating
head(MeanRating_sorted)
only5<- filter(MeanRating, MeanRating=="5")#filter films only with MeanRating=5
View(only5)
only4<- filter(MeanRating, MeanRating=="4")#filter films only with MeanRating=4
View(only4)
only3<- filter(MeanRating, MeanRating=="3")#filter films only with MeanRating=3
View(only3)
only2<- filter(MeanRating, MeanRating=="2")#filter films only with MeanRating=2
View(only2)
only1<- filter(MeanRating, MeanRating=="1")#filter films only with MeanRating=1
View(only1)


#HISTOGRAM OF MEAN RATINGS
View(MeanRating)
dim(MeanRating)
#we have 9737 issue, so
hist(100, main = "Histogram of mean ratings", xlab = "MeanRating", border = "red", col = "blue", xlim = c(1,5), breaks = 5)
hist(MeanRating, main = "Histogram of mean ratings", xlab = "MeanRating", border = "red", col = "blue", xlim = c(1,5), breaks = 5)

only_five<- merge()
  View(only_five)
  # select(title, genres, rating)%>%
  view(RatMov)

A<- sqldf("select * from RatMov where rating=5")%>%
  summarise(RatMov, MeanRating2 = mean(rating))%>%
View(A)





RatMov<- merge(x=movies,y=Rating,by="movieId",all.x=TRUE)%>%

library(sqldf)
ALLs<- sqldf("select * from RatMov")#DZIA£A KOMENDA
Adventure<- sqldf("select * from RatMov where genres ")

View(Adventure)




data("MovieLense")
Adventure<- sqldf("select * genres")


#****************************************************** Filtering data by .... --------------------------------------------------




# choosing films with best rating -----------------------------------------

library(sqldf)
select(MeanRating_by_title, )

# summary for the ratings
summary(RatMean_by_ID)
rnorm(RatMean_by_ID)
#conclusion: mean value is almost the same as median value, so in next calculations we can use mean value and is equal 3.0; there are 18 occurance of .............
# 0 valuses which means that ............





********************************************************# STATISTICS_OCCURANCE ----------------------------------------------------




# *************************************************************************RECOMMENDERLAB ----------------------------------------------------------

data("MovieLense")
MovieLense
class(MovieLense)
dim(MovieLense)
image(as.matrix(similarity_users), main="User similarity")
VecRat<- as.vector(MovieLense@data)
unique(VecRat)
TablRat<- table(VecRat)
TablRat

# vector_ratings<- as.vector(MovieLense@data)
# unique(vector_ratings)
# table_ratings<- table(vector_ratings)
# table_ratings
# vector_ratings2<- vector_ratings[vector_ratings != 0]
# # vector_ratings<- factor(vector_ratings)
# ggplot(vector_ratings2)+ggtitle("Distribution of the ratings")



# connection to DBI
con<- dbConnect((RSQLite::sQlite(), ":MovieLens:")
dbConnect()
data("MovieLense")
dbListTables(conn = MovieLense)
try(MovieLense)
MovieLense

ggplot(MovieLense@data)+ggtitle("XXX")








average_ratings<- colMeans(MovieLense)
average_ratings_relevant<- average_ratings[view_per_movie > 100]
class(average_ratings)
sapply(average_ratings, class)
class(average_ratings)
View(average_ratings)

ggplot(average_ratings)+stat_bin(binwidth = 0,1) + ggtitle("Distribution of the average movie rating")

Occurance_ratings<- table(vector_ratings)


# TOP 5 FROM ACTION -------------------------------------------------------




# a) rearraging data like "vertical search" in excel ----------------------

# Top.melt<- melt(RatMov, id.vars = c("movieId"), measure.vars = "rating") #to jest raczej do tego uk³adu nie potrzebne na razie
# head(TOP.melt)
# view(Top.melt)


# TOP.cast<- cast(TOP.melt, movieId~variable, mean)
# view(TOP.cast)



# b) calculate mean value of rating for each movieId and sorting them descending




  # arrange(desc(rating))
view(TOP5)

# cast(TOP.melt, formula = ID, fun.aggregate = c(mean))


# as.matrix(RatMov)
# RatMov %>% mutate(meanrating =  if movieIdmean(RatMov$rating)}) %>%
# view(RatMov)
#                     group_by(movieId)%>%
#
#
#   view(RatMov)
#
#
# sapply(RatMov, class)
# as.double(RatMov$rating)
# mean(RatMov$rating, trim = 2)
# sapply(RatMov, class)
#
#
# Top5Action<- RatMov%>%
#   # arrange(desc())%>%
#   # group_by(ratingdate)%>%
#   group_by(rating)%>%
#   # summarise(mean(ratings))%>%
#   arrange(desc(rating))%>%
#   top_n(5)%>%
# view(Top5Action)
#
# Top5Action<- RatMov%>%
#   # arrange(desc())%>%
#   # group_by(ratingdate)%>%
#   group_by(title())%>%
# view(Top5Action)
#
#
#   # summarise(mean(ratings))%>%
#   arrange(desc(rating))%>%
#   top_n(5)%>%




# Top5Action<- RatMov%>%
#   as.double(rating)
#   mutate(MeanRat=summarise(rating))
#   arrange(desc(rating))%>%
# view((Top5Action))
#   # group_by(ratingdate)%>%
#   # group_by(rating)%>%
#   # summarise(mean(ratings))%>%
#   arrange(desc(rating))%>%
#   top_n(5)%>%
#   view(Top5Action)


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



# USEFULL -----------------------------------------------------------------

install.packages(c("devtools", "ggplot2", "knitr", "yaml", "htmltools"))devtools::install_github("babynames", "hadley")devtools::install_github("shiny", "rstudio")devtools::install_github("rmarkdown", "rstudio")


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
# ten kod dobrze zamienia timestamp na datÄ™, gdy z=konkretna timestamp as.Date(as.POSIXlt(964982703, origin="1970-01-01"))
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



# # &&& checking code for removing NA value on simple example ---------------
#
# try(Rating)
# userID<- c(1,NA,3,4,5)
# movieid<- c(6,7,8,9,10)
# rating<- c(NA, 5, NA, 5, 4)
# timestamp<- c(944982703,954982703,9634982703,964982703,964952703)
# ratingdate<- c(2012, 2013, 2014, 2010, 2011)
#
# TESTDF<- data.frame(userID, movieid, rating, timestamp, ratingdate)
# view(TESTDF)
# ifelse (is.na(TESTDF), na.omit(TESTDF), newDF<- na.omit(TESTDF))
# view(newDF)


