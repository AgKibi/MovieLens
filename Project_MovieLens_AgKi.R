
                                                                                # WorkingDirectory

setwd(D:'AGNIESZKA/WsbProject/MovieLens/R')
getwd()

setwd('D:/AGNIESZKA/WsbProject/MovieLens')
                                                                                  # LOADING FILES
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

                                                                                   # CHECKING OF DATA CLASS


# Checking of files class
class(links) # links is data frame
class(movies) # movies is data frame
class(ratings) # ragings is data frame
class(tags)  # tags is data frame

# CHECKING OF COLUMN CLASS IN DATA.FRAME RATINGS

sapply(links, class)
sapply(movies, class)
sapply(ratings, class)
sapply(tags, class)


                                                                                   # LIBRARY THAT YOU WILL NEED



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
library(plotrix) # for 3D Pie Chart
library(shiny)

                                                        # Creating new df "ratings1" with adding a new column "ratingdate" as copy of timestamp from ratings
                                                                    # changing date format from Epoch timestamp into readable date (GMT)
Rating <- ratings %>%
  mutate(ratingdate = as.Date(as.POSIXlt(ratings$timestamp, origin="1970-01-01"))) %>%
view(Rating, title = NULL)

                                                                                # SAVING RESULTS AS .csv FILES  AND LOADING OF .csv FILES
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


                                                                            # Checking n/a value and null


#
# ifelse (is.na(links), na.omit(links), newlinks<- na.omit(links))
# ifelse (is.na(movies), na.omit(movies), newmovies<- na.omit(lmovies))
# ifelse (is.na(Rating), na.omit(Rating), newRating<- na.omit(Rating))
# ifelse (is.na(tags), na.omit(tags), newtags<- na.omit(tags))

is_empty(links)
is_empty(movies)
is_empty(Rating)
is_empty(tags)


# is.na(Rating)

# SEPARATION DATE FROM TITLE ----------------------------------------------


# DIVISION CATEGORY OF FILMS ----------------------------------------------


                                                            # Joining files: Rating with movies and creating new csv RatMov



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

#
# Podsumowanie<- table(VecRat)
# View(Podsumowanie)



                                                          # DATA AGGREGATION_calculation for mean Rating for each films



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
write.table(MeanRating, file = "MeanRating.csv", append = FALSE, sep = " ", dec = ".",
            row.names = TRUE, col.names = TRUE)

MeanRating <- read_csv("R/MeanRating.csv")
Parsed
cols(
  Title = col_character(),
  MeanRating = col_double(),
  movieId = col_double(),
  genres = col_character()
)
View(MeanRating)


                              # Joining dataframes: MeanRating with movies for next statistic operations and checking the class of data



MeanRating_movies<- merge(x=MeanRating, y=movies[ ,c("movieId", "title", "genres")], by.x = "Title", by.y="title", all.x=TRUE)
head(MeanRating_movies)
class(MeanRating_movies)
sapply(MeanRating_movies, class)

write.table(MeanRating_movies, file = "MeanRating_movies.csv", append = FALSE, sep = " ", dec = ".",
            row.names = TRUE, col.names = TRUE)

MeanRating_movies <- read_csv("R/MeanRating_movies.csv")
Parsed
cols(
  Title = col_character(),
  MeanRating = col_double(),
  movieId = col_double(),
  genres = col_character()
)
View(MeanRating_movies)

                                                              #ONLY 5, 4, 3, 2, 1----> CHOOSING FILMS AFTER RATINGS




only5<- arrange(MeanRating_movies, desc(MeanRating))%>% filter(MeanRating=="5") #data sorted by rating
view(only5)
write.table(only5, file = "only5.csv", append = FALSE, sep = " ", dec = ".",
            row.names = TRUE, col.names = TRUE)

only5 <- read_csv("only5.csv")
Parsed
cols(
  Title = col_character(),
  MeanRating = col_double(),
  movieId = col_double(),
  genres = col_character()
  )
view(only5)

only4<- arrange(MeanRating_movies, desc(MeanRating))%>% filter(MeanRating=="4")#filter films only with MeanRating=5
View(only4)
write.table(only4, file = "only4.csv", append = FALSE, sep = " ", dec = ".",
            row.names = TRUE, col.names = TRUE)
only4 <- read_csv("only4.csv")
Parsed
cols(
  Title = col_character(),
  MeanRating = col_double(),
  movieId = col_double(),
  genres = col_character()
)
view(only4)

only3<- arrange(MeanRating_movies, desc(MeanRating))%>% filter(MeanRating=="3")#filter films only with MeanRating=4
View(only3)
write.table(only3, file = "only3.csv", append = FALSE, sep = " ", dec = ".",
            row.names = TRUE, col.names = TRUE)
only3 <- read_csv("only3.csv")
Parsed
cols(
  Title = col_character(),
  MeanRating = col_double(),
  movieId = col_double(),
  genres = col_character()
)
view(only3)

only2<- arrange(MeanRating_movies, desc(MeanRating))%>% filter(MeanRating=="2")#filter films only with MeanRating=3
View(only2)
write.table(only2, file = "only2.csv", append = FALSE, sep = " ", dec = ".",
            row.names = TRUE, col.names = TRUE)

only2 <- read_csv("only2.csv")
Parsed
cols(
  Title = col_character(),
  MeanRating = col_double(),
  movieId = col_double(),
  genres = col_character()
)
view(only2)

only1<- arrange(MeanRating_movies, desc(MeanRating))%>% filter(MeanRating=="1")#filter films only with MeanRating=2
View(only1)

write.table(only1, file = "only1.csv", append = FALSE, sep = " ", dec = ".",
            row.names = TRUE, col.names = TRUE)

only1 <- read_csv("only1.csv")
Parsed
cols(
  Title = col_character(),
  MeanRating = col_double(),
  movieId = col_double(),
  genres = col_character()
)
view(only1)


only0<- arrange(MeanRating_movies, desc(MeanRating))%>% filter(MeanRating=="0")#filter films only with MeanRating=1
View(only0)
write.table(only0, file = "only0.csv", append = FALSE, sep = " ", dec = ".",
            row.names = TRUE, col.names = TRUE)

only0 <- read_csv("only0.csv")
Parsed
cols(
  Title = col_character(),
  MeanRating = col_double(),
  movieId = col_double(),
  genres = col_character()
)
view(only0)

onlyNaN<- arrange(MeanRating_movies, desc(MeanRating))%>% filter(MeanRating=="NaN")#filter films only with MeanRating="NaN"
View(onlyNaN)
write.table(onlyNaN, file = "onlyNaN.csv", append = FALSE, sep = " ", dec = ".",
            row.names = TRUE, col.names = TRUE)

onlyNaN <- read_csv("onlyNaN.csv")
Parsed
cols(
  Title = col_character(),
  MeanRating = col_double(),
  movieId = col_double(),
  genres = col_character()
)
view(onlyNaN)


# SPLITTING DATA FRAME STRING COLUMN INTO MULTIPLE COLUMNS

# library(tidyr)
# MeanRating_moviesSPl<- separate(MeanRating_movies, col = (Title), into = c("Title", "Year"), sep = " "
#
# MeanRating_moviesSPl
#
#
                                                                                  #HISTOGRAM OF MEAN RATINGS



# DATA FRAME ----> VECTOR;
View(MeanRating)
dim(MeanRating) #checking the dimension of the table for making a choice of breaks points
MeanRatingRVector<- as.vector(unlist(MeanRating$MeanRating)) #conversion column with MeanRating (column[2]) into vector to make possible visualisation of distribution of ratings
view(MeanRatingRVector)



# HISTOGRAM OF MEAN RATING MADE FROM ALL DATA
pdf("HISTOGRAM1.pdf")
HiSTOGRAM1<- hist(MRVector, main = "Mean ratings distribution", xlab = "MeanRating", border = "black", col = "blue", xlim = c(1,5), breaks = 5)
dev.off()
view(HiSTOGRAM1)


plot(HiSTOGRAM1)


# OCCURENCES CHECKING
Occurences_ratings<- table(MRVector)
write.table(Occurences_ratings, file = "Occurences_ratings.csv", append = FALSE, sep = " ", dec = ".",
            row.names = TRUE, col.names = TRUE)
view(Occurences_ratings)


# Creating vector from data.frame "Occurances" for further plot creating
Occurences_ratings<- table(MRVector)
class(Occurences_ratings)
sapply(Occurences_ratings, class)

# PIE CHART

PIE<- pie(Occurences_ratings)


# # 3D Exploded Pie Chart
# library(plotrix)
# MRVector
# slices <- c(10, 12, 4, 16, 8)
# lbls <- c("US", "UK", "Australia", "Germany", "France")
# pie3D(MRVector,labels=frequency(MeanRating$MeanRating),explode=0.1,
#       main="Occurances")

# CHECKING "0" AND "NaN" value in vector MeanRating
unique(MRVector) #rating equal to 0 represents a missing value, they should be removed

# Removing films with "0" ratings (films that have not been rating) and films with NaN (not a number) value
MRVector2<- MRVector[MRVector != 0 & MRVector !="NaN"]
view(MRVector2)

# HISTOGRAM OF MEAN RATING MADE FROM DATA AFTER REMOVING MOVIES THAT HAVE NOT BEEN RATED AND WITH VALUE "NaN"
pdf("HISTOGRAM2.pdf")
HISTOGRAM2<- hist(MRVector2, main = "Mean ratings distribution without films that have not been rated and without NaN value", xlab = "MeanRating", border = "black", col = "green", xlim = c(1,3), breaks = 3)
dev.off()




MeanRating_movies_T <- read.csv("D:/AGNIESZKA/WsbProject/MovieLens/MeanRating_movies_T.txt", encoding="UTF-8", sep="")
View(MeanRating_movies_T)

library(tidyselect)
A<- select(MeanRating_movies$genres, contains("Drama"))
view(A)

class(MeanRating_movies_T)
glimpse(MeanRating_movies)

# M<- matrix(c(MeanRating_movies$Title), c(MeanRating_movies$MeanRating, C(MeanRating_movies$movieId), c(MeanRating_movies$genres)),
#     nrow =  9742, ncol = 4, byrow = TRUE, dimnames = NULL)
# M
#
# view(c1)
# c2<- c(MeanRating$MeanRating)

#we have 9737 mean ratings (rated films), so

#****************************************************** recomender lab .... --------------------------------------------------
library(recommenderlab)
dim(RatMov)
m<- matrix(RatMov, nrow=100854, ncol=7, byrow=TRUE, dimnames = NULL)
view(m)


class(RatMov)
A<- select
A<- RatMov[rowCounts(RatMov)>50]
A




********************************************************# STATISTICS_OCCURANCE ----------------------------------------------------





average_ratings<- colMeans(MovieLense)
average_ratings_relevant<- average_ratings[view_per_movie > 100]
class(average_ratings)
sapply(average_ratings, class)
class(average_ratings)
View(average_ratings)

ggplot(average_ratings)+stat_bin(binwidth = 0,1) + ggtitle("Distribution of the average movie rating")

Occurance_ratings<- table(vector_ratings)


# TOP 5 FROM ACTION -------------------------------------------------------
library(sqldf)
library(magrittr)
library(stringr)
A<- read.table(MeanRating)




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

