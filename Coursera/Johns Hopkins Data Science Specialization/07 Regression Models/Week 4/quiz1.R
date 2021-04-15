shuttle <- MASS::shuttle
head(shuttle)

# question 1
shuttle$auto_num <- as.integer(shuttle$use == 'auto')
glm1 <- glm(auto_num ~ wind - 1, data = shuttle, family = binomial)
exp(coef(glm1))[1] / exp(coef(glm1))[2]

# question 2
glm2 <- glm(auto_num ~ wind + magn - 1, data = shuttle, family = binomial)
exp(coef(glm2))[1] / exp(coef(glm2))[2]

# question 3
glm3 <- glm(1 - auto_num ~ wind, data = shuttle, family = binomial)
summary(glm1)$coef
summary(glm3)$coef

# question 4
data("InsectSprays")
nspray <- as.numeric(factor(InsectSprays$spray))
glm4 <- glm(count ~ spray - 1, data = InsectSprays, family = poisson)
exp(coef(glm4))[1] / exp(coef(glm4))[2] 

# question 6
x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)
knots <- c(0)
term <- sapply(knots, function(knot) (x > knot) * (x - knot))
x_new <- cbind(1, x, term)
lm6 <- lm(y ~ x_new - 1)
ypred <- predict(lm6)

plot(x, y)
lines(term, ypred)
lines(x, ypred)
     