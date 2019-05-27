library(dplyr)
library(ggplot2)
library(plotly)
library(datasets)
library(stringr)
library(lubridate)


#---- load data ----

library(datasets)

data(mtcars)
data(EuStockMarkets)


#load LifeCycleSavings data

Savings <- read.csv(file = "Part5_LifeCycleSavings.csv")


#---- prepare data EuStockMarkets (stocks) -----------
stocks <- as.data.frame(EuStockMarkets)

time(EuStockMarkets)

## date format
time_extr <- as.numeric(time(EuStockMarkets))
tms <- date_decimal(time_extr)

## join vector with data frame 
stocks <- cbind(tms, stocks)



#---- prepare data - mtcars ------
# rowname as column 

mtcars <- cbind(rownames(mtcars), mtcars)
colnames(mtcars)[1] <- "Cars"

# rowname as index 
rownames(mtcars) <- seq(from = 1 , to = dim(mtcars)[1] )

mtcars <- mtcars %>%
  mutate(Brand = str_extract(as.character(Cars), '^[A-Za-z]+'))


#---- build stats ----

# mtcars brand summary
mtcars_summary <- mtcars %>%
  select(-Cars) %>%
  group_by(Brand) %>%
  summarise_all(funs(min, max, mean, median, length))


# stocks monthly summary
stocks_summary <- stocks %>%
  mutate(Date1 = paste(year(tms), month(tms), sep="-")) %>%
  group_by(Date1) %>%
  summarise(DAX = mean(DAX), SMI = mean(SMI), CAC=mean(CAC), FTSE=mean(FTSE))

# LifeCycleSavings



#---- PLOTS -----

# FOR MTCARS

mtcars_box_plot <- plot_ly(data = mtcars,
                           y = ~hp,
                           color = ~Brand,
                           type = 'box')


# FOR STOCKS
stocks_line_plot1 <- ggplot(data = stocks, 
                     aes(tms, FTSE )) +
  geom_line() + 
  geom_line(data = stocks, 
            aes(tms, DAX ),
            color = 'red')



stocks_line_plot2 <- plot_ly(data = stocks, 
                             x = ~tms,
                             y = ~FTSE, 
                             type = 'scatter', 
                             mode = 'lines') %>%
  add_trace(y = ~DAX, 
            name = 'DAX', 
            mode = 'lines+markers')



stocks_hist_plot1 <- plot_ly(data = stocks, 
                       x = ~DAX,
                       type = 'histogram')


stocks_hist_plot2 <- plot_ly(data = stocks, 
                             x = ~FTSE,
                             type = 'histogram')






#---- map LifeCycleSavings data ------

library(countrycode)


df_country <- Savings %>%
  mutate(code=countrycode(Country,"country.name","iso3c")) %>%
  filter(as.character(Country) != 'Guatamala')




# light grey boundaries              
l <- list(color = toRGB("grey"), width = 0.5)

# specify map projection options
g <- list(showframe = FALSE,
          showcoastlines = TRUE,
          showland = TRUE,
          landcolor = "white",
          coastlinewidth = 0.5,
          coastlinecolor = toRGB("grey"),
          projection = list(type = "Mercator"))


# draw map
plotMap11 <- plot_geo(df_country) %>%
  add_trace(z = ~sr, color = ~sr, colors = "Blues",
            text = ~Country, locations = ~code, marker = list(line = l)) %>%
  colorbar(title = "Legend") %>%
  layout(title = "Sample Map",
         geo = g)

#plotMap11


