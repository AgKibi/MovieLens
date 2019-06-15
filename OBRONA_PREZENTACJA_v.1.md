REKOMENDACJE  V.1
========================================================
author: 
date: 
autosize: true

Autorzy 
========================================================

- Kacper Biernacki
- Szymon Matyla
- Agnieszka Kibitlewska

Cel projektu
========================================================

- analiza danych zawartych w bazie MovieLens w programie R oraz w bazie SQL, 
- rekomendacja filmu 
- wyświetlenie wyniku na stronę html z wykorzystaniem django


Opis projektu
========================================================
Projekt składa się z trzech części:
  - część I to wczytanie danych, wstępna obróbka danych, podstawowe statystyki w R, utworzenie bazy danych w SQL, znalezienie nalepszych komedii i akcji (z oceną "5")
  - część II to utworzenie kodu rekomendującego film
  - część III to wyświetlenie danych na stronę


Użyte programy/techniki
========================================================
  1. R    - wczytanie danych
          - wstępna obórkba danych
          - podsumowania/statystyki
          - wizualizacje
  2. SQL  - prostsze niż w R wyszukiwanie danych
  
  3. Django
  
  4. RMarkdown
          - utworznie prezentacji
          
  5. GIT  - kontrola wersji
  
  6. GITHub
          - współdzielenie i zarządzanie projektem



Użyte biblioteki R
========================================================
  1. library (tidyverse) - pakiet umożliwiający manipulację danymi - w projekckie użyty do obsługi funkcji "mutate()",
                    - jego podpakiety to: dplyr (do ramek danych), lplyr (do list),
                    - ggplot2,
                    - readr
                    - stringr
                    
  2. library(readr) - wczytanie danych z plików .csv

  3. library(dplyr) - to pakiet umożliwiający manipulację danymi
              - jest to część większego pakietu tidyverse
              - rdzeń dplyr zawarty jest w pakiecie plyr; jest przeznaczony do pracy na ramkach danych
              - niezbędny do obsługi funkcji takich jak: apply(), tapply(), aggregate(), filter(), group by()
  4. library(lubridate) - niezastąpiony pakiet podczas pracy z datami
                  - to funkcje takie jak: is.Date, is.POSIXct, as_date


Użyte biblioteki
========================================================
  5. library(stringr)
                    - mapipulacja danymi, głównie operacje na tekście
  6. library(tidyr)
                    - manipulacja danymi, tabele danych
  7. ibrary(sqldf) 
                      - aby możliwa była obsługa funcji "select"
  8. library(magrittr)
                      - for %>% conducting

  9. library(rlang)  - obsługa funcji "last_error" umożliwiającej łatwiejszsze rozwiązywanie pojawiających się błędów
  10. library(foreach)
  11. library(reshape2) 
                      - przekształcanie tabeli do innej postaci
                      
 Użyte biblioteki
========================================================                     
                      
  12. library(recommenderlab) .................
  13. library(ggplot2) 
                      - niezbędny pakiet do tworzenia wizualizacji takich jak:
                      krzywe kalibracyjne, wykresy kołowe ("pie chart")
  14. library(lattice) 
                    - przy tworzenie histogramów
  15. library(plotrix) 
                    - for 3D Pie Chart
  16. library(DT)
                    - aby tabele mogły być interaktywn
  17. library(reprex) 
                    - do obsługi wyrażeń regularnych
                    - tutaj: genres like '%Drama%'"
  18. library(knitr)
                    - obsługa rmarkdown
                    
                    
Użyte biblioteki
========================================================
  10. library(foreach)
                      - .........................
  11. library(reshape2) 
                      - przekształcanie tabeli do innej postaci
  12. library(recommenderlab)
  13. library(ggplot2) 
                      - niezbędny pakiet do tworzenia wizualizacji takich jak:
                      krzywe kalibracyjne, wykresy kołowe ("pie chart")
  14. library(lattice) 
                    - przy tworzenie histogramów
  15. library(plotrix) 
                    - for 3D Pie Chart
  16. library(DT)
                    - aby tabele mogły być interaktywn
  17. library(reprex) 
                    - do obsługi wyrażeń regularnych
                    - tutaj: genres like '%Drama%'"
  18. library(knitr)
                    - obsługa rmarkdown

�adowanie plik�w �r�d�owych - head
========================================================

![xxxx](yyyyyyyyyyy.png)




Klasa plik�w �r�d�owych oraz klasa kolumn w plikach �r�d�owych
========================================================
#

![Class of files and columns](class_files_column_1.png)



Histogram ocen - bezpo�rednio z kodu
========================================================










```
Komunikat ostrzegawczy:
pakiet 'knitr' zosta� zbudowany w wersji R 3.5.3 


processing file: OBRONA_PREZENTACJA_v.1.Rpres
Quitting from lines 145-149 (OBRONA_PREZENTACJA_v.1.Rpres) 
B��d w poleceniu 'D:"AGNIESZKA/WsbProject/MovieLens/R"':
  argument o warto�ci NA/NaN
Wywo�ania: knit ... eval -> source -> withVisible -> eval -> eval -> setwd
Dodatkowo: Komunikaty ostrzegawcze:
1: package 'flexdashboard' was built under R version 3.5.3 
2: W poleceniu 'setwd(D:"AGNIESZKA/WsbProject/MovieLens/R")':
  pojawi�y si� warto�ci NA na skutek przekszta�cenia
Wykonywanie wstrzymane
```
