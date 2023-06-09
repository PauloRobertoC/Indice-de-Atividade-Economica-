#analise ARIMA do indice de atividade economica do banco central - IBC - BR
#elaboracao: Paulo Roberto Caneiro de Sa
#tabela BC: 24363

### obtendo as series a partir do Banco Central
### indice de atividade economica do banco central - IBC - BR
### mensal, a partir de janeiro de 2003 a abril de 2020
### 208 observa��es

#pacotes necess�rios:
library(BETS)
library(dygraphs)
library(ggplot2)
library(fpp2)
library(FitAR)
library(tseries)
library(forecast)

######################################################################################################
ibcbr <- BETSget(24363) 
print(ibcbr)
class(ibcbr)
dput(ibcbr)  # op��o para ter os dados como na structure abaixo

dvarejo <- diff(ibcbr)
# estatisticas basicas
summary(ibcbr)

### plot basico lembrar que em class(), ele j� indicou que era ts = serie
# temporal
plot(ibcbr)

# pelo pacote dygraph d� mais op��es
library(dygraphs)
help("dygraph")

dygraph(ibcbr2, main = "�ndice de atividade economica do banco central - IBC-BR <br> (Mensal) janeiro de 2003 a abril de 2020") %>%                 
  dyAxis("x", drawGrid = TRUE) %>% 
  dyEvent("2010-1-01", "2010", labelLoc = "bottom")%>% 
  dyEvent("2012-1-01", "2012", labelLoc = "bottom")%>% 
  dyEvent("2014-1-01", "2014", labelLoc = "bottom")%>% 
  dyEvent("2016-1-01", "2016", labelLoc = "bottom")%>% 
  dyEvent("2018-1-01", "2018", labelLoc = "bottom")%>% 
  dyEvent("2020-1-01", "2020", labelLoc = "bottom")%>% 
  dyOptions(drawPoints = TRUE, pointSize = 2) 

### Fun��o de Autocorrela��o (FAC) e Autocorrela��o parcial (FACp) com defasagem 36
# S�rie em n�vel - Usarei a rotina do Hyndman e Athanasopoulos (2018).

library(ggplot2)
ibcbr2 <- ibcbr
ibcbr2 %>% ggtsdisplay(main = "")

### S�rie em primeira diferen�a

#Como a s�rie apresenta varia��es sazonais importantes, 
#assim como tend�ncia importante, claramente n�o-estacion�rias, 
#vou olhar tamb�m em primeira diferen�a.

ibcbr2 %>% diff() %>% ggtsdisplay(main = "IBC-BR em primeira diferen�a")

### Primeira diferen�a sazonal e ACF e PACF
#Farei agora a diferen�a sazonal.

ibcbr2 %>% diff(lag = 12) %>% ggtsdisplay(main = "IBC-BR em primeira diferen�a sazonal")

### Ajuste sazonal e ACF e PACF
#Aplicaremos o ajuste sazonal tipo STL (Seasonal Decomposition of Time Series by Loess) aos dados.

library(fpp2)
ibcbradj <- ibcbr2 %>% stl(s.window = "periodic") %>% seasadj()
autoplot(ibcbradj)










































































































































