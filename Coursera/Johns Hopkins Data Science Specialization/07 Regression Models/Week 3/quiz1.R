data(mtcars)
head(mtcars)
fit <- lm(mpg ~ as.factor(cyl) + wt, data = mtcars)
summary(fit)

fit2 <- lm(mpg ~ as.factor(cyl) * wt, data = mtcars)
summary(fit2)

anova(fit, fit2, test = 'Chisq')

fit3 <- lm(mpg ~ I(wt * 0.5) + factor(cyl), data = mtcars)
summary(fit3)

x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)

hatvalues(lm(y ~ x))
dfbetas(lm(y ~ x))
