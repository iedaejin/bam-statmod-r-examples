# 02-data-quality.R
# Session 02 --- Introduction to statistical modelling
# Data quality: missing values (datasets::airquality), selection on the
# outcome (datasets::nhtemp) and measurement error in a covariate (simulation).
# Prof. Dae-Jin Lee (daelee@faculty.ie.edu)

# ---- 1. Missing values in airquality (New York, May-September 1973) ----
data(airquality)
nrow(airquality)                                # 153 days
colSums(is.na(airquality))                      # Ozone 37, Solar.R 7
sum(complete.cases(airquality))                 # 111 complete rows

# Is missingness related to something we observe? Count by month.
miss_by_month <- with(airquality, tapply(is.na(Ozone), Month, sum))
days_by_month <- with(airquality, tapply(Ozone, Month, length))
rbind(missing = miss_by_month, days = days_by_month)
# June: 21 of 30 days missing. Missingness depends on Month, so not MCAR.

# Complete-case mean vs a mean that reweights each month by its number of days
oz_month <- with(airquality, tapply(Ozone, Month, mean, na.rm = TRUE))
round(oz_month, 1)
c(complete_case = mean(airquality$Ozone, na.rm = TRUE),
  month_weighted = sum(oz_month * days_by_month) / sum(days_by_month))

# lm() silently drops incomplete rows: check the n it actually used
fit_aq <- lm(Ozone ~ Solar.R + Wind + Temp, data = airquality)
nobs(fit_aq)                                    # 111, not 153

# ---- 2. Selection on the outcome (missing not at random) ----
data(nhtemp)
nh <- data.frame(year = as.numeric(time(nhtemp)), temp = as.numeric(nhtemp))
sel <- subset(nh, temp >= 50)                   # suppose cold years were never recorded
c(n_all = nrow(nh), n_selected = nrow(sel))
c(mean_all = mean(nh$temp), mean_selected = mean(sel$temp))
c(slope_all = 10 * unname(coef(lm(temp ~ year, data = nh))[2]),
  slope_selected = 10 * unname(coef(lm(temp ~ year, data = sel))[2]))   # per decade

# ---- 3. Classical measurement error in a covariate attenuates the slope ----
set.seed(2027)
N <- 1e5
x <- rnorm(N, 0, 1)                              # true covariate, var 1
y <- 2 + 1 * x + rnorm(N, 0, 1)                  # true slope 1
w <- x + rnorm(N, 0, 1)                          # x measured with error, var(u) = 1
c(slope_true_x = unname(coef(lm(y ~ x))[2]),
  slope_noisy_x = unname(coef(lm(y ~ w))[2]),
  theory = 1 * 1 / (1 + 1))                      # beta1 * var(x) / (var(x) + var(u))

# Error in the response only: slope still unbiased, residual SD grows
y_noisy <- y + rnorm(N, 0, 1)
c(slope = unname(coef(lm(y_noisy ~ x))[2]),
  sigma_clean = summary(lm(y ~ x))$sigma,
  sigma_noisy = summary(lm(y_noisy ~ x))$sigma)  # about 1 and sqrt(2)
