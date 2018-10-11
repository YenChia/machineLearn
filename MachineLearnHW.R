install.packages("data.table")

library(readr)
library(dplyr)
library(rvest)
library(ggplot2)

file1 <-  "/home/kilio/all/train.csv"

dfTrain <- read_csv(file = file1, col_names = TRUE, quote = "\"", col_types = "nccnnccccccccccccccnncccccncccccccncnnnccccnnnnnnnnnncncnccncnncccnnnnnncccnnnccn")
dfTrain <- dfTrain[,-1]  ## delete "ID"

##### check NA

check_NA <- function(x) {
  is_na_num <- c()
  for (i in 1:length(x)) {
    n <- is.na(x[i]) %>% 
      sum()
    is_na_num <- c(is_na_num,  n)
  }
  names(is_na_num) <- colnames(x)
  return(is_na_num)
}

check_NA(dfTrain) %>% View()

##### NA to 0

null_to_zero <- function(x, cols) {
  for (i in 1:length(cols)) {
    x[is.na(x[,cols[i]]), cols[i]] <- 0
  }
  return(x)
}

null_col <- c("LotFrontage", "Alley", "BsmtQual", "BsmtCond", "BsmtExposure", "BsmtFinType1", "BsmtFinType2", "FireplaceQu", "GarageType", "GarageYrBlt", "GarageFinish", "GarageQual", "GarageCond")

dfTrain <- null_to_zero(dfTrain, null_col)

##### not NA to 1, NA to 0

classChange <- function(x, cols) {
  for (i in 1:length(cols)) {
    x[!is.na(x[,cols[i]]), cols[i]] <- 1
    x[is.na(x[,cols[i]]), cols[i]] <- 0
  }
  return(x)
}

type_col <- c("PoolQC", "Fence", "MiscFeature")

dfTrain <- classChange(dfTrain, type_col)

##### Decision Tree fill NA
library(rpart)
library(rpart.plot)
null_type <- c("MasVnrType", "MasVnrArea", "Electrical")

known <- dfTrain[!is.na(dfTrain[,null_type[3]]),]
unknown <- dfTrain[is.na(dfTrain[,null_type[3]]),]

CART.tree <- rpart(Electrical ~ ., data=known, control=rpart.control(minsplit=2, cp=0))
CART.Prediction <- predict(CART.tree, newdata=unknown, type='class')

dfTrain[is.na(dfTrain[,null_type[3]]), null_type[3]] <- CART.Prediction

##### write to train1.csv

write.csv(dfTrain, file = "/home/kilio/all/train1.csv", row.names = FALSE)

##### Random Forest
library(randomForest)
colnames(dfTrain)[c(43:44,69)] <- c("the1stFlrSF", "the2ndFlrSF", "the3SsnPorch")
RF_Model <- randomForest(SalePrice ~ ., data=dfTrain, ntree=300)
RF.Prediction <- predict(RF_Model, data[select,])

accuracy.rf <- sum(RF.Prediction==data[select,]$class)/length(RF.Prediction)
accuracy.rf

##### XGBoosting to SalePrice
library(xgboost)
