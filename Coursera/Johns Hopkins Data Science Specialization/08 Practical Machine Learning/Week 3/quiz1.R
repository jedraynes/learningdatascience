# load libraries
pacman::p_load(AppliedPredictiveModeling, 
               caret, 
               pgmm, 
               rpart, 
               dplyr, 
               rattle, 
               randomForest, 
               readr, 
               bestglm)

# question 1 -----

## load data
data(segmentationOriginal)

## subset the data
training <- filter(segmentationOriginal, Case == 'Train')
testing <- filter(segmentationOriginal, Case == 'Test')

## set the seed and train the model
set.seed(125)
model <- train(Class ~ ., method = 'rpart', data = training)

## plot
fancyRpartPlot(model$finalModel)

# question 3 -----

## load data
data(olive)
olive = olive[,-1]
names(olive)

## fit CART
model <- train(Area ~ ., method = 'rpart', data = olive)

## predict
newdata <- as.data.frame(t(colMeans(olive)))
predict(model , newdata = newdata)
unique(olive$Area)

# question 4 -----

## load data and split into testing and training data
# SAheart <- read.table('https://web.stanford.edu/~hastie/ElemStatLearn/datasets/SAheart.data', sep = ',', header = TRUE)[, -1]
data(SAheart)
set.seed(8484)
train <- sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA <- SAheart[train,]
testSA <- SAheart[-train,]

## set the seed for logistic regression
set.seed(13234)

## fit logistic regression
names(SAheart)
model <- train(chd ~ age + alcohol + obesity + tobacco + typea + ldl, method = 'glm', family = 'binomial', data = trainSA)

## missClass
missClass <- function(values,prediction){
  sum(((prediction > 0.5)*1) != values)/length(values)
}
missClass(trainSA$chd, predict(model, newdata = trainSA))
missClass(testSA$chd, predict(model, newdata = testSA))

# question 5 -----

## load the data
vowel_train <-read.table('https://web.stanford.edu/~hastie/ElemStatLearn/datasets/vowel.train', sep = ',', header = TRUE)[, -1]
vowel_test <- read.table('https://web.stanford.edu/~hastie/ElemStatLearn/datasets/vowel.test', sep = ',', header = TRUE)[, -1]

## factorize y
vowel_train$y <- as.factor(vowel_train$y)
vowel_test$y <- as.factor(vowel_test$y)

## set seed
set.seed(33833)

## random forest
model <- randomForest(y ~ ., data = vowel_train, importance = F)
model2 <- train(y ~ ., data = vowel_train, importance = F)

## varImp 
varImp(model, scale = F)
varImp(model2, scale = F)
