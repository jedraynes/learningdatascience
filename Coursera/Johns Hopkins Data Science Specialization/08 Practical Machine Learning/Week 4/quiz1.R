# load packages
pacman::p_load(AppliedPredictiveModeling, 
               caret, 
               pgmm, 
               rpart, 
               gbm, 
               lubridate, 
               forecast, 
               e1071, 
               elasticnet)

# question 1 -----

## load the data
vowel_train <-read.table('https://web.stanford.edu/~hastie/ElemStatLearn/datasets/vowel.train', sep = ',', header = TRUE)[, -1]
vowel_test <- read.table('https://web.stanford.edu/~hastie/ElemStatLearn/datasets/vowel.test', sep = ',', header = TRUE)[, -1]

## factorize
vowel_train$y <- as.factor(vowel_train$y)
vowel_test$y <- as.factor(vowel_test$y)

## set seed
set.seed(33833)

## random forest and gbm
model_1_rf <- train(y ~ ., method = 'rf', data = vowel_train)
model_1_gbm <- train(y ~ ., method = 'gbm', data = vowel_train, verbose = FALSE)

## predict on test data
predict_1_rf <- predict(model_1_rf, vowel_test)
predict_1_gmb <- predict(model_1_gbm, vowel_test)

## accuracy
confusionMatrix(table(predict_1_rf, vowel_test$y))$overall['Accuracy']
confusionMatrix(table(predict_1_gmb, vowel_test$y))$overall['Accuracy']

## compare where agree
preds_agree <- predict_1_rf == predict_1_gmb
ratio_agree <- vowel_test$y == predict_1_rf

## accuracy
sum(preds_agree * ratio_agree) / sum(preds_agree)
# question 2 -----

## load data
set.seed(3433)
data(AlzheimerDisease)
adData <- data.frame(diagnosis,predictors)
inTrain <- createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training <- adData[ inTrain,]
testing <- adData[-inTrain,]

## set seed
set.seed(62433)

## predict diagnosis
model_1 <- train(diagnosis ~ ., method = 'rf', data = training)
model_2 <- train(diagnosis ~ ., method = 'gbm', data = training, verbose = FALSE)
model_3 <- train(diagnosis ~ ., method = 'lda', data = training)

## predictions
pred_1 <- predict(model_1, testing)
pred_2 <- predict(model_2, testing)
pred_3 <- predict(model_3, testing)

## individual accuracy
confusionMatrix(table(pred_1, testing$diagnosis))$overall['Accuracy'] # rf
confusionMatrix(table(pred_2, testing$diagnosis))$overall['Accuracy'] # gbm
confusionMatrix(table(pred_3, testing$diagnosis))$overall['Accuracy'] # lda

## combine predictions
preds_df <- data.frame(pred_1, pred_2, pred_3, diagnosis = testing$diagnosis)
comb_model <- train(diagnosis ~ ., method = 'rf', data = preds_df)
comb_pred <- predict(comb_model, preds_df)
confusionMatrix(table(comb_pred, preds_df$diagnosis))$overall['Accuracy']

# question 3 -----

## load data
set.seed(3523)
data(concrete)
inTrain <- createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training <- concrete[ inTrain,]
testing <- concrete[-inTrain,]

## set seed
set.seed(233)

## lasso model
model <- train(CompressiveStrength ~ ., method = 'lasso', data = training)

## coeff
plot.enet(model$finalModel, xvar = 'penalty', use.color = TRUE)

# question 4 -----

## load data
dat = read.csv('C:\\Users\\Jed\\iCloudDrive\\Documents\\Learn\\R\\Johns Hopkins Data Science Specialization\\8 Practical Machine Learning\\Week 4\\gaData.csv')
training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)

## fit model
model <- bats(tstrain)

## predict
forecast <- forecast(model, h = nrow(testing))
results <- as.data.frame(forecast$lower[, 2])
results[, 2] <- as.data.frame(forecast$upper[, 2])
results[, 3] <- testing$visitsTumblr
sum((results[3]>results[1])&(results[3]<results[2]))/nrow(results)

# question 5 -----

## load data
set.seed(3523)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

## set seed
set.seed(325)

## model
model <- svm(CompressiveStrength ~ ., data = training)

## predict
preds <- predict(model, testing)

## RMSE
accuracy(preds, testing$CompressiveStrength)
sqrt(mean((preds - testing$CompressiveStrength)^2))
