# 02-nhtemp-two-models.R
# Session 02 --- Introduction to statistical modelling
# Two models for the New Haven temperature series (datasets::nhtemp):
#   model 1: y_i = mu + e_i                 (constant mean + noise)
#   model 2: y_i = beta0 + beta1 t_i + e_i  (linear trend + noise)
# Prof. Dae-Jin Lee (daelee@faculty.ie.edu)

# ---- 1. Load the data from the package (never type the values by hand) ----
data(nhtemp)
class(nhtemp)       # "ts": a time series
tsp(nhtemp)         # start 1912, end 1971, frequency 1
nh <- data.frame(year = as.numeric(time(nhtemp)),
                 temp = as.numeric(nhtemp))
n <- nrow(nh)
n                   # 60 annual means (deg F)
summary(nh$temp)

plot(nhtemp, type = "o", pch = 19, cex = 0.6,
     xlab = "Year", ylab = "Mean annual temperature (deg F)")

# ---- 2. Model 1: constant mean. Least squares gives the sample mean ----
ybar <- mean(nh$temp)
s    <- sd(nh$temp)
c(ybar = ybar, s = s, se_ybar = s / sqrt(n))   # 51.16, 1.266, 0.163

m1 <- lm(temp ~ 1, data = nh)
coef(m1)            # identical to ybar
summary(m1)$sigma   # identical to s (divisor n - 1)

# ---- 3. Model 2: linear trend. Slope = Sxy / Sxx ----
Sxx <- sum((nh$year - mean(nh$year))^2)
Sxy <- sum((nh$year - mean(nh$year)) * (nh$temp - ybar))
b1  <- Sxy / Sxx
b0  <- ybar - b1 * mean(nh$year)
c(Sxx = Sxx, Sxy = Sxy, b0 = b0, b1 = b1)

m2 <- lm(temp ~ year, data = nh)
coef(m2)            # same numbers as the hand computation
10 * coef(m2)[2]    # about 0.37 deg F per decade

# Centre the year so that the intercept means something (temperature in 1912)
coef(lm(temp ~ I(year - 1912), data = nh))

# ---- 4. Compare the fits ----
rss1 <- sum(resid(m1)^2)
rss2 <- sum(resid(m2)^2)
c(RSS1 = rss1, RSS2 = rss2,
  sigma1 = summary(m1)$sigma, sigma2 = summary(m2)$sigma,
  R2 = 1 - rss2 / rss1)
anova(m1, m2)       # F test of the trend: a preview of Session 5

# Normal log-likelihood at the estimates (Session 3 develops this)
c(logLik(m1), logLik(m2))
c(sigma2_ML_m1 = rss1 / n, sigma2_ML_m2 = rss2 / n)

# ---- 5. Residuals: what the systematic part leaves behind ----
op <- par(mfrow = c(1, 2))
plot(nh$year, resid(m1), pch = 19, main = "Model 1", xlab = "Year", ylab = "Residual")
abline(h = 0, col = "grey50")
plot(nh$year, resid(m2), pch = 19, main = "Model 2", xlab = "Year", ylab = "Residual")
abline(h = 0, col = "grey50")
par(op)

# ---- 6. Checking the assumptions of model 2 ----
qqnorm(resid(m2)); qqline(resid(m2))
shapiro.test(resid(m2))                        # no evidence against normality
acf(resid(m2), lag.max = 15)                   # independence over time?
c(lag1_m1 = acf(resid(m1), plot = FALSE)$acf[2],
  lag1_m2 = acf(resid(m2), plot = FALSE)$acf[2])

# ---- 7. Predicting 1972: confidence vs prediction interval ----
new <- data.frame(year = 1972)
predict(m2, new, interval = "confidence")      # uncertainty about the mean
predict(m2, new, interval = "prediction")      # plus the variability of one year

# ---- 8. A predictive check: fit on 1912-1961, predict 1962-1971 ----
train <- subset(nh, year <= 1961)
test  <- subset(nh, year >  1961)
h1 <- lm(temp ~ 1,    data = train)
h2 <- lm(temp ~ year, data = train)
rmse <- function(fit) sqrt(mean((test$temp - predict(fit, test))^2))
c(rmse_model1 = rmse(h1), rmse_model2 = rmse(h2))
