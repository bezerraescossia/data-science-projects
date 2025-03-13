#Título: "Loan Analysis"

gc()
rm(list = ls())

install.packages("tidyverse")
install.packages("readxl")
install.packages("DataExplorer")
install.packages("gridExtra")
install.packages("GGally")
install.packages("caret")
install.packages("MASS")
install.packages("neuralnet")
install.packages("readxl")
install.packages("car")
install.packages("rpart")
install.packages("rattle")
install.packages('rpart.plot')
install.packages('RColorBrewer')
install.packages("remotes")  #<- instalar 
library(remotes)
remotes::install_github("cran/DMwR", force = TRUE) #<- instalar
install.packages("leaps")

library(tidyverse)

bank.df <- read.csv("UniversalBank.csv")

DataExplorer::plot_intro(bank.df)

dim(bank.df)

anyNA(bank.df)

glimpse(bank.df)

# efetuando uma tabela
tabela <- bank.df %>% 
  group_by(PersonalLoan) %>% 
  summarize(contagem = n()) %>%  # contagem manipulador
  mutate(pct = contagem/sum(contagem))  # encontra o percentual

tabela

# Use sempre cores pastéis nas apresentações
# http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

g1 <- ggplot(tabela, aes(PersonalLoan, pct, fill = contagem)) + 
  geom_bar(stat='identity',fill = c("darkolivegreen3", "lightcoral")) + 
  geom_text(aes(label=scales::percent(pct)), position = position_stack(vjust = .5))+
  scale_y_continuous(labels = scales::percent)+
  theme_minimal()+
  labs(x ="Porcentagem",
       y = "Emprestimo",
       title = "Universal")


g2 <- ggplot(tabela,  aes(x = PersonalLoan, y = contagem))+  
  geom_col(fill = c("darkolivegreen3", "lightcoral"))+
  geom_text(aes(label = contagem), position = position_stack(vjust = 0.5))  +
  theme_minimal()+
  labs(x = "Contagem",
       y = "Empréstimo",
       title = "Universal")+
  theme_minimal()


library(gridExtra)

grid.arrange(g1, g2, ncol = 2, top = "Visão do crédito da Sample")


base <- bank.df %>% dplyr::select(-c(ID, ZIP.Code))

id <- bank.df$ID

base <- base %>% dplyr::rename(credito = PersonalLoan)
glimpse(base)

library(DMwR)

set.seed(080325)

base$credito <- as.factor(base$credito)

completa <- SMOTE(credito ~., data.frame(base), perc.over = 600,  perc.under = 200)

# efetuando uma tabela
tabela <- completa %>% 
  group_by(credito) %>% 
  summarize(contagem = n()) %>%  # contagem manipulador
  mutate(pct = contagem/sum(contagem))  # encontra o percentual

tabela

glimpse(completa) # credito está como factor

# Particionando a série

#install.packages("caret")
library(caret)

# A função createDataPartition pode ser usada para criar divisões equilibradas dos dados. 
# Se o argumento y para esta função é um fator, a amostragem aleatória ocorre dentro de cada classe 
# e deve preservar a distribuição geral da classe dos dados. Por exemplo, 
# para criar uma única divisão de 70/30% dos dados de df

# Segregando a data em 2/3 para train (montaremos o modelo) e 1/3 para test

trainIndex <- createDataPartition(completa$credito, 
                                  p = 0.70, 
                                  list = FALSE, 
                                  times = 1)
train <- completa[ trainIndex,]
test  <- completa[-trainIndex,]

class(train)
class(test)

# Proporção de Sobreviventes na df (dataframe inteiro)
round(prop.table(table(completa$credito)) * 100, digits = 2)

# Verificar se as proporções são próximas
round(prop.table(table(train$credito)) * 100, digits = 2)

round(prop.table(table(test$credito)) * 100, digits = 2)

# transformando credito em regressão logística

log <- glm(credito ~ ., family = "binomial",  data = train)

summary(log)



#vif
library(car)
vif(log)

# optei por retirar Experience

train <- train %>% dplyr::select(-Experience)

log1 <- glm(credito ~ ., family = "binomial",  data = train)

summary(log1)

#vif
vif(log1)


# STEPWISE
# Com o stepwise - escolhendo as variaveis dependentes com menor Critério de 
# Informação de Akaike

#install.packages("MASS")
library(MASS)

step.model <- log1 %>%stepAIC(trace = FALSE)

summary(step.model)

step <- step.model$formula

step # o interessante é que Age não foi computada. 

# Efetuando a rede neural

library(neuralnet)

#### Rede Neural Artificial ###

glimpse(train) # todas as variaveis são numéricas, exceto credito

train$credito <- as.numeric(ifelse(train$credito == "0", "0", "1"))

glimpse(train)

table(train$credito) #ok

nn <- neuralnet(step,
                hidden = 16,
                lifesign = "minimal",
                linear.output = FALSE,
                threshold = 0.1 , 
                data = train)

# demorou 7 minutos. time: 7.05 mins


### Plotando a Rede Neural Artificial

plot(nn)


# Predicao

predicao_nn <- predict(nn, newdata =  test, type= "class")

predicao_nn <- factor(ifelse(predicao_nn > 0.5, "1", "0"))


class(test$credito)
class(predicao_nn) #ok 

length(predicao_nn)
length(test$credito)

predicao_nn # ok

(confusionMatrix(predicao_nn, test$credito))

# Uau!! 


















