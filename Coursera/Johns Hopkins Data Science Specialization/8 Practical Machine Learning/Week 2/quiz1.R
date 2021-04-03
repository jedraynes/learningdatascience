# load packages
library(caret)
library(ggplot2)
library(Hmisc)
library(dplyr)

# question 1 ---
library(AppliedPredictiveModeling)
data(AlzheimerDisease)

adData = data.frame(diagnosis,predictors)
testIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)
training = adData[-testIndex,]
testing = adData[testIndex,]

# question 2 ---
data(concrete)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

# plot
# cutCompressiveStrength <- cut2(concrete$CompressiveStrength, g = 3)
# table(cutCompressiveStrength)

# index
ggplot(data = concrete, aes(x = rownames(concrete), y = CompressiveStrength)) + 
  geom_point()

# flyash
ggplot(data = concrete, aes(x = rownames(concrete), y = CompressiveStrength, color = FlyAsh)) + 
  geom_point()

# age
ggplot(data = concrete, aes(x = rownames(concrete), y = CompressiveStrength, color = Age)) + 
  geom_point()

# question 3 ---
names(concrete)

# plot as is
ggplot(data = concrete, aes(x = Superplasticizer)) + 
  geom_histogram(fill = 'cadetblue', color = 'black', bins = 30)

# plot log transform
ggplot(data = concrete, aes(x = log(Superplasticizer + 1))) + 
  geom_histogram(fill = 'cadetblue', color = 'black', bins = 30)
range(concrete$Superplasticizer)

# question 4 ---
set.seed(3433)data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[inTrain,]
testing = adData[-inTrain,]

# subset
train_IL <- training %>% select(starts_with('IL'))

# preproc
preProc <- preProcess(train_IL, method = 'pca', thresh = 0.8)
preProc$numComp

# question 5 ---
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

# subset
train_IL <- training %>% select(c('diagnosis', starts_with('IL')))
test_IL <- testing %>% select(c('diagnosis', starts_with('IL')))

# as is
fit <- train(diagnosis ~ ., method = 'glm', data = train_IL)
preds <- predict(fit, test_IL)
confusionMatrix(preds, test_IL$diagnosis)

# pca
fit_pca <- train(diagnosis ~ ., method="glm", data = train_IL, preProcess = "pca", trControl = trainControl(preProcOptions = list(thresh = 0.8)))
preds_pca <- predict(fit_pca, test_IL)
confusionMatrix(preds_pca, test_IL$diagnosis)