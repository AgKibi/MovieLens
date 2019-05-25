# DISTANCES BETWEEN USERS 
#
#       u1    u2    u3
#u1     x    1.12   3.14
#u2    1.12   x     2.15
#u3    3.14  2.15    x

# user 3:
# u3 ---->>>  (1) u2 -> (2.15)   5.29 - 2.15 = 3.14 -->> 3.14/5.29 == 0.59 (%)
#             (2) u1 -> (3.14)   5.29 - 3.14 = 2.15 -->> 2.15/5.29 == 0.41 (%)

#                 sum =  5.29

# FILM RATINGS BY USER
#   f1 f2 f3 f4
#u2  5  4  1  4
#u1  3  2  4  3
films <- matrix(c(5,4,1,4,3,2,4,3), nrow = 2, ncol = 4, byrow=TRUE)
dimnames(films) = list(
  c('u2','u1'),
  c('f1','f2','f3','f4')
)

# USER WEiGHTS
#     f1   f2   f3   f4
#u2 0.59 0.59 0.59 0.59
#u1 0.41 0.41 0.41 0.41
user_weights <- matrix(c(rep(0.59,4),rep(0.41,4)),nrow = 2, ncol = 4, byrow = TRUE)
dimnames(user_weights) = list(
  c('u2','u1'),
  c('f1','f2','f3','f4')
)

#MULTIPLY RATINGS AND WEIGHTS
#     f1   f2   f3   f4
#u2 2.95 2.36 0.59 2.36
#u1 1.23 0.82 1.64 1.23
films_weighted <- films * user_weights

colMeans(films_weighted) # <<--- results NOT APPLICABLE
#f1    f2    f3    f4 
#2.090 1.590 1.115 1.795 

colSums(films_weighted) # RESULTS OK !! works as a weighted mean
# f1   f2   f3   f4 
#4.18 3.18 2.23 3.59 

films_weighted_rating <- colSums(films_weighted)
#films_weighted[nrow(films_weighted)+1] <- films_weighted_rating -<-- works only with data frames
films_weighted <- rbind(films_weighted, films_weighted_rating)

#GENRES MATRIX                    
#   Drama Comedy Sci-FI Horror
#f1 FALSE   TRUE   TRUE  FALSE
#f2  TRUE   TRUE  FALSE  FALSE
#f3 FALSE  FALSE   TRUE   TRUE
#f4 FALSE  FALSE  FALSE   TRUE
genres <- matrix(c(FALSE,TRUE, TRUE, FALSE,
                   TRUE,TRUE, FALSE, FALSE,
                   FALSE,FALSE,TRUE,TRUE,
                   FALSE,FALSE,FALSE,TRUE),nrow = 4, ncol = 4, byrow=TRUE)
dimnames(genres) = list(
  c('f1','f2','f3','f4'),
  c('Drama','Comedy','Sci-FI','Horror')
)

# (1) if user wants to watch film of any genre -> all true :)   

sort(films_weighted["films_weighted_rating",],decreasing = TRUE)
#f1   f4   f2   f3 
#4.18 3.59 3.18 2.23 

# (2) if user wants to watch Drama and/or Comedy


# SELECTS only two columns :
genres <- cbind(genres[,1],genres[,2])
#  Drama  Comedy    logical_or    logical_and
#f1 FALSE  TRUE        OK              x
#f2  TRUE  TRUE        OK              OK
#f3 FALSE FALSE        x               x
#f4 FALSE FALSE        x               x


logical_or <- apply(genres, 1, function(x)(any(x))) ### (m1, [2-kolumny, 1-wiersze], any -> dowolny TRUE))
logical_and  <- apply(genres, 1, function(x)(all(x))) ### (m1, [2-kolumny, 1-wiersze], all(x)- all(TRUE))

#Drama and Comedy (only) -> logical_and
#                       f2
#u2                    4.18
#u1                    0.82
#films_weighted_rating 3.18
films_weighted[,logical_and]
sort(films_weighted["films_weighted_rating",logical_and],decreasing = TRUE)

#Drama and Comedy (whatever true) -> logical_or
#                       f1   f2
#u2                    2.95 4.18
#u1                    1.23 0.82 
#films_weighted_rating 4.18 3.18
films_weighted[,logical_or]
sort(films_weighted["films_weighted_rating",logical_or],decreasing = TRUE)
