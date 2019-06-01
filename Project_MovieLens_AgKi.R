
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

# CHECKING "0" AND "NaN" value in vector MeanRating
unique(MeanRatingRVector) #rating equal to 0 represents a missing value, they should be removed


# HISTOGRAM OF MEAN RATING MADE FROM ALL DATA
pdf("HISTOGRAM1.pdf")
HiSTOGRAM1<- hist(MeanRatingRVector, main = "Mean ratings distribution", xlab = "MeanRating", border = "black", col = "blue", xlim = c(1,5), breaks = 5)
dev.off()
view(HiSTOGRAM1)


plot(HiSTOGRAM1)


# OCCURENCES CHECKING
Occurences_ratings<- table(MeanRatingRVector)
write.table(Occurences_ratings, file = "Occurences_ratings.csv", append = FALSE, sep = " ", dec = ".",
            row.names = TRUE, col.names = TRUE)
view(Occurences_ratings)


# Creating vector from data.frame "Occurances" for further plot creating
Occurences_ratings<- table(MeanRatingRVector)
class(Occurences_ratings)
sapply(Occurences_ratings, class)

# PIE CHART

# PIE<- pie(Occurences_ratings)

RatingDistribution = c(Occurences_ratings)
view(RatingDistribution)
labels<- c("Not rated--->", "Rated for: 5--->", "Rated for: 4--->", "Rated for: 3--->", "Rated for: 2--->", "Rated for: 1--->" )
pct<- round(RatingDistribution/sum(RatingDistribution)*100)
labelsP<- paste(labels, pct)# addition percentage to labels
lbls<- paste(labelsP, "%", sep="") # addition % to labels

pdf("PieChart")
    PieChart<- pie(RatingDistribution, labels = lbls, , col= rainbow(length(lbls)), main = "Pie chart of rating distribution")
dev.off()
view(PieChart)


# pie3D(RatingDistribution, labels = lbls, labelcol = par ("fg"), labelcex = 1.5, explode = 0.1, main = "Pie Chart of rating distribution")


# Removing films with "0" ratings (films that have not been rating) and films with NaN (not a number) value
MRVector2<- MRVector[MRVector != 0 & MRVector !="NaN"]
view(MRVector2)

# HISTOGRAM OF MEAN RATING MADE FROM DATA AFTER REMOVING MOVIES THAT HAVE NOT BEEN RATED AND WITH VALUE "NaN"
pdf("HISTOGRAM2.pdf")
HISTOGRAM2<- hist(MRVector2, main = "Mean ratings distribution without films that have not been rated and without NaN value", xlab = "MeanRating", border = "black", col = "green", xlim = c(1,3), breaks = 3)
dev.off()



# TOP 5 FROM COMEDY -WITH SQL

# In SQL Server 2014 Managment Studio, create new database "AKDBMovieLens"---> than create new table "movies" in by loading the .csv file "movies"
# For creating new table "movies": right click on the name of new database (AKDBMovieLens)---> choose "Tasks"---> Import Data ---> "Data sources" choose as "FlatFileFlask"
# by commend:
# select * from dbo.movies
# where genres like 'Comedy'; ---> Execute
# you will filter all comedies---> results writed down as .csv file named "Comedy" in folder set as "working directory" (for it: on the result dialog box do right click---> save result as)
# new file "Comedy" load into R with library "readr"---> remember to check the delimiter (here: semicolon ";")


library(readr)
Comedy <- read_delim("Comedy.csv", ";", escape_double = FALSE,
                     col_names = FALSE, trim_ws = TRUE)
View(Comedy)
class(Comedy)
dim(Comedy) # checking the dimension of data.frame
names(Comedy) #checking name of data.frame
names(Comedy)[1]<- "movieId"
names(Comedy)[2]<- "title"
names(Comedy)[3]<- "genres"
names(Comedy)
head(Comedy)
view(Comedy)

MeanRating_Comedy<- merge(x=MeanRating, y=Comedy[ ,c("movieId", "title", "genres")], by.x = "Title", by.y="title", all.x=FALSE) # because not all of the movies from MeanRating data frame are comedy
# all.x=false is set to not create the empty rows with "na"
view(MeanRating_Comedy)


write.table(MeanRating_Comedy, file = "MeanRating_Comedy.csv", append = FALSE, sep = " ", dec = ".",
            row.names = TRUE, col.names = TRUE)

MeanRating_Comedy <- read_csv("R/MeanRating_Comedy.csv")
Parsed
cols(
  Title = col_character(),
  MeanRating = col_double(),
  movieId = col_double(),
  genres = col_character()
)
View(MeanRating_Comedy)
sapply(MeanRating, class)

MeanRating_Comedy_s<- sqldf("SELECT * from MeanRating_Comedy order by MeanRating desc")
view(MeanRating_Comedy_s)

Best_Comedy<- sqldf("SELECT * from MeanRating_Comedy_s where MeanRating=5")
view(Best_Comedy)

write.table(Best_Comedy, file = "Best_comedy.csv", append = FALSE, sep = " ", dec = ".",
            row.names = TRUE, col.names = TRUE)

Best_Comedy <- read_csv("R/Best_Comedy.csv")
Parsed
cols(
  Title = col_character(),
  MeanRating = col_double(),
  movieId = col_double(),
  genres = col_character()
)
View(Best_Comedy)

