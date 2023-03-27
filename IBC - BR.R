#analise ARIMA do indice de atividade economica do banco central - IBC - BR
#elaboracao: Paulo Roberto Caneiro de Sa
#tabela BC: 24363

### obtendo as series a partir do Banco Central
### indice de atividade economica do banco central - IBC - BR
### mensal, a partir de janeiro de 2003 a abril de 2020
### 208 observações

#pacotes necessários:
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
dput(ibcbr)  # opção para ter os dados como na structure abaixo

dvarejo <- diff(ibcbr)
# estatisticas basicas
summary(ibcbr)

### plot basico lembrar que em class(), ele já indicou que era ts = serie
# temporal
plot(ibcbr)

# pelo pacote dygraph dá mais opções
library(dygraphs)
help("dygraph")

dygraph(ibcbr2, main = "Índice de atividade economica do banco central - IBC-BR <br> (Mensal) janeiro de 2003 a abril de 2020") %>%                 
  dyAxis("x", drawGrid = TRUE) %>% 
  dyEvent("2010-1-01", "2010", labelLoc = "bottom")%>% 
  dyEvent("2012-1-01", "2012", labelLoc = "bottom")%>% 
  dyEvent("2014-1-01", "2014", labelLoc = "bottom")%>% 
  dyEvent("2016-1-01", "2016", labelLoc = "bottom")%>% 
  dyEvent("2018-1-01", "2018", labelLoc = "bottom")%>% 
  dyEvent("2020-1-01", "2020", labelLoc = "bottom")%>% 
  dyOptions(drawPoints = TRUE, pointSize = 2) 

### Função de Autocorrelação (FAC) e Autocorrelação parcial (FACp) com defasagem 36
# Série em nível - Usarei a rotina do Hyndman e Athanasopoulos (2018).

library(ggplot2)
ibcbr2 <- ibcbr
ibcbr2 %>% ggtsdisplay(main = "")

### Série em primeira diferença

#Como a série apresenta variações sazonais importantes, 
#assim como tendência importante, claramente não-estacionárias, 
#vou olhar também em primeira diferença.

ibcbr2 %>% diff() %>% ggtsdisplay(main = "IBC-BR em primeira diferença")

### Primeira diferença sazonal e ACF e PACF
#Farei agora a diferença sazonal.

ibcbr2 %>% diff(lag = 12) %>% ggtsdisplay(main = "IBC-BR em primeira diferença sazonal")

### Ajuste sazonal e ACF e PACF
#Aplicaremos o ajuste sazonal tipo STL (Seasonal Decomposition of Time Series by Loess) aos dados.

library(fpp2)
ibcbradj <- ibcbr2 %>% stl(s.window = "periodic") %>% seasadj()
autoplot(ibcbradj)










































































































































